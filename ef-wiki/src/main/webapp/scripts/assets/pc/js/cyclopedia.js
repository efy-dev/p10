/**
 * Created by Administrator on 2015/9/14.
 */
//头部
//$(function(){
//    $('.craft-details .craft-nav  li').click(function(){
//        $(this).addClass('.craft-details .craft-nav active').siblings().removeClass('.craft-details .craft-nav ul active')
//    })
//})

//作品标签

//瀑布流


$(function(){
    //大首页banner
    //$('.home-craft .content-umn li').click(function(){
    //    $('.home-craft .max-banner .content-lbt-img li').eq($(this).index()).fadeIn().siblings().fadeOut();
    //    $(this).addClass('active').siblings().removeClass('active')
    //});
    (function(){
        var $liImg=$('.focus .slider-main li');
        var $liNav=$('.focus .slider-nav li');
        var index=0;
        var timer=null;
        var iSpeed=3000;
        $liImg.eq(0).show();
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
    //
    var cur=0;
    var oUl=$('.craft-content .commodity-list ul');
    var oLiWidth=oUl.find('li').width()+25;
    var oUlWidth=oLiWidth*oUl.find('li').length;
    oUl.css({'width':oUlWidth+'px'});

    $('.left-icon').click(function(){
        cur--;
        if(cur<0){
            cur=0;
        }
        $(this).siblings('.commodity-list').find('ul').animate({'margin-left':oLiWidth*5*cur+'px'},500);
        return false;

    })
    $('.right-icon').click(function(){
        cur++;
        if(cur>1){
            cur=1;
        }
        $(this).siblings('.commodity-list').find('ul').animate({'margin-left':-oLiWidth*5*cur+'px'},500);
        return false;
    })
    //关注
    $('.btn-guan').click(function(){
        $(this).toggleClass('active');
        if($(this).find('.gz-icon').is(':visible')){
            $(this).find('.gz-icon').hide();
            $(this).find('.icon-txl').hide();
        }else{
            $(this).find('.gz-icon').show();
            $(this).find('.icon-txl').show();
        }
        if($(this).hasClass('active')){
            $(this).find('em').html('已关注')
        }else{
            $(this).find('em').html('关注')
        }
        return false;
    })
    //110209工艺详情页-作品简介
    $('.details .detaile-left .detaile-intro .intro-matter li').click(function(){
        $(this).addClass('active').siblings('li').removeClass('active');
        $('.master-tab').eq($(this).index()).show().siblings('.master-tab').hide();
    })


})