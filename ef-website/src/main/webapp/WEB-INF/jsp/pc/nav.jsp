<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/17
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="topbar wh">
    <div class="hd">
        <ul class="ul-item">
            <li><a href="" title="商家入驻">商家入驻</a></li>
            <li><a href="" title="手机e飞蚁">手机e飞蚁</a></li>
            <li><a href="" title="请登录">请登录</a></li>
            <li><a href="" title="快速注册">快速注册</a></li>
            <li class="cart">
                <a href="" title="购物车"><i class="icon"></i>购物车</a>
                <span class="tips"><em>0</em></span>
            </li>
        </ul>
    </div>
</div>
<!-- //End--topbar-->
<div class="header wh">
    <div class="hd">
        <div class="logo"><a class="icon" href="" target="_blank" title="e飞蚁-爱非遗"></a></div>
        <div class="nav">
            <ul>
                <c:forEach items="${jnode.children}" var="child">
                    <li>
                        <a class="${child.jnodeMatch("cur",currentJnode)}" href="<c:url value="${child.url}"/>" title="${child.text_zh_CN}">${child.text_zh_CN}</a>
                        <c:if test="${child.id=='productCategory'}">
                            <span class="bgbor"></span>
                            <div class="nav-links" style="display:none;">
                                <ul>
                                    <li class="title">陶 冶 烧 造</li>
                                    <li><a href="" target="_blank" title="">紫砂</a></li>
                                    <li><a href="" target="_blank" title="">景泰蓝</a></li>
                                    <li><a href="" target="_blank" title="">景德镇</a></li>
                                    <li><a href="" target="_blank" title="">钧瓷</a></li>
                                    <li><a href="" target="_blank" title="">龙泉青瓷</a></li>
                                </ul>
                                <ul>
                                    <li class="title">木 作 编 扎</li>
                                    <li><a href="" target="_blank" title="">木雕</a></li>
                                    <li><a href="" target="_blank" title="">竹雕</a></li>
                                    <li><a href="" target="_blank" title="">风筝</a></li>
                                    <li><a href="" target="_blank" title="">空竹</a></li>
                                </ul>
                                <ul>
                                    <li class="title">织 染 印 绣</li>
                                    <li><a href="" target="_blank" title="">潮绣</a></li>
                                    <li><a href="" target="_blank" title="">苏绣</a></li>
                                    <li><a href="" target="_blank" title="">顾绣</a></li>
                                    <li><a href="" target="_blank" title="">沈绣</a></li>
                                    <li><a href="" target="_blank" title="">瑶族绣</a></li>
                                    <li><a href="" target="_blank" title="">京绣</a></li>
                                    <li><a href="" target="_blank" title="">云锦</a></li>
                                    <li><a href="" target="_blank" title="">蜀锦</a></li>
                                    <li><a href="" target="_blank" title="">漳缎</a></li>
                                    <li><a href="" target="_blank" title="">缂丝</a></li>
                                    <li><a href="" target="_blank" title="">蓝印花布</a></li>
                                    <li><a href="" target="_blank" title="">蜡染</a></li>
                                </ul>
                                <ul>
                                    <li class="title">传 统 美 术</li>
                                    <li><a href="" target="_blank" title="">唐卡</a></li>
                                    <li><a href="" target="_blank" title="">剪纸</a></li>
                                    <li><a href="" target="_blank" title="">书法篆刻</a></li>
                                    <li><a href="" target="_blank" title="">陶瓷微书</a></li>
                                    <li><a href="" target="_blank" title="">脸谱</a></li>
                                    <li><a href="" target="_blank" title="">掐丝珐琅画</a></li>
                                </ul>
                                <ul>
                                    <li class="title">琢 玉 成 器</li>
                                    <li><a href="" target="_blank" title="">玉雕</a></li>
                                </ul>
                                <ul>
                                    <li class="title">金 石 錾 锻</li>
                                    <li><a href="" target="_blank" title="">铜雕</a></li>
                                    <li><a href="" target="_blank" title="">花丝镶嵌</a></li>
                                </ul>
                                <ul>
                                    <li class="title">如 胶 似 膝</li>
                                    <li><a href="" target="_blank" title="">平遥漆器</a></li>
                                    <li><a href="" target="_blank" title="">北京雕漆</a></li>
                                </ul>
                                <ul>
                                    <li class="title">文 房 四 宝</li>
                                    <li><a href="" target="_blank" title="">端砚</a></li>
                                    <li><a href="" target="_blank" title="">歙砚</a></li>
                                    <li><a href="" target="_blank" title="">粉蜡签</a></li>
                                </ul>
                                <ul>
                                    <li class="title">饕 餮 美 食</li>
                                    <li><a href="" target="_blank" title="">老汤精</a></li>
                                </ul>
                                <ul>
                                    <li class="title">茗 品 佳 酿</li>
                                </ul>
                                <ul>
                                    <li class="title">医 药 养 生</li>
                                </ul>
                            </div>
                        </c:if>
                    </li>
                </c:forEach>
                <%--<li><a href="" title="商品分类">商品分类</a></li>--%>
                <%--<li><a href="" title="传承人">传承人</a></li>--%>
                <%--<li><a href="" title="展览">展览</a></li>--%>
                <%--<li><a href="" title="资讯">资讯</a></li>--%>
            </ul>
        </div>
    </div>
</div>
