<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>大师详情页作品</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="assets/i/favicon.png">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
</head>
<body style="float: left;">
<div class="ae master-text">
  <div class="great-master">
    <div class="master-pic"><img src="http://tenant.efeiyi.com/${object.favicon}@!master-favicon-view" alt="传承人" class="am-img-thumbnail am-circle">
    </div>
    <h5>${object.fullName}</h5>
    <c:if test="${!empty object.projectName}">
      <p>[${object.projectName}]</p>
    </c:if>
    <div class="great"><em><ming800:status name='level' dataType='Tenant.level' checkedValue='${object.level}' type='normal'/>非物质文化遗产传承人</em><i class="icon-master"></i></div>
    <p class="text-great">${object.brief}</p>
    <div class="gz-master">
      <div class="mst-gz">
        <div class="pc-gz">
          <div class="bt-gz">
            <a class="btn-guan" onclick="followMaster(this,'${object.id}');">
              <div class="gz-q">
                <c:if test="${object.followStatus == '已关注'}">
                  <i class="gz-icon" style="display: none;"></i>
                </c:if>
                <c:if test="${object.followStatus == '关注'}">
                  <i class="gz-icon"></i>
                </c:if>
                <em>${object.followStatus}</em>
              </div>
            </a>
          </div>
        </div>
        <div class="mst-text"><span>${object.fsAmount}粉丝</span></div>
      </div>
    </div>
  </div>
  <div class="great-nav">
    <div class="nav-bars ae">
      <ul class="bars">
        <li><a href="<c:url value='/masterMessage/masterView/'/>${object.id}">主&nbsp;页</a></li>
        <li><a href="<c:url value='/masterMessage/introView/'/>${object.id}">介&nbsp;绍</a></li>
        <li class="active"><a href="<c:url value='/masterMessage/getPartWorks/'/>${object.id}">作&nbsp;品</a></li>
      </ul>
    </div>
  </div>
  <div class="craft-max">
    <div class="craft-work3 ae" style="display: block">
      <div class="river ae wait_photo" id="waterfall">
        <ul class="ae" id="pubu">

        </ul>
      </div>
    </div>
  </div>
</div>
</div>
<!-- //End--footer-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/pc/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/pc/js/system.js'/>"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="<c:url value='/scripts/assets/pc/js/cyclopedia.js'/>"></script>

<script>
  $(document).ready(function(){
    $("#pages").html("作品 - ${object.fullName} - e飞蚁");
  })
  function followMaster(o , masterId){
    var str;
    $.ajax({
      type: "post",//设置get请求方式
      url: "<c:url value='/masterMessage/followMaster.do'/>" ,//设置请求的脚本地址
      data: "masterId="+masterId,//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        var next = $(o).parent().parent().next().find("span");
        var fsAmount = parseInt($(o).parent().parent().next().find("span").html().split("粉")[0]);
        if(data == "noRole"){
          alert("您还未登录,请登录后操作!");
        }else if(data=="add"){
          str = "已关注";
          $(o).find("em").html(str);
          $(o).find(".gz-icon").hide();
          next.html((fsAmount + 1)+"粉丝");
        }else if(data=="del"){
          str = "关注";
          $(o).find("em").html(str);
          $(o).find(".gz-icon").show();
          next.html((fsAmount - 1)+"粉丝");
        }
      }
    })
  }
  var StartNum = 1;
  var ajaxkey = true;
  function praiseWork(o , workId){
    $.ajax({
      type: "get",//设置get请求方式
      url: "<c:url value='/masterMessage/praiseWork/'/>"+workId,//设置请求的脚本地址
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        var prevNode = $(o).parent().parent().prev().find("span");
        var amount = parseInt(prevNode.html());
        var num = parseInt($(o).find("span").html());
        if(data == "noRole"){
          alert("您还未登录,请登录后操作!");
        }else if(data == "add"){
          $(o).find("span").html(num + 1);
          prevNode.html(amount + 1);
        }else if(data == "del"){
          $(o).find("span").html(num - 1);
          prevNode.html(amount - 1);
        }
      }
    })
  }
  function storeWork(o,workId){
    $.ajax({
      type: "get",//设置get请求方式
      url: "<c:url value='/masterMessage/storeWork/'/>"+workId,//设置请求的脚本地址
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        if(data == "noRole"){
          alert("您还未登录,请登录后操作!");
        }else if(data == "add"){
          alert("收藏成功");
        }else if(data == "del"){
          alert("已取消收藏");
        }
      }
    })
  }
</script>
<SCRIPT>
  (function($){
    var
    //参数
            setting={
              column_width:233,//列宽
              column_className:'waterfall_column',//列的类名
              column_space:10,//列间距
              cell_selector:'.cell',//要排列的砖块的选择器，context为整个外部容器
              img_selector:'img',//要加载的图片的选择器
              auto_imgHeight:true,//是否需要自动计算图片的高度
              fadein:true,//是否渐显载入
              fadein_speed:600,//渐显速率，单位毫秒
              insert_type:1, //单元格插入方式，1为插入最短那列，2为按序轮流插入
              getResource:function(index){ }  //获取动态资源函数,必须返回一个砖块元素集合,传入参数为加载的次数
            },
            waterfall=$.waterfall={},//对外信息对象
            $waterfall=null;//容器
            waterfall.load_index=0, //加载次数
            $.fn.extend({
              waterfall:function(opt){
                opt=opt||{};
                setting=$.extend(setting,opt);
                $waterfall=waterfall.$waterfall=$(this);
                waterfall.$columns=creatColumn();
                render($(this).find(setting.cell_selector).detach(),false); //重排已存在元素时强制不渐显
                waterfall._scrollTimer2=null;
                $(window).bind('scroll',function(){
                  clearTimeout(waterfall._scrollTimer2);
                  waterfall._scrollTimer2=setTimeout(onScroll,300);
                });
                waterfall._scrollTimer3=null;
                $(window).bind('resize',function(){
                  clearTimeout(waterfall._scrollTimer3);
                  waterfall._scrollTimer3=setTimeout(onResize,300);
                });
                if( waterfall.load_index==0){
                  render(getElements(),true);
                }
              }
            });
    function creatColumn(){//创建列
      waterfall.column_num=calculateColumns();//列数
      //循环创建列
      var html='';
      for(var i=0;i<waterfall.column_num;i++){
        html+='<div class="'+setting.column_className+'" style="width:'+setting.column_width+'px; display:inline-block; *display:inline;zoom:1; margin-left:'+setting.column_space/2+'px;margin-right:'+setting.column_space/2+'px; vertical-align:top; overflow:hidden"></div>';
      }
      $waterfall.prepend(html);//插入列
      return $('.'+setting.column_className,$waterfall);//列集合
    }
    function calculateColumns(){//计算需要的列数
      var num=Math.floor(($waterfall.innerWidth())/(setting.column_width+setting.column_space));
      if(num<1){ num=1; } //保证至少有一列
      return num;
    }
    function render(elements,fadein){//渲染元素
      if(!$(elements).length) return;//没有元素
      var $columns = waterfall.$columns;
      $(elements).each(function(i){
        if(!setting.auto_imgHeight||setting.insert_type==2){//如果给出了图片高度，或者是按顺序插入，则不必等图片加载完就能计算列的高度了
          if(setting.insert_type==1){
            insert($(elements).eq(i),setting.fadein&&fadein);//插入元素
          }else if(setting.insert_type==2){
            insert2($(elements).eq(i),i,setting.fadein&&fadein);//插入元素
          }
          return true;//continue
        }
        if($(this)[0].nodeName.toLowerCase()=='img'||$(this).find(setting.img_selector).length>0){//本身是图片或含有图片
          var image=new Image;
          var src=$(this)[0].nodeName.toLowerCase()=='img'?$(this).attr('src'):$(this).find(setting.img_selector).attr('src');
          image.onload=function(){//图片加载后才能自动计算出尺寸
            image.onreadystatechange=null;
            if(setting.insert_type==1){
              insert($(elements).eq(i),setting.fadein&&fadein);//插入元素
            }else if(setting.insert_type==2){
              insert2($(elements).eq(i),i,setting.fadein&&fadein);//插入元素
            }
            image=null;
          }
          image.onreadystatechange=function(){//处理IE等浏览器的缓存问题：图片缓存后不会再触发onload事件
            if(image.readyState == "complete"){
              image.onload=null;
              if(setting.insert_type==1){
                insert($(elements).eq(i),setting.fadein&&fadein);//插入元素
              }else if(setting.insert_type==2){
                insert2($(elements).eq(i),i,setting.fadein&&fadein);//插入元素
              }
              image=null;
            }
          }
          image.src=src;
        }else{//不用考虑图片加载
          if(setting.insert_type==1){
            insert($(elements).eq(i),setting.fadein&&fadein);//插入元素
          }else if(setting.insert_type==2){
            insert2($(elements).eq(i),i,setting.fadein&&fadein);//插入元素
          }
        }
      });
    }
    function public_render(elems){//ajax得到元素的渲染接口
      render(elems,true);
    }
    function insert($element,fadein){//把元素插入最短列
      if(fadein){//渐显
        $element.css('opacity',0).appendTo(waterfall.$columns.eq(calculateLowest())).fadeTo(setting.fadein_speed,1);
      }else{//不渐显
        $element.appendTo(waterfall.$columns.eq(calculateLowest()));
      }
    }
    function insert2($element,i,fadein){//按序轮流插入元素
      if(fadein){//渐显
        $element.css('opacity',0).appendTo(waterfall.$columns.eq(i%waterfall.column_num)).fadeTo(setting.fadein_speed,1);
      }else{//不渐显
        $element.appendTo(waterfall.$columns.eq(i%waterfall.column_num));
      }
    }
    function calculateLowest(){//计算最短的那列的索引
      var min=waterfall.$columns.eq(0).outerHeight(),min_key=0;
      waterfall.$columns.each(function(i){
        if($(this).outerHeight()<min){
          min=$(this).outerHeight();
          min_key=i;
        }
      });
      return min_key;
    }
    function getElements(){//获取资源
      $.waterfall.load_index++;
      return setting.getResource($.waterfall.load_index,public_render);
    }
    waterfall._scrollTimer=null;//延迟滚动加载计时器
    function onScroll(){//滚动加载
      clearTimeout(waterfall._scrollTimer);
      waterfall._scrollTimer=setTimeout(function(){
        var $lowest_column=waterfall.$columns.eq(calculateLowest());//最短列
        var bottom=$lowest_column.offset().top+$lowest_column.outerHeight();//最短列底部距离浏览器窗口顶部的距离
        var scrollTop=document.documentElement.scrollTop||document.body.scrollTop||0;//滚动条距离
        var windowHeight=document.documentElement.clientHeight||document.body.clientHeight||0;//窗口高度
        if(scrollTop>=bottom-windowHeight){
          render(getElements(),true);
        }
      },100);
    }
    function onResize(){//窗口缩放时重新排列
      if(calculateColumns()==waterfall.column_num) return; //列数未改变，不需要重排
      var $cells=waterfall.$waterfall.find(setting.cell_selector);
      waterfall.$columns.remove();
      waterfall.$columns=creatColumn();
      render($cells,false); //重排已有元素时强制不渐显
    }
  })(jQuery);
</SCRIPT>
<SCRIPT>
  var html='';
  var opt={
    getResource:function(index,render){
      //index为已加载次数,render为渲染接口函数,接受一个dom集合或jquery对象作为参数。通过ajax等异步方法得到的数据可以传入该接口进行渲染，如 render(elem)
      if(index>=7) index=index%7+1;
      html=''
      if(ajaxkey){
        var flag = false;
        $.ajax({
          type:"get",//设置get请求方式
          url:"<c:url value='/masterMessage/getWorks/plistMasterWork_part/${object.id}/4/'/>"+StartNum,//设置请求的脚本地址
          data:"",//设置请求的数据
          async:false,

          dataType:"json",//设置请求返回的数据格式
          success:function(data){
            if(data != null && data.length > 0) {
              for(var i in data){
                html += "<li class=\"cell craft-page\">"+
                      "                    <a href=\"<c:url value='/masterMessage/getWorkDetails/'/>"+data[i].id+"\"><img src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+data[i].favicon+"\"></a>"+
                      "                    <h4 class=\"ae\">"+data[i].projectName+"</h4>"+
                      "                    <div class=\"function-page ae\">"+
                      "                        <div class=\"d-left\">"+
                      "                                <i class=\"h-i-con\"></i>"+
                      "                                <span>"+data[i].amount+"</span>"+
                      "                        </div>"+
                      "                        <div class=\"d-right\">"+
                      "                            <div class=\"right1\">"+
                      "                                <a onclick=\"praiseWork(this,'"+data[i].id+"');\">"+
                      "                                    <i class=\"h-i-con2\"></i>"+
                      "                                    <span>"+data[i].praiseNum+"</span>"+
                      "                                </a>"+
                      "                            </div>"+
                      "                            <div class=\"right2\">"+
                      "                                <a onclick=\"storeWork(this,'"+data[i].id+"');\">"+
                      "                                    <i class=\"h-i-con3\"></i>"+
                      "                                </a>"+
                      "                            </div>"+
                      "                        </div>"+
                      "                    </div>"+
                      "                </li>";
              }
            }else{
              flag = true;
            }
            StartNum=StartNum+1;
          },
          error:function(){
            alert("出错了，请联系管理员！！！");
            return false;
          },
          complete:function(){
            if(flag==true) {
              ajaxkey = false;
            }
          }
        })

      }
      return $(html);
    },
    auto_imgHeight:true,
    insert_type:1
  }
  $('#waterfall').waterfall(opt);

</SCRIPT>
</body>
</html>