<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>商品详情</title>
</head>
<body>

<article class="custom">
    <div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}'>
        <ul class="am-slides">
            <li><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!wap-product-pic"></li>
            <c:forEach items="${productModel.product.productPictureList}" var="picture">
                <li><img src="http://pro.efeiyi.com/${picture.pictureUrl}@!wap-product-pic"></li>
            </c:forEach>
        </ul>
    </div>
    <!--//End--am-slider-->
    <div class="bd details">
        <div class="bd des-title">
            <strong class="bd txt">${productModel.product.name}
                <c:forEach
                    items="${productModel.productPropertyValueList}" var="pv">
                ${pv.projectPropertyValue.value}
            </c:forEach> </strong>
            <a href="#分享" class="share">
                <i class="icon icon-share"></i>

                <p>分享</p>
            </a>
            <a onclick="getStatus(${productModel.product.id})" class="addfav">
                <i class="icon icon-addfav"></i>

                <p>收藏</p>
            </a>
        </div>
        <!-- //End--des-title-->
        <div class="bd des-price">
            <p class="bd p-price"><span>价格：</span><em>￥</em><strong>${productModel.price.intValue()}</strong></p>

            <p class="bd express">快递：0（飞蚁包邮）</p>
        </div>
        <!-- //End--des-price-->
        <div class="bd des-format">
            <a data-am-modal="{target: '#my-actions'}" class="bd btn-format" title="选择规格">选择规格<i
                    class="arrow-right"></i></a>
        </div>
        <!-- //End--des-format-->
        <div class="des-content">
            <div class="bd title">详情</div>
            <div class="bd" style="padding: 10px">
                <c:if test="${!empty product.productDescription}">
                    ${product.productDescription.content}
                </c:if>
                <%----%>
                <%----%>
                <%--<ul class="bd ul-text">--%>
                <%--<li class="small-title">【产品参数】</li>--%>
                <%--<li><span>品&nbsp;&nbsp;&nbsp;&nbsp;名：</span><span>《安格尔—公爵夫人肖像》</span></li>--%>
                <%--<li><span>尺&nbsp;&nbsp;&nbsp;&nbsp;寸：</span><span>100X128CM</span></li>--%>
                <%--<li><span>材&nbsp;&nbsp;&nbsp;&nbsp;质：</span><span>真丝底料  真丝色线</span></li>--%>
                <%--<li><span>绣制时间：</span><span>2006年</span></li>--%>
                <%--<li><span>绣制工时：</span><span>303天</span></li>--%>
                <%--<li><span>绣制技艺：</span><span>乱针绣</span></li>--%>
                <%--<li><span>所属项目：</span><span>苏绣</span></li>--%>
                <%--<li><span>项目级别：</span><span>国家级非物质文化遗产</span></li>--%>
                <%--<li><span>传承人：  </span><span>姚惠芬</span></li>--%>
                <%--<li><span>适&nbsp;&nbsp;&nbsp;&nbsp;用：</span><span>中国外事礼品  赠送外国友人 节庆送礼 家居装饰 个人收藏</span></li>--%>
                <%--</ul>--%>
                <%--<!-- //End--产品参数-->--%>
                <%--<ul class="bd ul-text">--%>
                <%--<li class="small-title">【产品描述】</li>--%>
                <%--<li>此幅公爵夫人为苏绣中著名的“仿画绣”，“乱针绣”的技法将画理与绣理相结合，苏绣与西洋油画完美相融。在原画的基础上有了新的表现形式和艺术生命。</li>--%>
                <%--</ul>--%>
                <%--<!-- //End--产品描述-->--%>
                <%--<ul class="bd ul-img">--%>
                <%--<li class="img-title">细节图一</li>--%>
                <%--<li class="img"><img src="../shop2015/upload/details-exp1.jpg" alt=""/></li>--%>
                <%--<li class="text">公爵夫人高雅端庄，造型丰满圆润，线条柔美流畅，面庞安详、肤如凝脂。</li>--%>
                <%--<li class="img-title">细节图二</li>--%>
                <%--<li class="img"><img src="../shop2015/upload/details-exp2.jpg" alt=""/></li>--%>
                <%--<li class="text">绣者将人物的皮肤和各种细节的质感处理得维纱维肖，几近完美。</li>--%>
                <%--<li class="img-title">细节图三</li>--%>
                <%--<li class="img"><img src="../shop2015/upload/details-exp3.jpg" alt=""/></li>--%>
                <%--<li class="text">绣者以极细的线条或深或淡地将其质感与动感巧妙地绣了出来，让人物顿时焕发精神，艺术感染力油然而生。</li>--%>
                <%--<li class="img-title">细节图四</li>--%>
                <%--<li class="img"><img src="../shop2015/upload/details-exp4.jpg" alt=""/></li>--%>
                <%--<li class="text">衣领处的压褶、袖口的花纹、裙摆的褶皱，绣者将丝线有机的融入原画笔触，较之油画更加真实可感。加之丝线本身具有光感，整幅图画异常光彩动人。</li>--%>
                <%--<li class="img-title">细节图五</li>--%>
                <%--<li class="img"><img src="../shop2015/upload/details-exp5.jpg" alt=""/></li>--%>
                <%--<li class="text">色彩清纯恬淡，明暗清晰、层次分明。蓝色优雅深沉，黄色华贵富丽，低调不失奢华。</li>--%>
                <%--</ul>--%>
                <%--<!-- //End--细节-->--%>
                <%--<ul class="bd ul-text ul-text2">--%>
                <%--<li class="small-title">【非遗-承袭】</li>--%>
                <%--<li>苏绣是中国古老的手工技艺之一，早在三国时期就有了关于苏绣制作的记载，吴王孙权曾命丞相赵达之妹手绣《列国图》，有“绣万国于一锦”之说。</li>--%>
                <%--<li>而其风骨神韵在隋唐时期奠定，迨至宋元其枝法与特色渐趋形成，《清秘藏》叙述：“宋人之绣，针线细密，用线一、二丝，用针如发细者为之。设色精妙，光彩射目。山水分远近之趣，楼阁得深邃之体人物具瞻眺生动之情，花鸟极绰约底馋唼之态，佳者较画更胜。”</li>--%>
                <%--<li>明清苏绣艺术走向成熟。“山水能分远近之趣；楼阁具现深邃之体；人物能有瞻眺生动之情；花鸟能报绰约亲昵之态。”</li>--%>
                <%--<li>民国时期，社会动荡、百业萧条，苏绣发展受到重创，直至新中国成立苏绣得以复兴。</li>--%>
                <%--</ul>--%>
                <%--<!-- //End--非遗-承袭-->--%>
                <%--<ul class="bd ul-text ul-text2">--%>
                <%--<li class="small-title">清洁：</li>--%>
                <%--<li>局部清洗采用酒精去渍。整体清洗：放在清水或含有中性清洁剂的冷水或温水中浸泡几分钟，冲洗，切忌揉搓或者挤压。然后把绣品布料放在干净的白色毛巾上，卷起来平整压一下，将多余的水去掉，展开，放置于通风处晾干，从背面熨平，熨的时候桌子上铺一块不脱色的布。</li>--%>
                <%--<li>尼龙绢：刺绣的原材料分绫、罗、绸、缎、绢、纺、葛等。</li>--%>
                <%--<li>其中尼龙绢薄如蝉翼，透明坚韧，弹性好、牢度强，不易折皱，是刺绣苏州花线：色泽鲜艳、有光泽、粗细均匀。</li>--%>
                <%--<li>2011年，苏州花线制作技艺被列入苏州市非物质文化遗产代表性项目名录。</li>--%>
                <%--</ul>--%>
                <%--<!-- //End--清洁-->--%>
                <%--<div class="bd peo-info">--%>
                <%--<ul class="bd">--%>
                <%--<li><i class="icon icon-v"></i>国家级非物质文化遗产传承人<span>[刺绣]</span></li>--%>
                <%--<li><img src="../shop2015/upload/peo-info-exp1.jpg" alt=""/></li>--%>
                <%--<li class="text">姚惠芬，一代“针神”沈寿的第四代传人、新一代绣娘领军人物。</li>--%>
                <%--<li class="text">出生于苏州刺绣世家，自幼学习苏绣，从艺三十多年，精通各种刺绣技法，擅长人物肖像及中国写意水墨画的绣制。</li>--%>
                <%--<li class="text">从一九九一年至今，姚惠芬所创作的苏绣艺术精品几十次荣获省市及国家级工艺美术大奖，被誉为“苏绣传人”、“中华巧女”。</li>--%>
                <%--<li class="text">姚惠芬首创“简针绣”技法，创作出《素描少女肖像》、《葡萄少女肖像》以及《写意牡丹系列》、《写意花鸟系列》等一系列具有高度艺术性和创造性的刺绣作品。</li>--%>
                <%--<li class="text">其作品已被英国“大英博物馆”、“伦敦大学美术馆”等国内外多家博物馆、艺术馆及美国总统小布什、联合国教科文组织总干事博科娃等名人收藏。</li>--%>
                <%--<li class="text">yaohuifen.efeiyi.com</li>--%>
                <%--</ul>--%>
                <%--</div>--%>
            </div>
            <!-- //End--box-des-->
        </div>
        <!-- //End--des-format-->
    </div>
    <!-- //End---->
    <div class="bd details-total-bar">
        <a class="btn-default" href="/tenantOfMobile/${productModel.product.tenant.id}" title="进店">进店</a>
        <a class="btn-default" href="#咨询" title="咨询">咨询</a>
            <a class="btn-cart" data-am-modal="{target: '#my-actions'}" title="放入购物车"><i
                    class="icon"></i>放入购物车</a>
        <a class="btn-buy"data-am-modal="{target: '#my-actions'}" title="立即购买">立即购买</a>
    </div>
</article>

<div class="am-modal-actions dialog-des-format" id="my-actions">
    <div class="bd ">
        <dl class="bd dl-des">
            <dt><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!wap-product-icon" width="130" alt=""/>
            </dt>
            <dd>价格：${productModel.price}</dd>
            <%--<dd>库存：10件</dd>--%>
            <dd>规格</dd>
        </dl>
        <ul class="bd ul-nav">
            <c:if test="${fn:length(productModelList) >1}">
                <c:forEach items="${productModel.product.productModelList}" var="pm">
                    <li> <a href="<c:url value="/product/productModel/${pm.id}"/> ">
                            ${pm.product.name} <c:forEach
                            items="${pm.productPropertyValueList}" var="pv">
                        ${pv.projectPropertyValue.value}
                    </c:forEach>
                    </a></li>
                </c:forEach>
            </c:if>
            <%--<li><a href="#规格2">规格2</a></li>--%>
            <%--<li><a href="#规格1">规格1</a></li>--%>
            <%--<li><a href="#规格2">规格2</a></li>--%>
        </ul>
        <%--<ul class="bd ul-amount">--%>
        <%--<li>购买数量</li>--%>
        <%--<li>--%>
        <%--<a class="sub btn-cart-no" href="#减"></a>--%>
        <%--<input class="ipt-txt" type="text" value="1"/>--%>
        <%--<a class="add" href="#加"></a>--%>
        <%--</li>--%>
        <%--</ul>--%>
        <c:if test="${productModel.amount <= 0}">
            <a  class="bd btn-cart">缺货</a>
        </c:if>
        <c:if test="${productModel.amount > 0}">
            <a href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" class="bd btn-cart">加 入 购 物 车</a>
        </c:if>
    </div>
</div>
<script type="text/javascript">
    function getStatus(o) {
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/product/addProductFavorite.do?id="/>' + o,
            dataType: 'json',
            success: function (data) {
                if(data==true){
                }
            },
        });
    }

    $().ready(function(){

        $("img").each(function(){
            $(this).css("width","100%");
        })

    })
</script>
</body>


</html>
