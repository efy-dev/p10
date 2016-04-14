<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>个人中心</title>
</head>
<body>
<!-- //End--header-->
<!--content-->
<div class="layout-col">
    <div class="mt wh1">
        <div class="extra-l">
            <strong>个人信息</strong>
        </div>
    </div>
    <!-- //End--information-->
    <div class="efeiyi-userinfo">
        <div class="userinfo-portrait">
            <dl>
                <dt>
                <div class="userinfo-figure">
                <c:if test="${empty user.pictureUrl}">
                    <img id="uploadPic" src="<c:url value="/scripts/images/yonghm.jpg"/>">
                </c:if>
                <c:if test="${!empty user.pictureUrl}">
                    <img id="uploadPic" style="width:100%;height:100%" src="http://pro.efeiyi.com/${user.pictureUrl}@!info-user-pic">
                </c:if>
                </div>
                <div class="editor" style="color: #fff;">
                    <a id="file" href="#">编辑头像</a>
                </div>
                </dt>
                <dd>
                    <p>当前头像</p>
                    <c:set var="pUser">
                        ${user.username}
                        </c:set>
                    <p><span>用户名：</span><span>${fn:substring(pUser, 0,3 )}****${fn:substring(pUser,7,11)}</span></p>
                    <p><span>用户类型：</span><span>个人用户</span></p>
                </dd>
            </dl>
        </div>
        <div class="userinfo-datum">
            <form id="personalInfo" action="<c:url value="/myEfeiyi/updatePersonalInfo.do"/>" method="post">
                <ul>
                    <li>
                        <label>昵称：</label>
                        <input type="text" id="name2" class="userinfo-tex" name="name2" value="${user.name2}">
                    </li>
                    <li>
                        <label>真实姓名：</label>
                        <input type="text" id="name" class="userinfo-tex" name="name" value="${user.name}">
                    </li>
                    <li>
                        <label>性别：</label>
                        <c:if test="${user.sex==1}">
                        <input type="radio" class="userinfo-box" value="1" name="sex" checked>男
                        </c:if>
                        <c:if test="${user.sex !=1}">
                            <input type="radio" class="userinfo-box" value="1" name="sex" >男
                        </c:if>
                      <c:if test="${user.sex == 2}">
                        <input type="radio" class="userinfo-box" value="2" name="sex" checked>女
                      </c:if>
                        <c:if test="${user.sex != 2}">
                            <input type="radio"  class="userinfo-box" value="2" name="sex" >女
                        </c:if>
                    </li>
                    <li>
                        <label class="act1">生日：</label>
                        <!--amazeui-->
                        <div class="am-input-group am-datepicker-date" data-am-datepicker="{format: 'yyyy-mm-dd'}">
                            <input type="text" id="bd" class="am-form-field" placeholder="年月日" readonly name="birthDate" value="<fmt:formatDate value="${user.birthDate}" pattern="yyyy-MM-dd" />">
      <span class="am-input-group-btn am-datepicker-add-on">
        <button class="am-btn am-btn-default actt" type="button"><span class="am-icon-calendar-1 "></span></button>
      </span>
                        </div>
                        <!--amazeui-->
                    </li>
                    <input type="hidden" name="id" value="${user.id}" >
                    <li>
                        <label></label>
                        <input type="button" class="dj-btn" onclick="pd(this);" value="保存个人信息">
                        <span class="active-d"></span>
                    </li>
                </ul>
            </form>
        </div>
    </div>
    <!-- //End--title-->
</div>
</div>
</div>
<!--content-->
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/js/system.js"/>"></script>
<script src="<c:url value="/scripts/js/jquery.validate.js"/>"></script>
<script src="<c:url value="/scripts/js/jquery.uploadify.min.js"/>"></script>



<script>
    function pd(obj){
        var name2=$("#name2").val();
        var name=$("#name").val();
        var bd=$("#bd").val();
        if(name=="" || name2=="" || bd==""){
            $(obj).next("span").text("您填写的信息不完整");
        }else{
            $("#personalInfo").submit();
            $(obj).next("span").text("");
        }

    }

//    $().ready(function() {
//        $("#personalInfo").validate({
//            rules: {
//                name2: "required",
//                name: "required",
//                birthDate: "required",
//            },
//        });
//    });

    function addPhotoDynamic(photoUrl){
        $("#uploadPic").attr("src","http://pro.efeiyi.com/"+photoUrl+"@!info-user-pic");
    }

    $(function () {
        //头像上传，使用 uploadify 插件。
        $("#file").uploadify({

            width: 106,
            height: 30,
            left:0,
            top:0,
            dataType: 'json',
            swf: '<c:url value="/scripts/js/uploadify.swf"/>',
            uploader: '<c:url value="/myEfeiyi/uploadIcon.do?id=${user.id}"/>',
            'onUploadSuccess':function(file, data, response){
                $('#' + file.id).find('.data').html(' 上传完毕');
                var jsonResult = eval(data);
                addPhotoDynamic(jsonResult);
            },
        });
    });

</script>
</body>
</html>
