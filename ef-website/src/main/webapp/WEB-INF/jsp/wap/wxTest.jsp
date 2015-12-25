<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/25 0025
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>微信功能测试页面</title>
</head>
<body>
微信功能测试页面

<a onclick="wxShare()">分享测试</a>

<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="<c:url value="/resources/js/weixin.js"/>"></script>
<script>

  initWx("<c:url value="/wx/init.do"/>");


  function wxShare(){
    wx.onMenuShareAppMessage({
      title: '测试标题', // 分享标题
      desc: '测试描述', // 分享描述
      link: '', // 分享链接
      imgUrl: '', // 分享图标
      type: '', // 分享类型,music、video或link，不填默认为link
      dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
      success: function () {
        // 用户确认分享后执行的回调函数
      },
      cancel: function () {
        // 用户取消分享后执行的回调函数
      }
    });
  }

</script>
</body>
</html>
