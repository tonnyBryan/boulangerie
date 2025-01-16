<%@ include file="/layout/include/header.jsp" %>

<%
    List<FabricationProduit> fabrications = (List<FabricationProduit>) request.getAttribute("fabrications");
%>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Liste Fabrication</li>
            </ol>
        </nav>
    </div>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Liste des fabrications tri&eacute;es par date d&eacute;croissante</h5>

            <div class="accordion accordion-flush" id="accordionFlushExample">
                <% 
                    if (fabrications != null) {
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
                    } 
                %>
            </div>
        </div>
    </div>
</main>
<%@ include file="/layout/include/footer.jsp" %>
