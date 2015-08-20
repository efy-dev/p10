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
        $('.preview .collect .icon').hover(function(){
            $(this).siblings('.hover').show();

        },function(){
            $(this).siblings('.hover').hide();
        });
        $('.preview .collect .icon').click(function(){
            $(this).siblings('.active').show();
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


        $('.tab-items li a').click(function(){
            var pos=$(this).attr('id');
            $("html,body").animate({scrollTop: pos}, 1000);
        })

        //function goto(elements) {
        //    var pos = 0;
        //    if (elements !== "") {
        //        // 定义将要去的描点位置
        //        pos = $(elements).offset().top;
        //    }
        //    $("html,body").animate({scrollTop: pos-20}, 1000);
        //}





    })();
})

$(function(){

})