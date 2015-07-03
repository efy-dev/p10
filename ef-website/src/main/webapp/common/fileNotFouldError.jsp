<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
    <meta name="heading" content="<s:text name='info.message.show'/>"/>
    <link rel="stylesheet" type="text/css" media="all" href="<c:url value='/styles/andreas/theme.css'/>"/>
</head>
<body>

<a href="javascript:window.history.back();">
    <img src="<c:url value="/images/button/back.gif"/>" alt="" align="absmiddle" style="border: none;"><s:text
        name="common.button.back"/>
</a>
<table cellspacing="0" cellpadding="0" class="maintable" border="0">
    <tr>
        <td class="head" colspan="4"/>
        <s:text name="info.error.file.notFould"/>
    </tr>

</table>

</body>
</html>
