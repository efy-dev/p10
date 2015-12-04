function QueryCondition() {
    this.label = "";
    this.propertyName = "";
    this.propertyValue = "";
    this.inputType = "";
    this.key = "";
    this.dataType = "";
    this.required = "";
}

var queryConditionArray = null;
var queryConditionArrayMap = new Object();

function generateValue(divId) {

    var conditionsValue = "";

    var defaultConditionsValue = document.getElementById("defaultConditions"+divId).value;
    var tempArray = queryConditionArrayMap[divId];
    for (var i = 0,j = 1; i < tempArray.length; i++) {
        var propertyName = tempArray[i].propertyName;
        if (tempArray[i].inputType != "default") {
            var tempId = propertyName.replace(/\./g, "_");

            var tempIdValue = "";
            if (tempArray[i].inputType == 'date') {
                tempIdValue = $("#" + tempId+j).val();
                if (tempId.indexOf("2") <= 0) {
                    j++;
                    var tempObject2 = $("#" + tempId + "2");
                    if (tempObject2.val() != undefined) {
                        var tempId2Value = tempObject2.val();
                        if (parseInt(tempId2Value.split("-")[0]) - parseInt(tempIdValue.split("-")[0]) > 2) {
                            alert("选择日期查询的时候， 日期跨度不要超过两年");
                            $("#form").submit(function () {
                                return false;
                            });
                            return false;
                        }
                    }
                }
            } else if (tempArray[i].inputType == "radio_dictionary" || tempArray[i].inputType == "radio_status") {
                var tempIdObject = $("input[name=\"" + tempId + "Name" + "\"]:checked");
                if (tempIdObject.val() != undefined) {
                    tempIdValue = tempIdObject.val();
                }
            } else {
                tempIdValue = document.getElementById(tempId).value;
            }

            var tempConditionValue = propertyName + ":";
            tempConditionValue += tempIdValue;
            if (tempArray[i].inputType == 'dialog_do' || tempArray[i].inputType == 'dialog_pop') {
                var tempNameValue = document.getElementById(tempId + "Name").value;
                tempConditionValue += "_" + tempNameValue;
            }

            conditionsValue += tempConditionValue + ";";
        } else {
            if (defaultConditionsValue != "") {
                var defaultConditionsValues = defaultConditionsValue.split(";");
                for (var j = 0; j < defaultConditionsValues.length; j++) {
                    var defaultValues = defaultConditionsValues[j].split(":");
                    if (defaultValues[0] == propertyName) {
                        conditionsValue += defaultConditionsValues[j] + ";";
                        break;
                    }
                }
            }
        }
    }

    if (conditionsValue.length > 0) {
        var resultConditions = conditionsValue.substring(0, conditionsValue.length - 1);
        var tempSortName = $("#tempSortName").val();
        if (tempSortName != null && tempSortName != '') {
            resultConditions += ";" + $("#tempSortOrder").val() + ":" + tempSortName;
        }
        $("#conditions"+divId).val(resultConditions);
//        document.getElementById('conditions').value = conditionsValue.substring(0, conditionsValue.length - 1);
    }
    /*为什么不这样提交    */
//    $("#form").m8uSubmit();
}


function generateCondition(url,divId, queryModel, queryLabel, conditions, model, tabTitle, baseUrl,param,title) {

    queryConditionArray = new Array();

    $.ajax({
        type: "post",
        url: url,
        cache: false,
        data: {qm: queryModel + '_' + divId},
        dataType: "json",
        success: function (data) {

            var jsonData = eval('(' + data + ')');
            var queryConditionArrayTemp = new Array();
            if (jsonData != null && jsonData.length > 0) {
                for (var i = 0; i < jsonData.length; i++) {
                    var queryCondition = new QueryCondition();
                    queryCondition.label = jsonData[i].label;
                    queryCondition.propertyName = jsonData[i].name;
                    queryCondition.propertyValue = jsonData[i].value;
                    queryCondition.inputType = jsonData[i].inputType;
                    queryCondition.key = jsonData[i].key;
                    queryCondition.dataType = jsonData[i].dataType;
                    queryCondition.required = jsonData[i].required;
                    queryConditionArray.push(queryCondition);
                    queryConditionArrayTemp.push(queryCondition);
                }
                queryConditionArrayMap[divId] = queryConditionArrayTemp;
                generateHtml(divId, queryModel, queryLabel, conditions, model, tabTitle,baseUrl,param, title);
                queryConditionArray = new Array();

            }
        }
    });

}

function addSelectAndRadios(conditions,baseUrl) {
    for (var i = 0; i < queryConditionArray.length; i++) {
        if (queryConditionArray[i].inputType != "default") {
            var tempId = queryConditionArray[i].propertyName.replace(/\./g, "_");
            var defaultValue = generatePropertyValue(conditions, queryConditionArray[i].propertyName, queryConditionArray[i].propertyValue);
            if (queryConditionArray[i].inputType == "select_dictionary" || queryConditionArray[i].inputType == "radio_dictionary") {
                if("/"==baseUrl){
                    addOptions(tempId, "/data/loadDictionaryData.do", defaultValue, {sid: queryConditionArray[i].key}, queryConditionArray[i].inputType, queryConditionArray[i].required);
                }else{
                    addOptions(tempId, baseUrl+"/data/loadDictionaryData.do", defaultValue, {sid: queryConditionArray[i].key}, queryConditionArray[i].inputType, queryConditionArray[i].required);
                }
            } else if (queryConditionArray[i].inputType == "select_status" || queryConditionArray[i].inputType == "radio_status") {
                if("/"==baseUrl){
                    addOptions(tempId, "/basic/xmj.do", defaultValue, {
                        qm: "statusType",
                        fieldName: queryConditionArray[i].key
                    }, queryConditionArray[i].inputType, queryConditionArray[i].required);
                }else{
                    addOptions(tempId, baseUrl+"/basic/xmj.do", defaultValue, {
                        qm: "statusType",
                        fieldName: queryConditionArray[i].key
                    }, queryConditionArray[i].inputType, queryConditionArray[i].required);
                }

            }
        }
    }
}


function addOptions(tempId, url, defaultValue, data, inputType, required) {
    jQuery.ajax({
        type: 'GET',
        cache: false,
        contentType: 'application/json',
        url: url,
        data: data,
        dataType: 'json',
        success: function (data) {
            var tagStr = "";
            for (var i = 0; i < data.length; i++) {

                if (inputType == "select_dictionary" || inputType == "select_status") {
                    var option = document.createElement("option");
                    option.value = data[i].id;
                    option.text = data[i].text;
                    if (defaultValue != "" && defaultValue == data[i].id) {
                        option.selected = "selected";
                    }
                    var selector = document.getElementById(tempId);
                    var options = selector.options;
                    options.add(option);
                    //.options.add(option);
                } else {
                    tagStr += "<input type='radio' name=\"" + tempId + "Name" + "\" value=\"" + data[i].id + "\" ";
                    if (defaultValue != "" && defaultValue == data[i].id) {
                        tagStr += " checked=\"checked\"";
                    }

                    if (i == 0 && required == "true") {
                        tagStr += " class=\"radioValidate\"";
                    }

                    tagStr += " />" + data[i].text + "&nbsp;";
                }

            }

            if (inputType == "radio_dictionary" || inputType == "radio_status") {
                $("#" + tempId).append(tagStr);
            }
        }
    });
}



function generateHtml(divId, queryModel, queryLabel, conditions, model, tabTitle,baseUrl,param, title) {
    var tagStr = "<div class=\"queryDiv inline-block\">";
    tagStr += "<form class='am-form-inline' id=\"form\" action=\""+baseUrl+"basic/xm.do?qm=" + queryModel + "_" + divId + "\" method=\"post\">";

    tagStr += " <input type=\"hidden\" id=\"conditions"+divId+"\" name=\"conditions\"/> ";

    for(var key in param){
        if(typeof param[key] !="function"){
            tagStr+=" <input type=\"hidden\" value=\""+param[key]+"\" name=\""+key+"\"/> ";
        }
    }

    var datatimeIdArray = new Array();

    tagStr += " <input type=\"hidden\" id=\"defaultConditions"+divId+"\" name=\"defaultConditions\" value=\"" + conditions + "\"/> ";
    var j=0;
    for (var i = 0; i < queryConditionArray.length; i++) {
        if (queryConditionArray[i].inputType != "default") {
            var tempId = queryConditionArray[i].propertyName.replace(/\./g, "_");
            var thePropertyValue = generatePropertyValue(conditions, queryConditionArray[i].propertyName, queryConditionArray[i].propertyValue);
            tagStr += "<div class=\"am-form-group\">"
            tagStr += "" + queryConditionArray[i].label;

            if (queryConditionArray[i].inputType == "dialog_do" || queryConditionArray[i].inputType == "dialog_pop") {
                if (thePropertyValue == null || thePropertyValue == "null" || thePropertyValue == "") {
                    thePropertyValue = " " + "_" + " ";
                }
                tagStr += " <input type=\"hidden\" " +
                    "id=\"" + tempId + "\" " +
                    "name=\"" + queryConditionArray[i].propertyName + "\" " +
                    "value=\"" + thePropertyValue.split("_")[0] + "\"/> ";
                /*name*/
                tagStr += "<input  type=\"text\" " +
                    "id=\"" + tempId + "Name\" " +
                    "name=\"" + queryConditionArray[i].propertyName + "Name\" " +
                    "value=\"" + thePropertyValue.split("_")[1] + "\"";

                /*弹窗*/
                if (queryConditionArray[i].key == "city") {
                    tagStr += "onclick=\"listCity(\'" + tempId + "\',\'" + tempId + "Name\');\"";
                } else if (queryConditionArray[i].key == "singleCity") {
                    tagStr += "onclick=\"listCity(\'" + tempId + "\',\'" + tempId + "Name\', {isSingle:true});\"";
                } else if (queryConditionArray[i].inputType == "dialog_pop") {
                    tagStr += "onclick=\"m8uDialog.openDialog(\'" + tempId + "\',\'" + tempId + "Name" + "\',\'" + queryConditionArray[i].key + "\')\"";
                } else {
                    tagStr += "onclick=\"m8uDialog.openXDialog(\'" + tempId + "\',\'" + tempId + "Name" + "\',\'" + queryConditionArray[i].key + "\')\"";
                }

                if (queryConditionArray[i].required == "true") {
                    tagStr += " class=\"am-form-field\" required";
                }

                tagStr += " size=\"15\"/>&nbsp;&nbsp;";
            } else if (queryConditionArray[i].inputType == "select_status" || queryConditionArray[i].inputType == "select_dictionary") {
                tagStr += "<select id=\"" + tempId + "\" ";
                if (queryConditionArray[i].required == "true") {

                    tagStr += " class=\"selectValidate\"";
                }
                tagStr += "><option value=''>请选择</option></select>&nbsp;&nbsp;";
            } else if (queryConditionArray[i].inputType == "radio_status" || queryConditionArray[i].inputType == "radio_dictionary") {
                tagStr += "&nbsp;&nbsp;<span id=\"" + tempId + "\"></span>&nbsp;&nbsp;";
            } else {
                tagStr += " <input  type=\"text\"";
                if (queryConditionArray[i].inputType == "date") {
                    j++
                    datatimeIdArray.push(tempId);
                    tagStr += " class=\"am-form-field\" data-am-datepicker readonly size=\"14\"";
                } else {
                    tagStr += " class=\"am-form-field\" size=\"15\"";
                }

                if (queryConditionArray[i].required == "true") {
                    tagStr += " required";
                }

                if (queryConditionArray[i].inputType == "date"){
                    tagStr += " id=\"" + tempId + j +"\"" +
                        " name=\"" + queryConditionArray[i].propertyName + "\"" +
                        " />";
                }else {
                    tagStr += " id=\"" + tempId  +"\"" +
                        " name=\"" + queryConditionArray[i].propertyName + "\"" +
                        " value=\"" + thePropertyValue + "\"/>";
                }

                if (queryConditionArray[i].inputType == "date" && queryConditionArray[i].propertyName.indexOf("2") > 0) {

                    tagStr += "<a href=\"###\" onclick=\"listAllDateType('" + tempId.substr(0, tempId.length - 1) + "', '" + tempId + "')\">" +
//                            "<img title=\"快速选择日期\" align=\"middle\" src=\"" + m8u.projectName() + "/scripts/m8u/themes/metro/images/datebox_arrow.png\"/>" +
                        "<span title=\"快速选择日期\">周期</span>" +
                        "</a>";
                }

                tagStr += "&nbsp;&nbsp;";
            }
            tagStr += "</div>"

        }
    }
    tagStr += " <input class=\"am-btn am-btn-default\" type=\"submit\" onclick=\"generateValue('" + divId + "');\" value=\"查找\"/> ";

    tagStr += "</form>";
    tagStr += "</div>";

    if (tabTitle == title && conditions != null && conditions != "") {
        tagStr += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        tagStr += "<div class=\"inline-block\">";
        tagStr += "<a style=\"display:block\" id=\"doResultSave1\" href=\"###\" onclick=\"viewlabel();\">保存当前查询结果</a>";
        tagStr += "<div style=\"display:none\" id=\"doResultSave2\">";
        tagStr += "<form id=\"doResult\" action=\"" + m8u.projectName() + "/basic/xm.do?qm=saveOrUpdateDoResult&tempQm=" + queryModel + "&tempLabel=" + queryLabel + "&conditions=" + conditions + "&model=" + model + "\" method=\"post\">";
        tagStr += "<input type=\"text\" class=\"easyui-validatebox\" name=\"label\" data-options=\"required:true\" id=\"doResultLabel\"/>";
        tagStr += "<input type=\"hidden\" id=\"sortName\" name=\"sortName\" />";
        tagStr += "<input type=\"hidden\" id=\"sortOrder\" name=\"sortOrder\" />";
        tagStr += "<a href=\"###\" onclick=\"doResultSave();\">保存</a>";
        tagStr += "</form>";
        tagStr += "</div>";
        tagStr += "</div>";
    }

    var div =  $("#" + divId);

    div.append(tagStr);


    addSelectAndRadios(conditions,baseUrl);


    for (var did = 0; did < datatimeIdArray.length; did++) {
        $('#' + datatimeIdArray[did]+(did+1)).datepicker();
    }

//
//        $(".easyui-datebox").datebox({
//            readOnly: true
//        });
//        $(".easyui-combobox").combobox({
//
//        });
//        $(".easyui-validatebox").validatebox({
//
//        });
}

/*查询后页面显示值*/
function generatePropertyValue(conditions, propertyName, propertyValue) {
    var tempPropertyValue = propertyValue;
//            alert(propertyName + "-------" + conditions);
    if (conditions != null) {
        var conditionArray = conditions.split(";");
        for (var i = 0; i < conditionArray.length; i++) {
            var tempConditions = conditionArray[i].split(":");
            if (tempConditions[0] == propertyName) {
                tempPropertyValue = tempConditions[1];
            }
        }
    }
    return tempPropertyValue;
}



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
                alert(form2.elements[j].placeholder + "不能为空");
                form2.elements[j].focus();
                return false;
            }
        }
    }
    return true;
}

