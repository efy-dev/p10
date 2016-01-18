<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/16 0016
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${subject.name}</title>
    <meta name="description" content="">
</head>
<body>
${subject.subjectDescription.content}

<script>
    function generateQrcode(url){
        $('#table').qrcode({
            render: "div",
            text: url,
            foreground:'#ff0000'
        });
    }
</script>
<script type="text/javascript">
    $(function(){
        (function(){
            $(window).scroll(function(){
                var d=$(document).scrollTop();
                if(d>560){
                    $('#fixed,.btns').fadeIn();
                }else{
                    $('#fixed,.btns').fadeOut(100);
                }
            });
            $('#fixed .top').click(function(){
                $('html,body').animate({'scrollTop':'0'},200);
                return false;
            });
        })();

        var currentButton = "0";

        (function(){
//            $("title").html("“华韵礼遇·中国年”大礼包");$("meta[name=description]").attr("content","e飞蚁为中国传统文化打造系列礼物，为您送上原汁原味的节庆文化。");
            $('#btn-buy').on('click',function(){
                currentButton="0";
                $(".dialog .con .title").html("请选择数量后点击确认按钮");
                $('.dialog').each(function(){
                    $(this).show().addClass('dialog-buy');
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
                currentButton="1";
                $("#table").html("");
                $(".dialog .con .title").html("请选择数量后扫码下单");
                generateQrcode("http://www.efeiyi.com/order/giftBuy/ihykdmfn1k8httnz/1");
                $('.dialog').each(function(){
                    $(this).addClass('dialog-gift').show();
                })
                clickInput();
                $('.btn-true').on('click',function(){
                    var $val=$('#ipt').val();
                    window.location.href ='http://www.efeiyi.com/order/giftBuy/ihykdmfn1k8httnz/'+parseInt($val);
                });
                return false;
            });
            function clickInput(){

                var currentUrl = "";
                if (currentButton=="0"){
                    currentUrl = "http://www.efeiyi.com/order/easyBuy/ihykdmfn1k8httnz?amount=";
                }else {
                    currentUrl = "http://www.efeiyi.com/order/giftBuy/ihykdmfn1k8httnz/"
                }

                $('#add').on('click',function(){
                    var $ipt=$(this).siblings('#ipt');
                    var $val=$ipt.val();
                    $("#table").html("");
                    if($val<99){
                        $ipt.val(parseInt($val)+1);
                    }
                    generateQrcode(currentUrl+$ipt.val());
                });
                $('#sub').on('click',function(){
                    var $ipt=$(this).siblings('#ipt');
                    var $val=$ipt.val();
                    $("#table").html("");
                    if($val>1){
                        $ipt.val(parseInt($val)-1);
                    }
                    generateQrcode(currentUrl+$ipt.val());
                });

                $('#close').on('click',function(){
                    var $div=$(this).parents('.dialog');
                    $('#ipt').val('1');
                    $div.each(function(){
                        $(this).hide().attr('class','dialog');
                        $(this).find('.con').css({
                            'height':'',
                            'margin-top':''
                        });
                        $(this).find('.info').show();
                    });
                    $('#sub,#add').unbind();
                })
            }
        })();
    });
</script>


</body>
</html>
