<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/29
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
  <title>答题设置</title>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf">
    <strong class="am-text-primary am-text-lg">答题设置</strong>
  </div>
</div>
<hr/>
<div class="am-g">
  <form onsubmit="return formValidate()"
        action="<c:url value='/basic/xm.do?qm=saveOrUpdateQuestionSetting'/>"
        method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
    <input type="hidden" name="id" value="${questionSetting.id}">
    <input type="hidden" name="status" value="1"/>

    <div class="am-form-group">
      <label class="am-u-sm-3 am-form-label" style="width: 100px;">等级I<small>*</small></label>
      <div class="am-u-sm-9" style="width: auto;float: left">

        <span style="width: auto;float: left;font-family:'应用字体 Regular', '应用字体';margin-left: 10px;margin-top: 4px;margin-right: 10px;">前</span>

        <input type="text" style="width: auto; float: left; height: 35px"
               name="rank11" id="rank11" title="等级I下限" placeholder="等级I下限"
               onblur="rankPrizeValidate('rank11', 'rank12', 'prize10')"
               value="${questionSetting.rank11}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">至</span>

        <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
               name="rank12" id="rank12" title="等级I上限" placeholder="等级I上限"
               onblur="rankPrizeValidate('rank12', 'rank11', 'prize10')"
               value="${questionSetting.rank12}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">名,奖励</span>

        <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
               name="prize10" id="prize10" title="等级I奖励金额" placeholder="等级I奖励金额"
               onblur="rankPrizeValidate('prize10', 'rank11', 'rank12')"
               value="${questionSetting.prize10}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">元（余额）;</span>

      </div>
    </div>

    <div class="am-form-group">
      <label class="am-u-sm-3 am-form-label" style="width: 100px;">等级II<small>*</small></label>
      <div class="am-u-sm-9" style="width: auto;float: left">

        <span style="width: auto;float: left;font-family:'应用字体 Regular', '应用字体';margin-left: 10px;margin-top: 4px;margin-right: 10px;">前</span>

        <input type="text" style="width: auto; float: left; height: 35px"
               name="rank21" id="rank21" title="等级II下限" placeholder="等级II下限"
               onblur="rankPrizeValidate('rank21', 'rank22', 'prize20')"
               value="${questionSetting.rank21}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">至</span>

        <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
               name="rank22" id="rank22" title="等级II上限" placeholder="等级II上限"
               onblur="rankPrizeValidate('rank22', 'rank21', 'prize20')"
               value="${questionSetting.rank22}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">名,奖励</span>

        <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
               name="prize20" id="prize20" title="等级II奖励金额" placeholder="等级II奖励金额"
               onblur="rankPrizeValidate('prize20', 'rank21', 'rank22')"
               value="${questionSetting.prize20}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">元（余额）;</span>

      </div>
    </div>

    <div class="am-form-group">
      <label class="am-u-sm-3 am-form-label" style="width: 100px;">等级III<small>*</small></label>
      <div class="am-u-sm-9" style="width: auto;float: left">

        <span style="width: auto;float: left;font-family:'应用字体 Regular', '应用字体';margin-left: 10px;margin-top: 4px;margin-right: 10px;">前</span>

        <input type="text" style="width: auto; float: left; height: 35px"
               name="rank31" id="rank31" title="等级III下限" placeholder="等级III下限"
               onblur="rankPrizeValidate('rank31', 'rank32', 'prize30')"
               value="${questionSetting.rank31}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">至</span>

        <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
               name="rank32" id="rank32" title="等级III上限" placeholder="等级III上限"
               onblur="rankPrizeValidate('rank32', 'rank31', 'prize30')"
               value="${questionSetting.rank32}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">名,奖励</span>

        <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
               name="prize30" id="prize30" title="等级III奖励金额" placeholder="等级III奖励金额"
               onblur="rankPrizeValidate('prize30', 'rank31', 'rank32')"
               value="${questionSetting.prize30}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">元（余额）;</span>

      </div>
    </div>

    <div class="am-form-group">
      <label class="am-u-sm-3 am-form-label" style="width: 100px;"><small>&nbsp;&nbsp;</small></label>
      <div class="am-u-sm-9" style="width: auto;float: left">
        <input type="checkbox" name="commonPrizeTrue" id="commonPrizeTrue" value=""
               style="float: left;margin-left: 10px; margin-top: 12px;margin-right: 4px;"
               onchange="commonPrizeValidate()"
               <c:if test="${questionSetting.commonPrizeTrue == '1'}">checked</c:if>>

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">阳光普照奖</span>

        <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
               name="commonPrize" id="commonPrize" title="普通奖励金额" placeholder="普通奖励金额"
               value="${questionSetting.commonPrize}">

        <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">元优惠券,优惠券链接</span>

        <input type="text" style="width: 360px; float: left; margin-left: 10px; height: 35px"
               name="couponUrl" id="couponUrl" title="优惠券链接" placeholder="优惠券链接"
               value="${questionSetting.couponUrl}">
      </div>
    </div>

    <div class="am-form-group">
      <div class="am-u-sm-9 am-u-sm-push-3">
        <input type="submit" class="am-btn am-btn-primary" value="保存"/>
      </div>
    </div>

  </form>
</div>

<script>
  String.prototype.trim=function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
  };

  function rankPrizeValidate(val, val2, val3){
    var rank = $("#"+val).val();
    if(rank.trim() != ""){
      $("#"+val2).attr("required", true);
      $("#"+val3).attr("required", true);
    }else{
      $("#"+val2).removeAttr("required");
      $("#"+val3).removeAttr("required");
    }
  }

  function commonPrizeValidate(){
      if($("#commonPrizeTrue").is(":checked")){
          $("#commonPrize").attr("required", true);
          $("#couponUrl").attr("required", true);
          $("#commonPrizeTrue").val("1");
      }else{
          $("#commonPrize").removeAttr("required");
          $("#couponUrl").removeAttr("required");
          $("#commonPrizeTrue").val("0");
      }
  }

  function formValidate(){
      var rank11 = $("#rank11").val();
      var rank12 = $("#rank12").val();

      var rank21 = $("#rank21").val();
      var rank22 = $("#rank22").val();

      var rank31 = $("#rank31").val();
      var rank32 = $("#rank32").val();


      if(rank21.trim() != ""){
          if(rank12.trim() == ""){
              alert("请填写等级I的信息");
              return false;
          }else if(rank21-rank12 != 1){
              alert("请确保等级II下限与等级I上限相差1");
              return false;
          }
      }

      if(rank31.trim() != ""){
          if(rank22.trim() == ""){
              alert("请填写等级II的信息");
              return false;
          }else if(rank31-rank22 != 1){
              alert("请确保等级III下限与等级II上限相差1");
              return false;
          }
      }

      if(rank12.trim() != ""){
          if(rank12-rank11<1){
              alert("请确保等级I上限大于下限");
              return false;
          }
      }

      if(rank22.trim() != ""){
          if(rank22-rank21<1){
              alert("请确保等级II上限大于下限");
              return false;
          }
      }

      if(rank32.trim() != ""){
          if(rank32-rank31<1){
              alert("请确保等级III上限大于下限");
              return false;
          }
      }

    return true;
  }

</script>

</body>
</html>
