<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/22
  Time: 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
  <title>题目信息</title>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf">
    <strong class="am-text-primary am-text-lg">题目信息</strong>
  </div>
</div>
<hr/>
<div class="am-g">
  <form name="qForm" onsubmit="return checkRadio()"
        action="<c:url value='/question/saveOrUpdateQuestion.do'/>"
        method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="serial" value="${object.serial}"/>
    <input type="hidden" name="status" value="${object.status}"/>

    <div class="am-form-group">
      <label for="questionName" class="am-u-sm-3 am-form-label">题目名称<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="questionName" id="questionName"
               title="题目名称" placeholder="题目名称"
               value="${object.questionName}" required="true">
      </div>
    </div>
    <div class="am-form-group">
      <label for="questionContent" class="am-u-sm-3 am-form-label">题目内容<small>*</small></label>
      <div class="am-u-sm-9">
        <textarea name="questionContent" id="questionContent"
               title="题目名称" placeholder="题目名称"
               required="true">${object.questionContent}</textarea>
      </div>
    </div>
    <div class="am-form-group">
      <label for="answerA" class="am-u-sm-3 am-form-label">答案A<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="answerA" id="answerA" style="width: auto;float: left"
               title="答案A" placeholder="答案A"
               value="${object.answerA}" required="true">
        <input type="radio" name="answerTrue"
               style="margin-top: 12px;margin-left: 8px" value="A"
               <c:if test="${object.answerTrue == 'A'}">checked</c:if>>设为正确答案
      </div>
    </div>
    <div class="am-form-group">
      <label for="answerB" class="am-u-sm-3 am-form-label">答案B<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="answerB" id="answerB" style="width: auto;float: left"
               title="答案B" placeholder="答案B"
               value="${object.answerB}" required="true">
        <input type="radio" name="answerTrue"
               style="margin-top: 12px;margin-left: 8px" value="B"
               <c:if test="${object.answerTrue == 'B'}">checked</c:if>>设为正确答案
      </div>
    </div>
    <div class="am-form-group">
      <label for="answerC" class="am-u-sm-3 am-form-label">答案C<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="answerC" id="answerC" style="width: auto;float: left"
               title="答案C" placeholder="答案C"
               value="${object.answerC}" required="true">
        <input type="radio" name="answerTrue"
               style="margin-top: 12px;margin-left: 8px" value="C"
               <c:if test="${object.answerTrue == 'C'}">checked</c:if>>设为正确答案
      </div>
    </div>
    <div class="am-form-group">
      <label for="answerD" class="am-u-sm-3 am-form-label">答案D<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="answerD" id="answerD" style="width: auto;float: left"
               title="答案D" placeholder="答案D"
               value="${object.answerD}" required="true">
        <input type="radio" name="answerTrue"
               style="margin-top: 12px;margin-left: 8px" value="D"
               <c:if test="${object.answerTrue == 'D'}">checked</c:if>>设为正确答案
      </div>
    </div>
    <div class="am-form-group">
      <label for="answerKnowledge" class="am-u-sm-3 am-form-label">答案知识<small>*</small></label>
      <div class="am-u-sm-9">
        <textarea name="answerKnowledge" id="answerKnowledge"
                title="答案知识" placeholder="答案知识"
                required="true">${object.answerKnowledge}</textarea>
      </div>
    </div>

    <div class="am-form-group">
      <label for="pictureUrl" class="am-u-sm-3 am-form-label">题目图片<small>&nbsp;&nbsp;</small></label>
      <div class="am-u-sm-9">
        <input type="file" id="pictureUrl" name="pictureUrl" title="题目图片" placeholder="题目图片"
               value="${object.pictureUrl}">
      </div>
    </div>
    <div class="am-form-group">
      <label class="am-u-sm-3 am-form-label"><small></small></label>
      <div class="am-u-sm-9">
        <c:if test="${!empty object.pictureUrl}">
          <img src="<c:url value='${object.pictureUrl}'/>">
        </c:if>
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
    function checkRadio(){
        var tag = false;
        for(var i = 0; i < document.qForm.answerTrue.length; i++){
            if(document.qForm.answerTrue[i].checked){
                tag = true;
                break;
            }
        }
        if(!tag){
            alert("请设置一个正确答案");
        }
        return tag;
    }
</script>
</body>
</html>
