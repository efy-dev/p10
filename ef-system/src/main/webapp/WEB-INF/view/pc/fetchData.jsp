<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/5/12 0012
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/scripts/jquery-1.11.1.min.js"></script>
</head>
<body>

<iframe style="width: 100%;height: 50%" id="baike" src="http://baike.baidu.com"></iframe>
<button onclick="testIframe()">测试Iframe</button>
<script>

    function testIframe() {
        var dom = window.frames["baike"];
        var domvalue = window.frames["baike"].document.getElementById("query").value;
        console.log(dom);
        console.log(domvalue);
//        console.log( $(window.frames[1].document).find("#searchForm"));
//        console.log( $(window.frames[1].document).find("#searchForm").html());
//        console.log($(window.frames[1].document).find("#searchForm").find("#query").html());
//        $(window.frames["baike"].document).find("#searchForm").find("#query").attr("value", "测试");
    }

</script>

</body>
</html>
