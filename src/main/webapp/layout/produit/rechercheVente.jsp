<%@ include file="/layout/include/header.jsp" %>


<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">recherche Vente</li>
            </ol>
        </nav>
    </div>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Rechercher Ventes</h5>

            <form action="<%= request.getContextPath() %>/produit?type=rechercheVente" method="POST" class="row g-3">

                <div class="col-12">
                    <div class="form-group">
                        <label for="id_ingredient">Categorie a rechercher</label>
                        <select class="form-control" id="id_ingredient" name="id_type" required>
                            <option value="">Selectionner un categorie</option>
                            <%
                                List<TypeProduit> is = (List<TypeProduit>) request.getAttribute("types");
                                if (is != null) {
                                    for (TypeProduit i : is) {
                                        out.println("<option value=\"" + i.getId_type_produit() + "\">" + i.getDesignation() + "</option>");
                                    }
                                }
                            %>
                        </select>
                    </div><br>
                    <div class="form-group">

                        <label for="id_type_ingredient">Saveur a rechercher</label>
                        <select class="form-control" id="id_type_ingredient" name="id_saveur" required>
                            <option value="">Selectionner un saveur</option>
                            <%
                                List<Saveur> is1 = (List<Saveur>) request.getAttribute("saveurs");
                                if (is != null) {
                                    for (Saveur i : is1) {
                                        out.println("<option value=\"" + i.getId_saveur() + "\">" + i.getDesignation() + "</option>");
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="col-12">
                    <button type="submit" class="btn btn-primary">Rechercher</button>
                </div>
            </form>
        </div>
    </div>

    <%
        List<VenteProduit> ventes = (List<VenteProduit>) request.getAttribute("ventes");
    %>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Resultat recherche des ventes</h5>

            <div class="accordion accordion-flush" id="accordionFlushExample">
                <%
                    if (ventes != null) {
                        for (VenteProduit v : ventes) {
                            int idP = v.getId_vente();
                %>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-heading<%= idP %>">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse<%= idP %>" aria-expanded="false" aria-controls="flush-collapse<%= idP %>">
                            <div class="container-fluid">
                                <div class="row text-center w-100">
                                    <div class="col-md-4 col-12 text-start">
                                        <strong>Client :</strong> <%= v.getClient().getNom() %>
                                    </div>
                                    <div class="col-md-4 col-12 text-start">
                                        <strong>Total :</strong> <%= v.getTotal() %> Ar
                                    </div>
                                    <div class="col-md-4 col-12 text-start">
                                        <strong>Date :</strong> <%= v.getDate_vente() %>
                                    </div>
                                </div>
                            </div>
                        </button>
                    </h2>
                    <div id="flush-collapse<%= idP %>" class="accordion-collapse collapse" aria-labelledby="flush-heading<%= idP %>" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <ul>
                                <%
                                    for (DetailVenteProduit fille : v.getDetails()) {
                                %>
                                <li>
                                    <strong><%= fille.getQuantite_vendue() %></strong>
                                    de <strong><%= fille.getProduit_vendu().getNomCpl() %></strong>
                                    au prix de <strong><%= fille.getPrix_unitaire() %> Ar</strong>
                                </li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </div>


                <%
                        }
                    }
                %>
            </div>
        </div>
    </div>




</main>
<%@ include file="/layout/include/footer.jsp" %>
