<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/29
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<script type="text/javascript">
  function getMatchJnodes(id){
    var jmenu = document.getElementById("jmenu").value;
    var currentJnode = document.getElementById("currentJnode").value;
    var x = document.getElementById("matchJnode");
    var matchJnode = document.getElementById("matchJnode").value;
    var url =' <c:url value="/view/newView.do"/>' + "?id=" + id + "&jmenu=" + jmenu + "&currentJnode=" + currentJnode + "&matchJnode=" + matchJnode;
    window.location=url;
  }
</script>
<div class="slide-right">
  <div class="title">${tabTitle}</div>
  <div class="list-table">
    <table>
      <c:forEach items="${documentList}" var="document" varStatus="status">
        <tr>
          <td><a href='javascript:void(0)' onclick="getMatchJnodes('${document.id}')">${document.title}</a></td>
        </tr>
      </c:forEach>
    </table>
  </div>
</div>
</body>
