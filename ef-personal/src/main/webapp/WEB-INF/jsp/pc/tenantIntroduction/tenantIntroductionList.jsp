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
    <p><a href="${pageContext.request.contextPath}/tenant/${tenant.id}">首页</a><span>简介</span></p>
</div>
<div class="border-nav"></div>
<!--简介内容-->
<div id="page-column">
    <div class="column-left" style="">
        <div class="page-img"><img src="<c:url value="/scripts/assets/images/img5.jpg"/>"></div>
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
                    <td colspan="4">
                        <input type="text" class="column-tex1" maxlength="6">
                    </td>
                </tr>
                <tr class="tr3">
                    <td height="47" width="80"  class="td-1 td-s">性别</td>
                    <td height="47" width="173" style="border-right:1px solid #000"><ming800:status name='sex' dataType='Tenant.sex' checkedValue='${tenant.sex}' type='normal'/></td>
                    <td height="47" width="80" class="td-1 td-s">出生年月</td>
                    <td height="47" width="173" style="border-right:1px solid #000"><fmt:formatDate value="${tenant.birthday}" pattern="yyyy/MM" /></td>
                </tr>
                <tr class="tr4">
                    <td height="47" width="80"  class="td-1 td-s">籍贯</td>
                    <td height="47" width="173" style="border-right:1px solid #000">${tenant.originProvince.name}</td>
                    <td height="47" width="80" class="td-1 td-s">现居地</td>
                    <td height="47" width="173" style="border-right:1px solid #000">${tenant.presentAddress}</td>
                </tr>
                <tr class="tr5">
                    <td height="47" width="80"  class="td-1 td-s">代表作品</td>
                    <td height="47" width="173" style="border-right:1px solid #000"></td>
                    <td height="47" width="80" class="td-1 td-s">级别</td>
                    <td height="47" width="173" style="border-right:1px solid #000"><ming800:status name='sex' dataType='Tenant.level' checkedValue='${tenant.level}' type='normal'/></td>
                </tr>
                <tr class="tr6">
                    <td colspan="4"></td>
                </tr>
                </tbody>
            </table>
            <div class="column-text-p">
                ${tenant.content}
            </div>
        </div>
        <div id="da-shi-rong-yu">
            <h1>大师荣誉</h1>
            <div class="img-pictures-show">
                <c:forEach items="${list2}" varStatus="ln" var="pic">
                    <c:if test="${list2.size()-1 != ln.index && ln.index%2 == 0}">
                        <div class="one-img-pictures">
                            <dl class="one-img-dl-l">
                                <dt><img src="<c:url value="/scripts/assets/images/img6.jpg"/>"></dt>
                                <dd>${pic.title}1988中国工艺美术大师</dd>
                            </dl>
                    </c:if>
                    <c:if test="${ln.index%2 == 1}">
                            <dl class="one-img-dl-r">
                                <dt><img src="<c:url value="/scripts/assets/images/img6.jpg"/>"></dt>
                                <dd>${pic.title}1988中国工艺美术大师</dd>
                            </dl>
                        </div>
                    </c:if>
                    <c:if test="${list2.size()-1 == ln.index && ln.index%2 == 0}">
                        <div class="one-img-pictures">
                            <dl class="one-img-dl-l">
                                <dt><img src="<c:url value="/scripts/assets/images/img6.jpg"/>"></dt>
                                <dd>${pic.title}1988中国工艺美术大师</dd>
                            </dl>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div id="chu-ban-zhu-zuo">
            <h1>出版著作</h1>
            <ul>
                <c:forEach items="${list3}" var="list3">
                    <li><img src="<c:url value="/scripts/assets/images/img7.jpg"/>"></li>
                </c:forEach>
            </ul>
        </div>
        <div id="yi-shu-nian-biao">
            <h1>艺术年表</h1>
            <div class="text-line">
                <c:forEach items="${list}" var="introduction">
                    <c:if test="${'yi-shu-nian-biao'.equals(introduction.title)}">
                        ${introduction.content}
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<!--其他内容-->
</body>
</html>