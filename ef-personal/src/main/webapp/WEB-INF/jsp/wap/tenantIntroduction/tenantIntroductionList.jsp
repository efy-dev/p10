<!DocType html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--输入内容-->
<head>
</head>
<body>
<section id="intro-content">
  <div class="intro-text-1">
      <c:forEach items="${jbxxList}" var="jbxx">
          ${jbxxIntroduction.content}
      </c:forEach>
  </div>
</section>
<aside id="am-bg-q2">
  <div data-am-widget="tabs" class="am-tabs am-tabs-default">
    <ul class="am-tabs-nav am-cf">
      <li class="am-active">
        <a href="[data-tab-panel-0]">大师荣耀</a>
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
                  <img src="<c:url value="${dsry.url}"/>"
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
      <div

              .0 class="am-tab-panel ">
        <ul data-am-widget="gallery" class="am-gallery am-avg-sm-3
  am-avg-md-3 am-avg-lg-4 am-gallery-default" data-am-gallery="{ pureview: true }">
          <c:forEach items="${cbzzList}" var="cbzz">
            <li>
              <div class="am-gallery-item">
                <a href="#" class="">
                  <img src="<c:url value="${cbzz.url}"/>"
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
      <div
              data-tab-panel-2 class="am-tab-panel ">
        <c:forEach items="${ysnbList}" var="ysnb">
          ${ysnb.title}
        </c:forEach>
      </div>
    </div>
  </div>
</aside>
</body>
</html>
