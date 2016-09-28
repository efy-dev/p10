function renderHeader(it /**/) {
    var out = ' <a href="javascript:history.go(-1)" class="angle left" title="返回上一页"></a> <h1 class="text_hidden">' + (it.title) + '</h1><a class="icon user" title="个人中心"></a> <div class="layer"><a class="link" href="/"><i class="icon icon-home"></i>首页</a><a class="link" href="http://i.efeiyi.com/"><i class="icon icon-center"></i>个人中心</a><i class="angle"></i></div>';
    return out;
}

function renderHomeHeader(it /**/) {
    var out = ' <a href="http://www.efeiyi.com/app/index.html" class="icon logo" title="前门 华韵"></a> <a class="icon user" title="个人中心"></a> <div class="layer"> <a class="link" href="/"><i class="icon icon-home"></i>首页</a> <a class="link" href="http://i.efeiyi.com/"><i class="icon icon-center"></i>个人中心</a> <i class="angle"></i> </div>';
    return out;
}