<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title></title>
</head>
<body>
<div class="admin-content">
    <div class="am-g">

        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="<c:url value="/basic/xmm.do"/>" method="post" enctype="multipart/form-data"
                  class="am-form am-form-horizontal">
                <input type="hidden" name="id" value="${object.id}">
                <input type="hidden" name="bannerOrder" value="${object.bannerOrder}">
                <input type="hidden" value="saveOrUpdateBanner" name="qm">
                <div class="am-form-group">
                    <label for="title" class="am-u-sm-3 am-form-label">标题 / Title</label>
                    <div class="am-u-sm-9">
                        <input type="text" id="title" name="title" placeholder="标题 / Title" value="${object.title}">
                        <small>输入你要保存的标题</small>
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="groupName" class="am-u-sm-3 am-form-label">类别 / Category</label>
                    <div class="am-u-sm-9">
                        <div class="selectGroup" initValue="${object.group}">
                            <div class="selectItem" dataFrom="<c:url value="/banner/platform.do"/>"
                                 initValue="选择平台"></div>
                            <div class="selectItem" id="groupName" name="groupName" paramName="platform"
                                 dataFrom="<c:url value="/banner/position.do"/>"
                                 initValue="<c:if test="${not empty object.group}">${object.group}</c:if>
                                 <c:if test="${empty object.group}">请选位置</c:if> "></div>
                        </div>

                    </div>
                </div>
                <div class="am-form-group">
                    <label for="imageUrl" class="am-u-sm-3 am-form-label">轮播图 / Banner</label>

                    <div class="am-u-sm-9">
                        <c:if test="${not empty object.imageUrl}">
                            <%--<img src="http://${url}.efeiyi.com/${object.imageUrl}@!${urlStyle}"/>--%>
                            <input name="OldImageUrl" type="hidden" value="${object.imageUrl}">
                        </c:if>
                        <input type="file" id="imageUrl" value="${object.imageUrl}" name="imageUrl"
                               placeholder="轮播图 / Banner">
                        <small>选择你要保存的轮播图</small>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="directUrl" class="am-u-sm-3 am-form-label">PC地址</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="directUrl" name="directUrl" placeholder="点击轮播图跳转的url"
                               value="${object.directUrl}">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="wapUrl" class="am-u-sm-3 am-form-label">移动地址</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="wapUrl" name="wapUrl" placeholder="点击轮播图跳转的url" value="${object.wapUrl}">
                    </div>
                </div>
                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-push-3">
                        <button type="submit" class="am-btn am-btn-primary">保存</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function ajaxRequest(url, param, success, error, requestType) {
        if (typeof requestType == "undefined") {

        }
        $.ajax({
            type: requestType,
            url: url,
            cache: false,
            dataType: "json",
            data: param,
            success: success,
            error: error,
        });
    }

    var SelectGroupComponent = function () {
        //组件元素列表
        //联动的层级数量是通过配置文件配置而来的
        //声明一个select对象

        var select = function (clazz, name, dataFrom, id, initValue, grade, paramName) {
            this.clazz = clazz;
            this.name = name;
            this.dataFrom = dataFrom;
            this.id = id;
            this.initValue = initValue;
            this.grade = grade;
            this.html = html;
            this.paramName = paramName;
        }

        var selectMap = new Object(); //用来按顺序存放所有的select标签
        var parentDiv = $(".selectGroup");
        var selectItems = parentDiv.find(".selectItem");
        var groupSize = selectItems.length;
        //第一步 绘制下拉菜单
        for (var i = 0; i < groupSize; i++) {
            var selectItem = selectItems[i];
            selectItem = $(selectItem);
            console.log(selectItem);
            var selectTemp = new select(selectItem.attr("class"), selectItem.attr("name"), selectItem.attr("dataFrom"), selectItem.attr("id"), selectItem.attr("initValue"), i, selectItem.attr("paramName"));
            var html = "";
            if (i >= 0 && i < (groupSize - 1)) {
                html += '<select isChange="true"';
            } else {
                html += '<select value="' + parentDiv.attr("initValue") + '"';
            }
            html += ' paramName="' + selectTemp.paramName + '" dataFrom="' + selectTemp.dataFrom + '" grade="' + selectTemp.grade + '" class="' + selectTemp.clazz + '" id="' + selectTemp.id + '" name="' + selectTemp.name + '"><option>' + selectTemp.initValue + '</option></select> '
            selectTemp.html = html;
            selectMap[i] = selectTemp;
        }
        //获得第一级的数据
        var first = selectMap["0"];
        ajaxRequest(first.dataFrom, {}, function (data) {
            var out = '<option>' + first.initValue + '</option>';
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i][0] + '">' + data[i][1] + '</option>';
            }
            first.html = '<select isChange="true" paramName="' + first.paramName + '" dataFrom="' + first.dataFrom + '" grade="' + first.grade + '" class="' + first.clazz + '" id="' + first.id + '" name="' + first.name + '">' + out + '</select>';
            selectMap["0"] = first;
            var result = "";
            for (var key in selectMap) {
                result += selectMap[key].html;
            }
            parentDiv.html(result);
        })
        //选择当前级别的select之后出发下一级的数据获取，数据获取是通过当前级别所选戳来的选项去获取下一级数据
        var onChangeAction = function (e) {
            //可以得到当前级别选中的值（value）
            //问题如何得到下一级别的select .next("select")
            //选择的时候所以的低级节点都需要重置
            var $currentElement = $(e.target);
            var nextSelect = $currentElement.next();
            var nextSelectNeededParamName = nextSelect.attr("paramName");
            var nextSelectDataFrom = nextSelect.attr("dataFrom");
            //@TODO 待验证
            var parmObject = new Object();
            parmObject[nextSelectNeededParamName] = $currentElement.val();
            ajaxRequest(nextSelectDataFrom, parmObject, function (data) {
                var out = "";
                for (var i = 0; i < data.length; i++) {
                    out += '<option value="' + data[i][0] + '">' + data[i][1] + '</option>'
                }
                //@TODO 待优化
                var nextFirstOption = nextSelect.children()[0];
                console.log(nextFirstOption)
                out = nextFirstOption.outerHTML + out;
                nextSelect.html(out);
                var nextNextSelect = nextSelect.next();
                var nextNextFirstOption = nextNextSelect.children()[0];
                nextNextSelect.html(nextNextFirstOption.outerHTML);
                nextNextSelect.child("option:first").prop("selected", 'selected')
            });
        }
        parentDiv.on("change", "[isChange=true]", onChangeAction);
//        parentDiv.on("load", "[name=]", onChangeAction);
    }

    $().ready(function () {
        SelectGroupComponent();
    });

</script>

</body>
</html>
