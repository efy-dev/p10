/**
 * 渲染头部
 * @param it 页面的请求参数
 * @returns {string}
 */
function renderHeader(it /**/) {
    var out = ' <a href="javascript:history.go(-1)" class="angle left" title="返回上一页"></a> <h1 class="text_hidden">' + (it.title) + '</h1><a class="icon user" title="个人中心"></a> <div class="layer"><a class="link" href="/"><i class="icon icon-home"></i>首页</a><a class="link" href="http://i.efeiyi.com/"><i class="icon icon-center"></i>个人中心</a><i class="angle"></i></div>';
    return out;
}

function renderHomeHeader(it /**/) {
    var out = ' <a href="http://www.efeiyi.com/app/index.html" class="icon logo" title="前门 华韵"></a> <a class="icon user" title="个人中心"></a> <div class="layer"> <a class="link" href="/"><i class="icon icon-home"></i>首页</a> <a class="link" href="http://i.efeiyi.com/"><i class="icon icon-center"></i>个人中心</a> <i class="angle"></i> </div>';
    return out;
}

$().ready(function () {
    initWx("http://www.efeiyi.com/wx/init.do")
});

var Audio = function (audioBoxId) {
    this.id = audioBoxId;
    this.box = $("#" + audioBoxId);
    this.body = this.box.find("[data-type=audio-body]");
    this.button = this.box.find("[data-type=audio-button]");
    this.icon = this.box.find("[data-type=audio-icon]");
    this.status = this.body.attr("autoplay");

    if (this.status == "autoplay") {
        this.button.unbind();
        this.button.on("click", function () {
            this.stop();
        }.bind(this));
    } else {
        this.button.unbind();
        this.button.on("click", function () {
            this.play();
        }.bind(this));
    }

    this.bodyPlay = function () {
        this.body[0].play();
        this.icon.addClass("active");
        this.button.unbind();
        this.button.on("click", function () {
            this.stop();
        }.bind(this))
    };

    this.bodyStop = function () {
        this.body[0].pause();
        this.icon.removeClass("active");
        this.button.unbind();
        this.button.on("click", function () {
            this.play();
        }.bind(this))
    };

    this.play = function () {
        PageVariable.setCurrentAudio(this);
    };

    this.stop = function () {
        PageVariable.removeCurrentAudio(this);
    };

}