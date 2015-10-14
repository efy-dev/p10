/**
 * Created by Administrator on 2015/8/25.
 */
window.onload = function()
{
    document.getElementsByClassName('doc-vld-ta-2').onkeydown = function()
    {
        if(this.value.length >= 45)
            event.returnValue = false;
    }
}
$(function(){
    $('.discount .employ a').click(function(){
        $(this).addClass('yhq-active').siblings().removeClass('yhq-active');
    })
})

