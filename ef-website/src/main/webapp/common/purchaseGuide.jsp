<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style type="text/css">
    /* online */
    .purchaseGuide {
        z-index: 9999;
        position: fixed;
    }

    * html .purchaseGuide {
        position: absolute;
        top: expression(eval(document.documentElement.scrollTop));
    }

</style>


<%--<div class="floatRightBar">--%>
    <%--<ul>--%>
        <%--<c:if test="${!empty sessionScope.purchaseGuide}">--%>
            <%--<li style="color: #ffffff;padding-bottom: 22px;">--%>
                <%--<a style="color: #ffffff;">摄影师</a>--%>
                <%--<a id="photographer"></a>--%>
            <%--</li>--%>
            <%--<li style="color: #ffffff;padding-bottom: 22px;">--%>
                <%--<a style="color: #ffffff;" href="/${sessionScope.purchaseGuide.shotType.name}/dress/list">服装</a>:<span id="dress">0</span>--%>
                <%--<a href="/${sessionScope.purchaseGuide.shotType.name}/dress/list" id="chooseDressAddOne"--%>
                   <%--style="color:#ffffff;position: relative;top: -16px;;right: -8px;background-color: red;border-radius: 50px;padding: 0px;font-weight: 600;opacity: 0"><span>+1</span></a>--%>
            <%--</li>--%>
            <%--<li style="color: #ffffff;padding-bottom: 22px;">--%>
                    <%--&lt;%&ndash;<div id="returntop">&nbsp</div>&ndash;%&gt;--%>
                <%--<a style="color: #ffffff;" href="/${sessionScope.purchaseGuide.shotType.name}/scene/list">场景</a>:<span id="scene">0</span>--%>
                <%--<a href="/${sessionScope.purchaseGuide.shotType.name}/scene/list" id="chooseSceneAddOne"--%>
                   <%--style="color:#ffffff;position: relative;top: -16px;;right: -8px;background-color: red;border-radius: 50px;padding: 0px;font-weight: 600;opacity: 0"><span--%>
                        <%-->+1</span></a>--%>
            <%--</li>--%>
            <%--<li style="color: #ffffff;padding-bottom: 22px;">--%>
                    <%--&lt;%&ndash;<div id="returntop">&nbsp</div>&ndash;%&gt;--%>
                <%--<a style="color: #ffffff;" href="/${sessionScope.purchaseGuide.shotType.name}/frame/list">周边产品</a>:<span id="frame">0</span>--%>
                <%--<a href="/${sessionScope.purchaseGuide.shotType.name}/frame/list" id="chooseFrameAddOne"--%>
                   <%--style="color:#ffffff;position: relative;top: -16px;;right: -8px;background-color: red;border-radius: 50px;padding: 0px;font-weight: 600;opacity: 0"><span--%>
                        <%-->+1</span></a>--%>
            <%--</li>--%>

        <%--</c:if>--%>

        <%--<li class="l1"></li>--%>
        <%--<li class="l3">--%>
            <%--<ul class="div3">--%>
                <%--<div class="tc"><a href="#" class="blue"><img src="/scripts/yuepaila/images/common/wx.jpg"/></a>--%>

                    <%--<p class="blue">关注官网微信</p></div>--%>
                <%--<div class="triangle-right div3Tri"></div>--%>
            <%--</ul>--%>
        <%--</li>--%>
        <%--<li class="l5">--%>
            <%--<div id="returntop" onclick="$('html, body').animate({scrollTop: 0}, '500');">&nbsp</div>--%>
        <%--</li>--%>
        <%--<li>--%>
            <%--<a style="margin: -5px;" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2115513944&site=qq&menu=yes"><img--%>
                    <%--border="0" src="http://wpa.qq.com/pa?p=2:2115513944:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>--%>
        <%--</li>--%>
    <%--</ul>--%>
<%--</div>--%>



<div class="floatRightBar">
    <ul>
        <li class="l1"></li>
        <li class="l3">
            <div class="div3">
                <div class="tc"><a href="#"><img src="/scripts/yuepaila/images/common/wx.jpg"/></a><p class="red">关注官网微信</p></div>
                <div class="triangle-right div3Tri"></div>
            </div>
        </li>
        <a href="http://wpa.qq.com/msgrd?v=3&uin=2115513944&site=qq&menu=yes" target="_blank"><li class="l2"></li></a>
        <li class="l5">
            <div id="returntop" onclick="$('html, body').animate({scrollTop: 0}, '500');">&nbsp</div>
        </li>
    </ul>
</div>


<script type="application/javascript" src="/m8/promptWindow.js"></script>

<script>
    <c:if test="${!empty sessionScope.purchaseGuide}">
    var sceneCount = 0;

    function createSceneHtml(scenes, isChange,canselFunc) {
        var out = '';
//        for(var i = 0 ; i<scenes.length ; i++){
//            out+=' <li> <a href="/pc/scene/view.do?id='+(scenes[i].id)+'"> '+(scenes[i].name)+' </a> </li>';
//        }
        out = scenes.length;
        if (isChange == "scene") {
            if (out != sceneCount) {
                $("#chooseSceneAddOne").animate({padding: "10px", opacity: "1"}, "slow", "swing", function () {
                    $("#chooseSceneAddOne").animate({padding: "0px", opacity: "0"});
                });
                showChooseConfirm("提示", "该场景添加成功", function () {

                    location.href="/pc/budget/view.do";
                },canselFunc);
            } else {
                showAlert("提示", "该场景已经被选择！");
            }
        }
        sceneCount = out;
        return out;
    }


    var dressCount = 0;

    function createDressHtml(dresses, isChange,canselFunc) {
        var out = '';
//        for(var i = 0 ; i<dresses.length ; i++){
//            out+=' <li> <a href="/pc/dress/view.do?id='+(dresses[i].id)+'"> '+(dresses[i].name)+' </a> </li>';
//        }
        out = dresses.length;
        if (isChange == "dress") {
            if (out != dressCount) {
                $("#chooseDressAddOne").animate({padding: "10px", opacity: "1"}, "slow", "swing", function () {
                    $("#chooseDressAddOne").animate({padding: "0px", opacity: "0"})
                });

                showChooseConfirm("提示", "该服装添加成功", function () {
                    window.location.href = "/${sessionScope.purchaseGuide.shotType.name}/guide/save.do";
                },canselFunc);
            } else {
                showAlert("提示", "该服装已经被选择！");
            }
        }
        dressCount = out;
        return out;
    }



    function createPhotographerHtml(photographer) {
        var out = '';
        //        out = '<img style="max-height: 60px;max-width: 60px;"src="'+photographer.url+'">';
        out = photographer.name;
        return out;
    }

    var frameCount=0;
    function createPhotoFrameHtml(frames, isChange,canselFunc) {
        var out = '';
//        for(var i = 0 ; i<scenes.length ; i++){
//            out+=' <li> <a href="/pc/scene/view.do?id='+(scenes[i].id)+'"> '+(scenes[i].name)+' </a> </li>';
//        }
        out = frames.length;
        if (isChange == "frame") {
            if (out != frameCount) {
                $("#chooseFrameAddOne").animate({padding: "10px", opacity: "1"}, "slow", "swing", function () {
                    $("#chooseFrameAddOne").animate({padding: "0px", opacity: "0"});
                });
                showChooseConfirm("提示", "该相框添加成功", function () {
                    location.href="/pc/budget/view.do";
                },canselFunc);
            } else {
                showAlert("提示", "该相框已经被选择！");
            }
        }
        frameCount = out;
        return out;
    }

    function purchaseGuideChange(url, ischange, element,isView,shotType) {

        var canselFunc ;

        if (typeof isView != "undefined"){
            canselFunc = function(){
                location.href="/"+shotType+"/"+ischange+"/list";
            }
        }
        jQuery.ajax({
            type: 'get',
            async: false,
            url: url,
            dataType: 'json',
            success: function (data) {
                if (typeof element == "object") {
                    $(element).html("已选择");
                }
                data = JSON.parse(data);
                $("#photographer").html(createPhotographerHtml(data.photographer));
                $("#photographer").attr("href", "/${sessionScope.purchaseGuide.shotType.name}/photographer/" + data.photographer.id);
                $("#dress").html(createDressHtml(data.dresses, ischange,canselFunc));
                $("#scene").html(createSceneHtml(data.scenes, ischange,canselFunc));
                $("#frame").html(createPhotoFrameHtml(data.photoframe,ischange,canselFunc));
            },
            error: function () {
            }
        });
    }


    <c:if test="${!empty sessionScope.purchaseGuide}">

    $().ready(function () {
        jQuery.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/pc/guide/view.do"/>',
            dataType: 'json',
            success: function (data) {
                data = JSON.parse(data);
                $("#photographer").html(createPhotographerHtml(data.photographer));
                $("#photographer").attr("href", "/${sessionScope.purchaseGuide.shotType.name}/photographer/" + data.photographer.id);
                $("#dress").html(createDressHtml(data.dresses, false));
                $("#scene").html(createSceneHtml(data.scenes, false));
                $("#frame").html(createPhotoFrameHtml(data.photoframe, false));
            },
            error: function () {
            }
        });
    });
    </c:if>
    </c:if>
</script>