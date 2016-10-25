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

    </style>
</head>
<body>
<div class="am-g">
    <div dot-template="main-nav">
    </div>
    <div dot-template="main-menu">
    </div>
    <div dot-template="main-product-base">
    </div>
    <div dot-template="main-product-master">
    </div>
    <div dot-template="main-product-panel">
    </div>
    <div dot-template="main-product-model">
    </div>
    <div dot-template="main-product-model-panel">
    </div>
    <div dot-template="main-product-list">
    </div>
    <div dot-template="main-product-model-list">
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
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('productBase.render')">
            <span>新商品</span></button>
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('productList.render')">
            <span>商品管理</span></button>
    </div>
</script>

<script type="text/x-dot-template" id="main-product-base">
    <div class="main-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-product-base-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend>{{=it.tenantName}} 商品列表</legend>

                <input name="id" type="hidden" value="{{=(it.data!=null && it.data.id!=null ) ? it.data.id: ''}}">

                <div class="am-form-group">
                    <label for="product-name" class="am-u-sm-2 am-form-label">名称</label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="product-name"
                               value="{{=( it.data!=null ) ? it.data.name : ''}}"
                               placeholder="输入新商品名称">
                    </div>
                </div>


                <div class="am-form-group">
                    <label for="product-subName" class="am-u-sm-2 am-form-label">副标题</label>
                    <div class="am-u-sm-10">
                        <input name="subName" type="text" id="product-subName"
                               value="{{=(it.data!=null) ? it.data.subName : ''}}"
                               placeholder="输入新商品副标题">
                    </div>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="picture_url" class="am-u-sm-2 am-form-label">主图</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="picture_url" name="picture_url" type="file" multiple
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-10">
                        {{ if(it.data!=null && it.data.picture_url !=null){ }}
                        <img src="{{=it.data.picture_url}}" width="500"/>
                        {{ } }}
                    </div>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="product-audio" class="am-u-sm-2 am-form-label">语音介绍</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-audio" name="audio" type="file" multiple
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
                        <a onclick="PubSub.publish('{{=it.name}}.submit','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">保存</a>
                        <a onclick="PubSub.publish('{{=it.name}}.submitAndNext','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">下一步关联大师</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-product-master">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-product-master-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend><b>{{=it.data.name}}</b> 大师信息与技艺信息</legend>

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
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-product-master-list">
    {{ if(typeof it =="undefined" || it == null && it.length <= 0){ }}
    <a onclick="">未找到相关大师，点击提交数据补全请求</a>
    {{ }else{ }}
    <ul class="am-list  am-list-border" id="searchResult">
        {{ for(var i = 0 ; i < it.length; i++){ }}
        <li><a onclick="PubSub.publish('productMaster.chooseMaster','{{=it[i].id}}:{{=it[i].fullName}}')">{{=it[i].fullName}}</a>
        </li>
        {{ } }}
    </ul>
    {{ } }}
</script>

<script type="text/x-dot-template" id="main-product-panel">

    <div class="main-base" data-for="product-panelForm">
        <form class="am-form am-form-horizontal" name="tenant" id="main-product-panel-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">
            <fieldset>
                <legend><b>{{=it.data.name}}</b> 的栏目列表（商品详情）</legend>
                <input type="hidden" name="id" value="{{=it.data.id}}">

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">名称</label>
                    <div class="am-u-sm-9">
                        <input name="name" type="text" placeholder="名称">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">介绍</label>
                    <div class="am-u-sm-9">
                        <textarea name="content" rows="5" placeholder="介绍"></textarea>
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="product-imageList" class="am-u-sm-3 am-form-label">图片（可以选择多张图片）</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-imageList" name="imageList" type="file" multiple
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                    </div>
                </div>
                <div class="am-form-group am-form-file">
                    <label for="product-media" class="am-u-sm-3 am-form-label">语音介绍</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-media" name="media" type="file" multiple
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('{{=it.name}}.submit','{{=it.template}}-form')">去添加商品规格</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>

</script>

<script type="text/x-dot-template" id="main-product-list">

    <div>
        <div class="am-u-lg-6">
            <legend>{{=it.tenantName}} 商品列表</legend>
            <div class="am-input-group">
                <input type="text" class="am-form-field" oninput="PubSub.publish('{{=it.name}}.search',this)">
                <span class="am-input-group-btn">
                    <button class="am-btn am-btn-default" disabled type="button"><span
                            class="am-icon-search"></span></button>
                </span>
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
                        <button onclick="PubSub.publish('productBase.render',{productId:'{{=product.id}}'})"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 基本信息
                        </button>
                        <button onclick="PubSub.publish('productModelList.render','{{=product.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 商品规格
                        </button>
                        <button onclick="PubSub.publish('productModel.render',{productId:'{{=product.id}}'})"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 添加规格
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

<script type="text/x-dot-template" id="main-product-model">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="model" id="main-product-model-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend><b>{{=it.product}}</b> 商品规格信息</legend>
                <input type="hidden" name="id" value="{{=it.data != null ? it.data.id : ''}}">
                <input type="hidden" name="productId" value="{{=it.product}}">

                <div class="am-form-group">
                    <label for="product-model-name" class="am-u-sm-3 am-form-label">规格名称</label>
                    <div class="am-u-sm-9">
                        <input name="name" type="text" id="product-model-name"
                               value="{{=(it.data!=null && it.data.name!=null) ? it.data.name: ''}}"
                               placeholder="输入规格名称">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="product-model-amount" class="am-u-sm-3 am-form-label">库存（默认为1）</label>
                    <div class="am-u-sm-9">
                        <input name="amount" type="text" id="product-model-amount"
                               value="{{=(it.data!=null && it.data.amount!=null) ? it.data.amount : ''}}"
                               placeholder="输入库存">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="product-model-price" class="am-u-sm-3 am-form-label">线上价格</label>
                    <div class="am-u-sm-9">
                        <input name="price" type="text" id="product-model-price"
                               value="{{=(it.data!=null && it.data.price!=null)  ? it.data.price : ''}}"
                               placeholder="输入商品价格">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="product-model-marketPrice"
                           class="am-u-sm-3 am-form-label">线下价格（如果与线上价格相同，就不要填写了）</label>
                    <div class="am-u-sm-9">
                        <input name="marketPrice" type="text" id="product-model-marketPrice"
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
                        <input id="productModel_url" name="productModel_url" type="file" multiple
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                        {{ if(it.data!=null && it.data.productModel_url !=null){ }}
                        <img src="{{=it.data.productModel_url}}" width="500"/>
                        {{ } }}
                    </div>
                </div>


                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productBase.render','{{=it.product}}')">< 上一步</a>
                        <a onclick="PubSub.publish('{{=it.name}}.submit','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">下一步 ></a>
                        <%--<a class="am-btn am-btn-primary am-btn-lg"--%>
                        <%--onclick="PubSub.publish('tenantMaster.render','{{=it.data.id}}')">跳过</a>--%>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script type="text/x-dot-template" id="main-product-model-panel">
    <div class="main-base">
        <ul class="am-nav am-nav-tabs am-nav-justify">
            <li class="am-active"><a onclick="PubSub.publish('{{=it.name}}.tabShow',this)" data="product-model-panelForm">新的商品栏目</a>
            </li>
            <li><a onclick="PubSub.publish('{{=it.name}}.tabShow',this)" data="product-model-panelList">查看所有</a></li>
        </ul>
    </div>

    <div class="main-base" data-for="product-model-panelList" data-type="tabs" style="display: none">
        <legend><b>{{=it.data.name}}</b> 的栏目列表（商品详情）</legend>
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set">操作</th>
                <th class="table-title">名称</th>
                <th class="table-title">介绍</th>
                <th class="table-title">图片预览</th>
                <th class="table-title">语音预览</th>
            </tr>
            </thead>
            <tbody dot-template="main-product-model-panel-list">

            </tbody>
        </table>

        <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
            <a class="am-btn am-btn-primary am-btn-lg"
               onclick="PubSub.publish('productList.render')">完成</a>
            <a class="am-btn am-btn-primary am-btn-lg"
               onclick="PubSub.publish('productModel.render',{productId:'{{=it.data.product.id}}'})">添加下一个商品规格</a>
            <a class="am-btn am-btn-primary am-btn-lg"
               onclick="PubSub.publish('productBase.render',{tenantId:'{{=it.data.product.tenant.id}}'})">添加下一个商品</a>
        </div>
    </div>

    <div class="main-base" data-for="product-model-panelForm" data-type="tabs">
        <form class="am-form am-form-horizontal" name="tenant" id="main-product-model-panel-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">
            <fieldset>
                <legend><b>{{=it.data.name}}</b> 的栏目列表（商品详情）</legend>
                <input type="hidden" name="id" value="{{=it.data.id}}">

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">名称</label>
                    <div class="am-u-sm-9">
                        <input name="name" type="text" placeholder="名称">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">介绍</label>
                    <div class="am-u-sm-9">
                        <textarea name="content" rows="5" placeholder="介绍"></textarea>
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="product-model-imageList" class="am-u-sm-3 am-form-label">图片（可以选择多张图片）</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-model-imageList" name="imageList" type="file" multiple
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                    </div>
                </div>
                <div class="am-form-group am-form-file">
                    <label for="product-model-media" class="am-u-sm-3 am-form-label">语音介绍</label>
                    <div class="am-u-sm-9">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="product-model-media" name="media" type="file" multiple
                               onchange="PubSub.publish('{{=it.name}}'+'.imageView',this)">
                    </div>
                    <div class="file-list am-u-sm-9">
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-offset-3 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('productModel.render','{{=it.data.id}}')">< 上一步</a>
                        <a onclick="PubSub.publish('tenantPanel.submit','{{=it.template}}-form')"
                           class="am-btn am-btn-primary am-btn-lg">添加</a>
                        <a class="am-btn am-btn-primary am-btn-lg"
                           onclick="PubSub.publish('{{=it.name}}.nextProductModel','{{=it.template}}-form')">去添加下一个商品规格</a>
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
    <tr id="{{it=imageText.id}}">
        <td>
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                       onclick="PubSub.publish('tenantPanel.deletePanel','{{=imageText.id}}')"><span
                            class="am-icon-trash-o"></span> 删除
                    </a>
                </div>
            </div>
        </td>
        <td class="am-hide-sm-only"><a href="" style="padding-right: 20px">{{=imageText.name}}</a>
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

<script type="text/x-dot-template" id="main-product-model-list">

    <div>
        <div class="am-u-lg-6">
            <legend>{{=it.productId}} 规格列表</legend>
        </div>
        <div class="am-u-lg-12" dot-template="main-product-model-list-body">
            {{
            PubSub.publish(it.name+".body");
            }}
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
                        <button onclick="PubSub.publish('productModel.render',{id:'{{=productModel.id}}'})"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 基本信息
                        </button>
                        <button onclick="PubSub.publish('productPanel.render','{{=productModel.id}}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 规格详情
                        </button>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                           href="/yuanqu/product/createQRCode.do?id={{=productModel.id}}"><span
                                class="am-icon-trash-o"></span> 生成二维码
                        </a>
                        <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除(暂时不支持)
                        </button>
                    </div>
                </div>
            </td>
            <td>{{=productModel.name}}</td>
            <td>{{=productModel.serial}}</td>
            <td>{{=productModel.price}}</td>
            <td>{{=productModel.marketPrice}}</td>
            <td>{{=productModel.amount}}</td>
            <td>
                {{=productModel.createDateTime}}
            </td>
        </tr>
        {{ } }}

        </tbody>
    </table>

</script>

<script type="text/x-dot-template" id="main-product-project-list">
    {{ if(typeof it =="undefined" || it == null && it.length <= 0){ }}
    <a onclick="">未找到相关技艺，点击提交数据补全请求</a>
    {{ }else{ }}
    <ul class="am-list  am-list-border" id="">
        {{ for(var i = 0 ; i < it.length; i++){ }}
        <li>
            <a onclick="PubSub.publish('productMaster.chooseProject','{{=it[i].id}}:{{=it[i].name}}')">{{=it[i].name}}</a>
        </li>
        {{ } }}
    </ul>
    {{ } }}
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

        this.render = function (msg, data) {
            renderTemplate(this.template, this);
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

    var ProductBase = function (param) {
        this.tenant = null;
        this.submit = "/yuanqu/product/baseSubmit";
        this.label = "商品信息";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productBase";
        this.template = "main-product-base";         //组件绑定的模板//组件需要订阅的事件与消息

        this.render = function (msg, data) {
            this.tenant = null;
            ajaxRequest("/yuanqu/tenant/getUserTenants", {}, function (responseData) {
                this.data = responseData;
                renderTemplate(this.template, this);
            }.bind(this))
            this.show();
        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish("productList.render", data.tenant.id);
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
                    PubSub.publish("productMaster.render", data.id);
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
                    if ((/audio\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
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
            {message: this.name + ".submitAndNext", subscriber: this.submitAndNext}
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
        };

        this.chooseProject = function (msg, data) {
            var id = data.split(":")[0];
            var fullName = data.split(":")[1];
            $("#product-projectId").val(id);
            $("#project-search").val(fullName)
        };

        this.search = function (msg, data) {
            var success = function (responseData) {
                renderTemplate(this.masterList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/tenant/getTenantMasterList", {name: $(data).val()}, success);
        };
        this.projectSearch = function (msg, data) {
            var success = function (responseData) {
                renderTemplate(this.projectList, responseData);
            }.bind(this);
            ajaxRequest("/yuanqu/product/getProjectList", {name: $(data).val()}, success);
        };

        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish('productPanel.render', {
                        id: this.data.id
                    });
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
            {message: this.name + ".projectSearch", subscriber: this.projectSearch}
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
        this.product = null;

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null && typeof data.id != "undefined") {
                ajaxRequest("/yuanqu/product/getProductModelById", {id: data.id}, function (responseData) {
                    this.data = responseData;
                    this.product = this.data.product.id;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else if (typeof data != "undefined" && data != null) {
                this.product = data.productId;
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
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish("productModelPanel.render", data.id);
                    //@TODO
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
                    if ((/audio\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
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

    var ProductList = function (param) {
        this.currentSearch = null;
        this.tenantId = null;
        this.tenantName = null;
        this.index = 1;
        this.size = 10;
        this.label = "商品管理";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productList";
        this.template = "main-product-list";         //组件绑定的模板//组件需要订阅的事件与消息

        this.nextPage = function (msg, data) {
            this.index = this.index + 1;
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
            if (this.currentSearch != null) {
                param.name = this.currentSearch
            }
            if (this.tenantId != null) {
                param.tenantId = this.tenantId;
            }
            ajaxRequest("/yuanqu/product/getProductList", param, function (responseData) {
                this.data = responseData;
                renderTemplate(this.template + "-body", responseData);
            }.bind(this));
        };

        this.render = function (msg, data) {
            this.index = 1;
            ajaxRequest("/yuanqu/tenant/getUserTenants", {}, function (responseData) {
                this.tenantId = responseData.id;
                this.tenantName=responseData.name;
            }.bind(this));
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

        this.body = function (msg, data) {
            //@TODO 搜索列表与商品实体
            var param = {};
            if (this.productId != null) {
                param.productId = this.productId;
            }
            ajaxRequest("/yuanqu/product/getProductModelList", param, function (responseData) {
                this.data = responseData;
                renderTemplate(this.template + "-body", responseData);
            }.bind(this));
        };

        this.render = function (msg, data) {
            this.index = 1;
            this.productId = data;
            renderTemplate(this.template, this);
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

        this.subscribeArray = [
            {message: this.name + ".show", subscriber: this.show},
            {message: this.name + ".hide", subscriber: this.hide},
            {message: this.name + ".render", subscriber: this.render},
            {message: this.name + ".remove", subscriber: this.remove},
            {message: this.name + ".body", subscriber: this.body}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

    };

    var ProductModelPanel = function (param) {
        this.submit = "/yuanqu/product/panelSubmit";
        this.label = "店内实景";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "productModelPanel";
        this.template = "main-product-model-panel";         //组件绑定的模板//组件需要订阅的事件与消息
        this.panelListTemplate = "main-product-model-panel-list";

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/product/getProductModelById", {id: data}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else {
                renderTemplate(this.template, this);
            }
            this.show();

        };


        this.deletePanel = function (msg, data) {
            var success = function (responseData) {
                $("#" + responseData).remove();
            };
            ajaxRequest("/yuanqu/product/deletePanel", {id: data}, success);
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
            ajaxRequest("/yuanqu/product/getPanelListByProductModel", {id: this.data.id}, function (responseData) {
                renderTemplate(this.panelListTemplate, responseData);
            }.bind(this));
        };


        this.submitForm = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (responseData) {
                $("[data=product-model-panelList]").click();
                document.getElementById(data).reset();
                $("#my-modal-loading").modal("close");
            });
            return false;
        };

        this.nextProductModel = function (msg, data) {
            $("#my-modal-loading").modal();
            $("#" + data).ajaxSubmit(function (responseData) {
                PubSub.publish("productModel.render", {productId: this.data.product.id})
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
                    if ((/audio\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
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
            {message: this.name + ".deletePanel", subscriber: this.deletePanel},
            {message: this.name + ".nextProductModel", subscriber: this.nextProductModel}
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

        this.render = function (msg, data) {
            if (typeof data != "undefined" && data != null) {
                ajaxRequest("/yuanqu/product/getProductById", {id: data.id}, function (responseData) {
                    this.data = responseData;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else {
                renderTemplate(this.template, this);
            }
            this.show();

        };

        this.deletePanel = function (msg, data) {
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
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish('productModel.render', {
                        productId: this.data.id
                    });
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
                    if ((/audio\/\w+/.test(images[i].type))) {
                        reader.onload = function (e) {
                            var urlData = this.result;
                            $(data).parent().parent().find(".file-list").append("<audio src=\"" + urlData + "\" width=\"500\"  controls=\"controls\"/>")
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
            {message: this.name + ".deletePanel", subscriber: this.deletePanel},
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
    var productBase = new ProductBase();    //商品基本信息
    var productMaster = new ProductMaster();//商品大师信息
    var productModel = new ProductModel();  //商品规格信息
    var productModelPanel = new ProductModelPanel();  //商品规格详情
    var productPanel = new ProductPanel();//商品详情
    var productList = new ProductList();    //商品列表
    var productModelList = new ProductModelList();  //商品规格列表
    var menu = new Menu();

</script>

</body>
</html>
