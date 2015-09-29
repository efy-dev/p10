<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/28
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<body>
<div class="slide-right">
  <div class="title-hide">${tabTitle}</div>
  <div class="div-list">
    <ul class="div-list-ul div-list-txt">
      <c:forEach items="${documentList}" var="document">
        ${document.documentContent.content}
      </c:forEach>
      <%--<li><p>第一章总则</p></li>--%>
      <%--<li><p>第一条：为了继承和弘扬中华民族优秀传统文化，促进社会主义精神文明建设，加强非物质文化遗产保护、保存工作，制定本法。</p></li>--%>
      <%--<li>--%>
        <%--<p>第二条：本法所称非物质文化遗产，是指各族人民世代相传并视为其文化遗产组成部分的各种传统文化表现形式，以及与传统文化表现形式相关的实物和场所。包括：</p>--%>
        <%--<p>(一)传统口头文学以及作为其载体的语言；</p>--%>
        <%--<p>(二)传统美术、书法、音乐、舞蹈、戏剧、曲艺和杂技；</p>--%>
        <%--<p>(三)传统技艺、医药和历法；</p>--%>
        <%--<p>(四)传统礼仪、节庆等民俗；</p>--%>
        <%--<p>(五)传统体育和游艺；</p>--%>
        <%--<p>(六)其他非物质文化遗产。</p>--%>
        <%--<p>属于非物质文化遗产组成部分的实物和场所，凡属文物的，适用《中华人民共和国文物保护法》的有关规定。</p>--%>
      <%--</li>--%>
      <%--<li>--%>
        <%--<p></p>--%>
      <%--</li>--%>
    </ul>
  </div>
  <!-- //End--div-list-->
  <div class="pages wh">
    <c:url value="/protection/protection.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
      <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
      <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
    <%--<ul class="am-pagination am-pagination-centered">--%>
      <%--<li><a href="">首页</a></li>--%>
      <%--<li><a href="">上一页</a></li>--%>
      <%--<li class="am-active"><a href="">1</a></li>--%>
      <%--<li><a href="">2</a></li>--%>
      <%--<li><a href="">3</a></li>--%>
      <%--<li><a href="">4</a></li>--%>
      <%--<li><a href="">5</a></li>--%>
      <%--<li><a href="">...</a></li>--%>
      <%--<li><a href="#">9</a></li>--%>
      <%--<li><a href="#">10</a></li>--%>
      <%--<li class="am-disabled bigRound"><a href="#">下一页</a></li>--%>
      <%--<li class="pages-total">共135条</li>--%>
      <%--<li class="pages-nums">第01/35页</li>--%>
    <%--</ul>--%>
  </div>
  <!-- //End--pages-->
</div>
<!-- //End--slide-right-->
</div>
</div>

</body>
