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

<html>
<head>
  <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑专题</strong> /
    <small>New/Edit Subject</small>
  </div>
</div>
<hr/>
<div class="admin-content">
<div class="am-g">

    <form action="<c:url value="/product/saveSubject.do"/>" method="post" class="am-form am-form-horizontal">
    <%--<form action="<c:url value="/basic/xm.do?view=${view}"/>" method="post" class="am-form am-form-horizontal">--%>
      <input type="hidden" name="id" value="${object.id}">
      <input type="hidden" name="qm" value="saveOrUpdateSubject">
      <input type="hidden" name="resultPage" value="0" />
      <input type="hidden" name="step" value="subject">
        <input type="hidden" name="subjectDescription.id" value="${object.subjectDescription.id}">

      <%--<input type="hidden" name="view" value="${view}">--%>

      <div class="am-form-group">
        <label name="name" class="am-u-sm-3 am-form-label">专题名称</label>

        <div class="am-u-sm-9">

            ${object.name}

        </div>
      </div>

    <div class="am-form-group" >
        <input type="hidden" name="subject.id" value="${object.id}">
        <input type="hidden" name="resultPage" value="0" />

        <input type="hidden" name="step" value="description">
        <label class="am-u-sm-3 am-form-label">专题描述</label>
        <div class="am-u-sm-9" style="margin-top: 10px;">
                            <textarea id="subjectDescription" name="content" class="ckeditor" id="content"
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
                    <img width="35px;" src="<c:url value="http://pro.efeiyi.com/${subject.pictureUrl}@!product-model"/>"
                         alt=""/>
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


  <div class="am-u-md-13">
    <div class="am-panel am-panel-default">
      <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-3'}">
        <strong> 附件图片</strong>
        <span class="am-icon-chevron-down am-fr"></span></div>
      <div class="am-panel-bd am-collapse am-in" id="collapse-panel-3" style="height: auto;overflow: hidden">

        <ul style="width: 100%"  style="list-style:none">
          <c:if test="${!empty object.subjectPictureList}">
            <c:forEach var="subjectPicture" items="${object.subjectPictureList}">

              <li style="float: left;margin-right: 10px; width: 200px;"  name="${subjectPicture.id}">
                <dl style="margin-top: 6px;">
                  <dt style="width: 100%">
                    <img width="100%" name=""
                         src="http://pro.efeiyi.com/${subjectPicture.pictureUrl}@!product-model"
                         alt="附件图片"/>
                  </dt>

                  <dd style="width: 100%;text-align: center;" >

                    <a href="javascript:void(0);" onclick="deletePicture(this,'${subjectPicture.id}')">删除</a>
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


                      <input type="button" onclick="toSubmit('redirect:basic/xm.do?qm=formSubject')"  class="am-btn am-btn-primary" value="保存"/>


                         <input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=plistSubject_default')"  class="am-btn am-btn-primary" value="下一步"/>

                    </span>

            </div>
        </div>
</form>

</div>

</div>

<!-- content end -->
<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<script src="<c:url value="/scripts/upload/jquery.uploadify.js"/>"></script>
<script type="text/javascript" src="<c:url value='/scripts/jquery.zclip.js'/>"></script>
<script type="text/javascript">

  //复制图片地址
  function copyInit(obj){

    $(obj).zclip({
      path: "http://www.steamdev.com/zclip/js/ZeroClipboard.swf",
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

   //  CKEDITOR.replace('content', { height: '440px', width: '1000px' });
     $(".copy").each(function(){
       copyInit($(this));
     });

     $('#btn_upload').uploadify({
       uploader: '<c:url value="/product/uploadify.do?status=1&productId=${object.id}"/>',            // 服务器处理地址
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
         data = data.substring(1,data.length-1)
         var pictureId = data.split(":")[0].trim();
         var  imgUrl = data.split(":")[1];
         var  url = "http://pro.efeiyi.com/"+imgUrl+"@!product-model";
         var  trueUrl = "http://pro.efeiyi.com/"+imgUrl;
//                ///图片信息
//                var tr = '<tr name = "'+pictureId+'">' +
//                        ' <td>  ' +
//                        '   <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="deletePicture(this,\''+pictureId+'\')"  href="javascript:void(0);">' +
//                        '       <span class="am-icon-trash-o"></span> 删除 ' +
//                        '   </a>' +
//                        ' </td>' +
//                        ' <td>' +url+
//                        ' </td>' +
//                        ' <td>' +
//                        '   <img style="margin-left:2px;" width="18%;" src="'+url+'">' +
//                        ' </td>' +
//                        '</tr>';
         ///显示图片
         var img ='<li style="float: left;margin-right: 10px;width:200px;" name="'+pictureId+'">'+
                 '<dl style="margin-top: 6px;" >'+
                 '  <dt  style="width: 100%">'+
                 '   <img width="100%" name="'+pictureId+ '"  src="'+url+'" alt="商品主图片">'+
                 '  </dt>'+
                 '  <dd style="width: 100%;text-align:center" >'+
                 '<a href="javascript:void(0);" status="1" onclick="updatePictureStatus(this,\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
                 '   <a href="javascript:void(0);" onclick="deletePicture(this,\''+pictureId+'\')">'+
                 ' 删除'+
                 '</a>'+
                 '</dd>'+
                 '<dd style="width: 100%;text-align: center;" >'+
                 '<select style="width: 85%;" onchange="setModelPic(this,\''+pictureId+'\')">'+
                 '<option value="0">'+'设置商品规格图片'+'</option>';
         for(var n=0;n<modelIds.length;n++) {

           img +=  '<option value="'+modelIds[n]+ '">'+modelNames[n]+'</option>';

         }
         img += '      </select>'+
                 '</dd>'+
                 '<dd style="width: 100%;text-align: center;" >'+
                 '  <a href="javascript:void(0);" onclick="copyInit(this);"   class="copy" url="'+trueUrl+'">'+'复制图片地址'+'</a>'+
                 '</dd>'+
                 '</dl>'+
                 '</li>';

         $("#collapse-panel-1 ul").append(img);
//                $("#picUrl").append(tr);

//                $("#collapse-panel-1 ul li[name='"+pictureId+"'] .copy").zclip({
//                    path: "http://www.steamdev.com/zclip/js/ZeroClipboard.swf",
//                    copy: function(){
//                        return $(this).attr("url");
//                    },
//                    beforeCopy:function(){/* 按住鼠标时的操作 */
//                        $(this).css("color","orange");
//                    },
//                    afterCopy:function(){/* 复制成功后的操作 */
//                        var $copysuc = $("<div class='copy-tips'><div class='copy-tips-wrap'>☺ 复制成功</div></div>");
//                        $("body").find(".copy-tips").remove().end().append($copysuc);
//                        $(".copy-tips").fadeOut(3000);
//                    }
//                });

       }
     });
     $('#btn_upload3').uploadify({
       uploader: '<c:url value="/product/uploadify.do?status=3&productId=${object.id}"/>',            // 服务器处理地址
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
         data = data.substring(1,data.length-1)
         var pictureId = data.split(":")[0].trim();
         var  imgUrl = data.split(":")[1];
         var  url = "http://pro.efeiyi.com/"+imgUrl+"@!product-model";
         var  trueUrl = "http://pro.efeiyi.com/"+imgUrl;
         ///图片信息
//                var tr = '<tr name = "'+pictureId+'">' +
//                        ' <td>  ' +
//                        '   <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="deletePicture(this,\''+pictureId+'\')"  href="javascript:void(0);">' +
//                        '       <span class="am-icon-trash-o"></span> 删除 ' +
//                        '   </a>' +
//                        ' </td>' +
//                        ' <td>' +url+
//                        ' </td>' +
//                        ' <td>' +
//                        '   <img style="margin-left:2px;" width="18%;" src="'+url+'">' +
//                        ' </td>' +
//                        '</tr>';
         ///显示图片
         var img ='<li style="float: left;margin-right: 10px;width:200px;" name="'+pictureId+'">'+
                 '<dl style="margin-top: 6px;" >'+
                 '  <dt  style="width: 100%">'+
                 '   <img width="100%" name="'+pictureId+ '"  src="'+url+'" alt="商品主图片">'+
                 '  </dt>'+
                 '  <dd style="width: 100%;text-align:center" >'+
                   //      '<a href="javascript:void(0);" onclick="updatePictureStatus(this,\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
                 '   <a href="javascript:void(0);" onclick="deletePicture(this,\''+pictureId+'\')">'+
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


</script>


</body>
</html>
