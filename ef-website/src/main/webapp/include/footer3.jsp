<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/2/6
  Time: 15:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<hr style="margin-top: 18px">
<%--<div class="bdsharebuttonbox">--%>
<%--<a href="#" class="bds_more" data-cmd="more" style="margin-left: 24%;"></a>--%>
<%--<a href="#" class="bds_weixin"data-cmd="weixin" title="分享到微信"></a>--%>
<%--<a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>--%>
<%--<a href="#" class="bds_tqq" data-cmd="tqq"title="分享到腾讯微博"></a>--%>
<%--<a href="#"class="bds_renren"data-cmd="renren"title="分享到人人网"></a>--%>
<%--<a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>--%>
<%--</div>--%>
<%
    if (AuthorizationUtil.getMyUser().getId() == null) {
%>
<div class="am-g" style="margin-top: 16px;">
    <div class="am-u-sm-4 tc">
        <a href="/"><span style="font-size: 16px;color: #a3a3a3">主页</span></a>
    </div>
    <div class="am-u-sm-4 tc">
        <a href="/pc/register"><span style="font-size: 16px;color: #a3a3a3">注册</span></a>
    </div>
    <div class="am-u-sm-4 tc">
        <a href="/pc/login"><span style="font-size: 16px;color: #a3a3a3">登录</span></a>
    </div>
</div>
<%
    }
%>
<div class="am-g" style="margin-top: 10px;">
    <div class="am-u-sm-12" style="text-align: center">
        <a><span style="font-size: 16px;color: #f66c93">400-806-9955</span></a>
    </div>
</div>

<div class="am-g" style="margin-top: 18px;margin-bottom: 5px;">
    <div class="am-u-sm-12" style="text-align: center;margin-bottom: 10px">
        ©2013-2015 约拍啦
    </div>
</div>


<script>window._bd_share_config = {"common": {"bdSnsKey": {}, "bdText": "", "bdMini": "2", "bdMiniList": false, "bdPic": "", "bdStyle": "1", "bdSize": "24"}, "share": {}};
with (document)0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];
</script>
