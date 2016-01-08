<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
  <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>

    <style type="text/css">
        .line{margin-bottom:20px;}
        /* 复制提示 */
        .copy-tips{position:fixed;z-index:999;bottom:50%;left:50%;margin:0 0 -20px -80px;background-color:rgba(0, 0, 0, 0.2);filter:progid:DXImageTransform.Microsoft.Gradient(startColorstr=#30000000, endColorstr=#30000000);padding:6px;}
        .copy-tips-wrap{padding:10px 20px;text-align:center;border:1px solid #F4D9A6;background-color:#FFFDEE;font-size:14px;}
    </style>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑专题</strong> /
    <small>New/Edit Subject</small>
  </div>
</div>
<hr/>

<div class="am-g">

    <form action="<c:url value="/product/saveSubject.do"/>" method="post" class="am-form am-form-horizontal">
    <%--<form action="<c:url value="/basic/xm.do?view=${view}"/>" method="post" class="am-form am-form-horizontal">--%>
      <input type="hidden" name="id" value="${object.id}">
      <input type="hidden" name="qm" value="saveOrUpdateSubject">
      <input type="hidden" name="resultPage" value="0" />
      <input type="hidden" name="step" value="subject">
        <input type="hidden" name="subjectShow" value="${object.subjectShow}">
        <c:if test="${empty object.subjectIndex}">
            <input type="hidden" name="subjectIndex" value="1">
        </c:if>
        <c:if test="${not empty object.subjectIndex}">
            <input type="hidden" name="subjectIndex" value="${object.subjectIndex}">
        </c:if>
        <%--<input type="hidden" name="newUrl" value="">--%>
        <input type="hidden" name="pictureUrl" value="${object.pictureUrl}">
        <input type="hidden" name="subjectDescription.id" value="${object.subjectDescription.id}">

      <%--<input type="hidden" name="view" value="${view}">--%>

      <div class="am-form-group">
        <label name="name" class="am-u-sm-3 am-form-label">专题名称</label>

        <div class="am-u-sm-9">

            <input type="text" name="name" id="name" placeholder="" value="${object.name}" >

        </div>
      </div>
        <div class="am-form-group">
            <label name="template" class="am-u-sm-3 am-form-label">专题模板</label>

            <div class="am-u-sm-9">
                <ming800:status name="template" dataType="Subject.template" checkedValue="${object.template}" type="select" onchange="changeTemplate(this)" />
            </div>
        </div>
        <div class="am-form-group">
            <label name="template" class="am-u-sm-3 am-form-label">专题类别</label>

            <div class="am-u-sm-9">
                <ming800:status name="type" dataType="Subject.type" checkedValue="${object.type}" type="select" />
            </div>
        </div>
         <c:if test="${object.template=='2'}">
          <c:set value="block" var="dis"/>
          </c:if>
          <c:if test="${object.template=='1'|| empty object.template }">
              <c:set value="none" var="dis"/>
              </c:if>
            <div class="am-form-group" style="display: ${dis};" id="display">

                <label name="createDate" class="am-u-sm-3 am-form-label">活动时间</label>

                <div class="am-u-sm-9">
                    <div style="margin-top: 9px;">

                        起始:
                        <input style="width: 30%"  value="" type="text" id="startDateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDateTime\')}',minDate:'%y-%M-%d %H:%m:%s'})"  name="startDateTime" />
                        结束:
                        <input  style="width: 30%" value=""  id="endDateTime" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDateTime\')}'})" name="endDateTime"/>
                        <%--<fmt:formatDate value="${object.createDateTime}" type="both" pattern="YYYY-MM-dd HH:mm"/>--%>

                    </div>
                    <!-- <small>必填项*</small>-->
                </div>
            </div>
    <div class="am-form-group" >


        <label class="am-u-sm-3 am-form-label">专题描述</label>
        <div class="am-u-sm-9" style="margin-top: 10px;">
                            <textarea  name="subjectDescription.content" class="ckeditor" id="content"
                                      placeholder="商品描述" required >
                              ${object.subjectDescription.content}
                            </textarea>
        </div>

      <br>
    </div>


      <div class="am-form-group">
        <label name="serial" class="am-u-sm-3 am-form-label">封面</label>

        <div class="am-u-sm-9" style="margin-top: 10px;">
            <ul  style="list-style:none">
                <li>
                    <img id="pictureHost" width="100px;"  src="<c:url value="http://pro.efeiyi.com/${object.pictureUrl}@!product-model"/>"
                         alt="上传封面"/>
                </li>
                <li>
                    <a id="btn_upload"></a>
                </li>
            </ul>

        </div>
      </div>
  <div class="am-form-group">
    <label name="serial" class="am-u-sm-3 am-form-label">附件图片</label>

    <div class="am-u-sm-9" style="margin-top: 10px;">

      <a id="btn_upload3"></a>
    </div>
  </div>
        <c:if test="${not empty object.id}">
            <div class="am-form-group">
                <label name="createDate" class="am-u-sm-3 am-form-label">创建时间</label>

                <div class="am-u-sm-9">
                    <div style="margin-top: 9px;">
                        <input value="${object.createDateTime}" type="hidden" name="createDateTime"/>
                        <fmt:formatDate value="${object.createDateTime}" type="both" pattern="YYYY-MM-dd HH:mm:ss"/>
                    </div>
                    <!-- <small>必填项*</small>-->
                </div>
            </div>
        </c:if>
  <div class="am-u-md-13">
    <div class="am-panel am-panel-default">
      <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-3'}">
        <strong> 附件图片</strong>
        <span class="am-icon-chevron-down am-fr"></span></div>
      <div class="am-panel-bd am-collapse am-in" id="collapse-panel-3" style="height: auto;overflow: hidden">

        <ul style="width: 100%"  style="list-style:none" id="subjectPicture">
          <c:if test="${!empty object.subjectPictureList}">
            <c:forEach var="subjectPicture" items="${object.subjectPictureList}">

              <li style="float: left;margin-right: 10px; width: 200px;"  name="${subjectPicture.id}">
                <dl style="margin-top: 6px;">
                  <dt style="width: 100%">
                    <img width="100%" name=""
                         src="http://pro.efeiyi.com/${subjectPicture.pictureUrl}@!product-model"
                         alt="附件图片"/>
                      <input type="hidden" name="subjectPicture" value="${subjectPicture.pictureUrl}">
                      <input type="hidden" name="flag" value="0">
                      <input type="hidden" name="spId" value="${subjectPicture.id}">
                  </dt>

                  <dd style="width: 100%;text-align: center;" >

                    <a href="javascript:void(0);" onclick="deletePicture1(this)">删除</a>
                  </dd>

                  <dd style="width: 100%;text-align: center;" >
                    <a href="javascript:void(0);"  class="copy" url="http://pro.efeiyi.com/${subjectPicture.pictureUrl}">复制图片地址</a>
                  </dd>
                </dl>
              </li>

            </c:forEach>
          </c:if>
        </ul>
      </div>
    </div>
  </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                    <span style="padding: 10px;">
                   <%--<c:if test="${view == 'newProduct'}">--%>
                       <%--<input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=formProduct_ProductModel&view=${view}&id=${object.id}')" class="am-btn am-btn-primary" value="下一步"/>--%>
                   <%--</c:if>--%>
                        <%--<c:if test="${view == 'tenant'}">--%>
                          <%--<input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=formProduct_ProductModel&view=${view}&tenantId=${tenantId}&id=${object.id}')" class="am-btn am-btn-primary" value="下一步"/>--%>
                        <%--</c:if>--%>
                    </span>
                    <span style="padding: 10px;">


                      <input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=plistSubject_default')"  class="am-btn am-btn-primary" value="保存"/>


                         <%--<input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=formSubject_Description')"  class="am-btn am-btn-primary" value="下一步"/>--%>

                    </span>

            </div>
        </div>
</form>

</div>



<!-- content end -->
<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<script src="<c:url value="/scripts/upload/jquery.uploadify.js"/>"></script>
<script type="text/javascript" src="<c:url value='/scripts/jquery.zclip.js'/>"></script>
<script src="<c:url value="/resources/plugins/My97DatePicker/WdatePicker.js" />" ></script>
<script type="text/javascript">

  //复制图片地址
  function copyInit(obj){

    $(obj).zclip({
      path: "<c:url value="/scripts/zclip/ZeroClipboard.swf"/>",
      copy: function(){
        return $(this).attr("url");
      },
      beforeCopy:function(){/* 按住鼠标时的操作 */
        $(this).css("color","orange");
      },
      afterCopy:function(){/* 复制成功后的操作 */
        var $copysuc = $("<div class='copy-tips'><div class='copy-tips-wrap'>☺ 复制成功</div></div>");
        $("body").find(".copy-tips").remove().end().append($copysuc);
        $(".copy-tips").fadeOut(3000);
      }
    });


  }

   $(function(){

     CKEDITOR.replace('content', { height: '440px', width: '1000px','startupMode':'source' });
     $(".copy").each(function(){
       copyInit($(this));
     });
       if(${not empty object.startDateTime}){
           var startDateTime = '${object.startDateTime}'.substring(0,'${object.startDateTime}'.lastIndexOf("."));
           $("#startDateTime").val(startDateTime);
       }
       if(${not empty object.endDateTime}){
           var endDateTime = '${object.endDateTime}'.substring(0,'${object.startDateTime}'.lastIndexOf("."));

           $("#endDateTime").val(endDateTime);
       }
     $('#btn_upload').uploadify({
       uploader: '<c:url value="/product/subjectUploadify.do?status=1&subjectId=${object.id}"/>',            // 服务器处理地址
       swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
       buttonText: "上传封面图片",                 //按钮文字
       buttonClass:"am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only",         //按钮样式
       buttonCursor:"hand",                    //鼠标指针悬停在按钮上的样子
       height: 34,                             //按钮高度
       width:140,                              //按钮宽度
       auto : true,                          //自动上传
       multi:true,                            //多个文件上传
       scriptDate:{'status':'3'},
       checkExisting:true,                    //检查文件重复
       successTimeout:1000000,                 //超时
       fileSizeLimit:'20MB',
       removeTimeout:1,                        //移除时间
       fileTypeExts: "*.jpg;*.png;",           //允许的文件类型
       fileTypeDesc: "请选择图片文件",           //文件说明
       formData: { "imgType": "normal" }, //提交给服务器端的参数
       onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
           data = data.substring(1,data.length-1);
           var pictureId = "";
           var  imgUrl = data;
           var  url = "";
           var  trueUrl = "";
           $("input[name='pictureUrl']").val(imgUrl);
           url = "http://pro.efeiyi.com/"+imgUrl+"@!product-model";
           trueUrl = "http://pro.efeiyi.com/"+imgUrl;
           $("#pictureHost").attr("src",url);
       }
     });
     $('#btn_upload3').uploadify({
       uploader: '<c:url value="/product/subjectUploadify.do?status=2&subjectId=${object.id}"/>',            // 服务器处理地址
       swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
       buttonText: "上传附件图片",                 //按钮文字
       buttonClass:"am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only",         //按钮样式
       buttonCursor:"hand",                    //鼠标指针悬停在按钮上的样子
       height: 34,                             //按钮高度
       width:140,                              //按钮宽度
       auto : true,                          //自动上传
       multi:true,                            //多个文件上传
       scriptDate:{'status':'3'},
       checkExisting:true,                    //检查文件重复
       successTimeout:1000000,                 //超时
       fileSizeLimit:'20MB',
       removeTimeout:1,                        //移除时间
       fileTypeExts: "*.jpg;*.png;*",           //允许的文件类型
       fileTypeDesc: "请选择图片文件",           //文件说明
       formData: { "imgType": "normal" }, //提交给服务器端的参数
       onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
         data = data.substring(1,data.length-1);
           var pictureId = "";
           var  imgUrl = data;
           var  url = "";
           var  trueUrl = "";

           url = "http://pro.efeiyi.com/"+imgUrl+"@!product-model";
           trueUrl = "http://pro.efeiyi.com/"+imgUrl;

         ///显示图片
         var img ='<li style="float: left;margin-right: 10px;width:200px;" name="'+pictureId+'">'+
                 '<dl style="margin-top: 6px;" >'+
                 '  <dt  style="width: 100%">'+
                 '   <img width="100%" name="'+pictureId+ '"  src="'+url+'" alt="附件图片">'+
                 '      <input type="hidden" name="subjectPicture" value="'+imgUrl+'">'+
                 '      <input type="hidden" name="flag" value="1">'+
                 '      <input type="hidden" name="spId" value="0">'+
                 '  </dt>'+
                 '  <dd style="width: 100%;text-align:center" >'+
                   //      '<a href="javascript:void(0);" onclick="updatePictureStatus(this,\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
                 '   <a href="javascript:void(0);" onclick="deletePicture1(this)">'+
                 ' 删除'+
                 '</a>'+
                 '</dd>'+
                 '<dd style="width: 100%;text-align: center;" >'+
                 '  <a href="javascript:void(0);" onclick="copyInit(this);" class="copy" url="'+trueUrl+'">'+'复制图片地址'+'</a>'+
                 '</dd>'+
                 '</dl>'+
                 '</li>';

         $("#collapse-panel-3 ul").append(img);
//                $("#picUrl").append(tr);

       }
     });
     $("#btn_upload-button").css({"padding":"0em 0em","text-align":"center"});
     $("#btn_upload3-button").css({"padding":"0em 0em","text-align":"center"});
   });


  function toSubmit(result){
      $("input[name='resultPage']").val(result);
      if($("#name").val()==""){
          alert("专题名称不能为空");
      }

     else{

          $("form").submit();
      }

  }

 function deletePicture1(obj){
     var   spId = $("input[name='spId']",$(obj).parents("li")).val();
     if(spId == "0"){
         $(obj).parents("li").remove();
     }else{
         $("input[name='flag']",$(obj).parents("li")).val("-1");
         $(obj).parents("li").hide();
     }

 }

    function changeTemplate(obj){
        if($(obj).val()=="2"){
            $("#display").css({"display":"block"});
        }
        if($(obj).val()=="1"){
            $("#display").css({"display":"none"});
        }
    }
</script>


</body>
</html>
