<%@ include file="/layout/include/header.jsp" %>

<%
    List<VenteProduit> ventes = (List<VenteProduit>) request.getAttribute("ventes");
%>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Liste Vente</li>
            </ol>
        </nav>
    </div>


    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Liste des ventes</h5>

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
