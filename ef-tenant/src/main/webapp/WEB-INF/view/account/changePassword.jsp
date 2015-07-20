<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
</head>
<body>

       <table>
           <tr>
               <td>账号</td>
               <td> </td>
           </tr>
           <tr>
               <td>现密码</td>
               <td><input type="password" /></td>
           </tr>
           <tr>
               <td>新密码</td>
               <td><input type="password" /></td>
           </tr>
           <tr>
               <td>确定手机号</td>
               <td>
                   <input type="text" /><br/>
                   <input type="button" value="获取验证码" />
               </td>
           </tr>
           <tr>
               <td>验证码</td>
               <td><input type="text" /></td>
           </tr>
           <tr>
               <td colspan="2">
                 <input type="button" value="确定修改" />
               </td>
           </tr>
       </table>

</body>
</html>
