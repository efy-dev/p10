$(function(){
    //首页
    (function(){
        //导航
        var varnavUlLi=$('.nav .ul-list li');
        var varnavUlW=varnavUlLi.eq(0).height()*varnavUlLi.length;
        $('.btn-menu-down').click(function(){
            var ulList=$(this).siblings('.ul-list');

            $(this).hide().siblings('.btn-menu-up').show();
            ulList.stop(true).animate({'height':varnavUlW+'px'},200);
            $('.btn-menu-up').click(function(){
                $(this).hide().siblings('.btn-menu-down').show();
                ulList.stop(true).animate({'height':'40px'},200);
                return false;
            })
            return false;
        });
        
        //轮播图
        var ulNum=$('.slide-left .focus .am-slider-default .am-control-nav');
        if($(document).width()<970){
            ulNum.css({'margin-left':-ulNum.width()/2+'px'})
        }
        $(window).resize(function(){
            var ulNum=$('.slide-left .focus .am-slider-default .am-control-nav');
            if($(document).width()<970){
                ulNum.css({'margin-left':-ulNum.width()/2+'px','left':'50%'})
            }else{
                ulNum.css({'margin-left':'0','left':'450px'})
            }
        })
    })();

})
