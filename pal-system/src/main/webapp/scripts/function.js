var m8uDialog = $.extend({}, m8uDialog);

function dialog1(url, artDialogLogId, artDialogLogName, modalTitle,url2) {
    var modalStart = "<div class=\"am-modal am-modal-no-btn\" id=\"modalSelect\">" +
                            "<div class=\"am-modal-dialog\">" +
                                "<div class=\"am-modal-hd\">" + modalTitle +
                                    "<span data-am-modal-close class=\"am-close\">&times;</span>" +
                                "</div>" +
                                "<div>" +
                                    "<label>名&nbsp;&nbsp;称: &nbsp;</label>"+
                                    "<input type=\"text\" id=\"modalName\" placeholder=\"名称\">"+
                                    "<input type=\"button\" onclick=\"selectPS('"+artDialogLogId+"','"+artDialogLogName+"','"+url2+"')\" value=\"查询\">"+
                                "</div>"+
                                "<div class=\"am-modal-bd\"> "+
                                    "<div id=\"selectItemDiv\" style=\"height: 200px;overflow-y: auto\">";
    var modalEnd = "</div></div> </div> </div>";
    var modalContent = "";
    this.key = "";
    this.dataType = "";
    this.required = "";
    console.log($("#modalSelect").attr("id"));
    $.ajax({
        type: "post",
        url: url,
        cache: false,
        dataType: "json",
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                modalContent += "<div class=\"am-u-md-4\">" +
                    "<a href=\"javascript:void(0);\" onclick=\"choose(this,'" + artDialogLogId + "','" + artDialogLogName + "')\" name=\"" + data[i].name + "\" id=\"" + data[i].id + "\">" + data[i].name + "</a>" +
                    "</div>";
            }
            if(data.length == 0){
                modalContent = "<div style='color: red'>没有您需要的信息!</div>";
            }
            var out = modalStart + modalContent + modalEnd;
            if (typeof $("#modalSelect").attr("id") != "undefined") {
                var modalDiv = document.getElementById("modalSelect");
                modalDiv.parentNode.removeChild(modalDiv);
            }
            $("body").append(out);
            $("#modalSelect").modal({
                width: 500, height: 300
            });
        }
    });
}

var selectPS=function(artDialogLogId, artDialogLogName, url){
    var name = $("#modalName").val();
    var modalContent = "";
    var newUrl = encodeURI(url+name);
    $.ajax({
        type: "post",
        url: newUrl,
        cache: false,
        dataType: "json",
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                modalContent += "<div class=\"am-u-md-4\">" +
                    "<a href=\"javascript:void(0);\" onclick=\"choose(this,'" + artDialogLogId + "','" + artDialogLogName + "')\" name=\"" + data[i].name + "\" id=\"" + data[i].id + "\">" + data[i].name + "</a>" +
                    "</div>";
            }
            if(data.length == 0){
                modalContent = "<div style='color: red'>没有您需要的信息!</div>";
            }
            $("#selectItemDiv").html(modalContent);
        }
    });
}

function choose(element, artDialogLogId, artDialogLogName) {
    $("#" + artDialogLogId).attr("value", $(element).attr("id"));
    $("#modalSelect").modal('close');
    $("#" + artDialogLogName).attr("value", $(element).attr("name"));
}

m8uDialog.openDialog = function (artDialogLogId, artDialogLogName, type, condition, basePath) {
    var modalTitle = "";
    var url = basePath;
    var url2 = "";
    if (type == 'tenant') {     /*所有商户*/
        url = url + '/tenant/list/json';
        url2 = basePath + '/tenantLikesName/list/json?name=';
        modalTitle =  '选择商户';
    } else if (type == 'product') {       /*所有商品*/
        url = url + '/product/list/json';
    } else if (type == 'order') {       /*订单*/
        url = url + '/order/list/json';
    } else if (type == 'productSeries') {       /*所有商品系列*/
        url = url + '/productSeries/list/json';
        url2 = basePath + '/productSeriesLikesName/list/json?name=';
        modalTitle = '选择非遗项目';
    } else if (type == 'certification') {       /*商品认证信息*/
        url = url + '/tenantCertification/list/json?conditions=tenant.id:' + condition;
        url2 = basePath + '/tenantCertificationLikesName/list/json?tenantId='+ condition +'&name=';
        modalTitle = '选择认证信息';
    } else if (type == 'product2') {       /*商户的所有商品*/
        url = url + '/product2/list/json?conditions=tenant.id:' + condition;
        url2 = basePath + '/product2LikesName/list/json?tenantId='+ condition +'&name=';
        modalTitle = '选择商品';
    } else if (type == 'user') {       /*所有用户*/
        url = url + '/user/list/json';
    } else if (type == 'seriesByTenantNull') {/*商户为空时商户系列中所有系列*/
        url = url + '/seriesByTenantNull/list/json';
        url2 = basePath + '/seriesByTenantNullLikesName/list/json?name=';
        modalTitle = '选择非遗项目';
    } else if (type == 'seriesByTenant') {/*商户系列中某个商户包含的所有系列*/
        url = url + '/seriesByTenant/list/json?conditions=tenant.id:' + condition;
        url2 = basePath + '/seriesByTenantLikesName/list/json?tenantId='+ condition +'&name=';
        modalTitle = '选择非遗项目';
    } else if (type == 'TenantBySeriesNull') {/*系列为空时商户系列中所有商户*/
        url = url + '/TenantBySeriesNull/list/json';
        url2 = basePath + '/TenantBySeriesNullLikesName/list/json?name=';
        modalTitle =  '选择商户';
    } else if (type == 'TenantBySeries') {/*商户系列中某个系列包含的所有商户*/
        url = url + '/TenantBySeries/list/json?conditions=productSeries.id:' + condition;
        url2 = basePath + '/TenantBySeriesLikesName/list/json?tenantId='+ condition +'&name=';
        modalTitle =  '选择商户';
    }

    dialog1(url, artDialogLogId, artDialogLogName, modalTitle, url2);
};

function testAjaxSubmitForm(formId, url) {
    if (afterSubmitForm(formId)){
        $.ajax({
            type: "post",
            url: url,
            data: $("#" + formId).serialize(),
            cache: false,
            dataType: "json",
            success: function (data) {
                document.getElementById(formId).reset();
                window.location.href = data;
            },
            error: function (message) {
                alert(message.responseText);
            }
        });
    }
}

function afterSubmitForm(formId){
    var form2 = document.getElementById(formId);
    var a = form2.elements.length;//所有的控件个数
    for (var j=0;j<a;j++){
        if(form2.elements[j].required){
            if(form2.elements[j].value=="" || form2.elements[j].value==null){
                alert(form2.elements[j].title + "不能为空");
                form2.elements[j].focus();
                return false;
            }
        }
    }
    return true;
}

function myConfirm(url, type){
    var DValue=document.getElementById("DValue");
    var AValue=document.getElementById("AValue");
    var CValue=document.getElementById("CValue");
    var CAValue=document.getElementById("CAValue");
    var CLValue=document.getElementById("CLValue");
    if(type == "D"){
        DValue.setAttribute("style","display");
        AValue.setAttribute("style","display:none");
        CValue.setAttribute("style","display:none");
        CAValue.setAttribute("style","display:none");
        CLValue.setAttribute("style","display:none");
    }
    if(type == "A"){
        DValue.setAttribute("style","display:none");
        AValue.setAttribute("style","display");
        CValue.setAttribute("style","display:none");
        CAValue.setAttribute("style","display:none");
        CLValue.setAttribute("style","display:none");
    }
    if(type == "C"){//作废一个订单下所有标签
        DValue.setAttribute("style","display:none");
        AValue.setAttribute("style","display:none");
        CValue.setAttribute("style","display");
        CAValue.setAttribute("style","display:none");
        CLValue.setAttribute("style","display:none");
    }
    if(type == "CA"){//作废一个标签
        DValue.setAttribute("style","display:none");
        AValue.setAttribute("style","display:none");
        CValue.setAttribute("style","display:none");
        CAValue.setAttribute("style","display");
        CLValue.setAttribute("style","display:none");
    }
    if(type == "CL"){//作废一个标签
        DValue.setAttribute("style","display:none");
        AValue.setAttribute("style","display:none");
        CValue.setAttribute("style","display:none");
        CAValue.setAttribute("style","display:none");
        CLValue.setAttribute("style","display");
    }

    $('#my-confirm').modal({
        //width:300,
        //height:100,
        onConfirm: function() {
            if(type == "CA" || type == "CL"){
                cancelLabel(url)
            }else {
                window.location.href = url;
            }
        },
        onCancel: function() {
        }
    });
}

function cancelLabel(url){
    $.ajax({
        type: "post",
        url: url,
        cache: false,
        dataType: "json",
        success: function (data) {
            window.location.reload();
        },
        error: function (message) {
            alert(message.responseText);
        }
    });
}

function addNewNode(){
    var count = document.getElementById("count").value;
    var size = parseInt(count);
    var i = size;
    i += 1;
    var nameIdDiv = document.createElement("div");
    nameIdDiv.innerHTML = "<input type='hidden' name='propertyNameId"+i+"'>";
    var newDiv = document.createElement("div");
    var html = "<div class=\"am-form-group\" style=\"child-align: left\">"+
        "<label name=\"name\" for=\"name"+i+"\" class=\"am-u-sm-3 am-form-label\" style=\"width: auto\">"+i+"、</label>"+
        "<div class=\"am-u-sm-9\">"+
        "<input type=\"text\" name=\"name"+i+"\" id=\"name"+i+"\" placeholder=\"属性名\" required>"+
        "</div>"+
        "<div style=\"text-align: left;text-align: left;\">"+
        "<input onclick='deleteNode(\"divPP" + i +"\");'"+
        "type=\"button\" class=\"am-btn am-btn-default am-btn-xs am-text-danger\""+
        "style=\"margin-bottom: 6px;margin-left:2px;height: 35px;\""+
        "value=\"删除\" />"+
        "</div>"+
        "</div>";
    newDiv.innerHTML = html;
    newDiv.id = "divPP"+i;
    document.getElementById("pNameForm").appendChild(nameIdDiv);
    document.getElementById("pNameForm").appendChild(newDiv);
    if(size == 0){
        size = i;
        document.getElementById("count").value =  size;
    }else {
        document.getElementById("count").value =  size + 1;
    }
}

function deleteNode(val){
    if(val instanceof HTMLElement){
        val.parentNode.removeChild(val);
    }else {
        var delDiv = document.getElementById(val);
        delDiv.parentNode.removeChild(delDiv);
    }
}

function selectObjectSubmit(divId){
    //var LType = document.getElementById("POType");
    var LType = document.getElementById(divId);
    var type = LType.firstElementChild.value;
    if(type == null || type == ""){
        alert("请选择标签类型");
        return false;
    } else {
        return true;
    }
}