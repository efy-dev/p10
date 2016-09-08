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
            z-index: 99999;
        }

    </style>
</head>
<body>
<div class="am-g">
    <%--表单页页面是一个流程控制页面，编辑或者新建商铺的时候--%>
    <%--1.店铺信息--%>
    <%--（1）.基本信息--%>
    <%--（2）.验证审核信息--%>
    <%--（3）.添加对应的大师（选填）--%>
    <%--2.店铺内部实景（选填）--%>
    <%--3.商品信息（选填）--%>

    <%--如果是新建店铺，加载页面的时候就是直接进入流程，从第一步开始逐步添加信息--%>
    <%--如果是编辑店铺，加载页面的时候就是显示店铺的详细信息，以及编辑按钮--%>

    <%--页面中包含一个流程，而且流程中的各个节点又是独立存在的，每个几点的视图层使用dot模板来拆分，每个模板，就相当于一个流程节点，然后每个模板又是可以单独去渲染的（通过controller中的方法）--%>

    <%--把流程统一一下就是下边的结果--%>

    <%--第一步：店铺基本信息--%>
    <%--第二部：店铺的审核认证信息--%>
    <%--第三部：关联店铺大师--%>
    <%--第四部：添加店内实景--%>
    <%--第五部：添加店铺的商品信息--%>


    <%-----------------------------nav-----------------------------%>
    <div dot-template="main-nav">
        <%--<ol class="am-breadcrumb main-nav">--%>
        <%--<li><a href="#">园区管理</a></li>--%>
        <%--<li><a href="#">新的店铺</a></li>--%>
        <%--<li class="am-active">基本信息</li>--%>
        <%--</ol>--%>
    </div>


    <%----------------------------menu-----------------------------%>


    <div dot-template="main-menu">
        <%--<div class="main-menu">--%>
        <%--<button type="button" class="am-btn am-btn-primary "><span>新店铺</span></button>--%>
        <%--<button type="button" class="am-btn am-btn-primary "><span>店铺列表</span></button>--%>
        <%--<button type="button" class="am-btn am-btn-primary "><span>新景区</span></button>--%>
        <%--<button type="button" class="am-btn am-btn-primary "><span>景区列表</span></button>--%>
        <%--<button type="button" class="am-btn am-btn-primary "><span>新推荐</span></button>--%>
        <%--<button type="button" class="am-btn am-btn-primary "><span>推荐列表</span></button>--%>
        <%--<button type="button" class="am-btn am-btn-primary "><span>所有图片</span></button>--%>
        <%--</div>--%>
    </div>

    <div dot-template="main-tenant-base">

    </div>

    <%---------------------------content--------------------------------%>

    <div class="tenant-progress">
        <legend class="title">总体进度</legend>
        <div class="am-progress">
            <div class="am-progress-bar am-progress-bar-success" style="width: 20%">基本信息</div>
            <div class="am-progress-bar am-progress-bar-danger" style="width: 20%">审核认证</div>
            <div class="am-progress-bar am-progress-bar-danger" style="width: 20%">关联大师</div>
            <div class="am-progress-bar am-progress-bar-danger" style="width: 20%">添加店内实景</div>
            <div class="am-progress-bar am-progress-bar-danger" style="width: 20%">添加商品</div>
        </div>
    </div>


</div>

<script src="/scripts/yuanqu/js/jquery.form.js"></script>
<script src="/scripts/yuanqu/js/doT.min.js"></script>
<script src="/scripts/yuanqu/js/pubsub.js"></script>
<script src="/scripts/yuanqu/js/util.js"></script>

<script type="text/x-dot-template" id="main-nav">
    <ol class="am-breadcrumb main-nav">
        {{ if(it.currentComponent.hierarchy== 0){ }}
        <li><a>园区管理</a></li>
        {{ } else{ }}
        <li><a onclick="PubSub.publish('menu.render')">园区管理</a></li>
        {{ } }}
        {{
        if(typeof it.currentComponent != "undefined" && it.currentComponent!=null){
        if (it.currentComponent.hierarchy== 1){
        }}
        <li><a class="am-active" href="#">{{=it.currentComponent.label}}</a></li>
        {{ } else if (it.currentComponent.hierarchy == 2){ }}
        <li><a onclick="PubSub.publish('{{=it.currentComponent.father.name}}.render')">{{=it.currentComponent.father.label}}</a>
        </li>
        <li><a class="am-active" href="#">{{=it.currentComponent.label}}</a></li>
        {{ } }}
        {{ } }}
    </ol>
</script>

<script type="text/x-dot-template" id="main-menu">
    <div class="main-menu">
        <button type="button" class="am-btn am-btn-primary " onclick="PubSub.publish('menu.tenantBase')">
            <span>新店铺</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>店铺列表</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>新景区</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>景区列表</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>新推荐</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>推荐列表</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>所有图片</span></button>
    </div>
</script>

<script type="text/x-dot-template" id="main-tenant-base">
    <div class="main-tenant-base">
        <form class="am-form am-form-horizontal" name="tenant" id="main-tenant-base-form" action="{{=it.submit}}"
              enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend>店铺基本信息</legend>

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
                    <label for="latitude" class="am-u-sm-2 am-form-label">纬度</label>
                    <div class="am-u-sm-10">
                        <input name="latitude" type="text" id="latitude"
                               value="{{=it.data!=null ? it.data.latitude : ''}}" placeholder="输入实体店铺的纬度">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="longitude" class="am-u-sm-2 am-form-label">经度</label>
                    <div class="am-u-sm-10">
                        <input name="longitude" type="text" id="longitude"
                               value="{{=it.data!=null ? it.data.longitude : ''}}" placeholder="输入实体店铺的经度">
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
                        <input id="pictureUrl" name="pictureUrl" type="file" multiple
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
                        <input id="logoUrl" name="logoUrl" type="file" multiple
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
                        <input id="audio" name="audio" type="file" multiple
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
                        <button type="submit" class="am-btn am-btn-primary am-btn-lg">下一步 ></button>
                        <a class="am-btn am-btn-primary am-btn-lg" onclick="PubSub.publish('tenantCheck.render')">跳过</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</script>

<script>

    $().ready(function () {
        initPage();
    });

    function initPage() {
        var nav = new Nav();
        var menu = new Menu();
        menu.render();
    }

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
            $("[dot-template=" + this.template + "]").show("slow");
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").remove();
        };
        this.setCurrentComponent = function (msg, data) {
            if (this.currentComponent != null) {
                this.currentComponent.hide();
            }
            data.father = this.currentComponent
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
            PubSub.publish("nav.setCurrentComponent", this);
        };
        this.show = function (msg, data) {
            $("[dot-template=" + this.template + "]").show("slow");
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("[dot-template=" + this.template + "]").remove();
        };

        this.tenantBase = function (msg, data) {
            var tb = new TenantBase();
            tb.render();
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

    var TenantBase = function (param) {
        this.submit = "/yuanqu/baseSubmit";
        this.label = "店铺基本信息";
        this.data = null;
        this.father = null;
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "tenantBase";
        this.template = "main-tenant-base";         //组件绑定的模板//组件需要订阅的事件与消息

        this.render = function (msg, data) {
            if (typeof this.param != "undefined" && typeof this.param.id != "undefined" && this.param.id != null) {
                ajaxRequest("/yuanqu/getTenantById", {id: this.param.id}, function (data) {
                    this.data = data;
                    renderTemplate(this.template, this);
                }.bind(this))
            } else {
                renderTemplate(this.template, this);
            }
            this.show();
            PubSub.publish("nav.setCurrentComponent", this);
        };
        this.show = function (msg, data) {
            $("[dot-template=" + this.template + "]").show("slow");
        };
        this.hide = function (msg, data) {
            $("[dot-template=" + this.template + "]").hide();
        };
        this.remove = function (msg, data) {
            $("." + this.template).remove();
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
            {message: this.name + ".imageView", subscriber: this.imageView}
        ];

        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber.bind(this));
        }

        $('#main-tenant-base-form').ready(function () {
            $(this).ajaxForm(function (data) {
                if (typeof data.id != "undefined" && data.id != null) {
                    PubSub.publish("tenantCheck.render", data);
                }
            });
        });

    };

    function renderTemplate(templateId, data) {
        $("[dot-template=" + templateId + "]").html(doT.template($("#" + templateId).text())(data));
    }


</script>

</body>
</html>
