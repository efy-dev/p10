<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/25
  Time: 17:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<!doctype html>
<html class="no-js">
<head>
    <title>非遗名录</title>
</head>
<body>
<!-- //End--slide-left-->
<div class="slide-right">
    <div class="title">国家非物质文化遗产国家名录项目</div>
    <div class="div-list">
        <div class="filter-item">
            <jsp:include flush="true"
                         page="/project/provinceList.do?provinceid=${provinceid}&type=${type}"/>
        <jsp:include flush="true"
                             page="/project/project.type.do?type=${type}&provinceid=${provinceid}"/>
        <!-- //End--filter-item-->
        <jsp:include flush="true"
                     page="/project/project.List.do?provinceid=${provinceid}&type=${type}"/>
        <!-- //End--div-list-->

        <!-- //End--pages-->
    </div>
    <!-- //End--slide-right-->
    <script type="text/javascript">
        function batchClick(object, val) {
            $("#batch a").removeClass("active");
            $(object).addClass("active");
            return false;
        }
        function provinceClick(object, provinceid) {
            $("#pro a").removeClass("active");
            $(object).addClass("active");
            var types = $("#type a");
            var type = "-1";
            for(var x=0; x< types.length;x++){
                if( "active" == $(types[x]).attr("class")){
                    type = $(types[x]).attr("id");
                    break;
                }
            }
            var url = "<c:url value="/project/project.do?qm=plistProject_default&provinceid="/>" + provinceid + "&type=" + type;
            window.location.href = url;
            return false;
        }
        function typeClick(object, type) {
            $("#type a").removeClass("active");
            $(object).addClass("active");
            var provinceids = $("#pro a");
            var provinceid = "-1";
            for(var x=0; x< provinceids.length;x++){
                if( "active" == $(provinceids[x]).attr("class")){
                    provinceid = $(provinceids[x]).attr("id");
                    break;
                }
            }
            var url = "<c:url value="/project/project.do?qm=plistProject_default&provinceid="/>" + provinceid + "&type=" + type;
            window.location.href = url;
            return false;
        }
    </script>
</body>
</html>
