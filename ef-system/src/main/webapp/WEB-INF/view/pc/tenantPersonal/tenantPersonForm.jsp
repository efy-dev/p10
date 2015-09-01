<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <script src="<c:url value="/scripts/jquery-1.11.1.min.js"/>"></script>
    <title></title>
</head>
<body>
<center>
  <form action="<c:url value="/basic/xmm.do"/>" method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
    <input type="hidden" name="qm" value="saveOrUpdatePersonTenant">
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="type" value="13" />
    <table>
      <div class="am-form-group">
        <label for="name" class="am-u-sm-3 am-form-label">*名称</label>

        <div class="am-u-sm-9">
          <input type="text" id="name" name="name" placeholder="name" value="${object.name}">
        </div>
      </div>
      <div class="am-form-group">
        <label for="identity" class="am-u-sm-3 am-form-label">身份证号</label>

        <div class="am-u-sm-9">
          <input type="text" id="identity" name="identity" placeholder="身份证号" value="${object.identity}">
        </div>
      </div>
      <div class="am-form-group">
        <label for="frontPhotoUrl" class="am-u-sm-3 am-form-label">*经营者身份证电子版正面</label>

        <div class="am-u-sm-9">
                <span style="padding: 10px;">
                       <c:if test="${!empty object.frontPhotoUrl}">
                         <img width="7%" src="http://tenant.efeiyi.com/${object.frontPhotoUrl}@!product-model">
                       </c:if>
                </span>
          <input type="file" id="frontPhotoUrl" name="frontPhotoUrl" placeholder="frontPhotoUrl"
                 value="${object.frontPhotoUrl}">
        </div>
      </div>
      <div class="am-form-group">
        <label for="versoPhotoUrl" class="am-u-sm-3 am-form-label">*经营者身份证电子版正面</label>

        <div class="am-u-sm-9">
                <span style="padding: 10px;">
                       <c:if test="${!empty object.frontPhotoUrl}">
                         <img width="7%" src="http://tenant.efeiyi.com/${object.versoPhotoUrl}@!product-model">
                       </c:if>
                </span>
          <input type="file" id="versoPhotoUrl" name="versoPhotoUrl" placeholder="versoPhotoUrl"
                 value="${object.versoPhotoUrl}">
        </div>
      </div>
      <div class="am-form-group">
        <label for="identityPhotoUrl" class="am-u-sm-3 am-form-label">*经营者身份证电子版正面</label>

        <div class="am-u-sm-9">
                <span style="padding: 10px;">
                       <c:if test="${!empty object.identityPhotoUrl}">
                         <img width="7%" src="http://tenant.efeiyi.com/${object.identityPhotoUrl}@!product-model">
                       </c:if>
                </span>
          <input type="file" id="identityPhotoUrl" name="identityPhotoUrl" placeholder="identityPhotoUrl"
                 value="${object.identityPhotoUrl}">
        </div>
      </div>
      <div class="am-form-group">
        <label name="addressProvince.id" for="${object.id}" class="am-u-sm-3 am-form-label">*营业执照所在省 <small>*</small></label>
        <div class="am-u-sm-9" style="margin-top: 10px">
          <select id="${object.id}" name="addressProvince.id" onchange="provinceChange(this , '${object.id}')">
            <option value="${object.addressProvince.id}">${object.addressProvince.name}</option>
          </select>
        </div>
      </div>
      <div class="am-form-group">
        <label name="addressCity.id" for="${object.id}" class="am-u-sm-3 am-form-label">*营业执照所在市 <small>*</small></label>
        <div class="am-u-sm-9" style="margin-top: 10px">
          <select id="citys${object.id}" name="addressCity.id">
            <option value="${object.addressCity.id}">${object.addressCity.name}</option>
          </select>
        </div>
      </div>
      <div class="am-form-group">
        <div class="am-u-sm-9 am-u-sm-push-3">
          <button type="submit" class="am-btn am-btn-primary">保存个人信息</button>
        </div>
      </div>
    </table>
  </form>
</center>
<script>
  function chooseCity(element,provinceId,cityId,o){
    $(element).val(provinceId);
    var callback = function(){
      $("#citys" + o).val(cityId);
    }
    provinceChange(element, o,callback);
  }

  $.post("<c:url value="/address/listProvince.do"/>",
          function (data) {
            var obj = eval(data);
            var out = '<option value="">请选择</option>';
            for (var i = 0; i < obj.length; i++) {
              console.log(obj[i]+"----"+obj[i]);
              out += '<option value="' + obj[i]["id"] + '">' + obj[i]["name"] + '</option>';
            }
            $("#${object.id}").append(out);
            chooseCity($("#${object.id}") , "${object.addressProvince.id}","${object.addressCity.id}","${object.id}");
          }
  )

  function provinceChange(element, o, callback) {
    $("#citys" + o).empty();
    var provinceId = $(element).val();
    $.post("<c:url value="/address/listCity.do"/>",
            {provinceId: provinceId},
            function (data) {
              var obj = eval(data);
              var out = '<option value="">请选择</option>';
              for (var i = 0; i < obj.length; i++) {
                out += '<option value="' + obj[i]["id"] + '">' + obj[i]["name"] + '</option>';
              }
              $("#citys" + o).append(out);
              if(typeof callback!= "undefined"){
                callback();
              }
            }
    )
  }
  $(function(){
    $('#btn_upload').uploadify({
      uploader: '<c:url value="/product/uploadify.do?productId=${object.id}"/>',            // 服务器处理地址
      swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
      buttonText: "上传商品图片",                 //按钮文字
      buttonClass:"am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only",         //按钮样式
      buttonCursor:"hand",                    //鼠标指针悬停在按钮上的样子
      height: 34,                             //按钮高度
      width:140,                              //按钮宽度
      auto : true,                          //自动上传
      multi:true,                            //多个文件上传
      scriptDate:{'status':'3'},
      checkExisting:true,                    //检查文件重复
      successTimeout:1000000,                 //超时
      fileSizeLimit:'2MB',
      removeTimeout:1,                        //移除时间
      fileTypeExts: "*.jpg;*.png;",           //允许的文件类型
      fileTypeDesc: "请选择图片文件",           //文件说明
      formData: { "imgType": "normal" }, //提交给服务器端的参数
      onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
        data = data.substring(1,data.length-1)
        var pictureId = data.split(":")[0].trim();
        var  imgUrl = data.split(":")[1];
        var  url = "http://pro.efeiyi.com/"+imgUrl+"@!product-model";
        ///图片信息
        var tr = '<tr name = "'+pictureId+'">' +
                ' <td>  ' +
                '   <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="deletePicture(this,\''+pictureId+'\')"  href="#">' +
                '       <span class="am-icon-trash-o"></span> 删除 ' +
                '   </a>' +
                ' </td>' +
                ' <td>' +url+
                ' </td>' +
                ' <td>' +
                '   <img style="margin-left:2px;" width="18%;" src="'+url+'">' +
                ' </td>' +
                '</tr>';
        ///显示图片
        var img ='<li style="float: left;margin-right: 10px;" name="'+pictureId+'">'+
                '<dl style="margin-top: 6px;" >'+
                '  <dt  style="width: 50%">'+
                '   <img width="100%" name="'+pictureId+ '"  src="'+url+'" alt="商品主图片">'+
                '  </dt>'+
                '  <dd style="width: 50%;text-align:center" >'+
                '   </a>'+
                '<a href="#" onclick="updatePictureStatus(\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
                '   <a href="#" onclick="deletePicture(this,\''+pictureId+'\')">'+
                ' 删除'+
                '</dd>'+
                '</dl>'+
                '</li>';

        $("#collapse-panel-1 ul").append(img);
        $("#picUrl").append(tr);
      }
    });
    $("#btn_upload-button").css({"padding":"0em 0em","text-align":"center"});
  });
</script>
</body>
</html>
