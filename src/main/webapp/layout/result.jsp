<%@include file="include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item active">result</li>
            </ol>
        </nav>
    </div>

    <%
        String titre = (String) request.getAttribute("titre");
        String errorMessage = (String) request.getAttribute("error");
        String successMessage = (String) request.getAttribute("success");
    %>

    <div class="card mb-3">
        <div class="card-header">
            <h5 class="card-title"><%= titre != null ? titre : "Default Title" %></h5>
        </div>

        <div class="card-body">
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage %>
                </div>
                <button onclick="window.history.back()" class="btn btn-outline-warning">Retour</button>
            <% } else if (successMessage != null) { %>
                <div class="alert alert-success" role="alert">
                    <%= successMessage %>
                </div>
            <% } %>
        </div>
    </div>
</main>

<script src="<%= request.getContextPath() + "/" %>assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/chart.js/chart.umd.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/echarts/echarts.min.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/quill/quill.min.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/tinymce/tinymce.min.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/php-email-form/validate.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/js/main.js"></script>
</body>
</html>
