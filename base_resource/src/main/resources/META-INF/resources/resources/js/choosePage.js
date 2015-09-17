/**
 * Created by Administrator on 2015/9/9 0009.
 */

var currentDivId = ""

//选中的时候在父文档中被调用 带real后缀的为id值 type=hidden
function pChoosed(divid, modelId, modelName) {
    $("#" + divid).val(modelName);
    $("#" + divid + "real").val(modelId);
    $("#iframe").hide();
    $('#iframe').attr('src', $('#iframe').attr('src'));
}

function iframeInit(){
    $($(window.frames[0].document).find("#initIframe")).attr("name", currentDivId)
    $($(window.frames[0].document).find("#initIframe")).click();
}

$().ready(function () {

    var iframe = '<iframe id="iframe" name="iframe"style="position: fixed;height: 100%;width: 100%;background: black;background: rgba(0,0,0,0.45);z-index: 98;display: none;top: 0;left: 0;display: none"></iframe>'
    $("body").append(iframe);
    // url新建BaseChoose的链接 param新建BaseChoose的参数  target跳转页面的路径  finish选择完成之后的接口
    $("[data-efy-choose-input]").each(function () {
        $(this).click(function () {
            currentDivId = $(this).attr("id")
            var target = $(this).attr("target");
            var finish = $(this).attr("finish")
            var divId = $(this).attr("id");
            $("#iframe").attr("src", target);
            $("#iframe").show()
            //setTimeout(function () {
            //    $($(window.frames[0].document).find("#initIframe")).attr("name", divId)
            //    $($(window.frames[0].document).find("#initIframe")).click();
            //},1000);
            //console.log($($(window.frames[0].document).find("#initIframe")).attr("name", divId));
            //$($(window.frames[0].document).find("#initIframe")).attr("name", divId);
        });
    })

})
