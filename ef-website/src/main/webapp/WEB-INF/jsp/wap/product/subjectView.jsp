<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>【 精选专题 】 -e飞蚁</title>
    <meta name="description" content="">
    <style>
        .list-class .ul-list-img p {
            padding: 0;
        }
    </style>
    <script>

        var wx_share_title = "“华韵礼遇·中国年”大礼包"; //分享标题
        var wx_share_des = "e飞蚁为中国传统文化打造系列礼物，为您送上原汁原味的节庆文化！";  //分享描述
        var wx_share_link = ""; //分享的链接地址  //需要动态获取，而不是直接填写静态值
        var wx_share_imgUrl = "http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/Clipboard%20Image.png"; //分享图片的url
        var wx_share_type = '';   //分享的类型   分享类型,music、video或link，不填默认为link
        var wx_share_dataUrl = ""; // 如果type是music或video，则要提供数据链接，默认为空
        var wx_api_list = ['onMenuShareAppMessage', 'onMenuShareTimeline'];    //需要使用的JS接口列表

    </script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="<c:url value="/scripts/wap/js/weixin.js"/>"></script>

    <script>
        initWx("http://mall.efeiyi.com/wx/init.do");
    </script>
</head>
<body>
<artice class="custom">
    <div class="bd list-class">
        <ul class="bd ul-list-img">
            <li><p>${subject.subjectDescription.content}</p></li>
        </ul>
        <ul class="bd ul-list">
            <c:forEach items="${productModelList}" var="productModel">
                <li class="bd">
                    <a href="<c:url value="/product/productModel/${productModel.productModel.id}"/>">
                        <img width="100%"
                             src="http://pro.efeiyi.com/${productModel.productModel.productModel_url}@!product-model"
                             alt="">

                        <p class="name">${productModel.productModel.product.name}</p>

                        <p class="price red"><em>￥</em><span>${productModel.productModel.price}</span></p>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
</artice>
<script>
    $().ready(function () {
        $("img").each(function () {
            $(this).css("width", "100%");
        })
    });
</script>
<script type="text/javascript">

    var msg_desc = "e飞蚁为中国传统文化打造系列礼物<br>为您送上原汁原味的节庆文化。";


    $(function(){
        $("title").html("“华韵礼遇·中国年”大礼包");$("meta[name=description]").attr("content","e飞蚁为中国传统文化打造系列礼物，为您送上原汁原味的节庆文化。");
        $('#btn-buy').on('click',function(){
            $('.dialog').each(function(){
                $(this).show();
                $(this).find('.con').css({
                    'height':'230px',
                    'margin-top':'-115px'
                });
                $(this).find('.info').hide();
            });
            clickInput();
            $('.btn-true').on('click',function(){
                var $val=$('#ipt').val();
                window.location.href ='http://mall.efeiyi.com/order/easyBuy/ihykdmfn1k8httnz?amount='+parseInt($val);
            });
            return false;
        });
        $('#btn-gift').on('click',function(){
            $('.dialog').each(function(){
                $(this).show();
            })
            clickInput();
            $('.btn-true').on('click',function(){
                var $val=$('#ipt').val();
                window.location.href ='http://mall.efeiyi.com/order/giftBuy/ihykdmfn1k8httnz/'+parseInt($val);
            });
            return false;
        });
        function clickInput(){
            $('#add').on('click',function(){
                var $ipt=$(this).siblings('#ipt');
                var $val=$ipt.val();
                if($val<99){
                    $ipt.val(parseInt($val)+1);
                }
            });
            $('#sub').on('click',function(){
                var $ipt=$(this).siblings('#ipt');
                var $val=$ipt.val();
                if($val>1){
                    $ipt.val(parseInt($val)-1);
                }
            });

            $('#close').on('click',function(){
                var $div=$(this).parents('.dialog');
                $div.each(function(){
                    $(this).hide();
                    $(this).find('.con').css({
                        'height':'',
                        'margin-top':''
                    });
                    $(this).find('.info').show();
                });
                $('#ipt').val('1');
                $('body').css('overflow','visible');

                $('#add,#sub').unbind();
            });
        }
    })
</script>


</body>
</html>