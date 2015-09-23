/**
 * Created by Administrator on 2015/9/14.
 */
$(function(){
    //动态--关注--分类导航
    (function(){
        var tabsNav=$('.dis-q1-tabs .tabs-nav-1');
        tabsNav.find('.item').click(function(){
            $(this).addClass('active').siblings('.item').removeClass('active');
        })
        tabsNav.find('.item-class').click(function(){
            tabsNav.hide().siblings('.tabs-nav-2').show();
            return false
        })

        



    })();
})




//zhan_kai
$(function(){
    $('unwind').click(function(){
       $('texp').css('height','auto');
    })
})



//tan-chu-kuang
$(document).ready(function(){
    $('#acs').click(function(){
        $('#showMessage').show();
        return false})
})



//zhan-kai
$(document).ready(function(){
    $('#zk').click(function(){
        $('.texp').css('height','auto');
        return false
    })
})


////fenxiang
//$(document).ready(function(){
//    $('#fxq').click(function(){
//        $('#fx').show();
//        return false
//    })
//})