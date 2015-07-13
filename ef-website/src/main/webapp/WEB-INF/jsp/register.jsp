<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/10
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>

<script type="text/javascript">
    /*function register(){
        window.location.href="/pc/register.do";
    }*/
    /*function validateSms(o){
        var flag = false;
        var val = $(o).val();
        if(val == "" || null == val){
            flag = false;
            alert("用户名不能为空");
            return flag;
        }
    }*/
</script>
<form action="<c:url value="/pc/register.do" />" method="post">
    <table>
        <tbody>
        <tr>
            <th>用户名:</th>
            <td>
                <input type="text" id="username" name="username"/>
            </td>
        </tr>
        <tr>
            <th>密码:</th>
            <td>
                <input type="password" id="password" name="password"/>
            </td>
        </tr>
        <tr>
            <th>确认密码:</th>
            <td>
                <input type="password" id="repassword" name="repassword"/>
            </td>
        </tr>
        <tr>
            <td>
                <input type="submit"  value="注册"/>
            </td>
        </tr>
        </tbody>
    </table>

</form>
</body>
</html>

