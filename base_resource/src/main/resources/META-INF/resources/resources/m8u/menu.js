/**
 * Created by Administrator on 2015/7/9.
 */
var olditem = null;
function onmenuitem(obj) {
    if (olditem == null) {
        olditem = document.getElementById("menuitemstart");
    }
    olditem.className = "menuitem_";
    obj.className = "menuitem";
    if (obj.index >= 2) {
        obj.style.borderBottom = "1px solid #FFFFFF";
    }
    olditem = obj;
}

function showIDialog(iDlg, sUrl) {
    if (iDlg === undefined) {
        window.top[1].top[1].iDlg.showDialog(sUrl);
    } else {
        iDlg.showDialog(sUrl);
    }
}

function doExit(url) {
    window.open(url, "_top");
}

function doIndex(url) {
    window.open(url, "_top");
}


function getSchoolMenu(jsonMenu) {
    var menuHtml = "<ul class='select'>";
    for (var i = 0; i < jsonMenu.length; i++) {
        menuHtml += "<li>";
        if (jsonMenu[i].text != "|") {
            if (jsonMenu[i].children != null) {
                if (jsonMenu[i].children.length > 0) {
                    menuHtml += "<a class='sub_a'>" + jsonMenu[i].text + "</a>";
                    var childrenMenu = jsonMenu[i].children;
                    var selectSub = "<ul class='select_sub'>";
                    for (var j = 0; j < childrenMenu.length; j++) {
                        selectSub += "<li><a class='select_a' href=javascript:getLeftMenu('" + childrenMenu[j].attributes.url + "')>" + childrenMenu[j].text + "</a></li>";
                    }
                    selectSub += "</ul>";
                    menuHtml += selectSub;
                }
            } else {
                menuHtml += "<a class='select_a' href=javascript:getLeftMenu('" + jsonMenu[i].attributes.url + "');>" + jsonMenu[i].text + "</a>";
            }
        } else {
            menuHtml += "<span class=delimiter>" + jsonMenu[i].text + "</span>";
        }
        menuHtml += "</li>";
    }
    menuHtml += "</ul>";
    document.getElementById('nav').innerHTML = menuHtml;

    $(function () {
        $(".sub_a").parent("li").each(function () {
            $(this).hover(function () {
                var LI_WIDTH = 64;     //li的宽度
                var left = $(this).position().left;
                var width = ($(".select_sub li").size() - 1) * LI_WIDTH;
                $(".select_sub").css({"left": left - width, "width": $(".select_sub li").size() * LI_WIDTH}).show();
            }, function () {
                $(".select_sub").hide();
            })
        })
    })
}

function getLeftMenu(menuId) {
    var url = m8u.projectName() + '/getMenu.do';
    jQuery.ajax({
        type: 'GET',
        contentType: 'application/json',
        url: url,
        cache: false,
        data: {menuId: menuId},
        dataType: 'json',
        success: function (data) {
            var jsonData = eval('(' + data + ')');
            //加载左侧的菜单树
            $('#JMenu').tree({
                data: jsonData,
                onClick: function (node) {
                    if (node.attributes.url != '') {
                        $("#centerPanel").attr("src", m8u.projectName() + node.attributes.url);
                    } else {
                        $(this).tree('toggle', node.target);
                    }
                }
            });

            //默认打开第一个节点的链接 如果第一个链接是文件夹 则打开该文件夹下的第一个链接
            if (jsonData[0].attributes.url != '') {
                var node = $('#JMenu').tree('find', jsonData[0].id);
                $('#JMenu').tree('select', node.target);
                $("#centerPanel").attr("src", m8u.projectName() + jsonData[0].attributes.url);
            } else {
                var node = $('#JMenu').tree('find', jsonData[0].children[0].id);
                $('#JMenu').tree('select', node.target);
                $("#centerPanel").attr("src", m8u.projectName() + jsonData[0].children[0].attributes.url);
            }
        },
        error: function (XMLHttpRequest) {
//            if(XMLHttpRequest.status==500){
            location.reload();  //处理session过期 点击头菜单报错的问题
        }
    });
}

function schoolMenuInit() {
    var elemId = document.getElementById('nav');
    var links = elemId.getElementsByTagName("a");
    links[0].className = 'selected';

    $("#nav a:not(.sub_a)").bind("click", function () {
        selectChild(this);
    });
    $("#nav .select_sub a").bind("click", function () {
        selectParent(this);
    });
}

function selectChild(node) {
    node.blur();
    $("#nav a").removeClass("selected");
    $(node).addClass("selected");

}
function selectParent(node) {
    $("#nav a").removeClass("selected");
    $(node).parents(".select_sub").prev(".sub_a").addClass("selected");
}


function branchOrder(url) {
    $("#centerPanel").attr("src", url);
}