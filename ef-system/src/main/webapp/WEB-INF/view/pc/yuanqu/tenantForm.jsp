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

        .main-content {
            width: 700px;
            margin: 50px;
        }

        .main-progress {
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

    <ol class="am-breadcrumb main-nav">
        <li><a href="#">园区管理</a></li>
        <li><a href="#">新的店铺</a></li>
        <li class="am-active">基本信息</li>
    </ol>


    <%----------------------------menu-----------------------------%>


    <div class="main-menu">
        <button type="button" class="am-btn am-btn-primary "><span>新店铺</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>店铺列表</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>新景区</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>景区列表</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>新推荐</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>推荐列表</span></button>
        <button type="button" class="am-btn am-btn-primary "><span>所有图片</span></button>
    </div>


    <%---------------------------content--------------------------------%>

    <div class="main-progress">
        <legend class="title">总体进度</legend>
        <div class="am-progress">
            <div class="am-progress-bar am-progress-bar-success" style="width: 20%">基本信息</div>
            <div class="am-progress-bar am-progress-bar-danger" style="width: 20%">审核认证</div>
            <div class="am-progress-bar am-progress-bar-danger" style="width: 20%">关联大师</div>
            <div class="am-progress-bar am-progress-bar-danger" style="width: 20%">添加店内实景</div>
            <div class="am-progress-bar am-progress-bar-danger" style="width: 20%">添加商品</div>
        </div>
    </div>


    <div class="main-content">
        <form class="am-form am-form-horizontal" id="myForm" action="/yuanqu/submit" enctype="multipart/form-data"
              method="post">

            <fieldset>

                <legend>店铺基本信息</legend>

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-2 am-form-label">店铺名称</label>
                    <div class="am-u-sm-10">
                        <input name="name" type="text" id="name" placeholder="输入新店铺的名称">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="address" class="am-u-sm-2 am-form-label">店铺地址</label>
                    <div class="am-u-sm-10">
                        <input name="address" type="text" id="address" placeholder="输入实体店铺的地址">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="latitude" class="am-u-sm-2 am-form-label">纬度</label>
                    <div class="am-u-sm-10">
                        <input name="longitude" type="text" id="latitude" placeholder="输入实体店铺的纬度">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="longitude" class="am-u-sm-2 am-form-label">经度</label>
                    <div class="am-u-sm-10">
                        <input name="longitude" type="text" id="longitude" placeholder="输入实体店铺的经度">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="content" class="am-u-sm-2 am-form-label">简介</label>
                    <div class="am-u-sm-10">
                        <textarea class="" rows="5" id="content" name="content"></textarea>
                    </div>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="pictureUrl" class="am-u-sm-2 am-form-label">店铺主图</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="pictureUrl" name="pictureUrl" type="file" multiple>
                        <div class="file-list"></div>
                    </div>
                </div>

                <div class="am-form-group am-form-file">
                    <label for="logoUrl" class="am-u-sm-2 am-form-label">店铺Logo</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="logoUrl" name="logoUrl" type="file" multiple>
                        <div class="file-list"></div>
                    </div>
                </div>


                <div class="am-form-group am-form-file">
                    <label for="audio" class="am-u-sm-2 am-form-label">语音介绍</label>
                    <div class="am-u-sm-10">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            选择文件
                        </button>
                        <input id="audio" name="audio" type="file" multiple>
                        <div class="file-list"></div>
                    </div>
                </div>


                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2 am-btn-group">
                        <a class="am-btn am-btn-primary am-btn-lg">< 上一步</a>
                        <button type="submit" class="am-btn am-btn-primary am-btn-lg">下一步 ></button>
                        <a class="am-btn am-btn-primary am-btn-lg">跳过</a>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>

</div>

<script src="/scripts/yuanqu/js/jquery.form.js"></script>
<script src="/scripts/yuanqu/js/doT.min.js"></script>
<script src="/scripts/yuanqu/js/pubsub.js"></script>

<script>


    $('#myForm').ready(function () {
        $(this).ajaxForm(function (data) {
            if (typeof  submitFormSuccess == "function") {
                submitFormSuccess(this);
            }
            alert(JSON.stringify(data));
        });
    });


    var submitFormSuccess = function (form) {

    };

    //业务组件 页面以外，不可复用  通用组件可复用
    var XXXComponent = function (param) {
        this.hierarchy = 1;  //组件的层级（通用属性，每个组件都有）
        this.param = param;
        this.name = "XXX";
        this.template = "template";         //组件绑定的模板//组件需要订阅的事件与消息
        this.subscribeArray = [
            {message: "XXXComponent.action", subscriber: this.action},
            {message: "XXXComponent.show", subscriber: this.show},
            {message: "XXXComponent.hide", subscriber: this.hide},
            {message: "XXXComponent.render", subscriber: this.render}
        ];

        this.publishArray = [
            {message: "YYYComponent.action", data: this.param}
        ];

        this.render = function (msg, data) {
            //加载数据（ajax）
            //渲染模板（dot模板或者其他模板）
        };


        this.show = function (msg, data) {

        };

        this.hide = function (msg, data) {

        };

        this.action = function (msg, data) {
            //xxx消息要触发的事件
        };

        //订阅所有需要订阅的消息
        for (var i = 0; i < this.subscribeArray.length; i++) {
            var subscribe = this.subscribeArray[i];
            PubSub.subscribe(subscribe.message, subscribe.subscriber).bind(this);
        }

        //发布所有需要发布的消息
        for (var j = 0; j < this.publishArray.length; j++) {
            var publish = this.publishArray[j];
            PubSub.publish(publish.message, publish.data)
        }

    };

    function renderTemplate(templateId, data) {
        $("[dot-template=" + templateId + "]").html(doT.template($("#" + templateId).text())(data));
    }


</script>

</body>
</html>
