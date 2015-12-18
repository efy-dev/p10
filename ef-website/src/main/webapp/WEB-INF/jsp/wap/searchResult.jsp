<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js">
<head>
    <title><c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}-</c:if>商品搜索-E飞蚁</title>
</head>
<body>
<article>
    <div id="result" class="bd search-sort">
        <ul class="bd tnav">
            <li>
                <a href="javascript:void(0);"
                   onclick="facetForward('<c:url value="/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&queryFacet=${searchParamBean.queryFacet}&priceUD=0&fq=${searchParamBean.fq}"/>')"
                   title="综 合">综 合</a>
            </li>
            <li>
                <a href="javascript:void(0);" onclick="sortDate2()" title="新 品">新 品</a>
            </li>
            <li>
                <a href="javascript:void(0)" onclick="sortForward4('product_model_price')">价  格
                    <i class="<c:if test='${searchParamBean.priceUD == 0}'>icon-a1</c:if><c:if test='${searchParamBean.priceUD != 0}'>icon-a2</c:if>"></i>
                </a>
            </li>
            <li>
                <a href="javascript:void(0);"
                   onclick="facetForward('<c:url value="/filterSearch.do?q=${searchParamBean.q}&resultPage=/filterCondition&queryFacet=${searchParamBean.queryFacet}&priceUD=0&fq=${searchParamBean.fq}&filter=filter"/>')"
                   title="筛 选">筛 选</a>
            </li>
        </ul>
        <ul class="ul-list">
            <%-- 没有获取到数据时显示 --%>
            <c:if test="${empty searchParamBean.searchResultList}">
                抱歉，没有搜索结果，您可以换个<font color="red">关键词</font>、<font color="red">分类条件</font>、<font color="red">价格区间</font>试试。</span>
            </c:if>
            <%-- 数据显示 --%>
            <c:forEach items="${searchParamBean.searchResultList}" var="result">
                <li>
                    <a href="<c:url value="/product/productModel/${result.id}"/>" title="">
                        <img src="http://pro.efeiyi.com/${result.picture_url}@!pc-project-list" alt="">
                        <p class="name">${result.product_name}<c:if test="${result.frequent != 1}">[${result.specification}]</c:if></p>
                        <p class="price"><em>￥</em>${result.product_model_price}</p>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
</article>

<script type="text/javascript">
    var facets = "${searchParamBean.facetFieldJson}";
    function facetForward(url) {
        window.location.href = url + "&facetFieldJson=" + facets + "&queryFacetJson=${searchParamBean.queryFacetJson}&group=efeiyi" ;
    }

    var priceUD = ${searchParamBean.priceUD};
    var sf = "${searchParamBean.sortField}";
    function sortForward4(sortField) {
        var sortOrder = "asc";
        if(priceUD == 0 && sf != "" && sf != "create_datetime"){
            sortOrder = "";
            priceUD = 1;
        }else{
            priceUD = 0;
        }
        var url = "<c:url value='/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&queryFacet=${searchParamBean.queryFacet}&sortField='/>" + sortField + "&sortOrder=" + sortOrder + "&fq=${searchParamBean.fq}" + "&priceUD=" + priceUD;
        facetForward(url)
    }

    function sortDate2() {
        var url = "<c:url value='/search.do?q=${searchParamBean.q}&resultPage=${searchParamBean.resultPage}&queryFacet=${searchParamBean.queryFacet}&sortField=create_datetime'/>"+"&sortOrder=&fq=${searchParamBean.fq}&priceUD=0";
        facetForward(url)
    }

    var dynamicTag = true;
    window.onscroll = function(){
        var bch = document.body.clientHeight;
        var dch = document.documentElement.clientHeight;
        var ch = 0;//窗口可视高度

        if(bch && dch){
            ch = (bch < dch)? bch : dch;
        }else{
            ch = (bch > dch)? bch : dch;
        }

        var bsh = document.body.scrollHeight;
        var dsh = document.documentElement.scrollHeight;
        var sh = Math.max(bsh, dsh);//页面实际高度

        var st = document.documentElement.scrollTop || document.body.scrollTop;//滚动条距离顶部高度
        var sf = sh-ch-st;//滚动条距离底部高度=实际高度-可视窗口高度-滚动条距离顶部高度
        if(sf <= 500 && dynamicTag){
            AjaxGetSearch();
        }
    };

    var pageIndex = ${searchParamBean.pageEntity.index};
    function AjaxGetSearch(){
        pageIndex = pageIndex + 1;
        var size = ${searchParamBean.pageEntity.size};
        var q = "${searchParamBean.q}";//记录检索关键字
        var resultPage = "/dynamicResult";//结果页面路径
        var queryFacet = "${searchParamBean.queryFacet}";//当前查询条件
        var facetFieldJson = "${searchParamBean.facetFieldJson}";//分类 存储在Json字符串中
        var queryFacetJson = "${searchParamBean.queryFacetJson}";//所有查询条件 存储在Json字符串中
        var sortField = "${searchParamBean.sortField}";//排序字段
        var sortOrder = "${searchParamBean.sortOrder}";//排序方式desc/asc
        var group = "efeiyi";//common配置文件分组
        var fq = "${searchParamBean.fq}";//价格区间
        var priceUD = "${searchParamBean.priceUD}";//价格排序图标方向
        var url = "/AjaxSearch.do?q="+q+"&resultPage="+resultPage+
//        var url = "/search.do?q="+q+"&resultPage="+resultPage+
                "&queryFacet="+queryFacet+"&facetFieldJson="+facetFieldJson+
                "&queryFacetJson="+queryFacetJson+"&sortField="+sortField+
                "&sortOrder="+sortOrder+"&group="+group+"&priceUD="+priceUD+"&fq="+fq+
                "&pageEntity.index="+pageIndex+"&pageEntity.size="+size;

        if(dynamicTag) {
            dynamicTag = false;
            $.ajax({
                type: "get",
                url: url,
                cache: false,
                success: function (data) {
                    data = data.replace( /^\s*/, '');
                    if (data != "") {
                        document.getElementById("result").innerHTML += data;
                        dynamicTag = true;
                    }
                },
                error: function (message, a, b) {
                    alert(message.responseText + a + b);
                    dynamicTag = true;
                }
            });
        }
    }
</script>

</body>
</html>
