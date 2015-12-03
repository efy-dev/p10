<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script>
        $(document).ready(
                function () {
                    var id = $("#id").val();
                    if (id != "") {
                        $("#sc").hide();
                    } else if (id == "") {
                        $("#quanchang").attr("checked", true);
                        $("#manjian").attr("checked", true);
                        $("#youhuiquan").attr("checked", true);
                        $("#xzpinlei").hide();
                        $("#xzdianpu").hide();
                        $("#xzshangpin").hide();
                        $("#miane").hide();
                    }

                    $("input:radio[name=range]").bind("change", function () {
                        //联动的时候要传的参数：projectCategory分类  project项目  tenant店铺  product商品
                        var val = $('input:radio[name="range"]:checked').val();
                        if (val == "1") {
                            $("#xzpinlei").hide();
                            $("#xzdianpu").hide();
                            $("#xzshangpin").hide();
                        } else if (val == "2") {
                            $("#xzdianpu").hide();
                            $("#xzshangpin").hide();
                            $("#xzpinlei").show();
                            getAllProjectCategory('pinlei');
                        } else if (val == "3") {
                            $("#xzpinlei").hide();
                            $("#xzshangpin").hide();
                            $("#xzdianpu").show();
                            getAllProjectCategory('dianpu');
                        } else if (val == "4") {
                            $("#xzpinlei").hide();
                            $("#xzdianpu").hide();
                            $("#xzshangpin").show();
                            getAllProjectCategory('danpin');
                        }
                    });
                    $("#project2").bind("change", function () {
                        var val = $('#project2').val();
                        getAllProject('pinlei', val);
                    });
                    $("#tenant3").bind("change", function () {//店铺使用选项中 类别下拉框的值改变时
                        var val = $('#tenant3').val();
                        getAllProject('dianpu', val);
                    });
                    $("#product3").change(function () {//单品使用选项中 类别下拉框的值改变时
                        var val = $('#product3').val();
                        getAllProject('danpin', val);
                    });
                    $("#tenant2").bind("change", function () {//店铺使用选项中 项目project下拉框的值改变时
                        var val = $('#tenant2').val();
                        getTenantByProject(val);
                    });
                    $("#product2").change(function () {//单品使用选项中 项目project下拉框的值改变时
                        var val = $('#product2').val();
                        getProductByProject(val);
                    });

                    $("input:radio[name=type]").change(function () {
                        var val = $('input:radio[name="type"]:checked').val();
                        if (val == "1") {
                            $("#shiyongtiaojian").show();
                            $("#miane").hide();
                        } else if (val == "2") {
                            $("#shiyongtiaojian").hide();
                            $("#miane").show();
                        }
                    });
                    $("input:radio[name=deliverType]").change(function () {
                        var val = $('input:radio[name="deliverType"]:checked').val();
                        if (val == "1") {
                            $("#lingqushijian").show();
                            $("#shuliang").show();
                        } else if (val == "2") {
                            $("#shuliang").show();
                            $("#lingqushijian").hide();
                        } else if (val == "3") {
                            $("#lingqushijian").hide();
                            $("#shuliang").hide();
                        }
                    });
                }
        );

        //获取所有的类别 这个时候传参是指定得到的数据在哪个优惠券使用范围的下拉选框中显示
        function getAllProjectCategory(type) {
            $.ajax({
                type: 'post',
                async: false,
                url: '<c:url value="/couponBatch/getAllProjectCategory.do"/>',
                dataType: 'json',
                data: {type: 'projectCategory'},
                success: function (data) {
                    var temp_html = "<option value=''>请选择</option>";
                    $.each(data, function (i, dist) {
                        temp_html += "<option value='" + dist.id + "'>" + dist.name + "</option>";
                    });
                    if ('pinlei' == type) {
                        $("#project2").html(temp_html).attr("disabled", false);
                        $("#project").empty().attr("disabled", true);
                    } else if ('dianpu' == type) {
                        $("#tenant3").html(temp_html).attr("disabled", false);
                        $("#tenant").empty().attr("disabled", true);
                        $("#tenant2").empty().attr("disabled", true);
                    } else if ('danpin' == type) {
                        $("#product3").html(temp_html).attr("disabled", false);
                        $("#product").empty().attr("disabled", true);
                        $("#product2").empty().attr("disabled", true);
                    }
                },
            });
        }

        //获取某一个类别对应的项目project
        function getAllProject(type, projectCategoryId) {
            $.ajax({
                type: 'post',
                async: false,
                url: '<c:url value="/couponBatch/getAllProject.do"/>',
                dataType: 'json',
                data: {'projectCategory_id': projectCategoryId},
                success: function (data) {
                    var temp_html = "<option value=''>请选择</option>";
                    $.each(data, function (i, dist) {
                        temp_html += "<option value='" + dist.id + "'>" + dist.name + "</option>";
                    });
                    if ('pinlei' == type) {
                        $("#project").html(temp_html).attr("disabled", false);
                    } else if ('dianpu' == type) {
                        $("#tenant2").html(temp_html).attr("disabled", false);
                        $("#tenant").empty().attr("disabled", true);
                    } else if ('danpin' == type) {
                        $("#product2").html(temp_html).attr("disabled", false);
                        $("#product").empty().attr("disabled", true);
                    }
                },
            });
        }
        //获取某一个项目project获取对应的店铺
        function getTenantByProject(projectId) {
            $.ajax({
                type: 'post',
                async: false,
                url: '<c:url value="/couponBatch/getTenantByProject.do"/>',
                dataType: 'json',
                data: {'project_id': projectId},
                success: function (data) {
                    var temp_html = "<option value=''>请选择</option>";
                    $.each(data, function (i, dist) {
                        temp_html += "<option value='" + dist.id + "'>" + dist.name + "</option>";
                    });
                    $("#tenant").html(temp_html).attr("disabled", false);
                },
            });
        }

        //获取某一个项目project获取对应的商品
        function getProductByProject(projectId) {
            $.ajax({
                type: 'post',
                async: false,
                url: '<c:url value="/couponBatch/getProductByProject.do"/>',
                dataType: 'json',
                data: {'project_id': projectId},
                success: function (data) {
                    var temp_html = "<option value=''>请选择</option>";
                    $.each(data, function (i, dist) {
                        temp_html += "<option value='" + dist.id + "'>" + dist.name + "</option>";
                    });
                    $("#product").html(temp_html).attr("disabled", false);
                },
            });
        }

        function saveAndCreate() {//保存并生成
            $("#form").attr("action", "<c:url value="/couponBatch/saveAndCreateCoupon.do"/>");
            $("#form").submit();
        }


    </script>
</head>
<body>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal" id="form">
                <input type="hidden" value="saveOrUpdateCouponBatch" name="qm">
                <input type="hidden" name="id" id="id" value="${object.id}">
                <input type="hidden" name="isCreatedCoupon" value="1">

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-3 am-form-label">优惠券批次名</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="name" name="name" placeholder="批次名" value="${object.name}">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-3 am-form-label">优惠券使用范围</label>

                    <div class="am-form-group">
                        <label class="am-radio-inline">
                            <input type="radio" name="range" id="quanchang" value="1"> 全场通用
                        </label>
                        <label class="am-radio-inline">
                            <input type="radio" name="range" id="pinlei" value="2"> 品类使用
                        </label>
                        <label class="am-radio-inline">
                            <input type="radio" name="range" id="dianpu" value="3"> 店铺使用
                        </label>
                        <label class="am-radio-inline">
                            <input type="radio" name="range" id="danpin" value="4"> 单品使用
                        </label>
                    </div>
                </div>

                <div class="am-form-group" id="xzpinlei">
                    <label for="name" class="am-u-sm-3 am-form-label">选择品类</label>

                    <div class="am-u-sm-9" name="project1" id="project1" style="float:left;">
                        <select id="project2" name="project2" style="width:120px;float:left;">
                        </select>
                        <select name="project" id="project" style="width:120px;float:left;margin-left:10px;">
                        </select>
                    </div>
                </div>
                <div class="am-form-group" id="xzdianpu">
                    <label for="name" class="am-u-sm-3 am-form-label">选择店铺</label>

                    <div class="am-u-sm-9" name="tenant1" id="tenant1" style="float:left;">
                        <select name="tenant3" id="tenant3" style="width:120px;float:left;">
                        </select>
                        <select name="tenant2" id="tenant2" style="width:120px;float:left;margin-left:10px;">
                        </select>
                        <select name="tenant" id="tenant" style="width:120px;float:left;margin-left:10px;">
                        </select>
                    </div>
                </div>
                <div class="am-form-group" id="xzshangpin" style="display: none">
                    <label for="name" class="am-u-sm-3 am-form-label">选择商品</label>

                    <div class="am-u-sm-9" name="product1" id="product1">
                        <select name="product3" id="product3" style="width:120px;float:left;">
                        </select>
                        <select name="product2" id="product2" style="width:120px;float:left;margin-left:10px;">
                        </select>
                        <select name="product" id="product" style="width:120px;float:left;margin-left:10px;">
                        </select>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-3 am-form-label">优惠券类型</label>

                    <div class="am-form-group">
                        <label class="am-radio-inline">
                            <input type="radio" name="type" value="1" id="manjian"> 满减券
                        </label>
                        <label class="am-radio-inline">
                            <input type="radio" name="type" value="2" id="xianjin"> 现金券
                        </label>
                    </div>
                </div>

                <div class="am-form-group" id="shiyongtiaojian">
                    <label for="name" class="am-u-sm-3 am-form-label">使用条件</label>

                    <div class="am-u-sm-9">
                        <span style="float: left;width:180px;"><em style="font-style: normal;float:left;">满</em><input style="width:120px;float:left;" type="text" id="priceLimit" name="priceLimit"
                                                            placeholder="使用条件" value="${object.priceLimit}"
                                                            ><em style="font-style: normal;float:left;">元&nbsp;减</em></span>
                        <span style="float: left;width: 180px;"><input type="text" id="price" name="price" placeholder="使用条件"
                                                          value="${object.price}" style="width:120px;float:left;"><em style="font-style: normal;float:left;">元</em></span>
                    </div>
                </div>

                <div class="am-form-group" id="miane">
                    <label for="price1" class="am-u-sm-3 am-form-label">面额</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="price1" name="price1" value="${object.price}">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-3 am-form-label">发放方式</label>

                    <div class="am-form-group">
                        <label class="am-radio-inline">
                            <input type="radio" name="deliverType" value="1" id="youhuiquan"> 发优惠券
                        </label>
                        <label class="am-radio-inline">
                            <input type="radio" name="deliverType" value="2" id="duihuanma"> 发兑换码
                        </label>
                        <label class="am-radio-inline">
                            <input type="radio" name="deliverType" value="3" id="tongma"> 通码
                        </label>

                    </div>

                </div>
                <div class="am-form-group" id="shuliang">
                    <label for="amount" class="am-u-sm-3 am-form-label">优惠券数量</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="amount" name="amount" placeholder="数量" value="${object.amount}">
                    </div>
                </div>

                <div class="am-form-group" id="lingqushijian">
                    <label for="amount" class="am-u-sm-3 am-form-label">领取时间</label>

                    <div class="am-u-sm-9">
                        <div class="am-form-group am-form-icon" style="width: 150px;float: left">
                            <i class="am-icon-calendar"></i>
                            <input type="text" id="startReceiveTime" name="startReceiveTime"
                                   class="am-form-field am-input-sm"
                                   placeholder="生效日期" value="${object.startReceiveTime}" data-am-datepicker readonly>
                        </div>
                        <div style="float: left">&nbsp;&nbsp;至&nbsp;&nbsp;</div>
                        <div class="am-form-group am-form-icon" style="width: 150px;float: left">
                            <i class="am-icon-calendar"></i>
                            <input type="text" id="endReceiveTime" name="endReceiveTime"
                                   class="am-form-field am-input-sm"
                                   placeholder="失效日期" value="${object.endReceiveTime}" data-am-datepicker readonly>
                        </div>
                    </div>
                </div>
                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">使用有效期</label>

                    <div class="am-u-sm-9">
                        <div class="am-form-group am-form-icon" style="width: 150px;float: left">
                            <i class="am-icon-calendar"></i>
                            <input type="text" id="startDate" name="startDate" class="am-form-field am-input-sm"
                                   placeholder="生效日期" value="${object.startDate}" data-am-datepicker readonly>
                        </div>
                        <div style="float: left">&nbsp;&nbsp;至&nbsp;&nbsp;</div>
                        <div class="am-form-group am-form-icon" style="width: 150px;float: left">
                            <i class="am-icon-calendar"></i>
                            <input type="text" id="endDate" name="endDate" class="am-form-field am-input-sm"
                                   placeholder="失效日期" value="${object.endDate}" data-am-datepicker readonly>
                        </div>
                    </div>
                </div>
                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-push-3">
                        <button type="submit" class="am-btn am-btn-primary">保存</button>
                        <%--<button type="submit" id="sc" class="am-btn am-btn-primary" onclick="saveAndCreate()">--%>
                            <%--保存并生成--%>
                        <%--</button>--%>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
