<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/29
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!doctype html>
<html class="no-js">
<head>
  <title>新闻详情</title>
</head>
<body>
<%--<div class="hd">--%>
  <%--<div class="slide-left">--%>
    <%--<div class="nav-list">--%>
      <%--<ul class="nav-list-ul">--%>
        <%--<li class="title"><a href="#" target="_parent">新闻公告</a></li>--%>
        <%--<li class="items active"><a href="/news/news.do?qm=plistNewsOrganization_default" target="_parent" title="协会新闻">协会新闻</a></li>--%>
        <%--<li class="items"><a href="/news/news.do?qm=plistNewsIndustry_default" target="_parent" title="行业新闻">行业新闻</a></li>--%>
        <%--<li class="items"><a href="/news/news.Bulletin.do?qm=plistNewsNote_default" target="_parent" title="协会公告">协会公告</a></li>--%>
      <%--</ul>--%>
    <%--</div>--%>
  <%--</div>--%>
<%--</div>--%>
<!-- //End--slide-left-->
<div class="slide-right">
  <div class="slide-article">
    <div class="title">
      <h1>${object.title}</h1>
      <span>发布人：${object.name}</span>
      <span>发布日期：<fmt:formatDate value="${object.publishDate}" pattern="yyyy年MM月dd日"/></span>
      <span>阅读次数：5085次</span>
    </div>
    <!-- //End---->
    <div class="article-con">
      ${object.documentContent.content}
      <%--<p class="img"><img src="../shop2015/upload/exp7.jpg" alt=""/></p>
      <p>5月8日，前文化部副部长、现中国艺术研究院院长王文章，中国非物质文化遗产保护协会会长马文辉亲自带队，与永新华韵董事长李永军、副总裁林涛及团队成员就浙江省非遗的生产性保护传承，一同考察了杭州、东阳两地的非遗项目。</p>
      <p>非物质文化遗产生产性保护的概念，最初是由王文章院长创造性地提出。他认为，中国的非物质文化遗产不可再生，有一些文化遗产已濒临失传边缘，这就决定了非遗传承工作首先要把“抢救”和“保护”放在第一位，而“生产性保护”较另外两种保护方式（“抢救性保护”和“整体性保护”）更有实践性。对于传统工艺美术类的手工技艺，“生产性保护”的作用更为重要：手工技艺是以匠人为核心的非遗类别，其文化内涵和工艺水平的高低均依靠人的手工创造完成，只能在生产实践中才能够实现技能的真正传承和延续。</p>
      <p>非遗考察团在“上有天堂，下有苏杭”的杭州市，主要考察了“十竹斋”木版水印技艺和“王星记”制扇技艺。“十竹斋”最早由明代的胡正言创立，雕刻技艺刚柔并济，采用多色套印技法，将版画中最复杂，却最精妙的木版水印技艺推向极致。2013年，“十竹斋”被评为“国家级非物质文化遗产保护研究基地”。木版水印技艺传承人魏立中曾在北京故宫博物院、国家图书馆等开展多次技艺培训，还将古老的木版水印技艺推往世界各地，法国普罗万、美国洛杉矶、日本东京、印度新德里……，每到一处都引起外国人对中国传统木版水印画的浓厚兴趣和喜爱。而他本人也荣获第三届“中华非物质文化遗产传承人”。</p>
      <p>而另一处考察地“王星记扇庄”，也是非遗“生产性保护”的典型案例。百年老字号“王星记扇子”是国内唯一最负盛名的传统名牌扇子，开创于清光绪元年（1875年），曾作为“国礼”馈赠外国国家元首。“王星记扇子”制扇技艺精湛，其扇面装饰尤其精美，融合了传统与现代审美，中国扇的美轮美奂跃然而生。</p>
      <p>“十竹斋”木版水印和“王星记”制扇这两种技艺集中展现了项目传承人的高超技艺和非遗传承人“生产性保护”的思路，生动地反映了“活态传承”的特色。另一方面，作品具有良好的市场认可度，经济效益转化度高，可以说是非遗“生产性保护”的成功范例。</p>
      <p>考察团还在浙江东阳参观考察了东阳木雕城、东阳木雕博物馆，感受到了东阳木雕博物馆恢弘大气的场景布置，来自世界各地的精湛木雕作品置放其间，其精妙绝伦的程度让人赞叹不已！</p>--%>
    </div>
  </div>
</div>
<!--//End--home-->
</body>
</html>
