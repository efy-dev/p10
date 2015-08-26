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

    })();

})