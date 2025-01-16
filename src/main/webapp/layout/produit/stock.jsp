<%@ include file="/layout/include/header.jsp" %>

<%
    List<ProduitCpl> produits = (List<ProduitCpl>) request.getAttribute("produits");
%>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Stock</li>
            </ol>
        </nav>
    </div>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Liste des produits avec stock</h5>

            <div class="accordion accordion-flush" id="accordionFlushExample">
                <% 
                    if (produits != null) {
                        for (ProduitCpl p : produits) {
                            int idP = p.getId_saveur_produit();
                            String r = (p.getRecette() == null)? "<span class=\"badge bg-warning text-dark\"><i class=\"bi bi-exclamation-triangle me-1\"></i> Pas de recette</span>" : "";
                            String stock = (p.getQuantite_en_stock() == 0)? "<span class=\"badge bg-warning text-dark\"><i class=\"bi bi-exclamation-triangle me-1\" style=\"margin:0 !important;\"></i></span>" : "";
                %>
                
                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-heading<%= idP %>">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse<%= idP %>" aria-expanded="false" aria-controls="flush-collapse<%= idP %>">
                            <div class="container-fluid">
                                <div class="row text-center w-100">
                                    <div class="col-md-3 col-12 text-start">
                                        <strong>Produit :</strong> <%= p.getNomCpl() %> <%= r %>
                                    </div>
                                    <div class="col-md-3 col-12 text-start">
                                        <strong>Type :</strong> <%= p.getProduit().getTypeProduit().getDesignation() %>
                                    </div>
                                    <div class="col-md-3 col-12 text-start">
                                        <strong>Prix :</strong> <%= p.getPrix_unitaire() %> Ar
                                    </div>
                                    <div class="col-md-3 col-12 text-start">
                                        <strong>Stock :</strong> <%= p.getQuantite_en_stock() %> <%= stock %>
                                    </div>
                                </div>
                            </div>
                        </button>
                    </h2>
                    <div id="flush-collapse<%= idP %>" class="accordion-collapse collapse" aria-labelledby="flush-heading<%= idP %>" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <h6>Formules de fabrication :</h6>
                            <ul>
                                <%
                                    Recette recette = p.getRecette();
                                    if (recette != null) {
                                        for (RecetteFille fille : recette.getRecetteFille()) {
                                %>
                                    <li>
                                        <strong><%= fille.getQuantite_necessaire() %></strong> 
                                        <%= fille.getIngredient().getUnite().getDesignation() %> 
                                        de <strong><%= fille.getIngredient().getNom_ingredient() %></strong>
                                    </li>
                                <%
                                        }
                                    } else {
                                        out.println("<p>Recette pas encore attribuee</p>");
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
