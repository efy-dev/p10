/**
 * Created by Administrator on 2015/7/28.
 */
function showAlert(title,content,callBack){//提示框标题，及提示内容. 为空时，使用默认值
    getAlertDiv();
    if(title!=null&&""!=title){
        $("#my-alert .am-modal-hd").html(title);
    }
    if(content!=null&&""!=content){
        $("#my-alert .am-modal-bd").html(content);
    }
    if(callBack){
        $('#my-alert').on('closed.modal.amui',callBack);
    }
    $('#my-alert').modal();
}

function getAlertDiv(){//动态添加提示框内容到当前页面
    $("#my-alert").remove();
    $("body").append("<div class=\"am-modal am-modal-alert\" tabindex=\"-1\" id=\"my-alert\">"+
        "<div class=\"am-modal-dialog\">"+
        "<div class=\"am-modal-hd\">哎呀</div>"+
        "<div class=\"am-modal-bd\">"+
        "操作没成功！"+
        "</div>"+
        "<div class=\"am-modal-footer\">"+
        "<span class=\"am-modal-btn\">确定</span>"+
        "</div>"+
        "</div>"+
        "</div>");
}

function showConfirm(title,content,confirmFunc){
    getConfirmDiv();
    if(title!=null&&""!=title){
        $("#my-confirm .am-modal-hd").html(title);
    }
    if(content!=null&&""!=content){
        $("#my-confirm .am-modal-bd").html(content);
    }
    $('#my-confirm').modal({
        relatedElement: this,
        onConfirm: confirmFunc
    });

}

function getConfirmDiv(){//动态添加确认框内容到当前页面
    $("#my-confirm").remove();
    $("body").append("<div class=\"am-modal am-modal-confirm\" tabindex=\"-1\" id=\"my-confirm\">"+
        "<div class=\"am-modal-dialog\">"+
        "<div class=\"am-modal-hd\">提示</div>"+
        "<div class=\"am-modal-bd\">"+
        "您确定继续此操作吗?"+
        "</div>"+
        "<div class=\"am-modal-footer\">"+
        "<span class=\"am-modal-btn\" data-am-modal-cancel>取消</span>"+
        "<span class=\"am-modal-btn\" data-am-modal-confirm>确定</span>"+
        "</div>"+
        "</div>"+
        "</div>");
}

function showPrompt(title,content,confirmFunc){
    getPromptDiv();
    if(title!=null&&""!=title){
        $("#my-prompt .am-modal-hd").html(title);
    }
    if(content!=null&&""!=content){
        $("#my-prompt .am-modal-bd span").html(content);
    }
    $('#my-prompt').modal({
        relatedElement: this,
        onConfirm: confirmFunc
    });
}

function getPromptDiv(){
    $('#my-prompt').remove();
    $('body').append('<div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">'+
        '<div class="am-modal-dialog">'+
        '<div class="am-modal-hd">提示</div>'+
        '<div class="am-modal-bd">'+
        '<span>您确定继续此操作吗?</span>'+
        '<input type="text" class="am-modal-prompt-input">'+
        '</div>'+
        '<div class="am-modal-footer">'+
        '<span class="am-modal-btn" data-am-modal-cancel>取消</span>'+
        '<span class="am-modal-btn" data-am-modal-confirm>确定</span>'+
        '</div>'+
        '</div>'+
        '</div>');
}

function showChooseConfirm(title,content,confirmFunc,cancelFunc){
    getChooseConfirmDiv();
    if(title!=null&&""!=title){
        $("#my-confirm .am-modal-hd").html(title);
    }
    if(content!=null&&""!=content){
        $("#my-confirm .am-modal-bd").html(content);
    }
    $('#my-confirm').modal({
        relatedElement: this,
        onConfirm: confirmFunc,
        onCancel:cancelFunc
    });

}

function getChooseConfirmDiv(){//动态添加确认框内容到当前页面
    $("#my-confirm").remove();
    $("body").append("<div class=\"am-modal am-modal-confirm\" tabindex=\"-1\" id=\"my-confirm\">"+
        "<div class=\"am-modal-dialog\">"+
        "<div class=\"am-modal-hd\">提示</div>"+
        "<div class=\"am-modal-bd\">"+
        "您确定继续此操作吗?"+
        "</div>"+
        "<div class=\"am-modal-footer\">"+
        "<span class=\"am-modal-btn\" data-am-modal-cancel>支付遇到问题？</span>"+
        "<span class=\"am-modal-btn\" data-am-modal-confirm>支付完成</span>"+
        "</div>"+
        "</div>"+
        "</div>");
}

function showIframe(iframeHtml){

}
