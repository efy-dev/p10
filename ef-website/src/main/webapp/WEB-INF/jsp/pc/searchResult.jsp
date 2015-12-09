<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title><c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}-</c:if>商品搜索-E飞蚁</title>
</head>
<body>
<div class="wh fly-nev">
    <div class="hd">
        <div class="searching ae">
            <ul class="sech-look1">
                <li><a href="#">检索结果</a></li>
                <li class="icon"></li>
                <li class="active"><a href="javascript:void(0);"><c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}</c:if></a></li>
            </ul>
        </div>
        <div class="searching ae">
            <div class="sech-look2">
                <!--分类-->
                <div class="loog-ground ae">
                    <div class="look-head">
                        <span>分类：</span>
                        <c:if test="${empty searchParamBean.queryFacet}">
                            <strong>
                        </c:if>
                            <a href="<c:url value="/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&facetFieldJson=${searchParamBean.facetFieldJson}&priceUD=0&group=efeiyi" />">全部</a>
                        <c:if test="${empty searchParamBean.queryFacet}">
                            </strong>
                        </c:if>
                    </div>
                    <div class="look-body">
                        <c:forEach items="${searchParamBean.facetFieldsMap}" var="facetFields">
                            <c:forEach items="${facetFields.value}" var="facetEntry">
                                <a href="javascript:void(0);"
                                   class="<c:if test="${not empty searchParamBean.queryFacet && fn:contains(searchParamBean.queryFacet, facetEntry.key)}">active</c:if>"
                                   onclick="facetForward('<c:url value="/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&queryFacet=project_name:${facetEntry.key}&priceUD=0"/>')">
                                   ${facetEntry.key}

                                </a>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </div>
                <!--价格-->
                <div class="loog-ground ae">
                    <div class="look-head">
                        <span>价格：</span>
                        <c:if test="${empty searchParamBean.fq || searchParamBean.fq == 'product_model_price:[* TO *]'}">
                            <strong><a href="javascript:void(0);" onclick="priceSectionForward('[* TO *]')">全部</a></strong>
                        </c:if>
                        <c:if test="${not empty searchParamBean.fq && searchParamBean.fq != 'product_model_price:[* TO *]'}">
                            <a href="javascript:void(0);" onclick="priceSectionForward('[* TO *]')">全部</a>
                        </c:if>
                    </div>
                    <div class="look-body">
                        <a href="javascript:void(0);" onclick="priceSectionForward('[* TO 100]')" class="<c:if test="${searchParamBean.fq == 'product_model_price:[* TO 100]'}">active</c:if>">百元以内</a>
                        <a href="javascript:void(0);" onclick="priceSectionForward('[100 TO 1000]')" class="<c:if test="${searchParamBean.fq == 'product_model_price:[100 TO 1000]'}">active</c:if>">100~1000</a>
                        <a href="javascript:void(0);" onclick="priceSectionForward('[1000 TO 5000]')" class="<c:if test="${searchParamBean.fq == 'product_model_price:[1000 TO 5000]'}">active</c:if>">1000~5000</a>
                        <a href="javascript:void(0);" onclick="priceSectionForward('[5000 TO 10000]')" class="<c:if test="${searchParamBean.fq == 'product_model_price:[5000 TO 10000]'}">active</c:if>">5000~1万</a>
                        <a href="javascript:void(0);" onclick="priceSectionForward('[10000 TO 100000]')" class="<c:if test="${searchParamBean.fq == 'product_model_price:[10000 TO 100000]'}">active</c:if>">1万~10万</a>
                        <a href="javascript:void(0);" onclick="priceSectionForward('[100000 TO *]')" class="<c:if test="${searchParamBean.fq == 'product_model_price:[100000 TO *]'}">active</c:if>">10万以上</a>
                    </div>
                </div>
                <!--用途-->
                <%--<div class="loog-ground ae">--%>
                    <%--<div class="look-head">--%>
                        <%--<span>用途：</span>--%>
                        <%--<strong><a href="#">全部</a></strong>--%>
                    <%--</div>--%>
                    <%--<div class="look-body">--%>
                        <%--<a href="#">家居摆设 </a>--%>
                        <%--<a href="#">生日礼物</a>--%>
                        <%--<a href="#">创意</a>--%>
                        <%--<a href="#">爱情</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
            </div>
        </div>
        <div class="shop-sort newshop-sort ae">
            <ul class="link1">
                <li class="active">
                    <a href="javascript:void(0);"
                       onclick="facetForward('<c:url value="/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&queryFacet=${searchParamBean.queryFacet}&priceUD=0&fq=${searchParamBean.fq}"/>')"
                       title="综合排序">综合排序</a>
                </li>
                <li class="line"><i class="icon"></i></li>
                <li class="active">
                    <a href="javascript:void(0)" title="价  格" onclick="sortForward2('product_model_price')">价  格
                        <i id="priceUD${searchParamBean.priceUD}"
                           class="icon <c:if test='${searchParamBean.priceUD == 0}'>arrow-up</c:if><c:if test='${searchParamBean.priceUD != 0}'>arrow-down</c:if>"></i>
                    </a>
                </li>
                <%--<li class="line"><i class="icon"></i></li>--%>
                <%--<li class="active">--%>
                    <%--<a href="#" title="销量">销量</a>--%>
                <%--</li>--%>
                <%--<li class="line"><i class="icon"></i></li>--%>
                <%--<li class="active">--%>
                    <%--<a href="#" title="人气">人气</a>--%>
                <%--</li>--%>
                <li class="line"><i class="icon"></i></li>
                <li class="active">
                    <a href="javascript:void(0);" title="新品" onclick="sortDate()">新品</a>
                </li>
                <li class="line"><i class="icon"></i></li>
            </ul>
            <%--<ul class="link3">--%>
                <%--<li>--%>
                    <%--<input type="checkbox">--%>
                    <%--<span>诚品宝认证</span>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<input type="checkbox">--%>
                    <%--<span>推荐精品</span>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<input type="checkbox">--%>
                    <%--<span>纯手工制作</span>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<a href="#">商品</a>--%>
                    <%--<a href="javascript:void(0)" class="line-i">|</a>--%>
                    <%--<a href="#" class="hover">店铺</a>--%>
                <%--</li>--%>
            <%--</ul>--%>
        </div>
        <div class="category">
            <div class="list-pro">
                <ul class="ul-item">
                    <%-- 没有获取到数据时显示 --%>
                    <c:if test="${empty searchParamBean.searchResultList}">
                        抱歉，没有找到“${searchParamBean.q}”的搜索结果，您可以换个关键词试试。
                    </c:if>
                    <%-- 数据显示 --%>
                    <c:forEach items="${searchParamBean.searchResultList}" var="result">
                        <li>
                            <a href="http://www2.efeiyi.com/product/productModel/${result.id}" target="_blank" title="">
                                <img class="imgfilter" src="http://pro.efeiyi.com/${result.picture_url}@!product-hot" alt="">
                                <p class="wh name">${result.product_name}<c:if test="${result.frequent != 1}">[${result.specification}]</c:if></p>
                                <p class="wh price">￥${result.product_model_price}</p>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div style="clear: both">
                <c:url value="/search.do" var="url"/>
                <ming800:pcPageList bean="${searchParamBean.pageEntity}" url="${url}">
                    <ming800:pcPageParam name="q" value="${searchParamBean.q}"/><%-- 记录检索关键字 --%>
                    <ming800:pcPageParam name="resultPage" value="${searchParamBean.resultPage}"/><%-- 结果页面路径 --%>
                    <ming800:pcPageParam name="queryFacet" value="${searchParamBean.queryFacet}"/> <%-- 当前查询条件 --%>
                    <ming800:pcPageParam name="facetFieldJson" value="${searchParamBean.facetFieldJson}"/><%--分类 存储在Json字符串中--%>
                    <ming800:pcPageParam name="queryFacetJson" value="${searchParamBean.queryFacetJson}"/><%--所有查询条件 存储在Json字符串中--%>
                    <ming800:pcPageParam name="sortField" value="${searchParamBean.sortField}"/><%--排序字段--%>
                    <ming800:pcPageParam name="sortOrder" value="${searchParamBean.sortOrder}"/><%--排序方式desc/asc--%>
                    <ming800:pcPageParam name="group" value="efeiyi"/><%-- common配置文件检索分组 --%>
                    <ming800:pcPageParam name="fq" value="${searchParamBean.fq}"/><%-- 价格区间 --%>
                    <ming800:pcPageParam name="priceUD" value="${searchParamBean.priceUD}"/><%-- 价格排序图标标识 --%>
                </ming800:pcPageList>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var facets = "${searchParamBean.facetFieldJson}";
    function facetForward(url) {
        window.location.href = url + "&facetFieldJson=" + facets + "&queryFacetJson=${searchParamBean.queryFacetJson}&group=efeiyi" ;
    }
    function sortForward(sortField,sortOrder) {
        var url = "<c:url value='/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&queryFacet=${searchParamBean.queryFacet}&sortField='/>" + sortField + "&sortOrder=" + sortOrder +"&fq=${searchParamBean.fq}";
        facetForward(url)
    }
    var eId = "#priceUD${searchParamBean.priceUD}";
    function sortForward2(sortField) {

        var iClass = $(eId).attr("class");
        var sortOrder = "asc";
        var priceUD = 0;
        var tag = iClass.indexOf("arrow-up")>0;
        if(tag){
            sortOrder = "";
            priceUD = 1;
        }

        var url = "<c:url value='/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&queryFacet=${searchParamBean.queryFacet}&sortField='/>" + sortField + "&sortOrder=" + sortOrder +"&fq=${searchParamBean.fq}" + "&priceUD=" + priceUD;
        facetForward(url)
    }
    function priceSectionForward(priceSection){
        var url = "<c:url value='/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&queryFacet=${searchParamBean.queryFacet}&priceUD=${searchParamBean.priceUD}&fq=product_model_price:'/>" + priceSection;
        facetForward(url)
    }
    function sortDate() {
        var url = "<c:url value='/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&queryFacet=${searchParamBean.queryFacet}&sortField=create_datetime'/>"+"&sortOrder=&fq=${searchParamBean.fq}" + "&priceUD=0";
        facetForward(url)
    }
</script>

</body>
</html>
