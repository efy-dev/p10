<%@ page import="com.efeiyi.ec.system.organization.util.AuthorizationUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
  <title></title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/seller.css?v=20151218"/> ">
</head>
<body>
   <c:if test="${review=='1'}">
           <div class="wh step">
               <div class="step1"></div>
           </div>
           <div class="wh info">
               <div class="table">
                   <div class="enter-btn .wh"><a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${TENANT.id}"/> ">完&nbsp;善&nbsp;信&nbsp;息</a></div>
                   <div class="enter-flow wh">入&nbsp;驻&nbsp;流&nbsp;程</div>
                   <div class="wh enter-wh">
                       <div class="enter-list">
                           <dl>
                               <dt>完善信息<i class="enter-1"></i></dt>
                               <dd>
                                   <p>店铺信息<i class="txt-icon"></i></p>
                                   <p>商户资质信息<i class="txt-icon"></i></p>
                               </dd>
                           </dl>
                           <dl>
                               <dt>提交审核<i class="enter-2"></i></dt>
                               <dd>
                                   <p>提交e飞蚁审核<i class="txt-icon"></i></p>
                               </dd>
                           </dl>
                           <dl>
                               <dt>e飞蚁审核<i class="enter-3"></i></dt>
                               <dd>
                                   <p>e飞蚁7个工作日内反馈审核结果<i class="txt-icon"></i></p>
                               </dd>
                           </dl>
                           <dl class="noborder1">
                               <dt>店&nbsp;铺&nbsp;开&nbsp;通<i class="enter-4"></i></dt>
                               <dd>
                                   <p>店铺开通<i class="txt-icon"></i></p>
                                   <p>商家登录后台<i class="txt-icon"></i></p>
                               </dd>
                           </dl>
                       </div>
                   </div>
               </div>
           </div>
   </c:if>
<c:if test="${review=='2'}">


    <div class="audit">
        <div class="wh step">
            <div class="step2"></div>
        </div>
        <div class="wh tips"><strong>e飞蚁会在7个工作日内反馈审核结果，您可登陆查看审核状态，也可通过拨打400-876-8766</strong></div>
        <div class="wh info">
            <div class="btns">
                <a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${TENANT.id}"/>" class="btn-link">店铺信息</a>
                <a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${TENANT.id}"/>" class="btn-link">入驻信息</a>
            </div>
            <div class="table">
                <h1>审核日志</h1>
                <table width="100%">
                    <tr>
                        <th width="20%">入驻审核结果</th>
                        <th width="20%">操作时间</th>
                        <th width="60%">详  情</th>
                    </tr>
                    <c:forEach var="tenantReview" items="${tenantReviewList}">
                        <tr>
                            <td class="tc">
                                <p>
                                    审核未通过
                                </p>
                            </td>
                            <td class="tc">
                                <p>
                                    <fmt:formatDate value="${tenantReview.createDateTime}" pattern="yyyy-HH-mm hh:mm:ss"/>
                                </p>
                            </td>

                            <td class="tl">
                                <p>
                                   ${tenantReview.content}
                                </p>
                            </td>
                        </tr>
                    </c:forEach>
                    <%--<tr>--%>
                        <%--<td class="tc"><p>审核未通过</p></td>--%>
                        <%--<td class="tc"><p>2012-21-21 23:23</p></td>--%>
                        <%--<td class="tl">--%>
                            <%--<p>--%>
                                <%--<span>申请人：XXXXXXXXXXX</span>--%>
                                <%--<span>电话：18922225555</span>--%>
                            <%--</p>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                </table>
            </div>
        </div>


    </div>
</c:if>
<c:if test="${review=='3'}">


    <div class="audit">
        <div class="wh step">
            <div class="step1"></div>
        </div>
        <div class="wh tips"><strong>e飞蚁会在7个工作日内反馈审核结果，您可登陆查看审核状态，也可通过拨打400-876-8766</strong></div>
        <div class="wh info">
            <div class="btns">
                <a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${TENANT.id}"/>" class="btn-link">店铺信息</a>
                <a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${TENANT.id}"/>" class="btn-link">入驻信息</a>
            </div>
            <div class="table">
                <h1>审核日志</h1>
                <table width="100%">
                    <tr>
                        <th width="20%">入驻审核结果</th>
                        <th width="20%">操作时间</th>
                        <th width="60%">详  情</th>
                    </tr>
                    <c:forEach var="tenantReview" items="${tenantReviewList}">
                        <tr>
                            <td class="tc">
                                <p>
                                    审核未通过
                                </p>
                            </td>
                            <td class="tc">
                                <p>
                                    <fmt:formatDate value="${tenantReview.createDateTime}" pattern="yyyy-HH-mm hh:mm:ss"/>
                                </p>
                            </td>

                            <td class="tl">
                                <p>
                                      <span>${tenantReview.content}</span>
                                    <a class="btn-link" href="<c:url value="basic/xm.do?qm=viewTenant1&id=${TENANT.id}"/>">修 改</a>

                                </p>
                            </td>
                        </tr>
                    </c:forEach>
                    <%--<tr>--%>
                        <%--<td class="tc"><p>审核未通过</p></td>--%>
                        <%--<td class="tc"><p>2012-21-21 23:23</p></td>--%>
                        <%--<td class="tl">--%>
                            <%--<p>--%>
                                <%--<span>法人身份证电子版</span>--%>
                                <%--<span>请正确上传资质</span>--%>
                                <%--&lt;%&ndash;<a class="btn-txt" href="">修改</a>&ndash;%&gt;--%>
                                <%--<a class="btn-link" href="<c:url value="basic/xm.do?qm=viewTenant1&id=${TENANT.id}"/>">修 改</a>--%>
                            <%--</p>--%>
                            <%--<p>--%>
                                <%--<span>营业执照副本</span>--%>
                                <%--<span>照片不清晰</span>--%>
                                <%--&lt;%&ndash;<a class="btn-txt" href="">修改</a>&ndash;%&gt;--%>
                            <%--</p>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="tc"><p>审核未通过</p></td>--%>
                        <%--<td class="tc"><p>2012-21-21 23:23</p></td>--%>
                        <%--<td class="tl">--%>
                            <%--<p>--%>
                                <%--<span>申请企业入驻</span>--%>
                            <%--</p>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                </table>
            </div>
        </div>


    </div>

</c:if>
<c:if test="${review=='4'}">
    <div class="audit">
        <div class="success">
            <h2>恭喜您审核通过，欢迎入驻e飞蚁商户后台！</h2>
            <div class="brid">
                <ul>
                    <li>请仔细阅读以下内容：</li>
                    <li>使用流程：</li>
                    <li><img src="<c:url value="/scripts/images/audit1.jpg"/>" alt="" /></li>
                    <li>1、查看店铺基本信息，关联大师与项目。其中，关联项目为必填项。</li>
                    <li>2、上传商品，按照要求填写商品基本信息，上传商品图片。</li>
                    <li>3、到“商品列表”页面点击“上架”，完成该商品的上架出售。</li>
                    <li>4、发货，用户可在“订单管理”页面查看并处理订单，并在“发货记录管理”中查看发货状态。</li>
                    <li>具体使用说明详见<a style="color:#f90" target="_blank" href="<c:url value="/help.do"/>">《商户后台使用手册》</a></li>
                </ul>
            </div>
        </div>

    </div>
</c:if>
</body>
</html>
