<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js">
<head>
  <title>分类筛选</title>
</head>
<body>

<article>
  <div class="wh search">
    <div class="bd search-item">
      <h3 class="bd">分类</h3>
      <ul id="classify" class="bd ul-list">
        <li <c:if test="${empty searchParamBean.queryFacet}">class="active"</c:if>><a href="javascript:void(0);" title="全 部" onclick="classify(this, '')">全 部</a></li>
        <c:forEach items="${searchParamBean.facetFieldsMap}" var="facetFields">
          <c:forEach items="${facetFields.value}" var="facetEntry">
            <c:set var="key" value=":${facetEntry.key}" scope="page"/>
            <li <c:if test="${not empty searchParamBean.queryFacet && fn:contains(searchParamBean.queryFacet, key)}">class="active"</c:if>>
              <a href="javascript:void(0);" onclick="classify(this, '${facetEntry.key}')">${facetEntry.key}</a>
            </li>
          </c:forEach>
        </c:forEach>
      </ul>
    </div>
    <div class="bd search-item">
      <h3 class="bd">价格</h3>
      <ul id="price" class="bd ul-list">
        <li <c:if test="${empty searchParamBean.fq || searchParamBean.fq == 'product_model_price:[* TO *]'}">class="active"</c:if>>
          <a href="javascript:void(0);" onclick="price(this, '')" title="全 部">全 部</a>
        </li>
        <li <c:if test="${searchParamBean.fq == 'product_model_price:[* TO 100]'}">class="active"</c:if>>
          <a href="javascript:void(0);" onclick="price(this, '[* TO 100]')" title="百元以下">百元以下</a>
        </li>
        <li <c:if test="${searchParamBean.fq == 'product_model_price:[100 TO 1000]'}">class="active"</c:if>>
          <a href="javascript:void(0);" onclick="price(this, '[100 TO 1000]')" title="100~1000">100~1000</a>
        </li>
        <li <c:if test="${searchParamBean.fq == 'product_model_price:[1000 TO 5000]'}">class="active"</c:if>>
          <a href="javascript:void(0);" onclick="price(this, '[1000 TO 5000]')" title="1000~5000">1000~5000</a>
        </li>
        <li <c:if test="${searchParamBean.fq == 'product_model_price:[5000 TO 10000]'}">class="active"</c:if>>
          <a href="javascript:void(0);" onclick="price(this, '[5000 TO 10000]')" title="5000~1万">5000~1万</a>
        </li>
        <li <c:if test="${searchParamBean.fq == 'product_model_price:[10000 TO 100000]'}">class="active"</c:if>>
          <a href="javascript:void(0);" onclick="price(this, '[10000 TO 100000]')" title="1万~10万">1万~10万</a>
        </li>
        <li <c:if test="${searchParamBean.fq == 'product_model_price:[100000 TO *]'}">class="active"</c:if>>
          <a href="javascript:void(0);" onclick="price(this, '[100000 TO *]')" title="10万以上">10万以上</a>
        </li>
      </ul>
    </div>
    <%--<div class="bd search-item">--%>
      <%--<h3 class="bd">用途</h3>--%>
      <%--<ul class="bd ul-list">--%>
        <%--<li class="active"><a href="#" title="">全 部</a></li>--%>
        <%--<li><a href="#" title="">家居摆设</a></li>--%>
        <%--<li><a href="#" title="">生日礼物</a></li>--%>
        <%--<li><a href="#" title="">创 意</a></li>--%>
        <%--<li><a href="#" title="">爱 情</a></li>--%>
        <%--<li><a href="#" title="">收 藏</a></li>--%>
      <%--</ul>--%>
    <%--</div>--%>
  </div>
  <a class="bd search-item-btn" href="javascript:void(0);" onclick="confirm()">确    定</a>
</article>

<script type="text/javascript">
  var q = "${searchParamBean.q}";//记录检索关键字
  var resultPage = "/searchResult";//结果页面路径
  var queryFacet = "${searchParamBean.queryFacet}";//当前查询条件
  var facetFieldJson = "${searchParamBean.facetFieldJson}";//分类 存储在Json字符串中
  var queryFacetJson = "${searchParamBean.queryFacetJson}";//所有查询条件 存储在Json字符串中
  var sortField = "${searchParamBean.sortField}";//排序字段
  var sortOrder = "${searchParamBean.sortOrder}";//排序方式desc/asc
  var group = "efeiyi";//common配置文件分组
  var fq = "${searchParamBean.fq}";//价格区间
  var priceUD = "${searchParamBean.priceUD}";//价格排序图标方向

  function classify(obj, val){
    $("#classify li").removeClass("active");
    $(obj).parent().addClass("active");
    if(val != ""){
      queryFacet = "project_name:" + val;
    }else{
      queryFacet = "";
    }
  }

  function price(obj, val){
    $("#price li").removeClass("active");
    $(obj).parent().addClass("active");
    if(val != ""){
      fq = "product_model_price:" + val;
    }else{
      fq="";
    }
  }

  function confirm(){
    var url = "/search.do?q="+q+"&resultPage="+resultPage+
            "&queryFacet="+queryFacet+"&facetFieldJson="+facetFieldJson+
            "&queryFacetJson="+queryFacetJson+"&sortField="+sortField+
            "&sortOrder="+sortOrder+"&group="+group+"&priceUD="+priceUD+"&fq="+fq;
//    window.location.href = url;
    searchPostSubmit(url);
  }

  function searchPostSubmit(fullUrl) {
    fullUrl = fullUrl.split("?");
    var myForm = document.createElement("form");
    myForm.method = "post";
    myForm.action = fullUrl[0];
    var params = fullUrl[1].split("&");
    for ( var x = 0; x < params.length; x++) {
      var myInput = document.createElement("input");
      var paramEntry = params[x].split("=");
      myInput.name = paramEntry[0];
      myInput.value = decodeURI(paramEntry[1]);
      myForm.appendChild(myInput);
    }
    document.body.appendChild(myForm);
    myForm.submit();
  }
</script>
<style type="text/css">
  .wh {width:100%;min-width:414px;float:left;position:relative;z-index:1}
</style>
</body>
</html>
