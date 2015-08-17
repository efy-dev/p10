$(function(){
    //焦点图
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
})

$(function(){
    $('.shop-sort .link2 dt').click(function(){
        $(this).toggleClass('active').siblings('dd').slideToggle('fast');
    })
})