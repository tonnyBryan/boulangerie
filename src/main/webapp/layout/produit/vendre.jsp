<%@ include file="/layout/include/header.jsp" %>

<%
    List<ProduitCpl> produits = (List<ProduitCpl>) request.getAttribute("produits");
    List<Client> clients = (List<Client>) request.getAttribute("clients");
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
                                            <input type="number" class="form-control" name="quantites[]" placeholder="Quantit&eacute;" value="0" required> 
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
                    <div class="d-flex">
                        <button type="submit" class="btn btn-primary">Vendre</button>
                    </div>
                </form>

            </div>
        </div>
    </div>


</main>
<%@ include file="/layout/include/footer.jsp" %>
