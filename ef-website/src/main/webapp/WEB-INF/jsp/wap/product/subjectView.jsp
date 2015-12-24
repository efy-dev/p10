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
                window.location.href ='http://www.efeiyi.com/order/easyBuy/ihykdmfn1k8httnz?amount='+parseInt($val);
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
                window.location.href ='http://www.efeiyi.com/order/giftBuy/ihykdmfn1k8httnz/'+parseInt($val);
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