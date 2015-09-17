var m8uDialog = $.extend({}, m8uDialog);

function dialog1(url, artDialogLogId, artDialogLogName) {
    var modalStart = "<div class=\"am-modal am-modal-no-btn\" id=\"" + artDialogLogId + artDialogLogName + "\">" +
        "<div class=\"am-modal-dialog\">" +
        "<div class=\"am-modal-hd\">" +
        "<span data-am-modal-close class=\"am-close\">&times;</span>" +
        "</div>" +
        "<div class=\"am-modal-bd\"> ";
    var modalEnd = "</div> </div> </div>";
    var modalContent = "";
    this.key = "";
    this.dataType = "";
    this.required = "";
    console.log($("#" + artDialogLogId + artDialogLogName).attr("id"));
    if (typeof $("#" + artDialogLogId + artDialogLogName).attr("id") == "undefined") {
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
                if (data.length == 0) {
                    modalContent = "<div style='color: red'>没有您需要的信息!</div>";
                }
                var out = modalStart + modalContent + modalEnd;
                $("body").append(out);
                $("#" + artDialogLogId + artDialogLogName).modal({
                    width: 500, height: 300
                });
            }
        });
    } else {
        $("#" + artDialogLogId + artDialogLogName).modal({
            width: 500, height: 300
        });
    }
}

function dialog2(url, artDialogLogId, artDialogLogName) {
    var modalStart = "<div class=\"am-modal am-modal-no-btn\" id=\"" + artDialogLogId + artDialogLogName + "\">" +
        "<div class=\"am-modal-dialog\">" +
        "<div class=\"am-modal-hd\">" +
        "<span data-am-modal-close class=\"am-close\">&times;</span>" +
        "</div>" +
        "<div class=\"am-modal-bd\"> ";
    var modalEnd = "</div> </div> </div>";
    var modalContent = "";
    this.key = "";
    this.dataType = "";
    this.required = "";
    console.log($("#" + artDialogLogId + artDialogLogName).attr("id"));

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
            var out = modalStart + modalContent + modalEnd;
            if (typeof $("#" + artDialogLogId + artDialogLogName).attr("id") != "undefined") {
                var modalDiv = document.getElementById(artDialogLogId + artDialogLogName);
                modalDiv.parentNode.removeChild(modalDiv);
            }
            $("body").append(out);
            $("#" + artDialogLogId + artDialogLogName).modal({
                width: 500, height: 300
            });
        }
    });
}

function choose(element, artDialogLogId, artDialogLogName) {
    $("#" + artDialogLogId).attr("value", $(element).attr("id"));
    $("#" + artDialogLogId + artDialogLogName).modal('close');
    $("#" + artDialogLogName).attr("value", $(element).attr("name"));
}

m8uDialog.openDialog = function (artDialogLogId, artDialogLogName, type, condition, basePath) {
    var url = basePath;
    if (type == 'tenant') {     /*所有商户*/
        url = url + '/tenant/list/json';
    } else if (type == 'product') {       /*所有商品*/
        url = url + '/product/list/json';
    } else if (type == 'order') {       /*订单*/
        url = url + '/order/list/json';
    } else if (type == 'productSeries') {       /*所有商品系列*/
        url = url + '/productSeries/list/json';
    } else if (type == 'certification') {       /*商品认证信息*/
        url = url + '/tenantCertification/list/json?conditions=tenant.id:' + condition;
    } else if (type == 'product2') {       /*商户的所有商品*/
        url = url + '/product2/list/json?conditions=tenant.id:' + condition;
    } else if (type == 'user') {       /*所有用户*/
        url = url + '/user/list/json';
    } else if (type == 'seriesByTenantNull') {/*商户为空时商户系列中所有系列*/
        url = url + '/seriesByTenantNull/list/json';
    } else if (type == 'seriesByTenant') {/*商户系列中某个商户包含的所有系列*/
        url = url + '/seriesByTenant/list/json?conditions=tenant.id:' + condition;
    } else if (type == 'TenantBySeriesNull') {/*系列为空时商户系列中所有商户*/
        url = url + '/TenantBySeriesNull/list/json';
    } else if (type == 'TenantBySeries') {/*商户系列中某个系列包含的所有商户*/
        url = url + '/TenantBySeries/list/json?conditions=productSeries.id:' + condition;
    }

    if (type == "seriesByTenantNull" || type == "seriesByTenant" || type == "TenantBySeriesNull" || type == "TenantBySeries") {
        dialog2(url, artDialogLogId, artDialogLogName);
    } else {
        dialog1(url, artDialogLogId, artDialogLogName);
    }
};

function testAjaxSubmitForm(formId, url) {
    if (afterSubmitForm(formId)) {
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
                //alert(message.responseText);
                if (message.status == 200) {
                    window.location.href = message.responseText;
                }
            }
        });
    }
}

function afterSubmitForm(formId) {
    var form2 = document.getElementById(formId);
    var a = form2.elements.length;//所有的控件个数
    for (var j = 0; j < a; j++) {
        if (form2.elements[j].required) {
            if (form2.elements[j].value == "" || form2.elements[j].value == null) {
                alert(form2.elements[j].placeholder + "不能为空");
                form2.elements[j].focus();
                return false;
            }
        }
    }
    return true;
}

function myConfirm(url, type) {
    var DValue = document.getElementById("DValue");
    var AValue = document.getElementById("AValue");
    var CValue = document.getElementById("CValue");
    var CAValue = document.getElementById("CAValue");
    var CLValue = document.getElementById("CLValue");
    if (type == "D") {
        DValue.setAttribute("style", "display");
        AValue.setAttribute("style", "display:none");
        CValue.setAttribute("style", "display:none");
        CAValue.setAttribute("style", "display:none");
        CLValue.setAttribute("style", "display:none");
    }
    if (type == "A") {
        DValue.setAttribute("style", "display:none");
        AValue.setAttribute("style", "display");
        CValue.setAttribute("style", "display:none");
        CAValue.setAttribute("style", "display:none");
        CLValue.setAttribute("style", "display:none");
    }
    if (type == "C") {//作废一个订单下所有标签
        DValue.setAttribute("style", "display:none");
        AValue.setAttribute("style", "display:none");
        CValue.setAttribute("style", "display");
        CAValue.setAttribute("style", "display:none");
        CLValue.setAttribute("style", "display:none");
    }
    if (type == "CA") {//作废一个标签
        DValue.setAttribute("style", "display:none");
        AValue.setAttribute("style", "display:none");
        CValue.setAttribute("style", "display:none");
        CAValue.setAttribute("style", "display");
        CLValue.setAttribute("style", "display:none");
    }
    if (type == "CL") {//作废一个标签
        DValue.setAttribute("style", "display:none");
        AValue.setAttribute("style", "display:none");
        CValue.setAttribute("style", "display:none");
        CAValue.setAttribute("style", "display:none");
        CLValue.setAttribute("style", "display");
    }

    $('#my-confirm').modal({
        //width:300,
        //height:100,
        onConfirm: function () {
            if (type == "CA" || type == "CL") {
                cancelLabel(url)
            } else {
                window.location.href = url;
            }
        },
        onCancel: function () {
            //alert('算求，不弄了');
        }
    });
}

function cancelLabel(url) {
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


//新增几个
function switchReadOnly(cid, bool, urll, propertyName) {
    var inputTag = document.getElementById(cid);

    if (bool) {
        $(inputTag).attr("readonly", "readonly")//将input元素设置为readonly
        var inputTags = document.getElementsByName($(inputTag).attr("name"));
        var getData = getGetDataByPropertyName(inputTags, propertyName);
        var url = urll + getData;
        doAjaxByUrl(url);
    } else {
        $(inputTag).removeAttr("readonly");//去除input元素的readonly属性
    }
}


function doAjaxByUrl(url) {
    $.ajax({
        type: "get",
        //async: "false",
        url: url,
        success: function (data) {
        },
        error: function (error, a, b) {
            //alert(error.responseText + "|" + a + "|" + b);
        }
    });
}

function getPostJsonDataByPropertyName(someTags, propertyName) {
    var jsonData = "{";
    for (var x = 0; x < someTags.length; x++) {
        jsonData += "'";
        jsonData += $(someTags[x]).attr(propertyName);
        jsonData += "':'";
        jsonData += $(someTags[x]).val();
        jsonData += "'";
        if (x == someTags.length - 1) {
            jsonData += "}";
            return jsonData;
        } else {
            jsonData += ",";
        }
    }
}

function getGetDataByPropertyName(someTags, propertyName) {
    var getData = "?";
    for (var x = 0; x < someTags.length; x++) {
        if (x != 0) {
            getData += "&";
        }
        getData += $(someTags[x]).attr(propertyName);
        getData += "=";
        getData += $(someTags[x]).val();
    }
    return getData;
}


function saveObject(id,url,propertyName,propertyValue,appendUrl){
   var objects = document.getElementsByName(id);
    var getData = "?";
    for(var x=0;x<objects.length;x++){
        if (x != 0) {
            getData += "&";
        }
        if($(objects[x]).attr("metaProperty") == propertyName){
            $(objects[x]).val(propertyValue);
        }
        getData += $(objects[x]).attr("metaProperty");
        getData += "=";
        getData += $(objects[x]).val();
    }
    url += getData;
    window.location=url + appendUrl;

}
