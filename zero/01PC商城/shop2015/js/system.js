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
        simgLi.mousedown(function(){
            clearInterval(timer);
            index=$(this).index();
            BimgLi.eq(index).fadeIn('200').siblings().fadeOut('200');
            $(this).addClass('active').siblings('li').removeClass('active');
        });
        simgLi.mouseup(function(){
            timer=setInterval(autoRun,iSpeed);
        })
        timer=setInterval(autoRun,iSpeed);
        //自动轮播
        function autoRun(){
            index++;
            if(index>simgLi.length-1){
                index=0;
            }
            BimgLi.eq(index).fadeIn('200').siblings().fadeOut('200');
            simgLi.eq(index).addClass('active').siblings('li').removeClass('active');
        }
        //收藏
        var $add=$('.preview .collect .icon');
        var $hover=$add.siblings('.hover');
        var $active=$add.siblings('.active');
        $add.hover(function(){
            if($active.is(':hidden')){
                $hover.show();
            }else{
                $hover.hide();
            }
        });
        $add.click(function(){
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
    //我的订单
    (function(){
        $('#orderNum .item:last tr').css({'border':'0'});
        $('.clearing-site span a').click(function(){
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
        $('.clearing-site span a').click(function(){
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    })();





})