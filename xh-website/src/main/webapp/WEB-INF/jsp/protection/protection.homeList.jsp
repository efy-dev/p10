<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/29
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
  function getMatchJnodes(id,currentJnode,matchJnode){
    var jmenu = document.getElementById("jmenu").value;
    var url =' <c:url value="/view/newView.do"/>' + "?id=" + id + "&jmenu=" + jmenu + "&currentJnode=" + currentJnode + "&matchJnode=" + matchJnode;
    window.location=url;
  }
</script>
<div class="wh data-down">
  <div class="title">资料下载<a class="btn-more" href="<c:url value='/protection/protection.list.do?qm=plistPolicy_default'/> " title="更多">更多</a></div>
  <ul class="list-table">
    <c:forEach items="${documentList}" var="document" begin="0" end="3">
      <li>
        <a href="javascript:(0)" onclick="getMatchJnodes('${document.id}','17','ProtectionPolicy')" target="_parent" title="${document.title}">
          <table>
            <tr>
              <td>${document.title}</td>
            </tr>
          </table>
        </a>
      </li>
    </c:forEach>
  </ul>
</div>