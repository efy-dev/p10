<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/18
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<span class="bgbor"></span>

<div class="nav-links" style="display:none;">
    <c:forEach items="${categoryList}" var="category">
        <ul>
            <li class="title">${category.name}</li>
            <c:forEach items="${projectMap.get(category.id)}" var="project">
                <li><a href="" target="_blank" title="">${project.name}</a></li>
            </c:forEach>
            <%--<li><a href="" target="_blank" title="">景泰蓝</a></li>--%>
            <%--<li><a href="" target="_blank" title="">景德镇</a></li>--%>
            <%--<li><a href="" target="_blank" title="">钧瓷</a></li>--%>
            <%--<li><a href="" target="_blank" title="">龙泉青瓷</a></li>--%>
        </ul>
    </c:forEach>
    <%--<ul>--%>
    <%--<li class="title">木 作 编 扎</li>--%>
    <%--<li><a href="" target="_blank" title="">木雕</a></li>--%>
    <%--<li><a href="" target="_blank" title="">竹雕</a></li>--%>
    <%--<li><a href="" target="_blank" title="">风筝</a></li>--%>
    <%--<li><a href="" target="_blank" title="">空竹</a></li>--%>
    <%--</ul>--%>
    <%--<ul>--%>
    <%--<li class="title">织 染 印 绣</li>--%>
    <%--<li><a href="" target="_blank" title="">潮绣</a></li>--%>
    <%--<li><a href="" target="_blank" title="">苏绣</a></li>--%>
    <%--<li><a href="" target="_blank" title="">顾绣</a></li>--%>
    <%--<li><a href="" target="_blank" title="">沈绣</a></li>--%>
    <%--<li><a href="" target="_blank" title="">瑶族绣</a></li>--%>
    <%--<li><a href="" target="_blank" title="">京绣</a></li>--%>
    <%--<li><a href="" target="_blank" title="">云锦</a></li>--%>
    <%--<li><a href="" target="_blank" title="">蜀锦</a></li>--%>
    <%--<li><a href="" target="_blank" title="">漳缎</a></li>--%>
    <%--<li><a href="" target="_blank" title="">缂丝</a></li>--%>
    <%--<li><a href="" target="_blank" title="">蓝印花布</a></li>--%>
    <%--<li><a href="" target="_blank" title="">蜡染</a></li>--%>
    <%--</ul>--%>
    <%--<ul>--%>
    <%--<li class="title">传 统 美 术</li>--%>
    <%--<li><a href="" target="_blank" title="">唐卡</a></li>--%>
    <%--<li><a href="" target="_blank" title="">剪纸</a></li>--%>
    <%--<li><a href="" target="_blank" title="">书法篆刻</a></li>--%>
    <%--<li><a href="" target="_blank" title="">陶瓷微书</a></li>--%>
    <%--<li><a href="" target="_blank" title="">脸谱</a></li>--%>
    <%--<li><a href="" target="_blank" title="">掐丝珐琅画</a></li>--%>
    <%--</ul>--%>
    <%--<ul>--%>
    <%--<li class="title">琢 玉 成 器</li>--%>
    <%--<li><a href="" target="_blank" title="">玉雕</a></li>--%>
    <%--</ul>--%>
    <%--<ul>--%>
    <%--<li class="title">金 石 錾 锻</li>--%>
    <%--<li><a href="" target="_blank" title="">铜雕</a></li>--%>
    <%--<li><a href="" target="_blank" title="">花丝镶嵌</a></li>--%>
    <%--</ul>--%>
    <%--<ul>--%>
    <%--<li class="title">如 胶 似 膝</li>--%>
    <%--<li><a href="" target="_blank" title="">平遥漆器</a></li>--%>
    <%--<li><a href="" target="_blank" title="">北京雕漆</a></li>--%>
    <%--</ul>--%>
    <%--<ul>--%>
    <%--<li class="title">文 房 四 宝</li>--%>
    <%--<li><a href="" target="_blank" title="">端砚</a></li>--%>
    <%--<li><a href="" target="_blank" title="">歙砚</a></li>--%>
    <%--<li><a href="" target="_blank" title="">粉蜡签</a></li>--%>
    <%--</ul>--%>
    <%--<ul>--%>
    <%--<li class="title">饕 餮 美 食</li>--%>
    <%--<li><a href="" target="_blank" title="">老汤精</a></li>--%>
    <%--</ul>--%>
    <%--<ul>--%>
    <%--<li class="title">茗 品 佳 酿</li>--%>
    <%--</ul>--%>
    <%--<ul>--%>
    <%--<li class="title">医 药 养 生</li>--%>
    <%--</ul>--%>
</div>
