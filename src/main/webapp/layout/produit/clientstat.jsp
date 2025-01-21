<%@ page import="com.boulangerie.model.view.V_Client_Stat" %>
<%@include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Client Stat</li>
            </ol>
        </nav>
    </div>

    <%
        List<V_Client_Stat> stats = (List<V_Client_Stat>) request.getAttribute("stats");
        if (stats != null && !stats.isEmpty()) {
    %>

    <div class="card">
        <div class="card-header">
            <h4 class="mb-0">Liste des client avec total</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Client</th>
                        <th>Contact</th>
                        <th>Total</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (V_Client_Stat stat : stats) {
                            Client client = stat.getClient();
                    %>
                    <tr>
                        <td>
                            <%= client.getNom() %>
                        </td>
                        <td>
                            <%= client.getContact() %>
                        </td>
                        <td>
                            <%= stat.getTotal() %>
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
<%@include file="/layout/include/footer.jsp" %>
