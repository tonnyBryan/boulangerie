<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.boulangerie.model.ingredient.*" %>
<%@ page import="com.boulangerie.model.produit.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.boulangerie.model.client.*" %>

<%@ page import="com.boulangerie.service.*" %>


<html>
<head>
    <title>Title</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <link href="<%= request.getContextPath() + "/" %>assets/img/favicon.png" rel="icon">
    <link href="<%= request.getContextPath() + "/" %>assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
    <link href="<%= request.getContextPath() + "/" %>assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() + "/" %>assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="<%= request.getContextPath() + "/" %>assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() + "/" %>assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="<%= request.getContextPath() + "/" %>assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="<%= request.getContextPath() + "/" %>assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="<%= request.getContextPath() + "/" %>assets/vendor/simple-datatables/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() + "/" %>assets/css/style.css" rel="stylesheet">
    <script src="<%= request.getContextPath() + "/" %>assets/js/myjs.js"></script>
    <script src="<%= request.getContextPath() + "/" %>assets/js/nice-framework.js"></script>

</head>
<body>
<header id="header" class="header fixed-top d-flex align-items-center">
    <div class="d-flex align-items-center justify-content-between">
        <a href="#" class="logo d-flex align-items-center">
            <span class="d-none d-lg-block">BOULANGERIE</span>
        </a>
        <i class="bi bi-list toggle-sidebar-btn"></i>
    </div>
    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">
            <li class="nav-item dropdown pe-3">

                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <span class="d-none d-md-block dropdown-toggle ps-2">fako</span>
                </a><!-- End Profile Iamge Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                    <li class="dropdown-header">
                        <h6>SID : </h6>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="<%= request.getContextPath() %>/user?form=logout">
                            <i class="bi bi-box-arrow-right"></i>
                            <span>Log Out</span>
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </nav>
</header>
<aside id="sidebar" class="sidebar" style="display: flex; flex-direction: column;">
    <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-item">
            <a class="nav-link " href="#">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-layout-text-window-reverse"></i><span>Produits</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="<%= request.getContextPath() %>/produit?type=ajouter">
              <i class="bi bi-circle"></i><span>Ajouter</span>
            </a>
          </li>
            <li>
                <a href="<%= request.getContextPath() %>/produit?type=attribuerRecette">
                    <i class="bi bi-circle"></i><span>Attribuer recette</span>
                </a>
            </li>
          <li>
            <a href="<%= request.getContextPath() %>/produit?type=fabriquer">
              <i class="bi bi-circle"></i><span>Fabriquer</span>
            </a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/produit?type=vendre">
              <i class="bi bi-circle"></i><span>Vendre</span>
            </a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/produit?type=stock">
              <i class="bi bi-circle"></i><span>Stock</span>
            </a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/produit?type=listeFab">
              <i class="bi bi-circle"></i><span>Liste Fabrication</span>
            </a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/produit?type=listeVente">
              <i class="bi bi-circle"></i><span>Liste Vente</span>
            </a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/produit?type=listespec">
              <i class="bi bi-circle"></i><span>Recherche specifique</span>
            </a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/produit?type=produire">
              <i class="bi bi-circle"></i><span>Produire</span>
            </a>
          </li>
            <li>
                <a href="<%= request.getContextPath() %>/produit?type=rechercheVente">
                    <i class="bi bi-circle"></i><span>Recherche Vente</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/produit?type=conseilmoisinsert">
                    <i class="bi bi-circle"></i><span>Insert Conseil Mois</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/produit?type=conseilmoisliste">
                    <i class="bi bi-circle"></i><span>Conseil du mois</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/produit?type=client">
                    <i class="bi bi-circle"></i><span>today Client</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/produit?type=clientstat">
                    <i class="bi bi-circle"></i><span>Client Stat</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/produit?type=ventecommission">
                    <i class="bi bi-circle"></i><span>Vendeur Commission</span>
                </a>
            </li>
        </ul>
      </li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#ingredient-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-bar-chart"></i><span>Ingredients</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="ingredient-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="<%= request.getContextPath() %>/ingredient?type=ajouter">
              <i class="bi bi-circle"></i><span>Ajouter</span>
            </a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/ingredient?type=acheter">
              <i class="bi bi-circle"></i><span>Acheter</span>
            </a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/ingredient?type=stock">
              <i class="bi bi-circle"></i><span>Stock</span>
            </a>
          </li>
        </ul>
      </li>

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-bar-chart"></i><span>Charts</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="charts-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
                <li>
                    <a href="<%= request.getContextPath() %>/statistique?type=chart">
                        <i class="bi bi-circle"></i><span>ApexCharts</span>
                    </a>
                </li>
            </ul>
        </li>
    </ul>
</aside>

