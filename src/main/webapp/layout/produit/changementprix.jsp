<%@ include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Liste des changements de prix</li>
            </ol>
        </nav>
    </div>

    <div>
        <form action="<%= request.getContextPath() %>/produit" method="get">
            <input type="hidden" name="type" value="changementprix">

            <div class="card">
                <div class="card-header">
                    <h5>Vous pouvez filtrer</h5>
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
                    </div>
                    <div class="d-flex mb-2">
                        <button type="submit" class="btn btn-primary">Valider</button>
                    </div>
                    <div class="d-flex">
                        <a href="http://localhost:8080/boulangerie_war/produit?type=changementprix" class="btn btn-secondary">All</a>
                    </div>

                </div>
            </div>
        </form>
    </div>

    <%
        List<ChangementPrix> changements = (List<ChangementPrix>) request.getAttribute("changements");
        if (changements != null) {
    %>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Historique des changements</h5>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Produit</th>
                        <th>Ancien Prix</th>
                        <th>Nouveau Prix</th>
                        <th>Date de changement</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (ChangementPrix cp : changements) {
                    %>

                    <tr>
                        <td>
                            <%= cp.getProduitCpl().getProduit().getNom_produit() %>
                        </td>
                        <td>
                            <%= cp.getOldPrix() %>
                        </td>
                        <td>
                            <%= cp.getNewPrix() %>
                        </td>
                        <td>
                            <%= cp.getDate_changement() %>
                        </td>
                    </tr>

                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <%
        }
    %>

</main>
<%@ include file="/layout/include/footer.jsp" %>
