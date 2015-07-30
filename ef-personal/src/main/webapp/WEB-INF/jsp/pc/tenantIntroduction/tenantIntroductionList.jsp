<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>传承人</title>
</head>
<body>
<!--简介-->
<div id="page-nav">
    <p><a href="<c:url value="/"/>">首页</a><span>简介</span></p>
</div>
<div class="border-nav"></div>
<!--简介内容-->
<div id="page-column">
    <div class="column-left" style="">
        <div class="page-img"><img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-favicon"></div>
        <div class="buttom-text">
            <p><a href="#ji-ben-xin-xi">基本信息</a></p>

            <p><a href="#da-shi-rong-yu">大师荣誉</a></p>
            <p><a href="#chu-ban-zhu-zuo">出版著作</a></p>
            <p><a href="#yi-shu-nian-biao">艺术年表</a></p>
        </div>
    </div>
    <div class="column-right">
        <div id="ji-ben-xin-xi">
            <h1>基本信息</h1>
            <table class="table-bg">
                <tbody>
                <tr class="tr1" style="height:3px;">
                    <td height="3" colspan="4" style="height:3px"></td>
                </tr>
                <tr class="tr2">
                    <td colspan="4" align="center">
                        ${tenant.fullName}
                    </td>
                </tr>
                <tr class="tr3">
                    <td height="47" width="80"  class="td-1 td-s" style="border-right:1px #000 dotted;">性别</td>
                    <td height="47" width="173" style="border-right:1px solid #000" align="center"><ming800:status name='sex' dataType='Tenant.sex' checkedValue='${tenant.sex}' type='normal'/></td>
                    <td height="47" width="80" class="td-1 td-s" style="border-right:1px #000 dotted;">出生年月</td>
                    <td height="47" width="173" style="border-right:1px solid #000" align="center">${tenant.birthday}</td>
                </tr>
                <tr class="tr4">
                    <td height="47" width="80"  class="td-1 td-s" style="border-right:1px #000 dotted;">籍贯</td>
                    <td height="47" width="173" style="border-right:1px solid #000" align="center">${tenant.originProvince.name}</td>
                    <td height="47" width="80" class="td-1 td-s" style="border-right:1px #000 dotted;">现居地</td>
                    <td height="47" width="173" style="border-right:1px solid #000" align="center">${tenant.presentAddress}</td>
                </tr>
                <tr class="tr5">
                    <td height="47" width="80"  class="td-1 td-s" style="border-right:1px #000 dotted;">代表作品</td>
                    <td height="47" width="173" style="border-right:1px solid #000" align="center"></td>
                    <td height="47" width="80" class="td-1 td-s" style="border-right:1px #000 dotted;">级别</td>
                    <td height="47" width="173" style="border-right:1px solid #000" align="center"><ming800:status name='sex' dataType='Tenant.level' checkedValue='${tenant.level}' type='normal'/></td>
                </tr>
                <tr class="tr6">
                    <td colspan="4"></td>
                </tr>
                </tbody>
            </table>
            <div class="column-text-p">
                <c:if test="${jbxxIntroduction != null}">
                    ${jbxxIntroduction.content}
                </c:if>
            </div>
        </div>
        <c:if test="${dsryList != null && dsryList.size() > 0}">
            <div id="da-shi-rong-yu">
                <h1>大师荣誉</h1>
                <div class="img-pictures-show">
                    <c:forEach items="${dsryList}" varStatus="ln" var="pic">
                        <c:if test="${dsryList.size()-1 != ln.index && ln.index%2 == 0}">
                            <div class="one-img-pictures">
                            <dl class="one-img-dl-l">
                                <dt><img src="http://tenant.efeiyi.com/${pic.url}@!tenant-pc-intro"></dt>
                                <dd>${pic.title}</dd>
                            </dl>
                        </c:if>
                        <c:if test="${ln.index%2 == 1}">
                            <dl class="one-img-dl-r">
                                <dt><img src="http://tenant.efeiyi.com/${pic.url}@!tenant-pc-intro"/></dt>
                                <dd>${pic.title}</dd>
                            </dl>
                            </div>
                        </c:if>
                        <c:if test="${dsryList.size()-1 == ln.index && ln.index%2 == 0}">
                            <div class="one-img-pictures">
                                <dl class="one-img-dl-l">
                                    <dt><img src="http://tenant.efeiyi.com/${pic.url}@!tenant-pc-intro"></dt>
                                    <dd>${pic.title}</dd>
                                </dl>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>
        <c:if test="${cbzzList != null && cbzzList.size() > 0}">
            <div id="chu-ban-zhu-zuo">
                <h1>出版著作</h1>
                <ul>
                    <c:forEach items="${cbzzList}" var="pic">
                        <li><img src="http://tenant.efeiyi.com/${pic.url}@!tenant-pc-intro"></li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        <c:if test="${masterIntroduction != null}">
            <div id="yi-shu-nian-biao">
                <h1>艺术年表</h1>
                <div class="text-line">
                    ${masterIntroduction.content}
                </div>
            </div>
        </c:if>
    </div>
</div>
<!--其他内容-->
</body>
</html>