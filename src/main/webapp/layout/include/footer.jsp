<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
<script>
    createPopup("<%= error %>", 'alert');
</script>
<%
    }
%>

<%
    String success = (String) request.getAttribute("success");
    if (success != null) {
%>
<script>
    createPopup("<%= success %>", 'success');
</script>
<%
    }
%>

<script src="<%= request.getContextPath() + "/" %>assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/quill/quill.min.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/tinymce/tinymce.min.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/vendor/php-email-form/validate.js"></script>
<script src="<%= request.getContextPath() + "/" %>assets/js/main.js"></script>
</body>
</html>
