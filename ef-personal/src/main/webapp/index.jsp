<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script type="text/javascript">
        function submit(){
            window.location.href = "/tenant/tenantList.do";
        }
    </script>
</head>
<body>
<h2>Hello World!</h2>
<input type="button" value="提交" onclick="submit();"/>
</body>
</html>
