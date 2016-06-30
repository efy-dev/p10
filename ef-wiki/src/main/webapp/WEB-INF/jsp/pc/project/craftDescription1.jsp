<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/4/14
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js">
<head>
  <script src="<c:url value="/resources/jquery/jquery.qrcode.min.js"/>"></script>
  <script type="text/javascript" charset="utf-8" src="/scripts/assets/js/utf8-jsp/ueditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="/scripts/assets/js/utf8-jsp/ueditor.all.min.js"> </script>
  <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
  <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
  <script type="text/javascript" charset="utf-8" src="/scripts/assets/js/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
    <title></title>
</head>
<body>
<div class="craft-particulars2016">
  <div class="craft-crumbs">
    <div class="particulars">
      <div class="crumbs"><a href="http://j.efeiyi.com/ef-wiki/" >首页</a><em class="">></em><a href="http://j.efeiyi.com/ef-wiki/" class=""><ming800:status name="type" dataType="Project.type" checkedValue="${artistry.getType()}" type="normal"/></a><a href="" class="present"><em class="present">></em>${artistry.project.name}</a></div>
    </div>
  </div>

  <div class="user">
    <div class="skill">
      <div class="page">
        <div class="txt-page">
          <p class="name">技艺名称：<a>${artistry.name}</a></p>
          <p class="rank">技艺级别：<em><ming800:status name="level" dataType="Project.level" checkedValue="${artistry.getLevel()}" type="normal"/></em></p>
          <c:if test="${not empty artistry.project.addressDistrict}">
              <p class="area">所属地区：<em>${artistry.project.addressDistrict.addressCity.addressProvince.name}${artistry.project.addressDistrict.addressCity.name}${artistry.project.addressDistrict.name}</em></p>
          </c:if>
        <p><a  id="edit">编辑</a></p>
        </div>
        <div class="pic-page">
          <c:if test="${not empty masterProjectList&&fn:length(masterProjectList)>0}">
          <div class="user-pic">

              <a href="http://${masterProjectList.get(0).getMaster().name}.efeiyi.com/">
                <img src="<c:url value="http://tenant.efeiyi.com/${masterProjectList.get(0).getMaster().getFavicon()}@!wiki-pc-master-picture"/>" alt="">
                <div class="user-txt">
                  <p class="name">${masterProjectList.get(0).getMaster().getFullName()}</p>
                  <p class="craft">${masterProjectList.get(0).getProject().getName()}</p>
                  <p class="rank"><ming800:status name="level" dataType="Project.level" checkedValue="${masterProjectList.get(0).getProject().getLevel()}" type="normal"/>传承人</p>
                </div>
                </a>
          </div>
          </c:if>
          <div class="wechat" >
            <div id="native"></div>
            <div class="user-wechat">
              <p>扫描二维码</p>
              <p>到手机查看</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="introduce">
    <div class="craft-introduce">
      <div class="topic">
        <div class="bd-list"></div>
        <div class="topic-txt"><span>工艺介绍</span></div>
        <div class="bd-list"></div>
      </div>
      <div class="txt">
        <form action="<c:url value="/save.do"/>" method="post">
          <div style="width:100%">
            <script type="text/plain" id="editor"  name="content" style="width:100%;height:260px">
            </script>
            <div id="description">
            ${artistryDescription.descriptionPC}
             </div>
          </div>
        </form>

      </div>
    </div>
  </div>
</div>
<div class="scroll-bar" style="z-index: 9999">
  <div class="scroll-bar-top">
    <span class="btn"><i class="icon" style="margin-left: 4px;margin-top: 6px;display: block;"></i></span>
  </div>
</div>
<script type="text/javascript">
  $().ready(function () {
    var url = "http://j.efeiyi.com/ef-wiki/project/${artistry.id}";
    $('#native').qrcode({
      text: url,
            width: 160,
            height: 160
    });
  })

</script>
<script type="text/javascript">

//  var ue = UE.getEditor('editor');
  //实例化编辑器
  //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
  <%--var ue = UE.getEditor('editor');--%>


</script>
<script>

  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){

            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),

          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)

  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-69796169-1', 'auto');

  ga('send', 'pageview');

</script>
</body>
</html>
