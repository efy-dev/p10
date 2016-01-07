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
<script>

    var wx_share_title = "“华韵礼遇·中国年”大礼包"; //分享标题
    var wx_share_des = "e飞蚁为中国传统文化打造系列礼物，为您送上原汁原味的节庆文化！";  //分享描述
    var wx_share_link = "http://www.efeiyi.com/wx/wxTest.do"; //分享的链接地址  //需要动态获取，而不是直接填写静态值
    var wx_share_imgUrl = "http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/Clipboard%20Image.png"; //分享图片的url
    var wx_share_type = '';   //分享的类型   分享类型,music、video或link，不填默认为link
    var wx_share_dataUrl = ""; // 如果type是music或video，则要提供数据链接，默认为空
    var wx_api_list = ['onMenuShareAppMessage', 'onMenuShareTimeline'];    //需要使用的JS接口列表

</script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="<c:url value="/scripts/wap/js/weixin.js"/>"></script>

<script>
    initWx("http://www.efeiyi.com/wx/init.do");
</script>
</body>
</html>
