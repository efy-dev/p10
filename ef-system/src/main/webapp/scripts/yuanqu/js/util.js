function ajaxRequest(url, param, success) {
    $.ajax({
        crossDomain: true,
        type: "post",
        url: url,
        cache: false,
        dataType: "json",
        data: param,
        success: function (data) {
            //1.处理data当中的错误信息
            success(data);
        }
    });

    $.ajaxSetup({
        type: "POST",
        error: function (jqXHR, textStatus, errorThrown) {
            $("#my-modal-loading").modal("close");
            switch (jqXHR.status) {
                case(500):
                    showAlert("提示", "服务器出错啦，请联系管理员。。。");
                    break;
                case(401):
                    showAlert("提示", "请先登录！");
                    break;
                case(403):
                    showAlert("提示", "您没有执行该操作的权限！");
                    break;
                case(408):
                    showAlert("提示", "服务器繁忙，请稍后重试");
                    break;
                default:
                    showAlert("提示", "未知错误，请联系管理员。。。");
            }
        }
    });
}
function renderTemplate(templateId, data) {
    $("[dot-template=" + templateId + "]").html(doT.template($("#" + templateId).text())(data));
}
Date.prototype.format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1,                 //月份
        "d+": this.getDate(),                    //日
        "h+": this.getHours(),                   //小时
        "m+": this.getMinutes(),                 //分
        "s+": this.getSeconds(),                 //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds()             //毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};