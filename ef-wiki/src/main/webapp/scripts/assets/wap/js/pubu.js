
$(window).load(function(){
    //getData("<c:url value='/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index='/>");
    PBL("#pubu","#box",2);
    //var ajaxkey = true;
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
        var pageH = $(document.body).height();
        var scrollT = $(window).scrollTop(); //滚动条top
        var aa = (pageH - winH - scrollT) / winH;
        //alert(aa)
        if(aa < 0.02){
           // if (getDataCheck() && ajaxkey) {
            //if (ajaxkey) {
                $("#wikiNav li").each(function(index,element){

                    if($(element).attr("class")=="item active"){

                        //if($(element).children().attr("href")=="[data-tab-panel-0]"){
                        if($(element).attr("id")=="0"){
                            if(ajaxkey1){
                                PBL("#pubu","#box",2);
                                getData1("/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index=");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数

                            }

                        }
                        if($(element).attr("id")=="1"){
                            var flag = $("#flag").val();
                            //alert(flag)
                            if(ajaxkey && flag=="front"){
                                PBL("#recommends","#recommend",2);
                                getData("/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index=");
                            }
                            if(ajaxkey2 && flag=="back"){
                                PBL("#after","#attention",2);
                                getData4("/base/afterAttention.do?conditions=&pageEntity.size=10&pageEntity.index=");
                            }
                        }
                        if($(element).attr("id")=="2"){

                        }
                    }

                });
               // getData("/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index=");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数

           // };

        }


    });




});

function saveProjectFllow(projectId){
    /*if(AuthorizationUtil.getMyUser().getId() == null){
     alert("您还未登陆，请登录后再操作");
     return false;
     }*/
    $.ajax({
        type:"get",
        url:"/base/attention.do?projectId="+projectId+"oper=add",//设置请求的脚本地址
        data:"",
        dataType:"json",
        success:function(data){
           /* if(data==false){
                alert("您还未登陆，请登录后再操作");
                return false;
            }
          if(data==true){
              $("#"+projectId).html("已关注");
              return true;
          }
       */
            if(data=="false"){
                alert("您还未登陆，请登录后再操作");
                return false;
            }
            if(data=="true"){
                $("#"+projectId).html("取消关注");
                return true;
            }
            if(data=="del"){
                $("#"+projectId).html("关注");
                return true;
            }
            if(data=="error"){
                alert("未知错误，请联系管理员！！！");
                return false;
            }
        },
        error:function(){

            alert("出错了，请联系管理员！！！");
            return false;
        },
        complete:function(){

        }
    });
}

/************************************************* ↓ 函数 ↓ */
//瀑布流主函数
function PBL(outer,boxs,style){//outer父级元素、boxs子级元素，style加载样式（ 1或者2 ）
    var pubu = $(outer);
    var box = $(boxs);
    var num = Math.floor($(document.body).width()/box.outerWidth());//根据浏览器宽度获得显示的列的数量
    pubu.width(num*(box.outerWidth()));//给pubu的宽度赋值
    var allHeight = [];//定义一个数组存储所有列的高度
    for(var i=0;i<box.length;i++){
        if (i<num) {
            allHeight[i]=box.eq(i).outerHeight();
        }else{
            var minHeight = Math.min.apply({},allHeight);//获得所有的列中高度最小的列的高度
            var sy = getSy(minHeight,allHeight);//获取高度最小的列的索引
            getStyle(box.eq(i),minHeight,sy*box.eq(i).outerWidth(),i,style);
            allHeight[sy] += box.eq(i).outerHeight();
        }
    }
}
//获取高度最小的列的索引
function getSy(minH,allH){
    for(sy in allH){
        if(allH[sy]==minH) return sy;
    }
}

function checkIsAttention(projectId){
    isAttention = false;
    $.ajax({
        type:"get",
        url:"/base/Isattention.do?projectId="+projectId,
        data:"",
        async:false,
        dataType:"json",
        success:function(data){
            if(data==false){
                isAttention = false;
                return false;
            }
            if(data==true){
                isAttention=true;
                return true;
            }
        },
        error:function(){

            alert("出错了，请联系管理员！！！");
            return false;
        },
        complete:function(){

        }
    })

}





//请求数据的方法
function getData(url){
    var flag = false;
    $.ajax({
        type:"get",//设置get请求方式
        url:url+StartNum2,//设置请求的脚本地址
        data:"",//设置请求的数据
        dataType:"json",//设置请求返回的数据格式
        success:function(data){
            var pubu = $("#recommend");
            if(data.list && data.list != null){
            for(i in data.list){

                var projectid = data.list[i].project.id;
                var word ="关注";
                checkIsAttention(projectid);
                 if(isAttention==true){
                    word = "已关注";
                 }
                var box = $("<li> <div class='suit-list-bt'>" +
                    "<a href='#'><img src="+data.list[i].project.picture_url+"></a>" +
                    " <a class='gz-fd-icon' id='"+projectid+"' href='#' onclick='saveProjectFllow(\""+projectid+"\")'>" +
                    word +
                    "</a> </div> </li>");

                pubu.append(box);

            }

            }else{
                //alert("no data!!!");
                flag = true;
            }
            PBL("#recommends","#recommend",2);
            StartNum2=StartNum2+1;
        },
        error:function(){

            alert("出错了，请联系管理员！！！");
            return false;
		},
        complete:function(){
            if(flag==true)
            ajaxkey = false;
        }
    });


}

//请求数据的方法
function getData1(url){
    var flag = false;
    $.ajax({
        type:"get",//设置get请求方式
        url:url+StartNum,//设置请求的脚本地址
        data:"",//设置请求的数据
        dataType:"json",//设置请求返回的数据格式
        success:function(data){
            var pubu = $("#pubu");
            if(data.list && data.list != null){
                for(i in data.list){

                    var moods = data.list[i].project.fsAmount;
                    if(moods==null) moods=0;
                    var box = $("<ul class='hot' id='box'>" +
                        "<li><a href='#'><img src="+data.list[i].project.picture_url+"></a> " +
                        "<div class='hot-poge'> <span style='margin-right: 1rem'>人气</span> " +
                        "<span>"+moods+"</span> " +
                        "</div></li> </ul>");
                    pubu.append(box);
                }

            }else{
                //alert("no data!!!");
                flag = true;
            }
            PBL("#pubu","#box",2);
            StartNum=StartNum+1;
        },
        error:function(){

            alert("出错了，请联系管理员！！！");
            return false;
        },
        complete:function(){
            if(flag==true) {
                ajaxkey1 = false;}
        }
    })
}

//判断请求数据的开关
function getDataCheck(){
    var pubu = $("#pubu");
    var box = $("#box");
    var lastboxHeight = $(box[box.length-1]).offset().top+Math.floor($(box[box.length-1]).outerHeight()/2);
    var documentHeight = $(window).height();
    var scrollTop = $(document).scrollTop();
    return lastboxHeight<documentHeight+scrollTop?true:false;
}
//存储开始请求数据条数的位置
var getStartNum = 0;
var StartNum = 1;
var StartNum2 = 1;
var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
var ajaxkey1 = true;
var  isAttention = false;
//设置请求数据加载的样式
function getStyle(boxs,top,left,index,style){
    if (getStartNum>=index) {
        return;
    }
    boxs.css("position","absolute");
    switch(style){
        case 1:
            boxs.css({
                "top":top+$(window).height(),
                "left":left
            });
            boxs.stop().animate({
                "top":top,
                "left":left
            },999);
        break;
        case 2:
            boxs.css({
                "top":top,
                "left":left,
                "opacity":"0"
            });
            boxs.stop().animate({
                "opacity":"1"
            },999);
    }
    getStartNum = index;//更新请求数据的条数位置





}
var afterNum2=2;
var ajaxkey2=true;
//请求数据的方法
function getData4(url){
    var flag = false;
    $.ajax({
        type:"get",//设置get请求方式
        url:url+afterNum2,//设置请求的脚本地址
        data:"",//设置请求的数据
        dataType:"json",//设置请求返回的数据格式
        success:function(data){
            var pubu = $("#attention");

            if(data && data.length>=1){
                for(i in data){
                    for(var key in data[i]){
                        var box = $(" <li> <div class='suit-zt--2-img am-u-sm-5 am-u-end'>" +
                            " <a href='/base/brifProject.do?projectId="+data[i][key].project.id+"'><img src='"+data[i][key].project.picture_url+"'> " +
                            "<div class='tp-bg-0'> " +
                            "<table> <tr><td>" +
                            "<div style='padding: 0 1rem;'>"+data[i][key].project.name+"</div></td></tr> </table> " +
                            "</div></a> </div> <div class='suit-zt--2-text am-u-sm-7 am-u-end'> " +
                            "<h4>"+data[i][key].project.name+"详情更新了</h4> <p>" +
                            "<a href='#'> 增加相关作品"+key+"幅</a></p> </div> </li> </ul>");

                    }

                    pubu.append(box);

                }

            }else{
                flag = true;
            }
            PBL("#after","#attention",2);
            afterNum2=afterNum2+1;
        },
        error:function(){

            alert("出错了，请联系管理员！！！");
            return false;
        },
        complete:function(){
            if(flag==true) {
                ajaxkey2 = false;
            }
        }
    })
}