<%@ page import="com.boulangerie.model.view.V_Client_Stat" %>
<%@ page import="com.boulangerie.model.view.V_Comm_Genre" %>
<%@include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Vente Commission</li>
            </ol>
        </nav>
    </div>

    <div>
        <form action="<%= request.getContextPath() %>/produit" method="get">
            <div class="card">
                <input type="hidden" name="type" value="ventecommission">
                <div class="card-header">
                    <h5>Vous pouvez filtrer</h5>
                </div>
                <div class="card-body">
                    <div class="mb-4">
                        <div class="mb-3">
                            <label for="date_debut" class="form-label">Debut de date</label>
                            <input type="date" class="form-control" id="date_debut" name="date_debut" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="mb-3">
                            <label for="date_fin" class="form-label">Fin de date</label>
                            <input type="date" class="form-control" id="date_fin" name="date_fin" required>
                        </div>
                    </div>

                    <div class="d-flex">
                        <button type="submit" class="btn btn-primary">Rechercher</button>
                    </div>
                </div>
            </div>
        </form>
    </div>


    <%
        List<VendeurStat> stats = (List<VendeurStat>) request.getAttribute("stats");
        if (stats != null && !stats.isEmpty()) {
    %>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Liste des commissions par vendeurs entre <strong><%= request.getAttribute("debut") %></strong> et <strong><%= request.getAttribute("fin") %></strong></h5>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Vendeur</th>
                        <th>Total commission</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (VendeurStat stat : stats) {
                            Vendeur vendeur = stat.getVendeur();
                    %>
                    <tr>
                        <td>
                            <%= vendeur.getNom() %> (<%= vendeur.getGenre().getDesignation() %>)
                        </td>
                        <td>
                            <%= stat.getTotal_value() %>
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

    <%
        V_Comm_Genre comm = (V_Comm_Genre) request.getAttribute("commgenre");
        if (comm != null) {
    %>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Total des commissions par genre entre <strong><%= request.getAttribute("debut") %></strong> et <strong><%= request.getAttribute("fin") %></strong></h5>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Total Homme</th>
                        <th>Total Femme</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <%= comm.getHomme() %>
                        </td>
                        <td>
                            <%= comm.getFemme() %>
                        </td>
                    </tr>
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
