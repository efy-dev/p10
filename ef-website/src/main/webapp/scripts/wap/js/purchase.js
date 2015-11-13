/**
 * Created by Administrator on 2015/10/20.
 */
$(function(){

    //我的订单tab
    $(function(){
    var mdli = $('.m-order .order-title li');
    var mdbox = $('.m-order .order-content .od-tab1')
    var time = null;

        mdli.click(function(){
            var mthis=$(this);

            mthis.addClass('active').siblings().removeClass('active')

            var index = mthis.index();

            mdbox.eq(index).show().siblings().hide();


        })

    })

    //开团详情tab
    $(function(){
        var coli = $('.colonel-table .c-title ul li')
        var cobox = $('.colonel-table .c-content .co-page')

        coli.click(function(){

            var cothis = $(this)

            cothis.addClass('active').siblings().removeClass('active')

            var index = cothis.index()


            cobox.eq(index).show().siblings().hide();

        })



    })



})()