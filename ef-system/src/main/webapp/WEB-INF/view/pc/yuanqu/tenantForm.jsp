<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/9/6 0006
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--@TODO--%>
    <title>基本信息</title>
    <style>

        .main-tenant-base {
            width: 700px;
            margin: 50px;
        }

        .main-base {
            width: 700px;
            margin: 50px;
        }

        .tenant-progress {
            width: 700px;
            margin: 50px;
        }

        .main-nav {
            width: 700px;
            margin: 50px;
        }

        .main-menu {
            width: 700px;
            margin: 50px;
            height: auto;
        }

        .main-menu button {
            width: 46%;
            margin: 10px;
            padding-top: 100px;
            padding-bottom: 100px;
        }

        .main-menu button span {
            font-size: 26px;;
        }

        .file-list {
            z-index: 10;
        }

        .selectButton {
            top: -12px;
        }

        .newButton {
            top: -12px;
            margin-right: 55px;
        }

        #nameSelect {
            width: 360px;
            margin-right: 20px;
        }

        .typeSelect {
            width: 100px;
            height: 38px;
            margin-right: 20px;
        }

        #startPrice,#endPrice{
            width: 150px;
            margin-right: 10px;
        }

       /* #endPrice {
            width: 150px;
            margin-right: 10px;
        }*/
    </style>
</head>
<body>
<div class="am-g">
    <div dot-template="main-nav">
    </div>
    <div dot-template="main-menu">
    </div>
    <div dot-template="main-tenant-new">
    </div>
    <div dot-template="main-tenant-panel-list">
    </div>
    <%--<div dot-template="main-tenant-panel">
    </div>--%>
    <div dot-template="main-tenant-master">
    </div>
    <div dot-template="main-product-base">
    </div>
    <div dot-template="main-product-model">
    </div>
    <div dot-template="main-product-panel">
    </div>
    <div dot-template="main-product-master-work">
    </div>
    <div dot-template="main-product-model-panel">
    </div>
    <div dot-template="main-product-master">
    </div>
    <div dot-template="main-tenant-list">
    </div>
    <div dot-template="main-tenant-panel-hot">
    </div>
    <div dot-template="main-product-list">
    </div>
    <div dot-template="main-product-model-list">
    </div>
    <div dot-template="main-scenic-region">
    </div>
    <div dot-template="main-scenic-region-list">
    </div>
    <div dot-template="main-recommend-base">
    </div>
    <div dot-template="main-recommend-list">
    </div>
    <div dot-template="main-sku-list">
    </div>
</div>

<div class="am-modal am-modal-loading am-modal-no-btn" tabindex="-1" id="my-modal-loading">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">正在上传...</div>
        <div class="am-modal-bd">
            <span class="am-icon-spinner am-icon-spin"></span>
        </div>
    </div>
</div>


<script src="/scripts/yuanqu/js/jquery.form.js"></script>
<script src="/scripts/yuanqu/js/doT.min.js"></script>
<script src="/scripts/yuanqu/js/pubsub.js"></script>
<script src="/scripts/yuanqu/js/alert.js"></script>
<script src="/scripts/yuanqu/js/util.js"></script>

<script type="text/x-dot-template" id="main-nav">
    <ol class="am-breadcrumb main-nav">
        {{ if(it.currentComponent.hierarchy== 0){ }}
        <li><a>园区管理</a></li>
        {{ } else { }}
        <li><a onclick="PubSub.publish('menu.render')">园区管理</a></li>
        {{ } }}
        {{
        if(typeof it.currentComponent != "undefined" && it.currentComponent!=null){
        if (it.currentComponent.father == null){
        }}
        <li><a class="am-active" href="#">{{=it.currentComponent.label}}</a></li>
        {{ } else { }}
        <li><a onclick="PubSub.publish('{{=it.currentComponent.father.name}}.show')">{{=it.currentComponent.father.label}}</a>
        </li>
        <li><a class="am-active" href="#">{{=it.currentComponent.label}}</a></li>
        {{ } }}
        {{ } }}
    </ol>
</script>

<script type="text/x-dot-template" id="main-menu">
    <div class="main-menu">
        {{if(it.data.permission!=null&&it.data.permission=='offline_manager'){}}
        {{if(it.data.userTenant!=null){}}
        <button type="button" class="am-btn am-btn-primary "
                onclick="PubSub.publish('productBase.new','{{=it.data.userTenant}}')">
            <span>新商品</span></button>
        <button type="button" class="am-btn am-btn-primary "
                onclick="PubSub.publish('productList.render','{{=it.data.userTenant}}')">
            <span>商品管理</span></button>
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('skuList.render',null)">
            <span>SKU管理</span></button>
        {{}}else{}}
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('tenantNew.render')">
            <span>新店铺</span></button>
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('tenantList.render')">
            <span>店铺管理</span></button>
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('scenicRegion.render')">
            <span>新景区</span></button>
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('scenicRegionList.render')">
            <span>景区管理</span>
        </button>
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('recommendBase.render')">
            <span>新推荐</span></button>
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('recommendList.render',null)">
            <span>推荐管理</span></button>
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('skuList.render',null)">
            <span>SKU管理</span></button>
        {{}}}
        <%--<button type="button" class="am-btn am-btn-primary "><span>图片管理</span></button>--%>
    </div>
</script>

<script type="text/x-dot-template" id="main-tenant-new">
    <div class="am-tabs" id="doc-my-tabs">
        <ul class="am-tabs-nav am-nav am-nav-tabs am-nav-justify" id="tenantNew">
            <li class="am-active" name="main-tenant-base"><a
                    onclick="PubSub.publish('{{=it.name}}.tabShow',this)">基本信息</a></li>
            <li name="main-tenant-check"><a onclick="PubSub.publish('{{=it.name}}.tabShow',this)">公司信息</a></li>
            <li name="main-tenant-panel"><a onclick="PubSub.publish('{{=it.name}}.tabShow',this)">店内实景</a></li>
        </ul>
        <div class="am-tabs-bd">
            <div name="main-tenant-base" dot-template="main-tenant-base" am-active></div>
            <div name="main-tenant-check" dot-template="main-tenant-check"></div>
            <div name="main-tenant-panel" dot-template="main-tenant-panel"></div>
        </div>
    </div>
</script>

<script type="text/x-dot-template" id="main-tenant-base">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-tenant-base-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend>店铺基本信息</legend>
                <input name="id" type="hidden" value="{{=it.data!=null ? it.data.id : ''}}">

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-2 am-form-label">店铺名称</label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="name" value="{{=it.data!=null ? it.data.name : ''}}"
                               placeholder="输入新店铺的名称">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="address" class="am-u-sm-2 am-form-label">店铺地址</label>
                    <div class="am-u-sm-10">
                        <input name="address" type="text" id="address" value="{{=it.data!=null ? it.data.address : ''}}"
                               placeholder="输入实体店铺的地址">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="latitude" class="am-u-sm-2 am-form-label">
                        纬度
                    </label>
                    <div class="am-u-sm-10">
                        <input name="latitude" type="number" id="latitude"
                               value="{{=it.data!=null ? it.data.latitude : ''}}" placeholder="输入实体店铺的纬度">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="longitude" class="am-u-sm-2 am-form-label">
                        经度
                    </label>
                    <div class="am-u-sm-10">
                        <input name="longitude" id="longitude" type="number"
                               value="{{=it.data!=null ? it.data.longitude : ''}}" placeholder="输入实体店铺的经度">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="longitude" class="am-u-sm-2 am-form-label">
                        大师
                    </label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="search"
                               value="{{=(it.data!=null && it.data.tenantMasterList!=null && it.data.tenantMasterList.length>0&&it.data.tenantMasterList[0].master!=null) ? it.data.tenantMasterList[0].master.fullName : ''}}"
                               placeholder="输入大师的名称" oninput="PubSub.publish('tenantMaster.search',this)">
                    </div>
                    <input name="masterId" type="hidden" id="masterId"
                           value="{{=(it.data!=null && it.data.tenantMasterList!=null && it.data.tenantMasterList.length>0&&it.data.tenantMasterList[0].master!=null) ? it.data.tenantMasterList[0].master.id : ''}}">
                    <input name="id" type="hidden" id="id"
                           value="{{=(it.data!=null) ? it.data.id : ''}}">
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10" dot-template="{{=it.masterList}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="content" class="am-u-sm-2 am-form-label">简介</label>
                    <div class="am-u-sm-10">
                        <textarea class="" rows="5" id="content" name="content">{{=it.data!=null ? it.data.content : ''}}</textarea>
                    </div>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="pictureUrl" class="am-u-sm-2 am-form-label">店铺主图</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="pictureUrl" name="pictureUrl" type="file" accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-10">
                        {{ if(it.data!=null && it.data.pictureUrl !=null){ }}
                        <img src="{{=it.data.pictureUrl}}" width="500"/>
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="logoUrl" class="am-u-sm-2 am-form-label">店铺Logo</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="logoUrl" name="logoUrl" type="file" accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-10">
                        {{ if(it.data!=null && it.data.logoUrl !=null){ }}
                        <img src="{{=it.data.logoUrl}}" width="500"/>
                        {{ } }}
                    </div>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="audio" class="am-u-sm-2 am-form-label">语音介绍</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="audio" name="audio" type="file" accept="audio/mpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-10">
                        {{ if(it.data!=null && it.data.audio !=null){ }}
                        <audio src="{{=it.data.audio}}" width="500" controls="controls"></audio>
                        {{ } }}
                    </div>
                </div>


                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2 am-btn-group">
                        <a onclick="PubSub.publish('tenantBase.submit','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">下一步 ></a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-tenant-check">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-tenant-check-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend><b>{{=it.data.id}}</b> 的公司信息</legend>
                <input type="hidden" name="id" value="{{=it.data.id}}">

                <div class="am-form-group">
                    <label for="contractNumber" class="am-u-sm-3 am-form-label">商家合同号</label>
                    <div class="am-u-sm-9">
                        <input name="contractNumber" type="text" id="contractNumber"
                               value="{{=(it.data!=null && it.data.contractNumber!=null) ? it.data.contractNumber : ''}}"
                               placeholder="商家合同号">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="epositBank" class="am-u-sm-3 am-form-label">开户行（全名）</label>
                    <div class="am-u-sm-9">
                        <input name="epositBank" type="text" id="epositBank"
                               value="{{=(it.data!=null && it.data.epositBank!=null) ? it.data.epositBank : ''}}"
                               placeholder="输入银行的全名">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="account" class="am-u-sm-3 am-form-label">银行账号</label>
                    <div class="am-u-sm-9">
                        <input name="account" type="text" id="account"
                               value="{{=(it.data!=null && it.data.account!=null)  ? it.data.account : ''}}"
                               placeholder="输入开户行账号">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="identity" class="am-u-sm-3 am-form-label">身份证号</label>
                    <div class="am-u-sm-9">
                        <input name="identity" type="text" id="identity"
                               value="{{=(it.data!=null && it.data.identity!=null) ? it.data.identity : ''}}"
                               placeholder="法人的身份证号">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="legalName" class="am-u-sm-3 am-form-label">经营者姓名</label>
                    <div class="am-u-sm-9">
                        <input name="legalName" type="text" id="legalName"
                               value="{{=(it.data!=null && it.data.legalName!=null) ? it.data.legalName : ''}}"
                               placeholder="法定代表人姓名">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="registeredAssets" class="am-u-sm-3 am-form-label">注册资本</label>
                    <div class="am-u-sm-9">
                        <input name="registeredAssets" type="text" id="registeredAssets"
                               value="{{=(it.data!=null && it.data.registeredAssets!=null) ? it.data.registeredAssets : ''}}"
                               placeholder="注册资本">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="businessScope" class="am-u-sm-3 am-form-label">经营范围</label>
                    <div class="am-u-sm-9">
                        <input name="businessScope" type="text" id="businessScope"
                               value="{{=(it.data!=null && it.data.businessScope!=null)  ? it.data.businessScope : ''}}"
                               placeholder="经营范围">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="phone" class="am-u-sm-3 am-form-label">联系人手机号</label>
                    <div class="am-u-sm-9">
                        <input name="phone" type="text" id="phone"
                               value="{{=(it.data!=null && it.data.phone!=null)  ? it.data.phone : ''}}"
                               placeholder="联系人手机号">
                    </div>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="organizationAttachment" class="am-u-sm-3 am-form-label">组织机构附件</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="organizationAttachment" name="organizationAttachment" type="file" accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.organizationAttachment !=null){ }}
                        <img src="{{=it.data.organizationAttachment}}" width="500"/>
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="bankAttachment" class="am-u-sm-3 am-form-label">银行开户附件</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="bankAttachment" name="bankAttachment" type="file" accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.bankAttachment !=null){ }}
                        <img src="{{=it.data.bankAttachment}}" width="500"/>
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="businessLicense" class="am-u-sm-3 am-form-label">营业执照</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="businessLicense" name="businessLicense" type="file" accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.businessLicense !=null){ }}
                        <img src="{{=it.data.businessLicense}}" width="500"/>
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="taxRegistrationAttachment" class="am-u-sm-3 am-form-label">税务登记附件</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="taxRegistrationAttachment" name="taxRegistrationAttachment" type="file"
                               accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.taxRegistrationAttachment !=null){ }}
                        <img src="{{=it.data.taxRegistrationAttachment}}" width="500"/>
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
                        <a onclick="PubSub.publish('tenantCheck.submit','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">下一步 ></a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-tenant-master-list">
    {{ if(typeof it =="undefined" || it == null && it.length <= 0){ }}
    <a onclick="">未找到相关大师，点击提交数据补全请求</a>
    {{ }else{ }}
    <ul class="am-list  am-list-border" id="searchResult">
        {{ for(var i = 0 ; i < it.length; i++){ }}
        <li><a onclick="PubSub.publish('tenantMaster.chooseMaster','{{=it[i].id}}:{{=it[i].fullName}}')">{{=it[i].fullName}}</a>
        </li>
        {{ } }}
    </ul>
    {{ } }}
</script>

<script type="text/x-dot-template" id="main-tenant-master">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-tenant-master-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend><b>{{=it.data.id}}</b> 的大师信息</legend>

                <div class="am-form-group">
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="search"
                               value="{{=(it.data!=null && it.data.tenantMasterList!=null && it.data.tenantMasterList.length>0&&it.data.tenantMasterList[0].master!=null) ? it.data.tenantMasterList[0].master.fullName : ''}}"
                               placeholder="输入大师的名称" oninput="PubSub.publish('tenantMaster.search',this)">
                        <input name="masterId" type="hidden" id="masterId"
                               value="{{=(it.data!=null && it.data.tenantMasterList!=null && it.data.tenantMasterList.length>0&&it.data.tenantMasterList[0].master!=null) ? it.data.tenantMasterList[0].master.id : ''}}">
                        <input name="id" type="hidden" id="id"
                               value="{{=(it.data!=null) ? it.data.id : ''}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10" dot-template="{{=it.masterList}}">
                    </div>
                </div>


                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('tenantCheck.render','{{=it.data.id}}')">< 上一步</a>
                        <a onclick="PubSub.publish('tenantMaster.submit','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">下一步 ></a>
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('tenantPanel.render','{{=it.data.id}}')">跳过</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-tenant-panel-list-body">
    <table class="am-table am-table-striped am-table-hover table-main">
        <thead>
        <tr>
            <th class="table-set">操作</th>
            <th class="table-title">名称</th>
            <th class="table-title">介绍</th>
            <th class="table-title">图片预览</th>
        </tr>
        </thead>
        <tbody>
        {{
        for(var i = 0 ; i< it.length ; i++){
        var imageText = it[i];
        }}
        <tr id="{{=imageText.id}}">
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                        <button onclick="PubSub.publish('tenantPanel.render','{{=imageText.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 编辑
                        </button>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                           onclick="showConfirm('提示','是否删除',function(){ PubSub.publish('tenantPanelList.delete','{{=imageText.id}}')})"><span
                                class="am-icon-trash-o"></span> 删除
                        </a>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                        <%-- href="/yuanqu/product/createQRCodeSample.do?productModelId={{=productModel.id}}"--%>><span
                                class="am-icon-trash-o"></span> 生成二维码
                        </a>
                    </div>
                </div>
            </td>
            <td class="am-hide-sm-only"><span href="" style="padding-right: 20px">{{=imageText.name}}</span>
            </td>
            <td class="am-hide-sm-only"><span style="padding-right: 20px">{{=imageText.content}}</span>
            </td>
            <td class="am-hide-sm-only">
                {{ if( typeof imageText.imageList!= "undefined" && imageText.imageList!=null
                &&imageText.imageList.length >
                0
                ){}}
                {{ for( var x=0; x < imageText.imageList.length; x++ ){ }}
                <a onclick="PubSub.publish('hotBase.new','{{=imageText.imageList[x].image.id}}')">
                    <img style="width: 20px;height: 20px;" src="{{=imageText.imageList[x].image.src}}" alt=""/>
                </a>
                {{} } }}
            </td>
        </tr>
        {{ } }}
        </tbody>
    </table>
</script>

<script type="text/x-dot-template" id="main-tenant-panel-list">
    <div class="main-tenant-base" data-for="panelList" data-type="tabs">
        <legend>店内实景</legend>
        <a class="am-btn am-btn-primary am-btn-lg"
           onclick="PubSub.publish('tenantPanel.new','{{=it.tenantId}}')">新建</a>
        <div class="am-u-lg-12" dot-template="main-tenant-panel-list-body">
            {{
            PubSub.publish(it.name+".body");
            }}
        </div>
         <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
             <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.prePage')">上一页</a>
             <a class="am-btn am-btn-primary am-btn-lg" id="tenant-panel-index">第{{=it.index}}页</a>
             <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.nextPage')">下一页</a>
         </div>
    </div>
</script>

<script type="text/x-dot-template" id="main-tenant-panel">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-tenant-panel-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">
            <fieldset>
                <legend>店内实景</legend>
                <input type="hidden" name="id" value="{{=it.data != null&&it.data.id!=undefined ? it.data.id : ''}}">
                <input type="hidden" name="tenantId"
                       value="{{=(it.tenantId!=null && it.tenantId!=undefined ) ? it.tenantId: ''}}">
                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">名称</label>
                    <div class="am-u-sm-9">
                        <input name="name" type="text"
                               value="{{=(it.data!=null && it.data.name!=null) ? it.data.name: ''}}"
                               placeholder="输入实景名称">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">介绍</label>
                    <div class="am-u-sm-9">
                        <textarea name="content" rows="5"
                                  value="{{=(it.data!=null && it.data.content!=null) ? it.data.content: ''}}"
                                  placeholder="输入实景介绍"></textarea>
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="imageList" class="am-u-sm-3 am-form-label">实景图片（可以选择多张图片）</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="imageList" name="imageList" type="file" multiple accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.imageList !=null){ }}
                        {{for(var i = 0 ; i< it.data.imageList.length ; i++){ }}
                        {{ var imagePanel = it.data.imageList[i];}}
                        <img src="{{=imagePanel.image.src}}" width="500"/>
                        {{ } } }}
                    </div>
                </div>
                <div class="am-form-group am-form-file">
                    <label for="media" class="am-u-sm-3 am-form-label">语音介绍</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="media" name="media" type="file" accept="audio/mpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.media !=null){ }}
                        <audio src="{{=it.data.media.src}}" width="500" controls="controls"></audio>
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
                        <a onclick="PubSub.publish('tenantPanel.submit','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">完成</a>
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('tenantList.render')">返回店铺列表</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>

</script>

<script type="text/x-dot-template" id="main-tenant-panel-product-model-list">
    {{ if(typeof it =="undefined" || it == null && it.length <= 0){ }}
    <a onclick="">未找到相关商品规格，点击提交数据补全请求</a>
    {{ }else{ }}
    <ul class="am-list  am-list-border" id="searchResult">
        {{ for(var i = 0 ; i < it.length; i++){ }}
        <li>
            <a onclick="PubSub.publish('hotBase.chooseProductModel','{{=it[i].id}}:{{=it[i].name}}')">{{=it[i].name}}</a>
        </li>
        {{ } }}
    </ul>
    {{ } }}
</script>

<script type="text/x-dot-template" id="main-tenant-panel-hot-list">
    {{
    for(var i = 0 ; i< it.length ; i++){
    var hot = it[i];
    }}
    <tr id="{{=hot.id}}">
        <td>
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                       onclick="showConfirm('提示','是否删除',function(){ PubSub.publish('hotBase.delete','{{=hot.id}}')})"><span
                            class="am-icon-trash-o"></span> 删除
                    </a>
                </div>
            </div>
        </td>
        <td class="am-hide-sm-only"><span style="padding-right: 20px">{{=hot.name}}</span>
        </td>
        <td class="am-hide-sm-only"><span style="padding-right: 20px">{{=hot.productModel==null?"":hot.productModel.name}}</span>
        </td>
        <td class="am-hide-sm-only"><span style="padding-right: 20px">{{=hot.abscissa==null?"":hot.abscissa}}</span>
        </td>
        <td class="am-hide-sm-only"><span style="padding-right: 20px">{{=hot.ordinate==null?"":hot.ordinate}}</span>
        </td>
        <td class="am-hide-sm-only">
            {{ if(typeof hot.image!= "undefined"&&hot.image!=null){}}
            <img width="10%" src="{{=hot.image.src}}" alt=""/>
            {{ } }}
        </td>
    </tr>
    {{ } }}
</script>

<script type="text/x-dot-template" id="main-tenant-panel-hot">
    <div class="main-tenant-base">
        <ul class="am-nav am-nav-tabs am-nav-justify">
            <li class="am-active"><a onclick="PubSub.publish('{{=it.name}}.tabShow',this)" data="panelHotForm">新的热点</a>
            </li>
            <li><a onclick="PubSub.publish('{{=it.name}}.tabShow',this)" data="panelHotList">查看所有</a></li>
        </ul>
    </div>

    <div class="main-tenant-base" data-for="panelHotList" data-type="tabs" style="display: none">
        <legend><b>{{=it.imageId}}</b> 的热点</legend>
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set">操作</th>
                <th class="table-title">名称</th>
                <th class="table-title">商品规格名称</th>
                <th class="table-title">热点横坐标</th>
                <th class="table-title">热点纵坐标</th>
                <th class="table-title">图片预览</th>
            </tr>
            </thead>
            <tbody dot-template="main-tenant-panel-hot-list">

            </tbody>
        </table>
    </div>

    <div class="main-tenant-base" data-for="panelHotForm" data-type="tabs">
        <form class="am-form am-form-horizontal" name="tenant" id="main-tenant-panel-hot-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">
            <fieldset>
                <legend><b>{{=it.imageId}}</b> 的热点</legend>
                <input type="hidden" name="imageId" id="imageId" value="{{=it.imageId}}">

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">名称</label>
                    <div class="am-u-sm-9">
                        <input name="name" type="text" placeholder="名称">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">
                        横坐标
                    </label>
                    <div class="am-u-sm-9">
                        <input name="abscissa" type="number" placeholder="横坐标"></input>
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">
                        纵坐标
                    </label>
                    <div class="am-u-sm-9">
                        <input name="ordinate" type="number" placeholder="纵坐标"></input>
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">
                        商品规格
                    </label>
                    <div class="am-u-sm-9">
                        <input name="name" type="text" id="search"
                               placeholder="输入商品规格名称" oninput="PubSub.publish('hotBase.search',this)">
                        <input name="productModelId" type="hidden" id="productModelId">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10" dot-template="{{=it.productModelList}}">
                    </div>
                </div>
                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('hotBase.submit','{{=it.template}}-form')">完成</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>

</script>

<script type="text/x-dot-template" id="main-tenant-list">

    <div>
        <div class="am-u-lg-6">
            <legend>店铺列表</legend>
            <button type="button"class="am-btn-group am-btn-group-xs newButton"
                    onclick="PubSub.publish('tenantNew.render')">
                <span class="am-icon-plus"></span>新建
            </button>
            <button type="button"
                    class="am-btn-group am-btn-group-xs selectButton "
                    onclick="PubSub.publish('{{=it.name}}.search')"><span
                    class="am-icon-search"></span>查找
            </button>
            <div class="am-input-group tenant-list">
                <input placeholder="输入店铺名称查询" id="nameSelect" type="text" class="am-form-field" id="inputValue">
                <select class="typeSelect" id="selectField">
                    <option value="name" selected>店名</option>
                    <option value="serial">编号</option>
                </select>
                <label>
                    <input type="checkbox" id="checkbox"> 无图
                </label>
            </div>
        </div>
        <div class="am-u-lg-12" dot-template="main-tenant-list-body">
            {{
            PubSub.publish(it.name+".body");
            }}
        </div>

        <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.prePage')">上一页</a>
            <a class="am-btn am-btn-primary am-btn-lg" id="tenant-index">第{{=it.index}}页</a>
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.nextPage')">下一页</a>
        </div>
    </div>

</script>

<script type="text/x-dot-template" id="main-tenant-list-body">

    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tbody>
        <tr style="text-align:left">
            <td>操作</td>
            <td>店铺名称</td>
            <td>店铺编号</td>
            <td>创建时间</td>
        </tr>

        {{
        for(var i = 0 ; i< it.length ; i++){
        var tenant = it[i];
        }}
        <tr>
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="PubSub.publish('tenantNew.render','{{=tenant.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 基本信息
                        </button>
                        <button onclick="PubSub.publish('productList.render','{{=tenant.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 商品管理
                        </button>
                        <button onclick="PubSub.publish('productBase.new','{{=tenant.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 添加商品
                        </button>
                        <button onclick="PubSub.publish('tenantBase.recommend','{{=tenant.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 推荐
                        </button>
                        <button onclick="showConfirm('提示','是否删除',function(){PubSub.publish('tenantList.delete','{{=tenant.id}}')})"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除
                        </button>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                           href="/yuanqu/product/createQRCodeSample.do?tenantId={{=tenant.id}}"><span
                                class="am-icon-trash-o"></span> 生成二维码
                        </a>
                    </div>
                </div>
            </td>
            <td>{{=tenant.name==null?"":tenant.name}}</td>
            <td>{{=tenant.serial==null?"":tenant.serial}}</td>
            <td>
                {{=(new Date(tenant.createDateTime)).format("yyyy-MM-dd hh:mm:ss")}}
            </td>
        </tr>
        {{ } }}

        </tbody>
    </table>

</script>

<script type="text/x-dot-template" id="main-sku-list">

    <div>
        <div class="am-u-lg-6">
            <legend>SKU列表</legend>
            <div class="am-input-group">
                <input type="text" class="am-form-field" oninput="PubSub.publish('{{=it.name}}.search',this)">
                <span class="am-input-group-btn">
                    <button class="am-btn am-btn-default" disabled type="button"><span
                            class="am-icon-search"></span></button>
                </span>
            </div>
        </div>
        <div class="am-u-lg-12" dot-template="main-sku-list-body">
            {{
            PubSub.publish(it.name+".body");
            }}
        </div>

        <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.prePage')">上一页</a>
            <a class="am-btn am-btn-primary am-btn-lg" id="sku-index">第{{=it.index}}页</a>
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.nextPage')">下一页</a>
        </div>
    </div>

</script>

<script type="text/x-dot-template" id="main-sku-list-body">

    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tbody>
        <tr style="text-align:left">
            <td>操作</td>
            <td>规格名称</td>
            <td>规格编号</td>
            <td>线上价格</td>
            <td>实体店价格</td>
            <td>库存</td>
            <td>状态</td>
            <td>创建时间</td>
        </tr>

        {{
        for(var i = 0 ; i< it.length ; i++){
        var productModel = it[i];
        }}
        <tr>
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="PubSub.publish('productModel.render','{{=productModel.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 基本信息
                        </button>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                           href="/yuanqu/product/createQRCodeSample.do?productModelId={{=productModel.id}}"><span
                                class="am-icon-trash-o"></span> 生成二维码
                        </a>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                           target="_blank"
                           href="http://www.efeiyi.com/app/product_details.html?productId={{=productModel.id}}"><span
                                class="am-icon-trash-o"></span> 预览页面
                        </a>
                        <button onclick="PubSub.publish('skuList.upper',{'id':'{{=productModel.id}}','status':'{{=productModel.status}}'})"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
                            {{?productModel.status==2}}
                            <span class="am-icon-edit"></span> 上架
                            {{??productModel.status==1}}
                            <span class="am-icon-edit"></span> 下架
                            {{?}}
                        </button>
                        <button onclick="showConfirm('提示','是否删除',function(){PubSub.publish('skuList.delete','{{=productModel.id}}')})"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除
                        </button>
                    </div>
                </div>
            </td>
            <td>{{=productModel.name}}</td>
            <td>{{=productModel.serial}}</td>
            <td>{{=productModel.price==null?"":productModel.price}}</td>
            <td>{{=productModel.marketPrice==null?"":productModel.marketPrice}}</td>
            <td>{{=productModel.amount}}</td>
            {{?productModel.status==2}}
            <td>下架</td>
            {{??productModel.status==1 }}
            <td>上架</td>
            {{?}}
            <td>
                {{=(new Date(productModel.createDateTime)).format("yyyy-MM-dd hh:mm:ss")}}
            </td>
        </tr>
        {{ } }}

        </tbody>
    </table>

</script>

<script type="text/x-dot-template" id="main-product-base">
    <div class="main-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-product-base-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend>商品信息</legend>

                <input name="id" type="hidden" value="{{=(it.data!=null && it.data.id!=null ) ? it.data.id: ''}}">
                <input name="tenantId" type="hidden"
                       value="{{=(it.tenantId!=null && it.tenantId!=undefined ) ? it.tenantId: ''}}">
                <div class="am-form-group">
                    <label for="product-name" class="am-u-sm-2 am-form-label">名称</label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="product-name"
                               value="{{=( it.data!=null&&it.data.name!=undefined ) ? it.data.name : ''}}"
                               placeholder="输入新商品名称">
                    </div>
                </div>


                <div class="am-form-group">
                    <label for="product-subName" class="am-u-sm-2 am-form-label">副标题</label>
                    <div class="am-u-sm-10">
                        <input name="subName" type="text" id="product-subName"
                               value="{{=(it.data!=null&&it.data.name!=undefined) ? it.data.subName : ''}}"
                               placeholder="输入新商品副标题">
                    </div>
                </div>
                <div class="am-form-group">
                    <label class="am-u-sm-2 am-form-label">大师</label>
                    <div class="am-u-sm-10">

                        <input name="name" type="text" id="product-search"
                               value="{{=it.data!=null && it.data.master!=null  ? it.data.master.fullName : ''}}"
                               placeholder="输入大师的名称" oninput="PubSub.publish('{{=it.name}}.masterSearch',this)">
                        <input name="masterId" type="hidden" id="product-masterId"
                               value="{{=it.data!=null && it.data.master!=null  ? it.data.master.id : ''}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10" dot-template="{{=it.masterList}}">
                    </div>
                </div>


                <div class="am-form-group">
                    <label class="am-u-sm-2 am-form-label">技艺</label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="project-search"
                               value="{{=it.data!=null && it.data.project!=null  ? it.data.project.name : ''}}"
                               placeholder="输入相关技艺的名称" oninput="PubSub.publish('{{=it.name}}.projectSearch',this)">
                        <input name="projectId" type="hidden" id="product-projectId"
                               value="{{=it.data!=null && it.data.project!=null  ? it.data.project.id : ''}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10" dot-template="{{=it.projectList}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-2 am-form-label">关联作品</label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="master-work-search"
                               value="{{=it.masterWorkProduct!=null&&it.masterWorkProduct!=undefined?it.masterWorkProduct.masterWork.name:''}}"
                               placeholder="输入作品名称" oninput="PubSub.publish('{{=it.name}}.masterWorkSearch',this)">
                        <input name="masterWorkId" type="hidden" id="master-work-id">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10" dot-template="{{=it.masterWorkList}}">
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="product-imageList" class="am-u-sm-2 am-form-label">商品详情</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-imageList" name="imageList" type="file" multiple accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-10">
                        {{
                        if( it.panel!=null&& it.panel.length>0){
                        for (var i = 0 ; i < it.panel.length ; i++){
                        var imageList = it.panel[i].imageList;
                        for (var j = 0 ; j < imageList.length ; j++){
                        }}
                        <img src="{{=imageList[j].image.src}}" width="500"/>
                        {{ } }}
                        {{ } }}
                        {{ } }}
                    </div>
                </div>
                <div class="am-form-group am-form-file">
                    <label for="product-audio" class="am-u-sm-2 am-form-label">语音介绍</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-audio" name="audio" type="file" accept="audio/mpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-10">
                        {{ if(it.data!=null && it.data.audio !=null){ }}
                        <audio src="{{=it.data.audio}}" width="500" controls="controls"></audio>
                        {{ } }}
                    </div>
                </div>


                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2 am-btn-group">
                        <a onclick="PubSub.publish('{{=it.name}}.complete','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">完成</a>
                        <a onclick="PubSub.publish('{{=it.name}}.submitAndNext','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">完成并添加规格</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-product-model">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="model" id="main-product-model-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend>商品规格信息</legend>
                <input type="hidden" name="id" value="{{=it.data != null&&it.data.id!=undefined ? it.data.id : ''}}">
                <input type="hidden" name="productId"
                       value="{{=(it.productId!=null && it.productId!=undefined ) ? it.productId: ''}}">
                <div class="am-form-group">
                    <label for="product-model-name" class="am-u-sm-3 am-form-label">规格名称</label>
                    <div class="am-u-sm-9">
                        <input name="name" type="text" id="product-model-name"
                               value="{{=(it.data!=null && it.data.name!=null) ? it.data.name: ''}}"
                               placeholder="输入规格名称">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="product-model-amount" class="am-u-sm-3 am-form-label">库存</label>
                    <div class="am-u-sm-9">
                        <input name="amount" type="number" id="product-model-amount" min="0"
                               value="{{=(it.data!=null && it.data.amount!=null) ? it.data.amount : ''}}"
                               placeholder="输入库存">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="product-model-price" class="am-u-sm-3 am-form-label">价格</label>
                    <div class="am-u-sm-9">
                        <input name="price" type="number" id="product-model-price"
                               value="{{=(it.data!=null && it.data.price!=null)  ? it.data.price : ''}}"
                               placeholder="输入商品价格">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="product-model-marketPrice"
                           class="am-u-sm-3 am-form-label">市场价格</label>
                    <div class="am-u-sm-9">
                        <input name="marketPrice" type="number" id="product-model-marketPrice"
                               value="{{=(it.data!=null && it.data.marketPrice!=null) ? it.data.marketPrice : ''}}"
                               placeholder="输入线下实体店中的价格">
                    </div>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="productModel_url" class="am-u-sm-3 am-form-label">商品规格主图</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="productModel_url" name="productModel_url" type="file" accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.productModel_url !=null&&it.data.productModel_url!=""){ }}
                        <img src="{{=it.data.productModel_url}}" width="500"/>
                        {{ } }}
                    </div>
                </div>
                <div class="am-form-group am-form-file">
                    <label for="product-model-imageList" class="am-u-sm-3 am-form-label">规格详情</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-model-imageList" name="imageList" type="file" multiple accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{
                        if( it.panel!=null&& it.panel.length>0){
                        for (var i = 0 ; i < it.panel.length ; i++){
                        var imageList = it.panel[i].imageList;
                        for (var j = 0 ; j < imageList.length ; j++){
                        }}
                        <img src="{{=imageList[j].image.src}}" width="500"/>
                        {{ } }}
                        {{ } }}
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productModel.submit','{{=it.template}}-form')">完成</a>
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productModel.submitAndNext','{{=it.template}}-form')">完成并添加商品 </a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-product-model-panel-list">
    {{
    for(var i = 0 ; i< it.length ; i++){
    var imageText = it[i];
    }}
    <tr id="{{=imageText.id}}">
        <td>
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                       onclick="showConfirm('提示','是否删除',function(){PubSub.publish('productModelPanel.delete','{{=imageText.id}}')})"><span
                            class="am-icon-trash-o"></span> 删除
                    </a>
                </div>
            </div>
        </td>
        <td>
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                       onclick="PubSub.publish('productModelPanel.render','{{=imageText.id}}')"><span
                            class="am-icon-trash-o"></span> 修改
                    </a>
                </div>
            </div>
        </td>
        <td class="am-hide-sm-only"><span href="" style="padding-right: 20px">{{=imageText.name}}</span>
        </td>
        <td class="am-hide-sm-only"><span style="padding-right: 20px">{{=imageText.content}}</span>
        </td>
        <td class="am-hide-sm-only">
            {{ if(typeof imageText.imageList!= "undefined" && imageText.imageList!=null &&
            imageText.imageList.length>0){ }}
            <img width="10%" src="{{=imageText.imageList[0].image.src}}" alt=""/>
            {{ } }}
        </td>
        <td class="am-hide-sm-only">
            {{ if(imageText.media!=null) { }}
            <audio src="{{=imageText.media.src}}" controls="controls">浏览器不支持音频插件</audio>
            {{ } }}
        </td>
    </tr>
    {{ } }}
</script>

<script type="text/x-dot-template" id="main-product-model-panel">
    <div class="main-base">
        <ul class="am-nav am-nav-tabs am-nav-justify">
            <li class="am-active"><a onclick="PubSub.publish('{{=it.name}}.tabShow',this)"
                                     data="product-model-panelForm">新的商品栏目</a>
            </li>
            <li><a onclick="PubSub.publish('{{=it.name}}.tabShow',this)" data="product-model-panelList">查看所有</a></li>
        </ul>
    </div>

    <div class="main-base" data-for="product-model-panelList" data-type="tabs" style="display: none">
        <legend><b>{{=it.data.id}}</b> 的栏目列表（商品规格详情）</legend>
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set" colspan="2">操作</th>
                <th class="table-title">名称</th>
                <th class="table-title">介绍</th>
                <th class="table-title">图片预览</th>
                <th class="table-title">语音预览</th>
            </tr>
            </thead>
            <tbody dot-template="main-product-model-panel-list">

            </tbody>
        </table>

    </div>

    <div class="main-base" data-for="product-model-panelForm" data-type="tabs">
        <form class="am-form am-form-horizontal" name="tenant" id="main-product-model-panel-form"
              action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">
            <fieldset>
                <legend><b>{{=it.data.id}}</b> 的栏目列表（商品规格详情）</legend>
                <input type="hidden" name="productModelId"
                       value="{{=it.productModelId!=null&&it.productModelId!=undefined?it.productModelId:''}}">
                <input type="hidden" id="productModelPanelId" name="id"
                       value="{{=it.id!=null&&it.id!=undefined?it.id:''}}">
                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">名称</label>
                    <div class="am-u-sm-9">
                        <input name="name" type="text" placeholder="名称" id="panelName"
                               value="{{=it.data!=null&&it.data.name!=undefined?it.data.name:''}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">介绍</label>
                    <div class="am-u-sm-9">
                        <textarea name="content" rows="5" placeholder="介绍" id="panelIntroduction">{{=it.data!=null&&it.data.content!=undefined?it.data.content:''}}</textarea>
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="product-model-imageList" class="am-u-sm-3 am-form-label">图片（可以选择多张图片）</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-model-imageList" name="imageList" type="file" multiple accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.imageList !=null){ }}
                        {{for(var i = 0 ; i< it.data.imageList.length ; i++){ }}
                        {{ var imagePanel = it.data.imageList[i];}}
                        <img src="{{=imagePanel.image.src}}" width="500"/>
                        {{ } } }}
                    </div>
                </div>
                <div class="am-form-group am-form-file">
                    <label for="product-model-media" class="am-u-sm-3 am-form-label">语音介绍</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-model-media" name="media" type="file" accept="audio/mpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.media !=null){ }}
                        <audio src="{{=it.data.media.src}}" width="500" controls="controls"></audio>
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productModel.render','{{=it.productModelId}}')">< 上一步</a>
                        <a onclick="PubSub.publish('productModelPanel.submit','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">添加</a>
                        {{if(it.data.product!=null&&it.data.product!='undefined'){}}
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productModel.new','{{=it.data.product.id}}')">下一个商品规格</a>
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productBase.new','{{=it.data.product.tenant.id}}')">下一个商品</a>
                        {{}}}
                    </div>
                </div>
            </fieldset>
        </form>
    </div>

</script>

<script type="text/x-dot-template" id="main-product-panel">

    <div class="main-base" data-for="product-panelForm">
        <form class="am-form am-form-horizontal" name="tenant" id="main-product-panel-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">
            <fieldset>
                <legend>商品详情</legend>
                <input type="hidden" name="id" value="{{=it.data!=null&&it.data.id!=undefined?it.data.id:''}}">
                <input type="hidden" name="productId"
                       value="{{=it.productId!=null&&it.productId!=undefined?it.productId:''}}">
                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">名称</label>
                    <div class="am-u-sm-9">
                        <input name="name" type="text" placeholder="名称"
                               value="{{=it.data!=null&&it.data.name!=undefined?it.data.name:''}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">介绍</label>
                    <div class="am-u-sm-9">
                        <textarea id="productPanelContent" name="content" rows="5" placeholder="介绍">{{=it.data!=null&&it.data.content!=undefined?it.data.content:''}}</textarea>
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="product-imageList" class="am-u-sm-3 am-form-label">图片（可以选择多张图片）</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-imageList" name="imageList" type="file" multiple accept="image/jpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.imageList !=null){ }}
                        {{for(var i = 0 ; i< it.data.imageList.length ; i++){ }}
                        {{ var imagePanel = it.data.imageList[i];}}
                        <img src="{{=imagePanel.image.src}}" width="500"/>
                        {{ } } }}
                    </div>
                </div>
                <div class="am-form-group am-form-file">
                    <label for="product-media" class="am-u-sm-3 am-form-label">语音介绍</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-media" name="media" type="file" accept="audio/mpeg"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.media !=null){ }}
                        <audio src="{{=it.data.media.src}}" width="500" controls="controls"></audio>
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('{{=it.name}}.submit','{{=it.template}}-form')">关联作品</a>
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productModel.new','{{=it.productId}}')">跳过</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>

</script>

<script type="text/x-dot-template" id="main-product-list">

    <div>
        <div class="am-u-lg-6">
            <legend>{{=it.tenantId}} 商品列表</legend>
            <button type="button" class="am-btn-group am-btn-group-xs newButton"
                    onclick="PubSub.publish('productBase.new','{{=it.tenantId}}')">
                <span class="am-icon-plus">新建</span></button>
            <button type="button"
                    class="am-btn-group am-btn-group-xs selectButton "
                    onclick="PubSub.publish('{{=it.name}}.search')"><span
                    class="am-icon-search selectButton"></span>查找
            </button>
            <div class="am-input-group product-list">
                <input placeholder="输入商品名称查询" type="text" id="nameSelect" class="am-form-field " id="inputValue">
                <select data-am-selected class="typeSelect" id="selectField">
                    <option value="name" selected>名称</option>
                    <option value="serial">编号</option>
                </select>
                <label>
                    <input type="checkbox" id="checkbox"> 无图
                </label>
            </div>
        </div>
        <div class="am-u-lg-12" dot-template="main-product-list-body">
            {{
            PubSub.publish(it.name+".body");
            }}
        </div>

        <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.prePage')">上一页</a>
            <a class="am-btn am-btn-primary am-btn-lg" id="product-index">第{{=it.index}}页</a>
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.nextPage')">下一页</a>
        </div>
    </div>

</script>

<script type="text/x-dot-template" id="main-product-list-body">

    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tbody>
        <tr style="text-align:left">
            <td>操作</td>
            <td>分组</td>
            <td>商品名称</td>
            <td>副标题</td>
            <td>创建时间</td>
        </tr>

        {{
        for(var i = 0 ; i< it.length ; i++){
        var product = it[i];
        }}
        <tr>
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="PubSub.publish('productBase.render','{{=product.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 基本信息
                        </button>
                        <button onclick="PubSub.publish('productModelList.render','{{=product.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 商品规格
                        </button>
                        <button onclick="PubSub.publish('productModel.new','{{=product.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 添加规格
                        </button>
                        <button onclick="showConfirm('提示','是否删除',function(){PubSub.publish('productList.delete','{{=product.id}}')})"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除
                        </button>
                    </div>
                </div>
            </td>
            <td>
                <select id="{{=product.id}}" onchange="PubSub.publish('productList.chooseTenantGroup',this)">
                    {{ for(var j = 0 ; j < product.tenant.tenantGroups.length ; j++){
                    var tenantGroup = product.tenant.tenantGroups[j];
                    }}
                    <option {{if(product.tenantGroup!=null && product.tenantGroup.id==tenantGroup.id){ }}
                            selected="selected" {{ } }}
                            value="{{=tenantGroup.id}}"> {{=tenantGroup.name}}
                    </option>
                    {{ } }}
                </select>
            </td>
            <td>{{=product.name}}</td>
            <td>{{=product.subName}}</td>
            <td>
                {{=(new Date(product.createDateTime)).format("yyyy-MM-dd hh:mm:ss")}}
            </td>
        </tr>
        {{ } }}

        </tbody>
    </table>

</script>

<script type="text/x-dot-template" id="main-product-model-list">

    <div>
        <div class="am-u-lg-6">
            <legend>{{=it.productId}} 规格列表</legend>
            <button type="button" class="am-btn-group am-btn-group-xs newButton"
                    onclick="PubSub.publish('productModel.new','{{=it.productId}}')">
                <span class="am-icon-plus">新建</span></button>
            <button type="button"
                    class="am-btn-group am-btn-group-xs selectButton "
                    onclick="PubSub.publish('{{=it.name}}.search')"><span
                    class="am-icon-search"></span>查找
            </button>
            <div class="am-input-group product-model" style="width:1000px">
                <input placeholder="输入商品规格名称查询" id="nameSelect" type="text" class="am-form-field" id="inputValue"
                       style="width: 360px">
                <select data-am-selected class="typeSelect" id="selectField">
                    <option value="name" selected>名称</option>
                    <option value="serial">编号</option>
                </select>
                <input placeholder="输入起始价格" id="startPrice" type="number" min="0" class="am-form-field">
                <input placeholder="输入终止价格" id="endPrice" type="number" min="0" class="am-form-field">
                <label>
                    <input type="checkbox" id="checkbox"> 无图
                </label>
            </div>
        </div>
        <div class="am-u-lg-12" dot-template="main-product-model-list-body">
            {{
            PubSub.publish(it.name+".body");
            }}
        </div>
        <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.prePage')">上一页</a>
            <a class="am-btn am-btn-primary am-btn-lg" id="product-model-index">第{{=it.index}}页</a>
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.nextPage')">下一页</a>
        </div>
    </div>

</script>

<script type="text/x-dot-template" id="main-product-model-list-body">

    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tbody>
        <tr style="text-align:left">
            <td>操作</td>
            <td>规格名称</td>
            <td>规格编号</td>
            <td>线上价格</td>
            <td>实体店价格</td>
            <td>库存</td>
            <td>状态</td>
            <td>创建时间</td>
        </tr>

        {{
        for(var i = 0 ; i< it.length ; i++){
        var productModel = it[i];
        }}
        <tr>
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="PubSub.publish('productModel.render','{{=productModel.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 基本信息
                        </button>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                           href="/yuanqu/product/createQRCodeSample.do?productModelId={{=productModel.id}}"><span
                                class="am-icon-trash-o"></span> 生成二维码
                        </a>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                           target="_blank"
                           href="http://www.efeiyi.com/app/product_details.html?productId={{=productModel.id}}"><span
                                class="am-icon-trash-o"></span> 预览页面
                        </a>
                        <button onclick="PubSub.publish('productModelList.upper',{'id':'{{=productModel.id}}','status':'{{=productModel.status}}'})"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
                            {{?productModel.status==2}}
                            <span class="am-icon-edit"></span> 上架
                            {{??productModel.status==1}}
                            <span class="am-icon-edit"></span> 下架
                            {{?}}
                        </button>
                        <button onclick="showConfirm('提示','是否删除',function(){PubSub.publish('productModelList.delete','{{=productModel.id}}')})"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除
                        </button>
                    </div>
                </div>
            </td>
            <td>{{=productModel.name}}</td>
            <td>{{=productModel.serial}}</td>
            <td>{{=productModel.price==null?"":productModel.price}}</td>
            <td>{{=productModel.marketPrice==null?"":productModel.marketPrice}}</td>
            <td>{{=productModel.amount}}</td>
            {{?productModel.status==2}}
            <td>下架</td>
            {{??productModel.status==1 }}
            <td>上架</td>
            {{?}}
            <td>
                {{=(new Date(productModel.createDateTime)).format("yyyy-MM-dd hh:mm:ss")}}
            </td>
        </tr>
        {{ } }}

        </tbody>
    </table>

</script>

<script type="text/x-dot-template" id="main-product-master-list">
    {{ if(typeof it =="undefined" || it == null && it.length <= 0){ }}
    <a onclick="">未找到相关大师，点击提交数据补全请求</a>
    {{ }else{ }}
    <ul class="am-list  am-list-border" id="searchResult">
        {{ for(var i = 0 ; i < it.length; i++){ }}
        <li><a onclick="PubSub.publish('productBase.chooseMaster','{{=it[i].id}}:{{=it[i].fullName}}')">{{=it[i].fullName}}</a>
        </li>
        {{ } }}
    </ul>
    {{ } }}
</script>

<script type="text/x-dot-template" id="main-product-project-list">
    {{ if(typeof it =="undefined" || it == null && it.length <= 0){ }}
    <a onclick="">未找到相关技艺，点击提交数据补全请求</a>
    {{ }else{ }}
    <ul class="am-list  am-list-border" id="">
        {{ for(var i = 0 ; i < it.length; i++){ }}
        <li>
            <a onclick="PubSub.publish('productBase.chooseProject','{{=it[i].id}}:{{=it[i].name}}')">{{=it[i].name}}</a>
        </li>
        {{ } }}
    </ul>
    {{ } }}
</script>

<script type="text/x-dot-template" id="main-product-master">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-product-master-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend><b>{{=it.data.id}}</b> 大师信息与技艺信息</legend>

                <div class="am-form-group">
                    <label class="am-u-sm-2 am-form-label">大师</label>
                    <div class="am-u-sm-10">

                        <input name="name" type="text" id="product-search"
                               value="{{=it.data!=null && it.data.master!=null  ? it.data.master.fullName : ''}}"
                               placeholder="输入大师的名称" oninput="PubSub.publish('productMaster.search',this)">
                        <input name="masterId" type="hidden" id="product-masterId"
                               value="{{=it.data!=null && it.data.master!=null  ? it.data.master.id : ''}}">
                        <input name="id" type="hidden" id="product-id"
                               value="{{=(it.data!=null) ? it.data.id : ''}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10" dot-template="{{=it.masterList}}">
                    </div>
                </div>


                <div class="am-form-group">
                    <label class="am-u-sm-2 am-form-label">技艺</label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="project-search"
                               value="{{=it.data!=null && it.data.project!=null  ? it.data.project.name : ''}}"
                               placeholder="输入相关技艺的名称" oninput="PubSub.publish('productMaster.projectSearch',this)">
                        <input name="projectId" type="hidden" id="product-projectId"
                               value="{{=it.data!=null && it.data.project!=null  ? it.data.project.id : ''}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10" dot-template="{{=it.projectList}}">
                    </div>
                </div>


                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('{{=it.name}}.submit','{{=it.template}}-form')">去添加商品详情</a>
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productPanel.render','{{=it.data.id}}')">跳过</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-product-master-work-list">
    {{ if(typeof it =="undefined" || it == null && it.length <= 0){ }}
    <a onclick="">未找到相关作品，点击提交数据补全请求</a>
    {{ }else{ }}
    <ul class="am-list  am-list-border" id="searchResult">
        {{ for(var i = 0 ; i < it.length; i++){ }}
        <li>
            <a onclick="PubSub.publish('productBase.chooseMasterWork','{{=it[i].id}}:{{=it[i].name}}')">{{=it[i].name}}</a>
        </li>
        {{ } }}
    </ul>
    {{ } }}
</script>

<script type="text/x-dot-template" id="main-product-master-work">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-product-master-work-form"
              action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend><b>{{=it.data.id}}</b>关联作品</legend>

                <div class="am-form-group">
                    <label class="am-u-sm-2 am-form-label">作品</label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="master-work-search"
                               placeholder="输入作品名称" oninput="PubSub.publish('productMasterWork.search',this)">
                        <input name="masterWorkId" type="hidden" id="master-work-id">
                        <input name="id" type="hidden" id="product-id" value="{{=it.data.id}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10" dot-template="{{=it.masterWorkList}}">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('{{=it.name}}.submit','{{=it.template}}-form')">去添加商品规格</a>
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productList.render','{{=it.data.bigTenant.id}}')">返回商品列表</a>
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productModel.new','{{=it.data.id}}')">跳过</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-scenic-region">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-scenic-region-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend>景区信息</legend>

                <div class="am-form-group">
                    <label for="scenic-name" class="am-u-sm-2 am-form-label">景区名称</label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="scenic-name" value="{{=it.data!=null ? it.data.name : ''}}"
                               placeholder="输入新景区的名称">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="scenic-latitude" class="am-u-sm-2 am-form-label">纬度</label>
                    <div class="am-u-sm-10">
                        <input name="latitude" type="text" id="scenic-latitude"
                               value="{{=it.data!=null ? it.data.latitude : ''}}" placeholder="输入景区铺的纬度">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="scenic-longitude" class="am-u-sm-2 am-form-label">经度</label>
                    <div class="am-u-sm-10">
                        <input name="longitude" type="text" id="scenic-longitude"
                               value="{{=it.data!=null ? it.data.longitude : ''}}" placeholder="输入景区铺的经度">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="scenic-content" class="am-u-sm-2 am-form-label">简介</label>
                    <div class="am-u-sm-10">
                        <textarea class="" rows="5" id="scenic-content" name="content">{{=it.data!=null ? it.data.content : ''}}</textarea>
                    </div>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="scenic-pictureUrl" class="am-u-sm-2 am-form-label">景区主图</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="scenic-pictureUrl" name="pictureUrl" type="file"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-10">
                        {{ if(it.data!=null && it.data.pictureUrl !=null){ }}
                        <img src="{{=it.data.pictureUrl}}" width="500"/>
                        {{ } }}
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="scenic-audio" class="am-u-sm-2 am-form-label">语音介绍</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="scenic-audio" name="audio" type="file" multiple
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-10">
                        {{ if(it.data!=null && it.data.audio !=null){ }}
                        <audio src="{{=it.data.audio}}" width="500" controls="controls"></audio>
                        {{ } }}
                    </div>
                </div>


                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2 am-btn-group">
                        <%--<a class="am-btn am-btn-primary am-btn-lg">< 上一步</a>--%>
                        <a onclick="PubSub.publish('{{=it.name}}.submitAndNext','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">保存并添加下一个</a>
                        <a onclick="PubSub.publish('{{=it.name}}.submitAndList','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">保存并打开景区管理 ></a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>

</script>

<script type="text/x-dot-template" id="main-scenic-region-list">

    <div>
        <div class="am-u-lg-6">
            <legend>景区列表</legend>
            <div class="am-input-group">
                <input type="text" class="am-form-field" oninput="PubSub.publish('{{=it.name}}.search',this)">
                <span class="am-input-group-btn">
                    <button class="am-btn am-btn-default" disabled type="button"><span
                            class="am-icon-search"></span></button>
                </span>
            </div>
        </div>
        <div class="am-u-lg-12" dot-template="main-scenic-region-list-body">
            {{
            PubSub.publish(it.name+".body");
            }}
        </div>

        <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.prePage')">上一页</a>
            <a class="am-btn am-btn-primary am-btn-lg" id="scenic-index">第{{=it.index}}页</a>
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.nextPage')">下一页</a>
        </div>
    </div>

</script>

<script type="text/x-dot-template" id="main-scenic-region-list-body">

    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tbody>
        <tr style="text-align:left">
            <td>操作</td>
            <td>景区名称</td>
            <td>简介</td>
        </tr>

        {{
        for(var i = 0 ; i< it.length ; i++){
        var scenic = it[i];
        }}
        <tr>
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="PubSub.publish('scenicRegion.render','{{=scenic.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 编辑
                        </button>
                        <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除(暂时不支持)
                        </button>
                    </div>
                </div>
            </td>
            <td>{{=scenic.name}}</td>
            <td>{{=scenic.content}}</td>
        </tr>
        {{ } }}

        </tbody>
    </table>

</script>

<script type="text/x-dot-template" id="main-recommend-base">
    <div class="main-base">
        <form class="am-form am-form-horizontal" name="recommend" id="main-recommend-base-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend>推荐信息</legend>

                <input name="id" type="hidden" value="{{=(it.data!=null && it.data.id!=null ) ? it.data.id: ''}}">

                <div class="am-form-group">
                    <label for="recommend-title" class="am-u-sm-2 am-form-label">标题</label>
                    <div class="am-u-sm-10">
                        <input name="title" type="text" id="recommend-title"
                               value="{{=( it.data!=null ) ? it.data.title : ''}}"
                               placeholder="输入推荐标题">
                    </div>
                </div>


                <div class="am-form-group">
                    <label for="recommend-short-text" class="am-u-sm-2 am-form-label">短简介</label>
                    <div class="am-u-sm-10">
                        <input name="shortText" type="text" id="recommend-short-text"
                               value="{{=(it.data!=null) ? it.data.shortText : ''}}"
                               placeholder="输入推荐的简介">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="recommend-redirect" class="am-u-sm-2 am-form-label">跳转链接</label>
                    <div class="am-u-sm-10">
                        <input name="redirect" type="text" id="recommend-redirect"
                               value="{{=(it.data!=null) ? it.data.redirect : ''}}"
                               placeholder="输入跳转链接">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-2 am-form-label" for="doc-select-1">推荐分组</label>
                    <div class="am-u-sm-10">
                        <select id="doc-select-1" name="group">
                            <option value="001">首页店铺推荐</option>
                        </select>
                    </div>
                    <span class="am-form-caret"></span>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="recommond-image" class="am-u-sm-2 am-form-label">主图</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="recommond-image" name="image" type="file"
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-10">
                        {{ if(it.data!=null && it.data.image !=null){ }}
                        <img src="{{=it.data.image.src}}" width="500"/>
                        {{ } }}
                    </div>
                </div>


                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2 am-btn-group">
                        <a onclick="PubSub.publish('{{=it.name}}.submitAndNext','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">保存并添加下一个</a>
                        <a onclick="PubSub.publish('{{=it.name}}.submitAndList','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">保存并跳到推荐管理</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-recommend-list">

    <div>
        <div class="am-u-lg-10">
            <legend> 推荐列表</legend>
            <div class="am-u-lg-6 am-input-group">
                <input type="text" class="am-form-field" oninput="PubSub.publish('{{=it.name}}.search',this)"
                       placeholder="输入推荐标题进行搜索">
                <span class="am-input-group-btn">
                    <button class="am-btn am-btn-default" disabled type="button"><span
                            class="am-icon-search"></span></button>
                </span>
            </div>
            <div class="am-u-lg-6">
                <form class="am-form">
                    <div class="am-form-group">
                        <select onchange="PubSub.publish('{{=it.name}}.groupSearch',this)">
                            <option value="001">首页推荐</option>
                        </select>
                        <span class="am-form-caret"></span>
                    </div>
                </form>
            </div>
        </div>

        <div class="am-u-lg-12" dot-template="main-recommend-list-body">
            {{
            PubSub.publish(it.name+".body");
            }}
        </div>

        <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.prePage')">上一页</a>
            <a class="am-btn am-btn-primary am-btn-lg" id="recommend-index">第{{=it.index}}页</a>
            <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('{{=it.name}}.nextPage')">下一页</a>
        </div>
    </div>

</script>

<script type="text/x-dot-template" id="main-recommend-list-body">

    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tbody>
        <tr style="text-align:left">
            <td>操作</td>
            <td>标题</td>
            <td>简介</td>
            <td>跳转链接</td>
            <td>创建时间</td>
        </tr>

        {{
        for(var i = 0 ; i< it.length ; i++){
        var recommend = it[i];
        }}
        <tr>
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="PubSub.publish('recommendBase.render','{{=recommend.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 编辑
                        </button>
                        <button class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 添加英文版商品（暂不支持）
                        </button>
                        <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除(暂不支持)
                        </button>
                    </div>
                </div>
            </td>
            <td>{{=recommend.title}}</td>
            <td>{{=recommend.shortText}}</td>
            <td>{{=recommend.redirect}}</td>
            <td>
                {{=recommend.createDatetime}}
            </td>
        </tr>
        {{ } }}

        </tbody>
    </table>

</script>

<script>

    window.onbeforeunload = function () {
        return "确认离开当前页面？";
    };

    $().ready(function () {
        menu.render();
    });

    var Nav = function (param) {
        this.label = "导航";
        this.father = null;
        this.currentComponent = null;
        this.hierarchy = 0;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "nav";
        this.template = "main-nav";         //组件绑定的模板//组件需要订阅的事件与消息
        this.render = function (msg, data) {
            renderTemplate(this.template, this);
            if (typeof this.currentComponent != "undefined" && this.currentComponent != null) {
                PubSub.publish(this.currentComponent.name + ".render");
            }
            this.show();

        };
        this.refresh = function (msg, data) {
            renderTemplate(this.template, this);
        };
        this.show = function (msg, data) {
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.setCurrentComponent = function (msg, data) {
            if (this.currentComponent != null) {
                this.currentComponent.hide();
            }
            data.father = this.currentComponent;
            this.currentComponent = data;
            this.refresh();
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".setCurrentComponent", subscriber: this.setCurrentComponent}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }
    };

    var Menu = function (param) {
        this.label = "菜单";
        this.father = null;
        this.hierarchy = 0;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "menu";
        this.template = "main-menu";         //组件绑定的模板//组件需要订阅的事件与消息
        this.data = null;

        this.render = function (msg, data) {
            ajaxRequest("/yuanqu/tenant/getUserTenantMessage", {}, function (responseData) {
                this.data = responseData;
                renderTemplate(this.template, this);
            }.bind(this));
            this.show();
        };
        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.tenantBase = function (msg, data) {
            PubSub.publish("tenantBase.render");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".tenantBase", subscriber: this.tenantBase}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }
    };

    var TenantNew = function (param) {
        this.data = null;
        this.father = null;
        this.label = "店铺信息";
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "tenantNew";
        this.template = "main-tenant-new";

        this.render = function (msg, data) {
            var $data = {};
            renderTemplate(this.template, this);
            if (typeof data != "undefined" && data != null) {
                $data["templateName"] = "main-tenant-base";
                $data["id"] = data;
                this.tabShow(null, $data);
            } else {
                var templateName = $("#tenantNew .am-active").attr("name");
                $data["templateName"] = templateName;
                this.tabShow(null, $data);
            }
            this.show();
        };
        this.tabShow = function (msg, data) {
            var templateName = "";
            this.initialize();
            if (data != null && typeof data.templateName != "undefined" && data.templateName != "") {
                templateName = data.templateName;
                this.data = data.id;
                $("#tenantNew").find("li").removeClass("am-active");
                $("#tenantNew").find("li[name=" + templateName + "]").addClass("am-active");
                var $active = $(".am-tabs-bd").find("div[name=" + templateName + "]");
                $active.show();
                $active.siblings().hide();
            } else {
                $(data).parent().siblings().removeClass("am-active");
                $(data).parent().addClass("am-active");
                templateName = $(data).parent().attr("name");
                var $active = $(data).parent().parent().next().find("div[name=" + templateName + "]");
                $active.show();
                $active.siblings().hide();
            }
            switch (templateName) {
                case "main-tenant-base":
                    PubSub.publish("tenantBase.render", this.data);
                    break;
                case "main-tenant-check":
                    if (this.data == null || typeof this.data == "undefined" || this.data == "") {
                        showAlert('提示', '请填写基本信息', function () {
                            PubSub.publish("tenantBase.render", this.data);
                            return false;
                        });
                    } else {
                        PubSub.publish("tenantCheck.render", this.data);
                    }
                    break;
                case "main-tenant-panel":
                    PubSub.publish("tenantPanelList.show");
                    if (this.data == null || typeof this.data == "undefined" || this.data == "") {
                        showAlert('提示', '请填写基本信息', function () {
                            PubSub.publish("tenantBase.render", this.data);
                            return false;
                        });
                    } else {
                        PubSub.publish("tenantPanelList.render", this.data);
                    }
                    break;
            }
        };

        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
            $panel = $("li[name='main-tenant-panel']");
            this.panelShow(null, $panel);
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.initialize = function (msg, data) {
            PubSub.publish("tenantPanelList.hide");
            PubSub.publish("tenantPanel.hide");
        };
        this.panelShow = function (msg, data) {
            if (data.hasClass("am-active")) {
                PubSub.publish("tenantPanelList.show");
            }
        };

        this.subscribeArray = [
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".tabShow", subscriber: this.tabShow},
            {message: this.name + ".initialize", subscriber: this.initialize},
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var TenantBase = function (param) {
        this.submit = "/yuanqu/tenant/baseSubmit";
        this.label = "店铺基本信息";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "tenantBase";
        this.template = "main-tenant-base";         //组件绑定的模板//组件需要订阅的事件与消息
        this.masterList = "main-tenant-master-list";

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/tenant/getTenantById", {id: data}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else {
                this.data = null;
                renderTemplate(this.template, this);
            }
        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    var param = {};
                    param["templateName"] = "main-tenant-check";
                    param["id"] = data.id;
                    PubSub.publish("tenantNew.tabShow", param);
                }
                $("#my-modal-loading").modal("close");
            });
            return false;
        };

        this.complete = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    this.father.show();
                }
                $("#my-modal-loading").modal("close");
            }.bind(this));
            return false;
        };

        this.recommend = function (msg, data) {
            ajaxRequest("/yuanqu/tenant/saveTenantRecommend", {id: data}, function (responseData) {
                PubSub.publish("recommendBase.render", responseData.id);
            }.bind(this))
        };
        this.chooseMaster = function (msg, data) {
            var id = data.split(":")[0];
            var fullName = data.split(":")[1];
            $("#masterId").val(id);
            $("#search").val(fullName)
            this.selectHide();
        };
        this.selectHide = function (msg, data) {
            $("[dot-template=" + this.masterList + "]").hide();
        };
        this.selectShow = function (msg, data) {
            $("[dot-template=" + this.masterList + "]").show();
        };
        this.searchMaster = function (msg, data) {
            this.selectShow();
            var success = function (responseData) {
                renderTemplate(this.masterList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/tenant/getTenantMasterList", {name: $(data).val()}, success);
        };
        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.imageView = function (msg, data) {
            var images = data.files;
            $(data).parent().parent().find(".file-list").html("");
            for (var i = 0; i < images.length; i++) {
                if (images[i]) {
                    var reader = new FileReader();
                    reader.readAsDataURL(images[i]);
                    if (data.name == "audio") {
                        if (/audio\/\w+/.test(images[i].type)) {
                            reader.onload = function (e) {
                                var urlData = this.result;
                                $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
                            }
                        } else {
                            return false;
                        }
                    }
                    if ((/image\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<img src=\"" + urlData + "\" width=\"500\"  />")
                        }
                    }
                }
            }
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".imageView", subscriber: this.imageView},
            {message: this.name + ".complete", subscriber: this.complete},
            {message: this.name + ".submit", subscriber: this.submitForm},
            {message: this.name + ".searchMaster", subscriber: this.searchMaster},
            {message: this.name + ".selectShow", subscriber: this.selectShow},
            {message: this.name + ".selectHide", subscriber: this.selectHide}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var TenantCheck = function (param) {
        this.submit = "/yuanqu/tenant/checkSubmit";
        this.label = "店铺审核认证信息";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "tenantCheck";
        this.template = "main-tenant-check";         //组件绑定的模板//组件需要订阅的事件与消息

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/tenant/getTenantById", {id: data}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else {
                renderTemplate(this.template, this);
            }
        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    var param = {};
                    param["templateName"] = "main-tenant-panel";
                    param["id"] = data.id;
                    PubSub.publish("tenantNew.tabShow", param);
                }
                $("#my-modal-loading").modal("close");
            });
            return false;
        };

        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.imageView = function (msg, data) {
            var images = data.files;
            $(data).parent().parent().find(".file-list").html("");
            for (var i = 0; i < images.length; i++) {
                if (images[i]) {
                    var reader = new FileReader();
                    reader.readAsDataURL(images[i]);
                    if (data.name == "audio") {
                        if (/audio\/\w+/.test(images[i].type)) {
                            reader.onload = function (e) {
                                var urlData = this.result;
                                $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
                            }
                        } else {
                            return false;
                        }
                    }
                    if ((/image\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<img src=\"" + urlData + "\" width=\"500\"  />")
                        }
                    }
                }
            }
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".imageView", subscriber: this.imageView},
            {message: this.name + ".submit", subscriber: this.submitForm}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var TenantList = function (param) {
        this.serachField = null;
        this.imageFlag = null;
        this.currentSearch = null;
        this.index = 1;
        this.size = 10;
        this.label = "店铺管理";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "tenantList";
        this.template = "main-tenant-list";         //组件绑定的模板//组件需要订阅的事件与消息
        this.totalPages = "";
        this.totalRecords = "";
        this.startPrice = null;
        this.endPrice = null;

        this.nextPage = function (msg, data) {
            this.totalPages = this.totalPages == 0 ? 1 : this.totalPages;
            this.index = this.index + 1 > this.totalPages ? this.totalPages : this.index + 1;
            $("#tenant-index").html("第" + this.index + "页");
            this.body();
        };

        this.prePage = function (msg, data) {
            this.index = this.index > 1 ? this.index - 1 : 1;
            $("#tenant-index").html("第" + this.index + "页");
            this.body();
        };

        this.delete = function (msg, data) {
            ajaxRequest("/yuanqu/tenant/deleteTenantById", {id: data}, function (responseData) {
                this.data = responseData;
                if (data.code != "1") {
                    this.body();
                }
            }.bind(this));
        };

        this.qrcode = function (msg, data) {
            var param = {};
            param.id = data;
            ajaxRequest("/yuanqu/tenant/createQRCode.do", param, function () {
            });
        };

        this.body = function (msg, data) {
            //@TODO 搜索列表与商品实体
            var param = {
                limit: this.size,
                offset: ((this.index - 1) * this.size)
            };
            param.name = this.currentSearch
            param.imageFlag = this.imageFlag;
            param.serachField = this.serachField;
            ajaxRequest("/yuanqu/tenant/getTenantList", param, function (responseData) {
                this.data = responseData.list;
                this.totalRecords = responseData.count;
                this.totalPages = this.totalRecords % this.size == 0 ? this.totalRecords / this.size : Math.floor(this.totalRecords / this.size) + 1;
                renderTemplate(this.template + "-body", this.data);
            }.bind(this));
        };

        this.render = function (msg, data) {
            this.index = 1;
            renderTemplate(this.template, this);
            this.show();
            PubSub.publish("tenantPanelList.isHide");
        };

        this.search = function (msg, data) {
            this.index = 1;
            this.currentSearch = $(".tenant-list #nameSelect").val();
            this.imageFlag = $(".tenant-list #checkbox").is(':checked');
            this.serachField = $(".tenant-list #selectField").val();
            this.body();
        };

        this.show = function (msg, data) {
            PubSub.publish("tenantNew.initialize");
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".body", subscriber: this.body},
            {message: this.name + ".search", subscriber: this.search},
            {message: this.name + ".qrcode", subscriber: this.qrcode},
            {message: this.name + ".nextPage", subscriber: this.nextPage},
            {message: this.name + ".prePage", subscriber: this.prePage},
            {message: this.name + ".delete", subscriber: this.delete},
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var HotBase = function (param) {
        this.submit = "/yuanqu/tenant/hotSubmit";
        this.label = "热点";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "hotBase";
        this.template = "main-tenant-panel-hot";         //组件绑定的模板//组件需要订阅的事件与消息
        this.panelListTemplate = "main-tenant-panel-hot-list";
        this.imageId = null;
        this.productModelList = "main-tenant-panel-product-model-list";

        this.new = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                this.imageId = data;
            }
            renderTemplate(this.template, this);
            this.show();
        };
        this.delete = function (msg, data) {
            ajaxRequest("/yuanqu/tenant/deleteHotById", {id: data}, function (responseData) {
                if (responseData.code != "1") {
                    ajaxRequest("/yuanqu/tenant/getHotListByImage", {id: this.imageId}, function (responseData) {
                        renderTemplate(this.panelListTemplate, responseData);
                    }.bind(this));
                }
            }.bind(this));
        };
        this.tabShow = function (msg, data) {
            $(data).parent().parent().find("li").each(function () {
                $(this).attr("class", "");
            });
            $(data).parent().attr("class", "am-active");

            $("[data-type=tabs]").each(function () {
                $(this).hide();
            });
            var tabData = $(data).attr("data");
            $("[data-for=" + tabData + "]").show();
            ajaxRequest("/yuanqu/tenant/getHotListByImage", {id: this.imageId}, function (responseData) {
                renderTemplate(this.panelListTemplate, responseData);
            }.bind(this));
        };

        this.chooseProductModel = function (msg, data) {
            var id = data.split(":")[0];
            var fullName = data.split(":")[1];
            $("#productModelId").val(id);
            $("#search").val(fullName);
            this.selectHide();
        };

        this.search = function (msg, data) {
            this.selectShow();
            var success = function (responseData) {
                renderTemplate(this.productModelList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/product/getProductModelNameList", {name: $(data).val()}, success);
        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (responseData) {
                $("[data=panelHotList]").click();
                document.getElementById(data).reset();
                $("#my-modal-loading").modal("close");
                $("#productModelId").val("");
            });
            return false;
        };

        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
            /*******************************************/
            $("#panelHotForm").parent().parent().find("li").each(function () {
                $(this).attr("class", "");
            });
            $("#panelHotForm").parent().attr("class", "am-active");

            $("[data-type=tabs]").each(function () {
                $(this).hide();
            });
            $("[data-for=panelHotForm]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.selectHide = function (msg, data) {
            $("[dot-template=" + this.productModelList + "]").hide();
        };
        this.selectShow = function (msg, data) {
            $("[dot-template=" + this.productModelList + "]").show();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".submit", subscriber: this.submitForm},
            {message: this.name + ".tabShow", subscriber: this.tabShow},
            {message: this.name + ".delete", subscriber: this.delete},
            {message: this.name + ".chooseProductModel", subscriber: this.chooseProductModel},
            {message: this.name + ".search", subscriber: this.search},
            {message: this.name + ".new", subscriber: this.new},
            {message: this.name + ".selectShow", subscriber: this.selectShow},
            {message: this.name + ".selectHide", subscriber: this.selectHide}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var TenantMaster = function (param) {
        this.submit = "/yuanqu/tenant/masterSubmit";
        this.label = "关联大师";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "tenantMaster";
        this.template = "main-tenant-master";         //组件绑定的模板//组件需要订阅的事件与消息
        this.masterList = "main-tenant-master-list";

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/tenant/getTenantById", {id: data}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else {
                renderTemplate(this.template, this);
            }
            this.show();

        };

        this.chooseMaster = function (msg, data) {
            var id = data.split(":")[0];
            var fullName = data.split(":")[1];
            $("#masterId").val(id);
            $("#search").val(fullName)
            this.selectHide();
        };

        this.search = function (msg, data) {
            this.selectShow();
            var success = function (responseData) {
                renderTemplate(this.masterList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/tenant/getTenantMasterList", {name: $(data).val()}, success);
        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish("tenantPanel.render", data.id);
                }
                $("#my-modal-loading").modal("close");
            });
            return false;
        };

        this.selectHide = function (msg, data) {
            $("[dot-template=" + this.masterList + "]").hide();
        };

        this.selectShow = function (msg, data) {
            $("[dot-template=" + this.masterList + "]").show();
        };

        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".submit", subscriber: this.submitForm},
            {message: this.name + ".chooseMaster", subscriber: this.chooseMaster},
            {message: this.name + ".search", subscriber: this.search},
            {message: this.name + ".selectHide", subscriber: this.selectHide},
            {message: this.name + ".selectShow", subscriber: this.selectShow}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var TenantPanel = function (param) {
        this.submit = "/yuanqu/tenant/panelSubmit";
        this.label = "店内实景";
        this.data = {};
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "tenantPanel";
        this.template = "main-tenant-panel";         //组件绑定的模板//组件需要订阅的事件与消息
        this.tenantId = "";
        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/product/getPanelById", {id: data}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                    this.show();
                    tenantPanelList.hide();
                }.bind(this));
            }
        };
        this.new = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                this.data = null;
                this.tenantId = data;
                renderTemplate(this.template, this);
                PubSub.publish("tenantPanelList.isHide");
            }
            this.show();
        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data != "undefined" && data != null) {
                    PubSub.publish("tenantPanelList.render", data.owner);
                }
                this.hide();
                tenantPanelList.show();
                $("#my-modal-loading").modal("close");
            }.bind(this));
            return false;
        };

        this.imageView = function (msg, data) {
            var images = data.files;
            $(data).parent().parent().find(".file-list").html("");
            for (var i = 0; i < images.length; i++) {
                if (images[i]) {
                    var reader = new FileReader();
                    reader.readAsDataURL(images[i]);
                    if (data.name == "media") {
                        if (/audio\/\w+/.test(images[i].type)) {
                            reader.onload = function (e) {
                                var urlData = this.result;
                                $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
                            }
                        } else {
                            return false;
                        }
                    }
                    if ((/image\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<img src=\"" + urlData + "\" width=\"500\"  />")
                        }
                    }
                }
            }
        };

        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.show = function (msg, data) {
            $("[dot-template=" + this.template + "]").show();
        }
        this.subscribeArray = [
            {message: this.name + ".new", subscriber: this.new},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".submit", subscriber: this.submitForm},
            {message: this.name + ".imageView", subscriber: this.imageView},
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var TenantPanelList = function (param) {
        this.index = 1;
        this.size = 10;
        this.label = "店内实景管理";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "tenantPanelList";
        this.template = "main-tenant-panel-list";         //组件绑定的模板//组件需要订阅的事件与消息
        this.totalPages = "";
        this.totalRecords = "";
        this.tenantId = "";

        this.nextPage = function (msg, data) {
            this.totalPages = this.totalPages == 0 ? 1 : this.totalPages;
            this.index = this.index + 1 > this.totalPages ? this.totalPages : this.index + 1;
            $("#tenant-panel-index").html("第" + this.index + "页");
            this.body();
        };

        this.prePage = function (msg, data) {
            this.index = this.index > 1 ? this.index - 1 : 1;
            $("#tenant-panel-index").html("第" + this.index + "页");
            this.body();
        };

        this.delete = function (msg, data) {
            ajaxRequest("/yuanqu/tenant/deletePanelById", {id: data}, function (responseData) {
                if (responseData.code != "1") {
                    this.body();
                }
            }.bind(this));
        };

        this.qrcode = function (msg, data) {
            var param = {};
            param.id = data;
            ajaxRequest("/yuanqu/tenant/createQRCode.do", param, function () {
            });
        };

        this.body = function (msg, data) {
            var param = {
                limit: this.size,
                offset: ((this.index - 1) * this.size)
            };
            param.id = this.tenantId;
            ajaxRequest("/yuanqu/tenant/getPanelListByTenant", param, function (responseData) {
                this.data = responseData.list;
                this.totalRecords = responseData.count;
                this.totalPages = this.totalRecords % this.size == 0 ? this.totalRecords / this.size : Math.floor(this.totalRecords / this.size) + 1;
                renderTemplate(this.template + "-body", this.data);
            }.bind(this));
        };

        this.render = function (msg, data) {
            this.index = 1;
            this.tenantId = data;
            renderTemplate(this.template, this);
        };

        this.show = function (msg, data) {
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.isHide = function (msg, data) {
            if ($("[dot-template=" + this.template + "]").is(":hidden")) {
                $("[dot-template=" + this.template + "]").show();
            } else {
                $("[dot-template=" + this.template + "]").hide();
            }
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".body", subscriber: this.body},
            {message: this.name + ".nextPage", subscriber: this.nextPage},
            {message: this.name + ".prePage", subscriber: this.prePage},
            {message: this.name + ".delete", subscriber: this.delete},
            {message: this.name + ".isHide", subscriber: this.isHide}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }
    }

    var ProductBase = function (param) {
        this.submit = "/yuanqu/product/baseSubmit";
        this.label = "商品信息";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productBase";
        this.template = "main-product-base";         //组件绑定的模板//组件需要订阅的事件与消息
        this.masterList = "main-product-master-list";
        this.projectList = "main-product-project-list";
        this.masterWorkList = "main-product-master-work-list";
        this.tenantId = null;
        this.panel = null;
        this.masterWorkProduct = null;

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/product/getProductById", {id: data}, function (responseData) {
                    this.data = responseData.product;
                    this.panel = responseData.panel;
                    this.masterWorkProduct = responseData.masterWorkProduct;
                    renderTemplate(this.template, this);
                }.bind(this))
            }
            this.show();
        };
        this.new = function (msg, data) {
            this.data = null;
            this.panel=null;
            this.tenantId = data;
            renderTemplate(this.template, this);
            this.show();
        };
        this.complete = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish("productList.render", data.bigTenant.id);
                }
                $("#my-modal-loading").modal("close");
            }.bind(this));
            return false;
        };
        this.submitAndNext = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish("productModelList.render", data.id);
                }
                $("#my-modal-loading").modal("close");
            });
            return false;
        };
        //关联大师和技艺
        this.chooseMaster = function (msg, data) {
            var id = data.split(":")[0];
            var fullName = data.split(":")[1];
            $("#product-masterId").val(id);
            $("#product-search").val(fullName)
            this.selectHide(null, this.masterList);
        };
        this.chooseProject = function (msg, data) {
            var id = data.split(":")[0];
            var fullName = data.split(":")[1];
            $("#product-projectId").val(id);
            $("#project-search").val(fullName);
            this.selectHide(null, this.projectList);
        };
        this.masterSearch = function (msg, data) {
            this.selectShow(null, this.masterList);
            var success = function (responseData) {
                renderTemplate(this.masterList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/tenant/getTenantMasterList", {name: $(data).val()}, success);
        };
        this.projectSearch = function (msg, data) {
            this.selectShow(null, this.projectList);
            var success = function (responseData) {
                renderTemplate(this.projectList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/product/getProjectList", {name: $(data).val()}, success);
        };
        //关联作品
        this.chooseMasterWork = function (msg, data) {
            var id = data.split(":")[0];
            var name = data.split(":")[1];
            $("#master-work-id").val(id);
            $("#master-work-search").val(name);
            this.selectHide(null, this.masterWorkList);
        };
        this.masterWorkSearch = function (msg, data) {
            this.selectShow(null, this.masterWorkList);
            var success = function (responseData) {
                renderTemplate(this.masterWorkList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/product/getMasterWorkList", {name: $(data).val()}, success);
        };
        this.selectHide = function (msg, data) {
            $("[dot-template=" + data + "]").hide();
        };
        this.selectShow = function (msg, data) {
            $("[dot-template=" + data + "]").show();
        };
        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.imageView = function (msg, data) {
            var images = data.files;
            $(data).parent().parent().find(".file-list").html("");
            for (var i = 0; i < images.length; i++) {
                if (images[i]) {
                    var reader = new FileReader();
                    reader.readAsDataURL(images[i]);
                    if (data.name == "audio") {
                        if (/audio\/\w+/.test(images[i].type)) {
                            reader.onload = function (e) {
                                var urlData = this.result;
                                $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
                            }
                        } else {
                            return false;
                        }
                    }
                    if ((/image\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<img src=\"" + urlData + "\" width=\"500\"  />")
                        }
                    }
                }
            }
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".imageView", subscriber: this.imageView},
            {message: this.name + ".complete", subscriber: this.complete},
            {message: this.name + ".submitAndNext", subscriber: this.submitAndNext},
            {message: this.name + ".chooseMaster", subscriber: this.chooseMaster},
            {message: this.name + ".chooseProject", subscriber: this.chooseProject},
            {message: this.name + ".masterSearch", subscriber: this.masterSearch},
            {message: this.name + ".projectSearch", subscriber: this.projectSearch},
            {message: this.name + ".selectHide", subscriber: this.selectHide},
            {message: this.name + ".selectShow", subscriber: this.selectShow},
            {message: this.name + ".chooseMasterWork", subscriber: this.chooseMasterWork},
            {message: this.name + ".masterWorkSearch", subscriber: this.masterWorkSearch},
            {message: this.name + ".new", subscriber: this.new}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }
    };

    var ProductMaster = function (param) {
        this.submit = "/yuanqu/product/masterSubmit";
        this.label = "关联大师";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productMaster";
        this.template = "main-product-master";         //组件绑定的模板//组件需要订阅的事件与消息
        this.masterList = "main-product-master-list";
        this.projectList = "main-product-project-list";

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/product/getProductById", {id: data}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else {
                renderTemplate(this.template, this);
            }
            this.show();
        };

        this.chooseMaster = function (msg, data) {
            var id = data.split(":")[0];
            var fullName = data.split(":")[1];
            $("#product-masterId").val(id);
            $("#product-search").val(fullName)
            this.selectHide();
        };

        this.chooseProject = function (msg, data) {
            var id = data.split(":")[0];
            var fullName = data.split(":")[1];
            $("#product-projectId").val(id);
            $("#project-search").val(fullName);
            this.selectProjectHide();
        };

        this.search = function (msg, data) {
            this.selectShow();
            var success = function (responseData) {
                renderTemplate(this.masterList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/tenant/getTenantMasterList", {name: $(data).val()}, success);
        };

        this.projectSearch = function (msg, data) {
            this.selectProjectShow()
            var success = function (responseData) {
                renderTemplate(this.projectList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/product/getProjectList", {name: $(data).val()}, success);
        };

        this.selectHide = function (msg, data) {
            $("[dot-template=" + this.masterList + "]").hide();
        };
        this.selectShow = function (msg, data) {
            $("[dot-template=" + this.masterList + "]").show();
        };

        this.selectProjectHide = function (msg, data) {
            $("[dot-template=" + this.projectList + "]").hide();
        };
        this.selectProjectShow = function (msg, data) {
            $("[dot-template=" + this.projectList + "]").show();
        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish('productPanel.new', this.data.id);
                }
                $("#my-modal-loading").modal("close");
            }.bind(this));
            return false;
        };

        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".submit", subscriber: this.submitForm},
            {message: this.name + ".chooseMaster", subscriber: this.chooseMaster},
            {message: this.name + ".chooseProject", subscriber: this.chooseProject},
            {message: this.name + ".search", subscriber: this.search},
            {message: this.name + ".projectSearch", subscriber: this.projectSearch},
            {message: this.name + ".selectHide", subscriber: this.selectHide},
            {message: this.name + ".selectShow", subscriber: this.selectShow},
            {message: this.name + ".selectProjectHide", subscriber: this.selectProjectHide},
            {message: this.name + ".selectProjectShow", subscriber: this.selectProjectShow},
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var ProductMasterWork = function (param) {
        this.submit = "/yuanqu/product/masterWorkSubmit";
        this.label = "关联作品";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productMasterWork";
        this.template = "main-product-master-work";         //组件绑定的模板//组件需要订阅的事件与消息
        this.masterWorkList = "main-product-master-work-list";
        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/product/getProductById", {id: data}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                }.bind(this));
            } else {
                renderTemplate(this.template, this);
            }
            this.show();
        };

        this.chooseMasterWork = function (msg, data) {
            var id = data.split(":")[0];
            var name = data.split(":")[1];
            $("#master-work-id").val(id);
            $("#master-work-search").val(name);
            this.selectShow();
        };

        this.search = function (msg, data) {
            this.selectShow();
            var success = function (responseData) {
                renderTemplate(this.masterWorkList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/product/getMasterWorkList", {name: $(data).val()}, success);
        };

        this.selectHide = function (msg, data) {
            $("[dot-template=" + this.masterWorkList + "]").hide();
        };
        this.selectShow = function (msg, data) {
            $("[dot-template=" + this.masterWorkList + "]").show();
        };
        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish('productModel.new', this.data.id);
                }
                $("#my-modal-loading").modal("close");
            }.bind(this));
            return false;
        };

        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".submit", subscriber: this.submitForm},
            {message: this.name + ".chooseMasterWork", subscriber: this.chooseMasterWork},
            {message: this.name + ".search", subscriber: this.search},
            {message: this.name + ".selectHide", subscriber: this.selectHide},
            {message: this.name + ".selectShow", subscriber: this.selectShow}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var ProductModel = function (param) {
        this.submit = "/yuanqu/product/modelSubmit";
        this.label = "商品规格信息";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productModel";
        this.template = "main-product-model";         //组件绑定的模板//组件需要订阅的事件与消息
        this.productId = null;
        this.panel = null;

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/product/getProductModelById", {id: data}, function (responseData) {
                    this.data = responseData.productModel;
                    this.productId = responseData.productModel.product.id;
                    this.panel = responseData.panel;
                    renderTemplate(this.template, this);
                }.bind(this));
            }
            this.show();
        };

        this.new = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                this.data = null;
                this.panel = null;
                this.productId = data;
                renderTemplate(this.template, this);
            }
            this.show();

        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data != "undefined" && data != null) {
                    PubSub.publish("productModelList.render", data.product.id);
                }
                $("#my-modal-loading").modal("close");
            });
            return false;
        };
        this.submitAndNext = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish("productList.render", data.product.tenant.id);
                }
                $("#my-modal-loading").modal("close");
            });
            return false;
        };

        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.imageView = function (msg, data) {
            var images = data.files;
            $(data).parent().parent().find(".file-list").html("");
            for (var i = 0; i < images.length; i++) {
                if (images[i]) {
                    var reader = new FileReader();
                    reader.readAsDataURL(images[i]);
                    if (data.name == "audio") {
                        if (/audio\/\w+/.test(images[i].type)) {
                            reader.onload = function (e) {
                                var urlData = this.result;
                                $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
                            }
                        } else {
                            return false;
                        }
                    }
                    if ((/image\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<img src=\"" + urlData + "\" width=\"500\"  />")
                        }
                    }
                }
            }
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".imageView", subscriber: this.imageView},
            {message: this.name + ".submit", subscriber: this.submitForm},
            {message: this.name + ".new", subscriber: this.new},
            {message: this.name + ".submitAndNext", subscriber: this.submitAndNext},
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }
    };

    var ProductList = function (param) {
        this.currentSearch = null;
        this.tenantId = null;
        this.label = "商品管理";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productList";
        this.template = "main-product-list";         //组件绑定的模板//组件需要订阅的事件与消息
        this.totalRecords = null;
        this.totalPages = null;
        this.serachField = null;
        this.imageFlag = null;
        this.index = 1;
        this.size = 10;

        this.nextPage = function (msg, data) {
            this.totalPages = this.totalPages == 0 ? 1 : this.totalPages;
            this.index = this.index + 1 > this.totalPages ? this.totalPages : this.index + 1;
            $("#product-index").html("第" + this.index + "页");
            this.body();
        };

        this.prePage = function (msg, data) {
            this.index = this.index > 1 ? this.index - 1 : 1;
            $("#product-index").html("第" + this.index + "页");
            this.body();
        };

        this.body = function (msg, data) {
            //@TODO 搜索列表与商品实体
            var param = {
                limit: this.size,
                offset: ((this.index - 1) * this.size)
            };
            param.tenantId = this.tenantId;
            param.name = this.currentSearch;
            param.imageFlag = this.imageFlag;
            param.serachField = this.serachField;
            ajaxRequest("/yuanqu/product/getProductList", param, function (responseData) {
                this.data = responseData.list;
                this.totalRecords = responseData.count;
                this.totalPages = this.totalRecords % this.size == 0 ? this.totalRecords / this.size : Math.floor(this.totalRecords / this.size) + 1;
                renderTemplate(this.template + "-body", this.data);
            }.bind(this));
        };

        this.delete = function (msg, data) {
            ajaxRequest("/yuanqu/product/deleteProductById", {id: data}, function (responseData) {
                this.data = responseData;
                if (data.code != "1") {
                    this.body();
                }
            }.bind(this));
        };

        this.render = function (msg, data) {
            this.index = 1;
            this.tenantId = data;
            renderTemplate(this.template, this);
            this.show();

        };

        this.chooseTenantGroup = function (msg, data) {
            var productId = $(data).attr("id");
            var tenantGroupId = $(data).val();
            ajaxRequest("/yuanqu/product/chooseTenantGroup", {
                "productId": productId,
                "tenantGroupId": tenantGroupId
            }, function () {
                console.log("保存成功");
            });
        };

        this.search = function (msg, data) {
            this.index = 1;
            this.currentSearch = $(".product-list #nameSelect").val();
            this.imageFlag = $(".product-list #checkbox").is(':checked');
            this.serachField = $(".product-list #selectField").val();
            this.body();
        };


        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".body", subscriber: this.body},
            {message: this.name + ".search", subscriber: this.search},
            {message: this.name + ".nextPage", subscriber: this.nextPage},
            {message: this.name + ".prePage", subscriber: this.prePage},
            {message: this.name + ".delete", subscriber: this.delete},
            {message: this.name + ".chooseTenantGroup", subscriber: this.chooseTenantGroup}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var ProductModelList = function (param) {
        this.productId = null;
        this.index = 1;
        this.size = 10;
        this.label = "规格管理";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productModelList";
        this.template = "main-product-model-list";         //组件绑定的模板//组件需要订阅的事件与消息
        this.currentSearch = null;
        this.imageFlag = null;
        this.serachField = null;

        this.body = function (msg, data) {
            var param = {
                limit: this.size,
                offset: ((this.index - 1) * this.size)
            };
            param.productId = this.productId;
            param.name = this.currentSearch
            param.imageFlag = this.imageFlag;
            param.serachField = this.serachField;
            param.startPrice = this.startPrice;
            param.endPrice = this.endPrice;
            ajaxRequest("/yuanqu/product/getProductModelList", param, function (responseData) {
                this.data = responseData.list;
                this.totalRecords = responseData.count;
                this.totalPages = this.totalRecords % this.size == 0 ? this.totalRecords / this.size : Math.floor(this.totalRecords / this.size) + 1;
                renderTemplate(this.template + "-body", this.data);
            }.bind(this));
        };
        this.search = function (msg, data) {
            this.index = 1;
            this.currentSearch = $(".product-model #nameSelect").val();
            this.imageFlag = $(".product-model #checkbox").is(':checked');
            this.serachField = $(".product-model #selectField").val();
            this.startPrice = $(".product-model #startPrice").val();
            this.endPrice = $(".product-model #endPrice").val();
            this.body();
        };
        this.render = function (msg, data) {
            this.index = 1;
            this.productId = data;
            renderTemplate(this.template, this);
            this.show();

        };
        this.delete = function (msg, data) {
            ajaxRequest("/yuanqu/product/deleteProductModelById", {id: data}, function (responseData) {
                this.data = responseData;
                if (data.code != "1") {
                    this.body();
                }
            }.bind(this));
        };
        this.upper = function (msg, data) {
            if (data.status == "1") {
                data.status = "2";
            } else if (data.status == "2") {
                data.status = "1";
            }
            ajaxRequest("/yuanqu/product/setProductModelStatus", {data: JSON.stringify(data)}, function (responseData) {
                this.productId = responseData.product.id;
                this.body();
            }.bind(this));
        };
        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.nextPage = function (msg, data) {
            this.totalPages = this.totalPages == 0 ? 1 : this.totalPages;
            this.index = this.index + 1 > this.totalPages ? this.totalPages : this.index + 1;
            $("#product-model-index").html("第" + this.index + "页");
            this.body();
        };
        this.prePage = function (msg, data) {
            this.index = this.index > 1 ? this.index - 1 : 1;
            $("#product-model-index").html("第" + this.index + "页");
            this.body();
        };


        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".body", subscriber: this.body},
            {message: this.name + ".delete", subscriber: this.delete},
            {message: this.name + ".upper", subscriber: this.upper},
            {message: this.name + ".search", subscriber: this.search}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var SKUList = function (param) {
        this.currentSearch = null;
        this.index = 1;
        this.size = 10;
        this.label = "SKU管理";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "skuList";
        this.template = "main-sku-list";         //组件绑定的模板//组件需要订阅的事件与消息
        this.totalPages = "";
        this.totalRecords = "";

        this.nextPage = function (msg, data) {
            this.totalPages = this.totalPages == 0 ? 1 : this.totalPages;
            this.index = this.index + 1 > this.totalPages ? this.totalPages : this.index + 1;
            $("#sku-index").html("第" + this.index + "页");
            this.body();
        };

        this.prePage = function (msg, data) {
            this.index = this.index > 1 ? this.index - 1 : 1;
            $("#sku-index").html("第" + this.index + "页");
            this.body();
        };

        this.delete = function (msg, data) {
            ajaxRequest("/yuanqu/product/deleteProductModelById", {id: data}, function (responseData) {
                this.data = responseData;
                if (data.code != "1") {
                    this.body();
                }
            }.bind(this));
        };

        this.upper = function (msg, data) {
            if (data.status == "1") {
                data.status = "2";
            } else if (data.status == "2") {
                data.status = "1";
            }
            ajaxRequest("/yuanqu/product/setProductModelStatus", {data: JSON.stringify(data)}, function (responseData) {
                this.productId = responseData.product.id;
                this.body();
            }.bind(this));
        };

        this.body = function (msg, data) {
            //@TODO 搜索列表与商品实体
            var param = {
                limit: this.size,
                offset: ((this.index - 1) * this.size)
            };
            if (this.currentSearch != null) {
                param.name = this.currentSearch
            }
            ajaxRequest("/yuanqu/product/getSKUList", param, function (responseData) {
                this.data = responseData.list;
                this.totalRecords = responseData.count;
                this.totalPages = this.totalRecords % this.size == 0 ? this.totalRecords / this.size : Math.floor(this.totalRecords / this.size) + 1;
                renderTemplate(this.template + "-body", this.data);
            }.bind(this));
        };

        this.render = function (msg, data) {
            this.index = 1;
            renderTemplate(this.template, this);
            this.show();
        };

        this.search = function (msg, data) {
            this.index = 1;
            this.currentSearch = $(data).val();
            this.body();
        };

        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".body", subscriber: this.body},
            {message: this.name + ".search", subscriber: this.search},
            {message: this.name + ".nextPage", subscriber: this.nextPage},
            {message: this.name + ".prePage", subscriber: this.prePage},
            {message: this.name + ".delete", subscriber: this.delete},
            {message: this.name + ".upper", subscriber: this.upper}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var ProductModelPanel = function (param) {
        this.submit = "/yuanqu/product/modelpanelSubmit";
        this.label = "商品规格详情";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productModelPanel";
        this.template = "main-product-model-panel";         //组件绑定的模板//组件需要订阅的事件与消息
        this.panelListTemplate = "main-product-model-panel-list";
        this.productModelId = null;
        this.id = null;
        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/product/getPanelById", {id: data}, function (responseData) {
                    if (responseData.code != "1") {
                        this.data = responseData;
                        this.id = responseData.id;
                        renderTemplate(this.template, this);
                    }
                }.bind(this));
            } else {
                renderTemplate(this.template, this);
            }
        };
        this.new = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                if (data.id != "undefined" && data.id != null) {
                    this.productModelId = data.id;
                } else {
                    this.productModelId = data;
                }
                ajaxRequest("/yuanqu/product/getProductModelById", {id: this.productModelId}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                    $("#panelIntroduction").val("");
                    $("#panelName").val("");
                }.bind(this));
            }
            this.show();
        };

        this.delete = function (msg, data) {
            ajaxRequest("/yuanqu/tenant/deletePanelById", {id: data}, function (responseData) {
                if (responseData.code != "1") {
                    ajaxRequest("/yuanqu/product/getPanelListByProductModel", {id: this.productModelId}, function (responseData) {
                        renderTemplate(this.panelListTemplate, responseData);
                    }.bind(this));
                }
            }.bind(this));
        };

        this.tabShow = function (msg, data) {
            $(".file-list").html("");
            $(data).parent().parent().find("li").each(function () {
                $(this).attr("class", "");
            });
            $(data).parent().attr("class", "am-active");

            $("[data-type=tabs]").each(function () {
                $(this).hide();
            });
            var tabData = $(data).attr("data");
            $("[data-for=" + tabData + "]").show();
            $("#productModelPanelId").val("");
            $("#panelIntroduction").val("");
            $("#panelName").val("");
            ajaxRequest("/yuanqu/product/getPanelListByProductModel", {id: this.productModelId}, function (responseData) {
                renderTemplate(this.panelListTemplate, responseData);
            }.bind(this));
        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (responseData) {
                $("[data=product-model-panelList]").click();
                document.getElementById(data).reset();
                $("#my-modal-loading").modal("close");
                $(".file-list img").remove();
            });
            return false;
        };

        this.nextProductModel = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (responseData) {
                PubSub.publish("productModel.new", this.data.product.id)
                $("#my-modal-loading").modal("close");
            }.bind(this));
            return false;
        };

        this.imageView = function (msg, data) {
            var images = data.files;
            $(data).parent().parent().find(".file-list").html("");
            for (var i = 0; i < images.length; i++) {
                if (images[i]) {
                    var reader = new FileReader();
                    reader.readAsDataURL(images[i]);
                    if (data.name == "media") {
                        if (/audio\/\w+/.test(images[i].type)) {
                            reader.onload = function (e) {
                                var urlData = this.result;
                                $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
                            }
                        } else {
                            return false;
                        }
                    }
                    if ((/image\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<img src=\"" + urlData + "\" width=\"500\"  />")
                        }
                    }
                }
            }
        };


        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".submit", subscriber: this.submitForm},
            {message: this.name + ".tabShow", subscriber: this.tabShow},
            {message: this.name + ".imageView", subscriber: this.imageView},
            {message: this.name + ".delete", subscriber: this.delete},
            {message: this.name + ".nextProductModel", subscriber: this.nextProductModel},
            {message: this.name + ".new", subscriber: this.new}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    }

    var ProductPanel = function (param) {
        this.submit = "/yuanqu/product/panelSubmit";
        this.label = "商品详情";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productPanel";
        this.template = "main-product-panel";         //组件绑定的模板//组件需要订阅的事件与消息
        this.productId = null;

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/product/getProductPanelById", {id: data}, function (responseData) {
                    if (responseData.code != "1") {
                        this.data = responseData;
                        this.productId = responseData.owner;
                        renderTemplate(this.template, this);
                    } else {
                        this.productId = data;
                        renderTemplate(this.template, this);
                    }
                }.bind(this));
            } else {
                renderTemplate(this.template, this);
            }
            this.show();
        };
        this.new = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                this.data = null;
                this.productId = data;
                renderTemplate(this.template, this);
            }
            this.show();
        };
        this.delete = function (msg, data) {
            var success = function (responseData) {
                $("#" + responseData).remove();
            };
            ajaxRequest("/yuanqu/product/deletePanel", {id: data}, success);
        };
        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.owner != "undefined" && data.owner != null) {
                    PubSub.publish('productMasterWork.render', data.owner);
                }
                $("#my-modal-loading").modal("close");
            }.bind(this));
            return false;
        };

        this.imageView = function (msg, data) {
            var images = data.files;
            $(data).parent().parent().find(".file-list").html("");
            for (var i = 0; i < images.length; i++) {
                if (images[i]) {
                    var reader = new FileReader();
                    reader.readAsDataURL(images[i]);
                    if (data.name == "media") {
                        if (/audio\/\w+/.test(images[i].type)) {
                            reader.onload = function (e) {
                                var urlData = this.result;
                                $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
                            }
                        } else {
                            return false;
                        }
                    }
                    if ((/image\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<img src=\"" + urlData + "\" width=\"500\"  />")
                        }
                    }
                }
            }
        };

        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".submit", subscriber: this.submitForm},
            {message: this.name + ".imageView", subscriber: this.imageView},
            {message: this.name + ".delete", subscriber: this.delete},
            {message: this.name + ".new", subscriber: this.new}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var ScenicRegion = function (param) {
        this.submit = "/yuanqu/tenant/scenicSubmit";
        this.label = "新景区";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "scenicRegion";
        this.template = "main-scenic-region";         //组件绑定的模板//组件需要订阅的事件与消息

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/tenant/getScenicRegionById", {id: data}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else {
                renderTemplate(this.template, this);
            }
            this.show();

        };

        this.submitAndNext = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    this.render("", data.id);
                }
                $("#my-modal-loading").modal("close");
            });
            return false;
        };

        this.submitAndList = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish("scenicRegionList");
                }
                $("#my-modal-loading").modal("close");
            });
            return false;
        };


        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.imageView = function (msg, data) {
            var images = data.files;
            $(data).parent().parent().find(".file-list").html("");
            for (var i = 0; i < images.length; i++) {
                if (images[i]) {
                    var reader = new FileReader();
                    reader.readAsDataURL(images[i]);
                    if (data.name == "audio") {
                        if (/audio\/\w+/.test(images[i].type)) {
                            reader.onload = function (e) {
                                var urlData = this.result;
                                $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
                            }
                        } else {
                            return false;
                        }
                    }
                    if ((/image\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<img src=\"" + urlData + "\" width=\"500\"  />")
                        }
                    }
                }
            }
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".imageView", subscriber: this.imageView},
            {message: this.name + ".submitAndNext", subscriber: this.submitAndNext},
            {message: this.name + ".submitAndList", subscriber: this.submitAndList}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var ScenicRegionList = function (param) {
        this.currentSearch = null;
        this.index = 1;
        this.size = 10;
        this.label = "景区管理";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "scenicRegionList";
        this.template = "main-scenic-region-list";         //组件绑定的模板//组件需要订阅的事件与消息

        this.nextPage = function (msg, data) {
            this.index = this.index + 1;
            $("#scenic-index").html("第" + this.index + "页");
            this.body();
        };

        this.prePage = function (msg, data) {
            this.index = this.index > 1 ? this.index - 1 : 1;
            $("#scenic-index").html("第" + this.index + "页");
            this.body();
        };

        this.body = function (msg, data) {
            //@TODO 搜索列表与商品实体
            var param = {
                limit: this.size,
                offset: ((this.index - 1) * this.size)
            };
            if (this.currentSearch != null) {
                param.name = this.currentSearch
            }
            ajaxRequest("/yuanqu/tenant/getScenicList", param, function (responseData) {
                this.data = responseData;
                renderTemplate(this.template + "-body", responseData);
            }.bind(this));
        };

        this.render = function (msg, data) {
            this.index = 1;
            this.tenantId = data;
            renderTemplate(this.template, this);
            this.show();

        };

        this.search = function (msg, data) {
            this.index = 1;
            this.currentSearch = $(data).val();
            this.body();
        };


        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".body", subscriber: this.body},
            {message: this.name + ".search", subscriber: this.search},
            {message: this.name + ".nextPage", subscriber: this.nextPage},
            {message: this.name + ".prePage", subscriber: this.prePage}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var RecommendBase = function (param) {
        this.submit = "/yuanqu/tenant/recommendSubmit";
        this.label = "新推荐";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "recommendBase";
        this.template = "main-recommend-base";         //组件绑定的模板//组件需要订阅的事件与消息

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/tenant/getRecommendById", {id: data}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else {
                renderTemplate(this.template, this);
            }
            this.show();
        };

        this.submitAndNext = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    this.render();
                }
                $("#my-modal-loading").modal("close");
            }.bind(this));
            return false;
        };


        this.submitAndList = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish("recommendList.render");
                }
                $("#my-modal-loading").modal("close");
            }.bind(this));
            return false;
        };


        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };
        this.imageView = function (msg, data) {
            var images = data.files;
            $(data).parent().parent().find(".file-list").html("");
            for (var i = 0; i < images.length; i++) {
                if (images[i]) {
                    var reader = new FileReader();
                    reader.readAsDataURL(images[i]);
                    if (data.name == "audio") {
                        if (/audio\/\w+/.test(images[i].type)) {
                            reader.onload = function (e) {
                                var urlData = this.result;
                                $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
                            }
                        } else {
                            return false;
                        }
                    }
                    if ((/image\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<img src=\"" + urlData + "\" width=\"500\"  />")
                        }
                    }
                }
            }
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".imageView", subscriber: this.imageView},
            {message: this.name + ".submitAndNext", subscriber: this.submitAndNext},
            {message: this.name + ".submitAndList", subscriber: this.submitAndList},
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }
    };

    var RecommendList = function (param) {
        this.currentSearch = null;
        this.group = null;
        this.index = 1;
        this.size = 10;
        this.label = "推荐管理";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "recommendList";
        this.template = "main-recommend-list";         //组件绑定的模板//组件需要订阅的事件与消息

        this.nextPage = function (msg, data) {
            this.index = this.index + 1;
            $("#recommend-index").html("第" + this.index + "页");
            this.body();
        };

        this.prePage = function (msg, data) {
            this.index = this.index > 1 ? this.index - 1 : 1;
            $("#recommend-index").html("第" + this.index + "页");
            this.body();
        };

        this.body = function (msg, data) {
            //@TODO 搜索列表与商品实体
            var param = {
                limit: this.size,
                offset: ((this.index - 1) * this.size)
            };
            if (this.currentSearch != null) {
                param.name = this.currentSearch
            }
            if (this.group != null) {
                param.group = this.group;
            }
            ajaxRequest("/yuanqu/tenant/getRecommendList", param, function (responseData) {
                this.data = responseData;
                renderTemplate(this.template + "-body", responseData);
            }.bind(this));
        };

        this.render = function (msg, data) {
            this.index = 1;
            this.group = data;
            renderTemplate(this.template, this);
            this.show();

        };

        this.search = function (msg, data) {
            this.index = 1;
            this.currentSearch = $(data).val();
            this.body();
        };

        this.search = function (msg, data) {
            this.index = 1;
            this.group = $(data).val();
            this.body();
        };


        this.show = function (msg, data) {
            PubSub.publish("nav.setCurrentComponent", this);
//            setTimeout("$('#data-am-selected').selected()", 1000);
            $("select").selected();
            $("[dot-template=" + this.template + "]").show();
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").html("");
        };

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".body", subscriber: this.body},
            {message: this.name + ".search", subscriber: this.search},
            {message: this.name + ".nextPage", subscriber: this.nextPage},
            {message: this.name + ".prePage", subscriber: this.prePage}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    function renderTemplate(templateId, data) {
        $("[dot-template=" + templateId + "]").html(doT.template($("#" + templateId).text())(data));
    }

    var nav = new Nav();
    var menu = new Menu();
    var tenantBase = new TenantBase();      //店铺基本信息
    var tenantCheck = new TenantCheck();    //店铺公司信息
    var tenantMaster = new TenantMaster();  //店铺大师信息
    var tenantPanel = new TenantPanel();    //店铺实景信息
    var productBase = new ProductBase();    //商品基本信息
    var productMaster = new ProductMaster();//商品大师信息
    var productModel = new ProductModel();  //商品规格信息
    var productModelPanel = new ProductModelPanel();  //商品规格详情
    var productPanel = new ProductPanel();//商品详情
    var tenantList = new TenantList();      //店铺列表
    var productList = new ProductList();    //商品列表
    var hotBase = new HotBase();  //热点
    var productModelList = new ProductModelList();  //商品规格列表
    var productMasterWork = new ProductMasterWork();//关联作品
    var scenicRegion = new ScenicRegion();          //景区信息
    var scenicRegionList = new ScenicRegionList();  //景区列表
    var recommendBase = new RecommendBase();        //推荐信息
    var recommendList = new RecommendList();        //推荐列表
    var skuList = new SKUList();
    var tenantNew = new TenantNew();
    var tenantPanelList = new TenantPanelList();

</script>

</body>
</html>
