<%@ include file="/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/theme/selectClazz.css'/>">
<div id="fd" style="display:none;opacity:1;z-index:9999;">
    <div class="contentup">
        <a href="#" style="color:#000000" class="od" onclick="closeed('fd');return false;">关闭</a>

        <div id="tittleup" style="color:#000000;z-index:3">
            请选择&nbsp;
            <select id="teachArea"></select>
        </div>
        <div id="categoryDiv" style="position: absolute;top: 23px;left: 0;overflow: auto;"></div>
        <div id="teachAreadiv"
             style="margin: 0; padding-top: 42px; position: absolute; top: 0; left: 0; overflow: auto;"></div>
        <div id="catagorydiv"
             style="margin: 0; padding-top: 42px; position: absolute; top: 0; left: 0; overflow: auto;"></div>
        <div id="clazzInstancediv" style="margin: 0;padding-top: 42px;position: absolute;top: 0; left: 215px;"></div>
        <div id="studentTrainingdiv" style="margin: 0;position: absolute;padding-top: 42px; top: 0; left: 321px;">
        </div>
        <div id="termCoursediv" style="margin: 0;padding-top: 42px;position: absolute;top: 0; left: 315px;"></div>
        <div id="search" style="left:200px;position:absolute;top:0px;margin:10px; text-align:center;">
            <input type="text" name="searchName"/>
            <input type="button" onclick="searchStudent();" value="搜索"/>
        </div>
    </div>
</div>