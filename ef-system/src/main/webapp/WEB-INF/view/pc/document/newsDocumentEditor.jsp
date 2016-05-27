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
<html>
<head>
  <title></title>
  <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>
  <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
  <script src="<c:url value="/scripts/upload/jquery.uploadify.js"/>"></script>
  <style type="text/css">
    .line{margin-bottom:20px;}
    /* 复制提示 */
    .copy-tips{position:fixed;z-index:999;bottom:50%;left:50%;margin:0 0 -20px -80px;background-color:rgba(0, 0, 0, 0.2);filter:progid:DXImageTransform.Microsoft.Gradient(startColorstr=#30000000, endColorstr=#30000000);padding:6px;}
    .copy-tips-wrap{padding:10px 20px;text-align:center;border:1px solid #F4D9A6;background-color:#FFFDEE;font-size:14px;}
  </style>
</head>
<body>



<div class="am-g">

  <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
  </div>


  <form action="<c:url value="/document/saveECDocument.do?groupName=${groupName}"/>" method="post" class="am-form am-form-horizontal">
    <input type="hidden" value="redirect:/basic/xm.do?qm=plistDocumentNews_default&groupName=${groupName} " name="url">
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="documentContent.id" value="${object.documentContent.id}">
    <div class="am-form-group">
      <label for="title" class="am-u-sm-3 am-form-label">标题</label>
      <div class="am-u-sm-9">
        <input type="text" id="title" name="title" placeholder="" value="${object.title}">
      </div>
    </div>
    <div class="am-form-group">
      <label for="group" class="am-u-sm-3 am-form-label">类别</label>
      <div class="am-u-sm-9">
        <ming800:status name="group" dataType="Document.group" checkedValue="${object.group}" type="select"/>
      </div>
    </div>
    <div class="am-form-group">
      <label  class="am-u-sm-3 am-form-label">内容</label>
      <div class="am-u-sm-9">
                            <textarea id="documentContent.content" name="documentContent.content" class="ckeditor"
                                      placeholder="输入内容">${object.documentContent.content}
                            </textarea>
      </div>
    </div>


    <div class="am-form-group">
      <label name="serial" class="am-u-sm-3 am-form-label">附件图片</label>

      <div class="am-u-sm-9" style="margin-top: 10px;">

        <a id="btn_upload3"></a>
      </div>
    </div>


    <div class="am-u-md-13">
      <div class="am-panel am-panel-default">
        <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-3'}">
          <strong> 附件图片</strong>
          <span class="am-icon-chevron-down am-fr"></span></div>
        <div class="am-panel-bd am-collapse am-in" id="collapse-panel-3" style="height: auto;overflow: hidden">

          <ul style="width: 100%"  style="list-style:none" id="documentPicture">
            <c:if test="${!empty object.documentPictureList}">
              <c:forEach var="documentPicture" items="${object.documentPictureList}">

                <li style="float: left;margin-right: 10px; width: 200px;"  name="${documentPicture.id}">
                  <dl style="margin-top: 6px;">
                    <dt style="width: 100%">
                      <img width="100%" name=""
                           src="http://pro.efeiyi.com/${documentPicture.pictureUrl}@!product-model"
                           alt="附件图片"/>
                      <input type="hidden" name="documentPicture" value="${documentPicture.pictureUrl}">
                      <input type="hidden" name="flag" value="0">
                      <input type="hidden" name="spId" value="${documentPicture.id}">
                    </dt>

                    <dd style="width: 100%;text-align: center;" >

                      <a href="javascript:void(0);" onclick="deleteDocumentPicture1(this)">删除</a>
                    </dd>

                    <dd style="width: 100%;text-align: center;" >
                      <a href="javascript:void(0);"  class="copy" url="http://pro.efeiyi.com/${documentPicture.pictureUrl}">复制图片地址</a>
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
        <button type="submit" class="am-btn am-btn-primary">保存修改</button>
      </div>
    </div>

  </form>
</div>

<script type="text/javascript" src="<c:url value='/scripts/jquery.zclip.js'/>"></script>
<script>

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
    CKEDITOR.replace('documentContent.content', {height: '440px', width: '1000px'});
    $(".copy").each(function(){
      copyInit($(this));
    });

    $('#btn_upload3').uploadify({
      uploader: '<c:url value="/document/documentUploadify.do"/>',            // 服务器处理地址
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
                '      <input type="hidden" name="documentPicture" value="'+imgUrl+'">'+
                '      <input type="hidden" name="flag" value="1">'+
                '      <input type="hidden" name="spId" value="0">'+
                '  </dt>'+
                '  <dd style="width: 100%;text-align:center" >'+
                  //      '<a href="javascript:void(0);" onclick="updatePictureStatus(this,\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
                '   <a href="javascript:void(0);" onclick="deleteDocumentPicture1(this)">'+
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
    $("#btn_upload3-button").css({"padding":"0em 0em","text-align":"center"});
  });

  function deleteDocumentPicture1(obj){
    var   spId = $("input[name='spId']",$(obj).parents("li")).val();
    if(spId == "0"){
      $(obj).parents("li").remove();
    }else{
      $("input[name='flag']",$(obj).parents("li")).val("-1");
      $(obj).parents("li").hide();
    }

  }
</script>
</body>
</html>
