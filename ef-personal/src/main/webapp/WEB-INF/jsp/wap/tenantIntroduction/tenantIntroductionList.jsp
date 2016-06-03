<!DocType html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--输入内容-->
<head>
  <title>${tenant.fullName}-简介</title>
</head>
<body>
<div class="am-u-sm-12" id="intro-content1">
    <c:if test="${jbxxIntroduction != null}">
        <div class="intro-text-1" style="height: auto;padding-top: 14px">
                ${jbxxIntroduction.content}
        </div>
    </c:if>
</div>
<div class="am-u-sm-12" id="am-bg-q21">
  <div data-am-widget="tabs" class="am-tabs am-tabs-default">
    <ul class="am-tabs-nav am-cf">
      <li class="am-active">
        <a href="[data-tab-panel-0]">大师荣誉</a>
      </li>
      <li class="">
        <a href="[data-tab-panel-1]">出版著作</a>
      </li>
      <li class="">
        <a href="[data-tab-panel-2]">艺术年表</a>
      </li>
    </ul>

    <div class="am-tabs-bd">
      <div data-tab-panel-0 class="am-tab-panel am-active">
        <ul data-am-widget="gallery" class="am-gallery am-avg-sm-3
  am-avg-md-3 am-avg-lg-4 am-gallery-default" data-am-gallery="{ pureview: true }">
          <c:forEach items="${dsryList}" var="dsry">
            <li>
              <div class="am-gallery-item">
                <a href="#" class="">
                  <img src="http://tenant.efeiyi.com/${dsry.url}"
                          />
                  <div class="am-gallery-desc">
                    ${dsry.title}
                  </div>
                </a>
              </div>
            </li>
          </c:forEach>
        </ul>
      </div>
      <div data-tab-panel-1 class="am-tab-panel ">
        <ul data-am-widget="gallery" class="am-gallery am-avg-sm-3
  am-avg-md-3 am-avg-lg-4 am-gallery-default" data-am-gallery="{ pureview: true }">
          <c:forEach items="${cbzzList}" var="cbzz">
            <li>
              <div class="am-gallery-item">
                <a href="#" class="">
                  <img src="http://tenant.efeiyi.com/${cbzz.url}"
                          />
                  <div class="am-gallery-desc">
                      ${cbzz.title}
                  </div>
                </a>
              </div>
            </li>
          </c:forEach>
        </ul>
      </div>
        <c:if test="${masterIntroduction != null}">
      <div data-tab-panel-2 class="am-tab-panel ">
              ${masterIntroduction.content}
      </div>
        </c:if>
    </div>
  </div>
</div>
</body>
</html>
