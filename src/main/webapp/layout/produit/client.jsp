<%@ page import="java.sql.Date" %>
<%@ include file="/layout/include/header.jsp" %>

<%
    List<VenteProduit> ventes = (List<VenteProduit>) request.getAttribute("ventes");
    Date dtInput = (Date) request.getAttribute("dateInput");
    String dateInput = (dtInput == null)? "today" : dtInput.toString();
%>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Client</li>
            </ol>
        </nav>
    </div>

    <div>
    <form action="<%= request.getContextPath() %>/produit" method="get">
        <div class="card">
            <input type="hidden" name="type" value="client">
            <div class="card-header">
                <h5>Vous pouvez choisir un date</h5>
            </div>
            <div class="card-body">
                <div class="mb-4">
                    <div class="mb-3">
                        <label for="date_debut" class="form-label">Choix</label>
                        <input type="date" class="form-control" id="date_debut" name="date" required>
                    </div>
                </div>

                <div class="d-flex">
                    <button type="submit" class="btn btn-primary">Insert</button>
                </div>
            </div>
        </div>
    </form>
    </div>


    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Liste des ventes <%= dateInput %></h5>

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

    <%
        List<Client> clients = (List<Client>) request.getAttribute("clients");
        if (clients != null && !clients.isEmpty()) {
    %>

    <div class="card">
        <div class="card-header">
            <h4 class="mb-0">Liste des client <%= dateInput %></h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Client</th>
                        <th>Contact</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                            for (Client client : clients) {
                    %>
                    <tr>
                        <td>
                            <%= client.getNom() %>
                        </td>
                        <td>
                            <%= client.getContact() %>
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
