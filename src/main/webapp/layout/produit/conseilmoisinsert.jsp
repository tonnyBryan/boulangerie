<%@ include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">insert conseil mois</li>
            </ol>
        </nav>
    </div>

    <div class="container">
        <form action="<%= request.getContextPath() %>/produit?type=conseilmoisinsert" method="post">
            <div class="card">
                <div class="card-header">
                    <h5>Insertion</h5>
                </div>
                <div class="card-body">
                    <div class="mb-4">
                        <div class="mb-3">
                            <label for="type_produit" class="form-label">Choisir Produits</label>
                            <select class="form-select" id="type_produit" name="id_produit" required>
                                <option value="" disabled selected>Choisir un produit</option>
                                <%
                                    List<ProduitCpl> produits = (List<ProduitCpl>) request.getAttribute("produits");
                                    if (produits != null) {
                                        for (ProduitCpl p : produits) {
                                %>
                                <option value="<%= p.getId_saveur_produit() %>"><%= p.getNomCpl() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="date_debut" class="form-label">Date de debut</label>
                            <input type="date" step="0.01" class="form-control" id="date_debut" name="date_debut" required>
                        </div>
                        <div class="mb-3">
                            <label for="date_fin" class="form-label">Date de fin</label>
                            <input type="date" step="0.01" class="form-control" id="date_fin" name="date_fin" required>
                        </div>
                    </div>

                    <div class="d-flex">
                        <button type="submit" class="btn btn-primary">Insert</button>
                    </div>
                </div>
            </div>
        </form>
    </div>


</main>
<%@ include file="/layout/include/footer.jsp" %>
