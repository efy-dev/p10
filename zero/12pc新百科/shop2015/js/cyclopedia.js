/**
 * Created by Administrator on 2015/9/14.
 */
//�ٿ���ҳ�ֲ�ͼ
$(function(){
    $('.cyclopedia .show .content .content-lbt .content-umn li').click(function(){
        $('.cyclopedia .show .content .content-lbt .content-lbt-img li').eq($(this).index()).fadeIn().siblings().fadeOut();
        $(this).addClass('active').siblings().removeClass('active')
    })
})