<%@ include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Changer Prix</li>
            </ol>
        </nav>
    </div>

    <div class="container">
        <form action="<%= request.getContextPath() %>/produit?type=prix" method="post">
            <div class="card">
                <div class="card-header">
                    <h5>Changement de prix</h5>
                </div>
                <div class="card-body">
                    <div class="mb-4">
                        <div class="mb-3">
                            <label for="produit" class="form-label">Choisir un produit</label>
                            <select class="form-select" id="produit" name="id_produit" required>
                                <option value="" disabled selected>Choix</option>
                                <%
                                    List<ProduitCpl> produits = (List<ProduitCpl>) request.getAttribute("produits");
                                    if (produits != null) {
                                        for (ProduitCpl produit : produits) {
                                %>
                                <option value="<%= produit.getId_saveur_produit() %>"><%= produit.getNomCpl() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="prix" class="form-label">Nouveau Prix</label>
                            <input type="number" step="0.01" class="form-control" id="prix" name="prix" required>
                        </div>
                        <div class="mb-3">
                            <label for="date" class="form-label">Date</label>
                            <input type="date" class="form-control" id="date" name="date" required>
                        </div>

                    </div>
                    <div class="d-flex">
                        <button type="submit" class="btn btn-primary">Valider</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</main>
<%@ include file="/layout/include/footer.jsp" %>
