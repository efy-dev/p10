<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/10
  Time: 17:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>虚拟订单计划信息</title>
    <script src="<c:url value='/resources/plugins/My97DatePicker/WdatePicker.js'/>"></script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">虚拟订单计划信息</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="orderPlanForm" onsubmit="return isSubmitForm()"
          action="<c:url value='/virtualPlan/saveVirtualOrderPlan.do'/>"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}"/>
        <input type="hidden" name="implementClass" value="${object.implementClass}"/>
        <input type="hidden" name="createDatetime" value="${object.createDatetime}"/>

        <div class="am-form-group">
            <label for="serial" class="am-u-sm-3 am-form-label">虚拟计划编号<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="serial" id="serial" title="虚拟计划编号"
                       value="${object.serial}" required="true" readonly>
            </div>
        </div>

        <div class="am-form-group">
            <label for="description" class="am-u-sm-3 am-form-label">虚拟数据批次名<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="description" id="description"
                       title="虚拟数据批次名" placeholder="虚拟数据批次名"
                       value="${object.description}" required="true" readonly>
            </div>
        </div>

        <div class="am-form-group">
            <label for="planType" class="am-u-sm-3 am-form-label">虚拟数据对象<small>*</small></label>
            <div class="am-u-sm-9" style="margin-top: 8px">
                <input type="text" value="<ming800:status name="planTypeSelect" dataType="PCVirtualPlan.planType" checkedValue="${object.planType}" type="normal"/>" readonly>
                <input type="hidden" name="planType" id="planType" title="虚拟数据对象" required="true" value="${object.planType}" readonly>
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">任务截止日期<small>*</small></label>
            <div class="am-u-sm-9">

                <input type="text" style="width: auto; float: left; height: 35px"
                       name="startDate" id="startDate" title="开始日期"
                       value="${object.startDate}" required="true" readonly>

                <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">至</span>

                <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
                       name="endDate" id="endDate" title="结束日期"
                       value="${object.endDate}" required="true" readonly>
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">任务运行时间<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" style="width: auto; float: left; height: 35px"
                       name="startTime" id="startTime" title="开始时间"
                       value="${object.startTime}" required="true" readonly>

                <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">至</span>

                <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
                       name="endTime" id="endTime" title="结束时间"
                       value="${object.endTime}" required="true" readonly>
            </div>
        </div>
        <hr/>
        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">订单数量区间<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="number" style="width: 210px; float: left; height: 35px; margin-top: 4px"
                       name="orderAmountFloor" id="orderAmountFloor" title="订单数量下限" placeholder="订单数量下限"
                       value="${object.orderAmountFloor}" required="true">

                <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 8px">至</span>

                <input type="number" style="width: 210px; float: left; margin-left: 10px; height: 35px; margin-top: 4px"
                       name="orderAmountCeil" id="orderAmountCeil" title="订单数量上限" placeholder="订单数量上限"
                       value="${object.orderAmountCeil}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">均值小时<small>*</small></label>
            <div class="am-u-sm-9">
                <input class="Wdate" onClick="WdatePicker({dateFmt:'HH:mm:ss'})"
                       type="text" style="width: auto; float: left; height: 35px; margin-top: 4px"
                       name="peakTime" id="peakTime" title="均值小时"
                       placeholder="均值小时" value="${object.peakTime}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">标准差小时<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="number" style="width: 210px; float: left; height: 35px; margin-top: 4px"
                       name="standardDeviation" id="standardDeviation" title="标准差小时" placeholder="标准差小时"
                       value="${object.standardDeviation}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">选择用户计划<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="hidden" name="virtualUserPlan.id" id="virtualUserPlanId"
                       placeholder="用户计划" value="${object.virtualUserPlan.id}" required="true">
                <input type="text" name="virtualUserPlan.description" id="virtualUserPlanName"
                       placeholder="用户计划" data-am-modal="{target: '#userPlanModal'}"
                       value="${object.virtualUserPlan.description}" >
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">选择商品<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="hidden" name="productModelIdList" id="productModelIdList"
                       placeholder="商品" value="${pmIdList}" required="true">
                <input type="text" name="productModelNameList" id="productModelNameList"
                       placeholder="商品" data-am-modal="{target: '#productModels'}" value="${pmNameList}" >
            </div>
        </div>

        <c:if test="${object.status == '1' || object.status == '2'}">
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
        </c:if>

    </form>
</div>

<div class="am-popup" id="userPlanModal" style="height: 500px">
    <div class="am-popup-inner">
        <div class="am-popup-hd">
            <h4 class="am-popup-title">用户计划</h4>
            <span data-am-modal-close class="am-close">&times;</span>
        </div>
        <div class="am-popup-bd" style="height: 10px">
            <input type="text" name="selUserPlan"  style="float: left" placeholder="编号或名称" value=""/>
            <a style="width: 10%;float: left;margin-left: 10px;"
               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
               href="javascript:void(0);" onclick="selUserPlan()">查找
            </a>
        </div>
        <div class="am-popup-bd" style="height: 420px">
            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover">
                <tr>
                    <td class="am-text-center" width="14%">操作</td>
                    <td class="am-text-center" width="17%">用户计划编号</td>
                    <td class="am-text-center" width="17%">用户计划名称</td>
                </tr>
            </table>
            <div style="height: 350px; overflow-y: auto; margin-top: 0px">
            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                   id="userPlanTable">
                <tbody>
                <c:forEach var="plan" items="${userPlanList}">
                    <tr name="${plan.description}" serial="${plan.serial}">
                        <td align="center" width="33%">
                            <a style="width: 10%;"
                               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                               href="javascript:void(0);" onclick="selectUserPlan('${plan.id}','${plan.description}')">
                                选择
                            </a>
                        </td>
                        <td class="am-text-center" width="33%">${plan.serial}</td>
                        <td class="am-text-center" width="33%">${plan.description}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</div>

<div class="am-popup" id="productModels" style="height: 550px">
    <div class="am-popup-inner">
        <div class="am-popup-hd">
            <h4 class="am-popup-title">选择商品</h4>
            <span data-am-modal-close class="am-close">&times;</span>
        </div>
        <div class="am-popup-bd" style="height: 10px">
            <input type="text" name="selProductModel"  style="float: left" placeholder="编号或名称" value=""/>
            <a style="width: 10%;float: left;margin-left: 10px;"
               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
               href="javascript:void(0);" onclick="selProductModel()">查找
            </a>
        </div>
        <div class="am-popup-bd" style="height: 420px">
            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover">
                <tr>
                    <td class="am-text-center" width="4%">操作</td>
                    <th class="am-text-center" width="8%">规格编号</th>
                    <th class="am-text-center" width="17%">规格名称</th>
                </tr>
            </table>
            <div style="height: 350px; overflow-y: auto;">
                <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                       id="productModelTable">
                    <tbody>
                    <c:forEach var="productModel" items="${productModelList}">
                        <tr name="${productModel.name}" serial="${productModel.serial}">
                            <td align="center" width="13%">
                                <c:if test="${fn:contains(pmIdList, productModel.id)}">
                                    <input type="checkbox" name="pModel" value="${productModel.id}" checked="checked" title="${productModel.product.name}[${productModel.name}]">
                                </c:if>
                                <c:if test="${not fn:contains(pmIdList, productModel.id)}">
                                    <input type="checkbox" name="pModel" value="${productModel.id}" title="${productModel.product.name}[${productModel.name}]">
                                </c:if>
                            </td>
                            <td class="am-text-center" width="33%">${productModel.serial}</td>
                            <td class="am-text-center" width="53%">${productModel.product.name}[${productModel.name}]</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div style="height: 10px; margin-top: 10px" align="center">
                <input type="button" name="cancel" value="取消" onclick="btnCancel()"/>
                <input type="button" name="confirm" value="确定" onclick="btnConfirm()"/>
            </div>
        </div>
    </div>
</div>

<script>
    function isSubmitForm(){
        if(afterSubmitForm() && amountCheck()){
            return true;
        }
        return false;
    }
    function afterSubmitForm(){
        var form = document.getElementById("orderPlanForm");
        var a = form.elements.length;//所有的控件个数
        for (var j=0;j<a;j++){
            if(form.elements[j].required){
                if(form.elements[j].value=="" || form.elements[j].value==null){
                    alert(form.elements[j].placeholder + "不能为空");
                    form.elements[j].focus();
                    return false;
                }
            }
        }
        return true;
    }
    function amountCheck(){
        var oaf = $("#orderAmountFloor").val();
        var oac = $("#orderAmountCeil").val();
        if(oac-oaf<=0){
            alert("订单数量下限应小于数量上限");
            return false;
        }
        return true;
    }

    function selUserPlan(){
        var v = $("input[name='selUserPlan']").val();
        if(v==""){
            $("#userPlanTable tr:gt(0)").each(function(){
                $(this).show();
            });
        }else {
            $("#userPlanTable tr:gt(0)").each(function () {
                if ($(this).attr("name").indexOf(v)!=-1 || $(this).attr("serial").indexOf(v) != -1 ) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    }
    function selectUserPlan(id,name){
        $("#virtualUserPlanId").val(id);
        $("#virtualUserPlanName").val(name);
        $("#userPlanModal").modal('close');
    }

    function selProductModel(){
        var v = $("input[name='selProductModel']").val();
        if(v==""){
            $("#productModelTable tr:gt(0)").each(function(){
                $(this).show();
            });
        }else {
            $("#productModelTable tr:gt(0)").each(function () {
                if ($(this).attr("name").indexOf(v)!=-1 || $(this).attr("serial").indexOf(v) != -1 ) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    }

    function btnCancel(){
        $("#productModels").modal('close');
    }
    function btnConfirm(){
        var idList = "";
        var nameList = "";
        $("input[name='pModel']:checked").each(function(){
//            alert($(this).attr("title"));
            if(idList != ""){
                idList = idList + "," + $(this).val();
            }else {
                idList = $(this).val();
            }
            if(nameList != ""){
                nameList = nameList + "," + $(this).attr("title");
            }else {
                nameList = $(this).attr("title");
            }
        });

        $("#productModelIdList").val(idList);
        $("#productModelNameList").val(nameList);
        $("#productModels").modal('close');
    }
</script>
</body>
</html>
