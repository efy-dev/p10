//    ----------------------------------m8u �ռ亯��������չ


var m8uDialog = $.extend({}, m8uDialog);

function dialog1(url, artDialogLogId, artDialogLogName, fun) {
    var modalStart = "<div class=\"am-modal am-modal-no-btn\" id=\"" + artDialogLogId + artDialogLogName + "\"><div class=\"am-modal-dialog\"><div class=\"am-modal-hd\"><span data-am-modal-close class=\"am-close\">&times;</span> </div> <div class=\"am-modal-bd\"> "
    var modalEnd = "</div> </div> </div>";
    var modalContent = ""
    this.key = "";
    this.dataType = "";
    this.required = "";
    if (typeof $("#" + artDialogLogId + artDialogLogName).attr("id") == "undefined") {

        $.ajax({
            type: "post",
            url: url,
            cache: false,
            dataType: "json",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    modalContent += "<div class=\"am-u-md-4\"><a href=\"javascript:void(0);\" onclick=\"choose(this,'" + artDialogLogId + "','" + artDialogLogName + "' ," + fun + ")\" name=\"" + data[i].name + "\" id=\"" + data[i].id + "\">" + data[i].name + "</a></div>"
                }
                var out = modalStart + modalContent + modalEnd;
                $("body").append(out)
                $("#" + artDialogLogId + artDialogLogName).modal({
                    width: 400, height: 225
                });
            }
        });
    } else {
        $("#" + artDialogLogId + artDialogLogName).modal({
            width: 400, height: 225
        });
    }
}


function xdialog1(url, artDialogLogId, artDialogLogName) {
    //暂时使用iframe的方式实现 在模态窗口中嵌入iframe
    var modalStart = "<div class=\"am-popup\" id=\"" + artDialogLogId + artDialogLogName + "\"><div class=\"am-popup-inner\"><div class=\"am-popup-hd\"><h4 class=\"am-popup-title\">...</h4><span data-am-modal-close class=\"am-close\">&times;</span> </div> <div class=\"am-popup-bd\"> "
    var modalEnd = "</div> </div> </div>";
    var modalContent = ""
    this.key = "";
    this.dataType = "";
    this.required = "";
    console.log($("#" + artDialogLogId + artDialogLogName).attr("id"));
    if (typeof $("#" + artDialogLogId + artDialogLogName).attr("id") == "undefined") {
        modalContent = "<iframe name=\"myFrame\" src=\"" + url + "\"></iframe>"
        var out = modalStart + modalContent + modalEnd;
        $("body").append(out)
        $("#" + artDialogLogId + artDialogLogName).modal('open', {
            width: 400, height: 225
        });
    } else {
        $("#" + artDialogLogId + artDialogLogName).modal('open', {
            width: 400, height: 225
        });
    }
}


function choose(element, artDialogLogId, artDialogLogName, fun) {

    $("#" + artDialogLogId).attr("value", $(element).attr("id"));
    $("#" + artDialogLogId + artDialogLogName).modal('close');
    $("#" + artDialogLogName).attr("value", $(element).attr("name"));
    if (typeof fun == "undefined") {
        fun('$(element).attr("id")');
    }

}
/* ȫ�ֶ��� */


/**
 * ��������
 * param artDialogLogId       ҳ���ϵİ༶id���ı����ʾID
 * param artDialogLogName     ҳ���ϵİ༶���Ƶ��ı����ʾID
 * param type ����
 * param fun                  �ص�����������ѡ��ʱ������
 */
m8uDialog.openDialog = function (artDialogLogId, artDialogLogName, type, fun) {
    var url = "";
    if (type == 'clazzInstance') {  /*�༶*/
        url = '/clazzInstance/formClazzInstanceDialog.do?printable=true';
    } else if (type == 'multiClazzInstance') {
        url = '/clazzInstance/formClazzInstanceDialog.do?printable=true&dispatcher=multi';
    } else if (type == 'course') {  /*�γ�*/
        url = '/course/formCourseDialog.do?printable=true';
    } else if (type == 'multiCourse') {
        url = '/course/formMultiCourseDialog.do?printable=true';
    } else if (type == 'clazz') {  /*���*/
        url = '/course/formClazzDialog.do?printable=true';
    } else if (type == 'bigClazz') {  /*����*/
        url = '/course/formBigClazzDialog.do?printable=true';
    } else if (type == 'studentTraining') {   /*ѧԱ*/
        url = '/studentTraining/formStudentTrainingDialog.do?printable=true&dispatcher=studentTraining';
    } else if (type == 'student') {   /*ѧԱ*/
        url = '/studentTraining/formStudentTrainingDialog.do?printable=true&dispatcher=student';
    } else if (type == 'tenant') {     /*�û�*/
        url = '/tenant/list/json';
    }else if (type == 'category') {     /*�û�*/
        url = '/category/list/json';
    } else if (type == 'multiUser') {
        url = '/organization/formMultiUserDialog.do?printable=true&theStatus=3';
    } else if (type == 'staff') {    /*Ա��*/
        url = '/organization/formUserDialog.do?printable=true&theStatus=2';
    } else if (type == 'multiStaff') {
        url = '/organization/formMultiUserDialog.do?printable=true&theStatus=2';
    } else if (type == 'userAndStaff') {   /*�û���Ա��*/
        url = '/organization/formUserDialog.do?printable=true&theStatus=1';
    } else if (type == 'multiUserAndStaff') {
        url = '/organization/formMultiUserDialog.do?printable=true&theStatus=1';
    } else if (type == 'teachBook') {  /*�̲�*/
        url = '/teachBook/formTeachBookDialog.do?printable=true';
    } else if (type == 'things') {       /*��Ʒ*/
        url = '/category/formCategoryDialog.do?printable=true&theType=5';
    } else if (type == 'books') {       /*ͼ��*/
        url = '/category/formBooksDialog.do?printable=true&theType=6';
    } else if (type == 'department') {       /*����*/
        url = '/organization/formDepartmentDialog.do?printable=true';
    } else if (type == 'relation') {       /*����*/
        url = '/relation/formRelation.do?printable=true';
    } else if (type.indexOf('nut_category_') >= 0) {       /*ԭ�����*/
        var tempType = type.split("_")[2];
        url = '/dish/listCategory.do?printable=true&theType=' + tempType;
    } else if (type == 'product') {       /*����*/
        url = '/product/list/json';
    } else if (type == 'order') {       /*����*/
        url = '/order/list/json';
    }

    //dialog1.data("artDialogDocument", document);
    //dialog1.data("artDialogLogId", artDialogLogId);
    //dialog1.data("artDialogLogName", artDialogLogName);
    //console.log(typeof dialog1.open)
    dialog1(url, artDialogLogId, artDialogLogName);
    var callback = function () {                  // �ص�����
        if (fun != null) {
            fun();
        }
    }
    //dialog.data("callback", callback);
}

m8uDialog.openXDialog = function (artDialogLogId, artDialogLogName, queryModel, fun) {
    var url = "/getXPage.do?qm=" + queryModel;
    //
    //$.dialog.data("artDialogDocument", document);
    //$.dialog.data("artDialogLogId", artDialogLogId);
    //$.dialog.data("artDialogLogName", artDialogLogName);
    //$.dialog.open(m8u.projectName() + url, {
    xdialog1(url, artDialogLogId, artDialogLogName);

    var callback = function () {                  // �ص�����
        if (fun != null) {
            fun();
        }
    }
    //$.dialog.data("callback", callback);
}


//------------------У��----------------------

var idObj = "";
var nameObj = "";
var teachAreaLicense = "";
var cityArray = new Array();       //У������
/**
 * ������У���ų�����
 * @param city �ܲ�У��
 */
function getAllCity(city) {
    cityArray = city;
    for (var i = 0; i < city.cityList.length; i++) {
        var childTeachArea = city.cityList[i];
        cityArray.push(childTeachArea);
        getAllCity(childTeachArea);
    }
}

/**
 * ѡ��У��
 * @param teachAreaId
 * @param teachAreaName
 */
function chooseCity(teachAreaId, teachAreaName) {
    idObj.val(teachAreaId);
    nameObj.val(teachAreaName);
    closeWindow();
}

var allCityAreaIds = "";

function getChildrenCity(teachAreaId, teachAreaName) {

    var city = null;
    for (var i = 0; i < cityArray.length; i++) {
        if (cityArray[i].id == teachAreaId) {
            city = cityArray[i];
            break;
        }
    }


    allCityAreaIds = city.id + ",";
    if (city.cityList != null && city.cityList.length > 0) {
        for (var j = 0; j < city.cityList.length; j++) {
            getChildrenCity(city.cityList[j].id);
        }
    }


    allCityAreaIds = allCityAreaIds.substring(0, allCityAreaIds.length - 1);
    idObj.val(allCityAreaIds);
    nameObj.val(teachAreaName);
    closeWindow();
}

/**
 * ����ȫ��
 * @param teachAreaId
 */
function chooseChildrenCity(teachAreaId) {
    var city = null;
    for (var i = 0; i < cityArray.length; i++) {
        if (cityArray[i].id == teachAreaId) {
            city = cityArray[i];
            break;
        }
    }

    var teachAreaNames = city.label;
    allCityAreaIds = city.id + ",";
    if (city.cityList != null && city.cityList.length > 0) {
        for (var j = 0; j < city.cityList.length; j++) {
            getChildrenCity(city.cityList[j].id);
        }
    }
    allCityAreaIds = allCityAreaIds.substring(0, allCityAreaIds.length - 1);
    idObj.val(allCityAreaIds);
    nameObj.val(teachAreaNames);
    closeWindow();
}

function expandCity(node, teachAreaId, isSingle, callback) {
    $(node).parents("ul").nextAll("ul").remove();
    var city = null;
    for (var i = 0; i < cityArray.length; i++) {
        if (cityArray[i].id == teachAreaId) {
            city = cityArray[i];
            break;
        }
    }

    var xqUl = '<ul style="padding: 10px;float: left;">';
    for (var i = 0; i < city.cityList.length; i++) {                                                                                      //һ��У��
        var childTeachArea = city.cityList[i];
        xqUl += '<li><a href="###" onclick="chooseCity(\'' + childTeachArea.id + '\',\'' + childTeachArea.name + '\'),' + callback + '()">' + childTeachArea.name + '</a>';
        if (childTeachArea.cityList.length > 0) {
            if (!isSingle) {
                xqUl += '(<a href="###" onclick="chooseChildrenCity(\'' + childTeachArea.id + '\',\'' + childTeachArea.name + '\'),' + callback + '()">�����¼�</a>)';
            }
            xqUl += '(<span><a href="###" onclick="expandCity(this,\'' + childTeachArea.id + '\',\'' + isSingle + '\',\'' + callback + '\')">չ��</a></span>)';
        }
        xqUl += '</li>';
    }
    xqUl += '</ul>';
    $("#teachAreaChoose").append(xqUl);
}

function listCity(idObjId, nameObjId, params) {
    var options = {
        isSingle: false,
        isFather: false,
        callback: function () {
        }
    };
    $.extend(options, params);

    idObj = $(document.getElementById(idObjId));
    nameObj = $(document.getElementById(nameObjId));

    jQuery.ajax({
        type: 'post',
        dataType: 'json',
        url: '/pc/city/listCityByJson.do',
        data: {
            isFather: options.isFather
        },
        success: function (cityList) {
            var isSingle = options.isSingle;
            var callback = options.callback;
            var operateDiv = '';

            var xqUl = '<ul style="padding: 10px;float: left;">';
            for (var i = 0; i < cityList.length; i++) {                                                                                                 //һ��У��
                var childTeachArea = cityList[i];
                xqUl += '<li><a href="###" onclick="chooseCity(\'' + childTeachArea.id + '\', \'' + childTeachArea.label + '\'),' + callback + '()">' + childTeachArea.label + '</a>';
                //if(!isSingle){
                //    xqUl += '(<a href="###" onclick="chooseChildrenCity(\''+ childTeachArea.id +'\', \''+ childTeachArea.name +'\')">�����¼�</a>)';
                //}
                //xqUl += '(<span><a href="###" onclick="expandCity(this,\''+ childTeachArea.id +'\',\'' + isSingle + '\',\'' + callback + '\')">չ��</a></span>)';
                xqUl += '</li>';
            }
            xqUl += '</ul>';
            var winDiv = $('<div id="teachAreaChoose" class="alertDiv"></div>');
            winDiv.append($('<div id="close" class="close" title="�ر�" onclick="closeWindow()">��<div>'));
            winDiv.append(operateDiv + xqUl)
                .css({
                    display: "block",
                    left: nameObj.offset().left + "px",
                    top: nameObj.offset().top + nameObj.outerHeight() - 1 + "px"
                })
                .appendTo("body");
            getAllCity(cityList);
        }
    });
}

//�رմ���
function closeWindow() {
    $("#teachAreaChoose").remove();
}


//------------------У��----------------------

var categoryIdObj = "";
var categoryNameObj = "";

/**
 * ѡ�����
 * @param categoryId
 * @param categoryName
 */
function chooseCategory(categoryId, categoryName) {
    categoryIdObj.val(categoryId);
    categoryNameObj.val(categoryName);
    closeCategoryWindow();
}

/*
 *�򿪴��� �г����
 * @param categoryIdObj ���ID��ŵĽڵ�ID
 * @param categoryNameObj ������ƴ�ŵĽڵ�ID
 * @param   params ����
 *  ҳ�����ʱ����ͨ�����·�ʽ����Ĭ��ֵ
 var params = {
 theType : 1,               //1 ԭ��
 };
 $('.maintablTe').table(params);
 */
function listCategory(idObjId, nameObjId, params) {
    var options = {
        theType: 1,
        callback: function () {
        }
    };
    $.extend(options, params);

    categoryIdObj = $(document.getElementById(idObjId));
    categoryNameObj = $(document.getElementById(nameObjId));
    /*
     Ϊʲô����ʵ�ַ�ʽ�����ԣ�
     idObj = $("#"+);
     nameObj = $("#"+nameObjId);
     */

    jQuery.ajax({
        type: 'post',
        dataType: 'json',
        url: m8u.projectName() + '/dish/listCategory.do',
        data: {
            theType: options.theType
        },
        success: function (data) {

            var callback = options.callback;
            var operateDiv = '';

            var xqUl = '<ul class="easyui-tree">';
            if (data.length > 0) {
                xqUl += generateCategoryStr(data, callback);
            }
            xqUl += '</ul>';

            var winDiv = $('<div id="categoryChoose" class="alertDiv"></div>');
            winDiv.append($('<div id="categoryClose" class="close" title="�ر�" onclick="closeCategoryWindow()">��<div>'));
            winDiv.append(operateDiv + xqUl)
                .css({
                    display: "block",
                    left: categoryNameObj.offset().left + "px",
                    top: categoryNameObj.offset().top + categoryNameObj.outerHeight() - 1 + "px"
                })
                .appendTo("body");

            $('.easyui-tree').tree({
                animate: true,
                onClick: function (node) {
                    if (node.state == "closed") {
                        $('.easyui-tree').tree('expand', node.target);
                    } else {
                        $('.easyui-tree').tree('collapse', node.target);
                    }
                }
            });
        }
    });
}

function generateCategoryStr(data, callback) {

    var tagStr = '';//padding: 10px;float: left;

    for (var i = 0; i < data.length; i++) {                                                                                                 //һ��У��
        var category = data[i];
        tagStr += "<li ";

        if (category.categoryList.length > 0) {
            tagStr += " data-options=\"state:'closed'\" ";
        }
        tagStr += ">";

        tagStr += '<span><a href="###" ';

        if (category.categoryList.length > 0) {
            tagStr += ' ';
        } else {
            tagStr += ' onclick="chooseCategory(\'' + category.id + '\', \'' + category.name + '\'),' + callback + '()" ';
        }

        tagStr += ">";
        tagStr += category.name + '</a></span>';
        if (category.categoryList.length > 0) {
            tagStr += "<ul>";
            tagStr += generateCategoryStr(category.categoryList, callback);
            tagStr += "</ul>";
        }
        tagStr += "</li>";
    }

    tagStr += "";

    return tagStr;
}

//�رմ���
function closeCategoryWindow() {
    $("#categoryChoose").remove();
}


//----------------------------total------------------------------
function getTotalMoney(qm, conditions, sumField, spanId) {

    jQuery.ajax({
        type: 'GET',
        cache: false,
        contentType: 'application/json',
        url: m8u.projectName() + "/basic/xmj.do",
        data: {qm: "sumField", queryModel: qm, conditions: conditions, countField: sumField},
        dataType: 'json',
        success: function (data) {
            $("#" + spanId).html(":" + m8u.formatCurrency(data) + "");
        }
    });

}


//-----------------------------------------��������-------------------------------
var dateTypeIdObj = "";
var dateTypeNameObj = "";

var daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var today = new Today();
var year = today.year;
var month = today.month;
var day = today.day;

function Today() {
    this.now = new Date();
    this.year = this.now.getFullYear();
    this.month = this.now.getMonth();
    this.day = this.now.getDate();
}

function listAllDateType(idObjId, nameObjId) {

    dateTypeIdObj = $(document.getElementById(idObjId));
    dateTypeNameObj = $(document.getElementById(nameObjId));

    var operateDiv = '';
    var zbUl = '<ul style="padding: 10px;float: left;">';
    /*����*/
    var todayTime = today.year + "-" + filterDate(today.month + 1) + "-" + filterDate(today.day);
    zbUl += '<li>' +
        "<a href=\"###\" onclick=\"chooseDateType('" + todayTime + "', '" + todayTime + "')\">" +
        "<span style='font-weight: bold'>����</span>" + "(" + todayTime + '->' + todayTime + ")" +
        '</a>' +
        '</li>';
    /*����*/
    var yesTime = addDays(new Date(), -1);
    zbUl += '<li>' +
        "<a href=\"###\" onclick=\"chooseDateType('" + yesTime + "', '" + yesTime + "')\">" +
        "<span style='font-weight: bold'>����</span>" + "(" + yesTime + '->' + yesTime + ")" +
        '</a><br/>' +
        '</li>';
    /*����*/
    var thisWeekTime1 = getFirstWeekDatetime(new Date());
    var thisWeekTime2 = getEndWeekDatetime(new Date());
    zbUl += '<li>' +
        "<a href=\"###\" onclick=\"chooseDateType('" + thisWeekTime1 + "', '" + thisWeekTime2 + "')\">" +
        "<span style='font-weight: bold'>����</span>" + "(" + thisWeekTime1 + '->' + thisWeekTime2 + ")" +
        '</a><br/>' +
        '</li>';
    /*����===*/
    var preWeekTime1 = addDaysByStr(thisWeekTime1, -7);
    var preWeekTime2 = addDaysByStr(thisWeekTime2, -7);
    zbUl += '<li>' +
        "<a href=\"###\" onclick=\"chooseDateType('" + preWeekTime1 + "', '" + preWeekTime2 + "')\">" +
        "<span style='font-weight: bold'>����</span>" + "(" + preWeekTime1 + '->' + preWeekTime2 + ")" +
        '</a><br/><br/>' +
        '</li>';

    /*����*/
    var thisMonthTime1 = today.year + "-" + filterDate(today.month + 1) + "-" + "01";
    var thisMonthTime2 = today.year + "-" + filterDate(today.month + 1) + "-" + getDays(today.year, today.month);
    zbUl += '<li>' +
        "<a href=\"###\" onclick=\"chooseDateType('" + thisMonthTime1 + "', '" + thisMonthTime2 + "')\">" +
        "<span style='font-weight: bold'>����</span>" + "(" + thisMonthTime1 + '->' + thisMonthTime2 + ")" +
        '</a><br/>' +
        '</li>';
    /*����*/
    var preMonthTime2 = addDaysByStr(thisMonthTime1, -1);
    var preMonthTime1 = preMonthTime2.split("-")[0] + "-" + preMonthTime2.split("-")[1] + "-" + "01";
    zbUl += '<li>' +
        "<a href=\"###\" onclick=\"chooseDateType('" + preMonthTime1 + "', '" + preMonthTime2 + "')\">" +
        "<span style='font-weight: bold'>����</span>" + "(" + preMonthTime1 + '->' + preMonthTime2 + ")" +
        '</a><br/>' +
        '</li>';
    /*����*/
    var thisYearTime1 = today.year + "-01-01";
    var thisYearTime2 = today.year + "-12-31";
    zbUl += '<li>' +
        "<a href=\"###\" onclick=\"chooseDateType('" + thisYearTime1 + "', '" + thisYearTime2 + "')\">" +
        "<span style='font-weight: bold'>����</span>" + "(" + thisYearTime1 + '->' + thisYearTime2 + ")" +
        '</a><br/>' +
        '</li>';

    /*ȥ��*/
    var preYearTime1 = today.year - 1 + "-01-01";
    var preYearTime2 = today.year - 1 + "-12-31";
    zbUl += '<li>' +
        "<a href=\"###\" onclick=\"chooseDateType('" + preYearTime1 + "', '" + preYearTime2 + "')\">" +
        "<span style='font-weight: bold'>ȥ��</span>" + "(" + preYearTime1 + '->' + preYearTime2 + ")" +
        '</a><br/>' +
        '</li>';
    zbUl += '</ul>';

    var winDiv = $('<div id="dateTypeChoose" class="alertDiv"></div>');
    winDiv.append($('<div class="close" title="�ر�" onclick="closeDateTypeWindow()">x<div>'));
    winDiv.append(operateDiv + zbUl)
        .css({
            display: "block",
            left: dateTypeIdObj.next().offset().left + "px",
            top: dateTypeIdObj.next().offset().top + dateTypeIdObj.outerHeight() - 1 + "px"
        })
        .appendTo("body");
}

//�رմ���
function closeDateTypeWindow() {
    $("#dateTypeChoose").remove();
}

function chooseDateType(startTime, endTime) {
    dateTypeIdObj.datebox('setValue', startTime);
    dateTypeNameObj.datebox('setValue', endTime);
    closeDateTypeWindow();
}

function getDays(year, month) {
    if (1 == month) {
        if (((0 == year % 4) && (0 != (year % 100))) || (0 == year % 400)) {
            return 29;
        } else {
            return 28;
        }
    } else {
        return daysInMonth[month];
    }
}

function filterDate(date) {
    if (date < 10) {
        return "0" + date;
    } else {
        return date;
    }
}

function addDays(date, days) {
    var n = 24 * 60 * 60 * 1000;
    var resultDay = new Date(date.getTime() + parseInt(days) * n);

    return resultDay.getFullYear() + "-" + filterDate(resultDay.getMonth() + 1) + "-" + filterDate(resultDay.getDate());
}

function addDaysByStr(str, days) {
    var strArray = str.split("-");
    var date = new Date(strArray[0], parseInt(strArray[1]) - 1, parseInt(strArray[2]));
    var n = 24 * 60 * 60 * 1000;
    var resultDay = new Date(date.getTime() + parseInt(days) * n);

    return resultDay.getFullYear() + "-" + filterDate(resultDay.getMonth() + 1) + "-" + filterDate(resultDay.getDate());
}


function getFirstWeekDatetime(date) {
    var w = date.getDay(), n = 24 * 60 * 60 * 1000;
    var first = new Date(date.getTime() - parseInt("6012345".charAt(w)) * n);

    return first.getFullYear() + "-" + filterDate(first.getMonth() + 1) + "-" + filterDate(first.getDate());
}
function getEndWeekDatetime(date) {
    var w = date.getDay(), n = 24 * 60 * 60 * 1000;
    var end = new Date(date.getTime() + parseInt("0654321".charAt(w)) * n);

    return end.getFullYear() + "-" + filterDate(end.getMonth() + 1) + "-" + filterDate(end.getDate());
}


/*ɾ������*/
function deleteFile(attachmentId) {
    jQuery.ajax({
        type: 'post',
        dataType: 'json',
        url: m8u.projectName() + '/deleteFile/deleteFile.do',
        data: {
            attachmentId: attachmentId
        },
        success: function (data) {
            if (data) {
                $("#" + attachmentId).remove();
            }
        }
    });
}


//zero using
m8uDialog.openDialog2zero = function (artDialogLogId, artDialogLogName, type, basePath) {
    var modalTitle = "";
    var url = basePath;
    var url2 = "";
    if (type == 'productModel') {       /*所有商品*/
        url = url + '/gift/productModel/list/json';
        url2 = basePath + '/gift/productModelLikesProductName/list/json?name=';
        modalTitle = '选择商品';
        dialog2zero(url, artDialogLogId, artDialogLogName, modalTitle, url2);
    }
    /*else if (type == 'user') {       /!*所有用户*!/
     url = url + '/gift/user/list/json';
     url2 = basePath + '/gift/userLikesName/list/json?name=';
     modalTitle = '选择用户';
     dialog1(url, artDialogLogId, artDialogLogName, modalTitle, url2);
     }*/
};

function dialog2zero(url, artDialogLogId, artDialogLogName, modalTitle,url2) {
    var modalStart = "<div class=\"am-modal am-modal-no-btn\" id=\"modalSelect\">" +
        "<div class=\"am-modal-dialog\">" +
        "<div class=\"am-modal-hd\">" + modalTitle +
        "<span data-am-modal-close class=\"am-close\">&times;</span>" +
        "</div>" +
        "<div>" +
        "<label>名&nbsp;&nbsp;称: &nbsp;</label>"+
        "<input type=\"text\" id=\"modalName\" placeholder=\"名称\">"+
        "<input type=\"button\" onclick=\"selectPS2zero('"+artDialogLogId+"','"+artDialogLogName+"','"+url2+"')\" value=\"查询\">"+
        "</div>"+
        "<div class=\"am-modal-bd\"> "+
        "<div id=\"selectItemDiv\" style=\"height: 200px;overflow-y: auto\">";
    var modalEnd = "</div></div> </div> </div>";
    var modalContent = "";
    console.log($("#modalSelect").attr("id"));
    $.ajax({
        type: "post",
        url: url,
        cache: false,
        dataType: "json",
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                modalContent += "<div class=\"am-u-md-4\">" +
                    "<a href=\"javascript:void(0);\" onclick=\"choose2zero(this,'"+artDialogLogId+"','"+artDialogLogName+"')\" name=\""+data[i].name +"\" id=\""+data[i].id+"\">"+data[i].name+"</a>"+
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

var selectPS2zero=function(artDialogLogId, artDialogLogName, url){
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
                    "<a href=\"javascript:void(0);\" onclick=\"choose2zero(this,'"+artDialogLogId+"','"+artDialogLogName+"')\" name=\""+data[i].name+"\" id=\""+data[i].id+"\">"+data[i].name+"</a>" +
                    "</div>";
            }
            if(data.length == 0){
                modalContent = "<div style='color: red'>没有您需要的信息!</div>";
            }
            $("#selectItemDiv").html(modalContent);
        }
    });
};

function choose2zero(element, artDialogLogId, artDialogLogName) {
    $("#" + artDialogLogId).attr("value", $(element).attr("id"));
    $("#modalSelect").modal('close');
    $("#" + artDialogLogName).attr("value", $(element).attr("name"));
}

function afterSubmitForm2zero(formId){
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
