$(function(){
    //导航
    (function(){
        $('.header .nav li').hover(function(){
           $(this).find('.bgbor').show();
           $(this).addClass('hover').find('.nav-links').stop().slideDown('fast');
        },function(){
            $(this).find('.bgbor').hide();
            $(this).removeClass('hover').find('.nav-links').stop().slideUp('fast');
        })
    })();
    //焦点图
    (function(){
        var $liImg=$('.focus .slider-main li');
        var $liNav=$('.focus .slider-nav li');
        var index=0;
        var timer=null;
        var iSpeed=3000;
        $liNav.mousedown(function(){
            clearInterval(timer);
            index=$(this).index();
            $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
            $(this).addClass('active').siblings('li').removeClass('active');
        });
        $liNav.mouseup(function(){
            timer=setInterval(autoFocus,iSpeed);
        })
        function autoFocus(){
            index++;
            if(index>$liImg.length-1){index=0;}
            $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
            $liNav.eq(index).addClass('active').siblings('li').removeClass('active');
        }
        timer=setInterval(autoFocus,iSpeed);
    })();
    //排序
    (function(){
        $('.shop-sort .link2 dt').click(function(){
            $(this).toggleClass('active').siblings('dd').stop().slideToggle('fast');
        })
    })();
    //商品详情页
    (function(){
        var simgLi=$('.preview .slider-img li');
        var BimgLi=$('.preview .slider-main li');
        var index=0;
        var timer=null;
        var iSpeed=3000;
        simgLi.click(function(){
            clearInterval(timer);
            index=$(this).index();
            BimgLi.eq(index).fadeIn('200').siblings().fadeOut('200');
            $(this).addClass('active').siblings('li').removeClass('active');
        });
        //收藏
        var $add=$('.preview .collect .icon');
        var $hover=$add.siblings('.hover');
        var $active=$add.siblings('.active');
        $add.hover(function(){
            $(this).addClass('icon-active');
            if($active.is(':hidden')){
                $hover.show();
            }else{
                $hover.hide();
            }
        },function(){
            $(this).removeClass('icon-active');
        });
        $add.click(function(){
            $(this).addClass('icon-active2');
            $hover.hide();
            $active.show();
        })
        //固定导航
        $(window).scroll(function(){
            var d=$(document).scrollTop();
            if(d>900){
                $('.tab-wrap').css({'position':'fixed','top':'0'})
            }else{
                $('.tab-wrap').css({'position':'','top':''})
            }
        });
        $('.product-intro .detail .part:last').css({'border':'0'});
        //描点
        $('.tab-items li a').click(function(){
            var pos=$($(this).attr('href')).offset().top;
            $("html,body").animate({scrollTop:pos-75},500);
            return false;
        });
        //规格选中
        $('.itemInfo .ul-list li').click(function(){
            $(this).addClass('active');
        })

    })();
    //注册--协议
    (function(){
        $('#protocol').click(function(){
            $('.thickframe').show();
            return false;
        })
        $('#closeBox,.btnt .btn-img').click(function(){
            $('.thickframe').hide();
            return false;
        })
    })();
    //收货地址
    (function(){
        $('.my-order .extra-r>a').click(function(){
            $(this).siblings('.active-pop').show();
            $('.my-order .clase, .my-order .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    })();
    //商品搜索
    (function(){
        $('.nav-item .title').click(function(){
            $(this).find('.icon').toggleClass('icon-active');
            $(this).siblings('.ul-list').stop().slideToggle(200);
            $(this).parents('.nav-item').find('.ul-list')
        })
    })();
    //商品详情页
    (function(){

    })();

})
