
<html>
<head>
    <title></title>

  <%--  <script type="text/javascript" >
        function tenantView(){
            var tenantId = $("#tenantId").val();
            window.location.href="/tenant/getTenant.do?tenantId="+tenantId;
        }
    </script>--%>
</head>
<body>
<form action="" method="post">
    <table>
        <tr>
            <td>${entity.id}</td>
            <td>${entity.name}</td>
        </tr>
    </table>
</form>
</body>
</html>
