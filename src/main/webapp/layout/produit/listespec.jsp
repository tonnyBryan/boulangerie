<%@ include file="/layout/include/header.jsp" %>


<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">recherche</li>
            </ol>
        </nav>
    </div>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Rechercher fabrication</h5>

            <form action="<%= request.getContextPath() %>/produit?type=listespec" method="POST" class="row g-3">
            
                <div class="col-12">
                    <div class="form-group">
                        <label for="id_ingredient">Ingredient a rechercher</label>
                        <select class="form-control" id="id_ingredient" name="id_ingredient" required>
                            <option value="">Selectionner un ingredient</option>
                            <%
                                List<Ingredient> is = (List<Ingredient>) request.getAttribute("ingredients");
                                if (is != null) {
                                    for (Ingredient i : is) {
                                        out.println("<option value=\"" + i.getId_ingredient() + "\">" + i.getNom_ingredient() + "</option>");
                                    }
                                }
                            %>
                        </select>
                    </div><br>
                    <div class="form-group">

                        <label for="id_type">Type a rechercher</label>
                        <select class="form-control" id="id_type" name="id_type" required>
                            <option value="">Selectionner un Type</option>
                            <%
                                List<TypeProduit> is1 = (List<TypeProduit>) request.getAttribute("types");
                                if (is != null) {
                                    for (TypeProduit i : is1) {
                                        out.println("<option value=\"" + i.getId_type_produit() + "\">" + i.getDesignation() + "</option>");
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
        List<FabricationProduit> fabrications = (List<FabricationProduit>) request.getAttribute("fabrications");
        if (fabrications != null) {
    %>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Resultat</h5>

            <div class="accordion accordion-flush" id="accordionFlushExample">
                <% 
                    for (FabricationProduit fab : fabrications) { 
                        int idFab = fab.getId_fabrication_produit();
                %>
                
                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-heading<%= idFab %>">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse<%= idFab %>" aria-expanded="false" aria-controls="flush-collapse<%= idFab %>">
                            Fabrication N&deg; <%= idFab %> du <%= fab.getDate_action() %>
                        </button>
                    </h2>
                    <div id="flush-collapse<%= idFab %>" class="accordion-collapse collapse" aria-labelledby="flush-heading<%= idFab %>" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <ul>
                            <%
                                for (FabricationProduitFille fille : fab.getFille()) {
                            %>
                                <li><%= fille.getQuantite_fabrique() %> fois de <%= fille.getProduitCpl().getNomCpl() %></li>
                            <%
                                }
                            %>
                            </ul>
                        </div>
                    </div>
                </div>

                <% 
                        }
                %>
            </div>
        </div>
    </div>

    <%
        }
    %>




</main>
<%@ include file="/layout/include/footer.jsp" %>
