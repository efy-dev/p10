$(function(){
    //首页
    (function(){
        //导航
        var navUl=$('.nav .ul-list');
        var navUlLi=navUl.find('li');
        var navUlLiActive=$('.nav .ul-list li.active');
        var navUlW=navUlLi.eq(0).height()*navUlLi.length;
        $('.btn-menu-down').click(function(){
            var ulList=$(this).siblings('.ul-list');

            $(this).hide().siblings('.btn-menu-up').show();
            ulList.stop(true).animate({'height':navUlW+'px'},200);
            $('.btn-menu-up').click(function(){
                $(this).hide().siblings('.btn-menu-down').show();
                ulList.stop(true).animate({'height':'40px'},200);
                return false;
            })
            return false;
        });
        //判断导航显示
        if($(document).width()<640){
            navUlLiActive.hide();
            navUlLi.eq(0).before('<li class="title">'+navUlLiActive.find('a').html()+'</li>')
        }
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

    //
    (function(){
       $('.org .slide-left .nav-list-ul li').click(function(){
           $(this).toggleClass('active');
           $(this).find('.items-list').stop(true).slideToggle();
           return false
       })
    })();

})
