$(function(){
    //头部无logoA
    $('#menu').click(function(){
        $('.menu-list').slideToggle('fast');
    });
    //购物车
    (function(){
        $('.icon-delete').click(function(){
           $('.alert-delete').fadeIn('fast');
        })

        $('.edit-dete').click(function(){
            $('.alert-delete').fadeIn('fast');
            return false;
        })

        if($('div').hasClass('payment-total-bar')){
            $('article').css({'padding-bottom':'50px'})
        }
    })();





})