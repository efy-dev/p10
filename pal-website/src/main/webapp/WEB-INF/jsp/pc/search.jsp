<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/layouts/public.jsp"%>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<!doctype html>
<div class="search-list">
  <div class="search-home">
    <div class="logo">
      <h1><a href="<c:url value='<%=basePath%>'/>"><img src="<c:url value='/resources/images/logo.png'/>"
                                                        width="160" height="72"/></a></h1>
    </div>
    <form id="form" method="get" action="<c:url value='/checkLabelPc.do'/>">
      <div class="title"><a class="active">真伪查询</a></div>
      <label for="">
        <%--<input class="txt" type="text" name="serial" id="serial" value="" placeholder="请输入名称查询,如:”苏绣”"/>--%>
        <input class="txt" type="text" name="serial" id="serial" value="" placeholder="请输入12位防伪码"/>
        <input class="btn" type="submit" value="查 询"/>
      </label>
    </form>
  </div>
</div>
<!--//End--search-list-->
<div class="hd">
  <div class="search-result">
    <h1>检索结果</h1>
    <c:forEach items="${searchList}" var="item">
    <div class="item">
      <a class="img" href=""><img src="http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/${item.picture_url}"/></a>
      <ul>
        <li><span>证书编号: 140522398541258</span><i class="icon icon-code"></i><i class="icon icon-card"></i><i class="icon icon-dna"></i></li>
        <li>名称: ${item.product_name}</li>
        <li>作者: ${item.master_name}</li>
        <li>商户: ${item.tenant_name}</li>
        <%--<li>创作年代: 2006</li>--%>
        <%--<li>认证时间: 2015年5月</li>--%>
        <%--<li>尺寸: 100*128cm</li>--%>
        <%--<li>类别: 苏绣</li>--%>
        <%--<li>重量: 1236.12g</li>--%>
      </ul>
    </div>
    </c:forEach>
    <!--//End-->
    <div style="clear: both">
      <c:url value="/search.do" var="url" />
      <ming800:pcPageList bean="${requestScope.pageEntity}" url="${url}">
        <ming800:pcPageParam name="q" value="${requestScope.q}"/>
      </ming800:pcPageList>
    </div>
  </div>
</div>
<!--//End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="js/amazeui.min.js"></script>
<script src="js/cpbjs.js"></script>
</body>
</html>
