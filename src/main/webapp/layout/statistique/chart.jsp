<%@include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
  <div class="pagetitle">
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="#">app</a></li>
        <li class="breadcrumb-item">statistique</li>
        <li class="breadcrumb-item active">Chart</li>
      </ol>
    </nav>
  </div>

  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Line Chart</h5>
      <div id="lineChart"></div>
      <script>
        document.addEventListener("DOMContentLoaded", () => {
          new ApexCharts(document.querySelector("#lineChart"), {
            series: [{
              name: "Desktops",
              data: [10, 41, 35, 51, 49, 62, 69, 91, 148]
            }],
            chart: {
              height: 350,
              type: 'area',
              zoom: {
                enabled: false
              }
            },
            markers: {
              size: 4
            },
            fill: {
              type: "gradient",
              gradient: {
                shadeIntensity: 1,
                opacityFrom: 0.3,
                opacityTo: 0.4,
                stops: [0, 90, 100]
              }
            },
            dataLabels: {
              enabled: false
            },
            stroke: {
              curve: 'smooth'
            },
            grid: {
              row: {
                colors: ['#f3f3f3', 'transparent'],
                opacity: 0.5
              },
            },
            xaxis: {
              categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
            }
          }).render();
        });
      </script>
    </div>
  </div>




</main>
<%@include file="/layout/include/footer.jsp" %>
