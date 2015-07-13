<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>

<script type="text/javascript">
    function loginOrRegister(o){
        var result = $(o).val();
       window.location.href="/pc/forward.do?result="+result;
    }
</script>
<h2>Hello World!</h2>
<input type="button" value="登录" onclick="loginOrRegister(this);"/>
<input type="button" value="注册" onclick="loginOrRegister(this);"/>
</body>
</html>
