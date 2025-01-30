<%@ include file="/layout/include/header.jsp" %>

<%
    List<ProduitCpl> produits = (List<ProduitCpl>) request.getAttribute("produits");
    List<Client> clients = (List<Client>) request.getAttribute("clients");
    List<Vendeur> vendeurs = (List<Vendeur>) request.getAttribute("vendeurs");

%>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Vendre</li>
            </ol>
        </nav>
    </div>

    <div class="container">
        <div class="card">
            <div class="card-header">
                Vente de Produits 
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/produit?type=vendre" method="post">
                    <div class="mb-3">
                        <label for="clientId" class="form-label">Client : </label>
                        <select class="form-select" id="clientId" name="clientId" required>
                            <option value="" disabled selected>Choisir un client</option>
                            <% 
                                if (clients != null) {
                                    for (Client client : clients) { 
                            %>
                                <option value="<%= client.getId_client() %>"><%= client.getNom() %></option>
                            <% 
                                    }
                                } 
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="vendeurId" class="form-label">Vendeur : </label>
                        <select class="form-select" id="vendeurId" name="vendeurId" required>
                            <option value="" disabled selected>Choisir un vendeur</option>
                            <%
                                if (vendeurs != null) {
                                    for (Vendeur vendeur : vendeurs) {
                            %>
                            <option value="<%= vendeur.getId_vendeur() %>"><%= vendeur.getNom() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Nom du produit</th>
                                    <th>Prix Unitaire</th>
                                    <th>Stock</th>
                                    <th>Quantit&eacute; &agrave; vendre</th> 
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    if (produits != null) {
                                        for (ProduitCpl produit : produits) {
                                            String recette = (produit.getRecette() == null)? "<span class=\"badge bg-warning text-dark\"><i class=\"bi bi-exclamation-triangle me-1\"></i> Pas de recette</span>" : "";
                                            String stock = (produit.getQuantite_en_stock() == 0)? "<span class=\"badge bg-warning text-dark\"><i class=\"bi bi-exclamation-triangle me-1\" style=\"margin:0 !important;\"></i></span>" : "";

                                %>
                                    <tr>
                                        <td><%= produit.getNomCpl() %> <%= recette %></td>
                                        <td><%= produit.getPrix_unitaire() %></td>
                                        <td><%= produit.getQuantite_en_stock() %> <%= stock %></td>
                                        <td>
                                            <input type="number" min="0" max="<%= produit.getQuantite_en_stock() %>" class="form-control" name="quantites[]" placeholder="Quantit&eacute;" value="0" required>
                                            <input type="hidden" name="produitId[]" value="<%= produit.getId_saveur_produit() %>"> <!-- ID du produit -->
                                        </td>
                                    </tr>
                                <% 
                                        }
                                    } 
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex  mb-2">
                        <h5>Total : <strong><span id="total-price">0</span></strong></h5>
                    </div>
                    <div class="d-flex">
                        <button type="submit" class="btn btn-primary">Vendre</button>
                    </div>
                </form>

            </div>
        </div>
    </div>


</main>

<script>
    // Fonction pour calculer et afficher le total
    function calculateTotal() {
        let totalPrice = 0;

        // Récupérer tous les champs d'entrée de quantité
        const rows = document.querySelectorAll("tbody tr");
        rows.forEach(row => {
            const priceElement = row.querySelector("td:nth-child(2)"); // Prix unitaire
            const quantityInput = row.querySelector("input[type='number']"); // Quantité

            const unitPrice = parseFloat(priceElement.textContent.trim()); // Prix unitaire
            const quantity = parseInt(quantityInput.value.trim(), 10); // Quantité saisie

            if (!isNaN(unitPrice) && !isNaN(quantity)) {
                totalPrice += unitPrice * quantity; // Ajouter au total
            }
        });

        // Afficher le total dans l'élément avec l'ID total-price
        document.getElementById("total-price").textContent = totalPrice.toFixed(2);
    }

    // Ajouter des écouteurs d'événements sur chaque champ de quantité
    document.querySelectorAll("input[name='quantites[]']").forEach(input => {
        input.addEventListener("input", calculateTotal); // Met à jour le total lors d'une saisie
    });

    // Calculer le total initial (au cas où il y a des valeurs par défaut)
    calculateTotal();
</script>


<%@ include file="/layout/include/footer.jsp" %>
