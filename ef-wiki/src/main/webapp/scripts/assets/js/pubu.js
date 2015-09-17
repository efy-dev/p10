

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
//请求数据的方法
function getData(url){


    ajaxkey = false;
    $.ajax({
        type:"get",//设置get请求方式
        url:url+StartNum,//设置请求的脚本地址
        data:"",//设置请求的数据
        dataType:"json",//设置请求返回的数据格式
        success:function(data){
            var pubu = $("#pubu");
            if(data.list && data.list != null){
            for(i in data.list){
                var box = $("<div class='box'><div class='pic'><img src="+data.list[i].project.picture_url+"></div></div>");
                pubu.append(box);
            }
            }else{
                //alert("no data!!!");
                return false;
            }
            PBL("#pubu",".box",2);
            //StartNum=StartNum+1;
        },
        error:function(){
       /* var data2 = [{"src":"/scripts/assets/images/3.jpg"},{"src":"/scripts/assets/images/4.jpg"},{"src":"/scripts/assets/images/5.jpg"},{"src":"/scripts/assets/images/6.jpg"},{"src":"/scripts/assets/images/7.jpg"},{"src":"/scripts/assets/images/8.jpg"},{"src":"/scripts/assets/images/9.jpg"},{"src":"/scripts/assets/images/10.jpg"}];
		var pubu = $("#pubu");
		     if(data2){
                for(i in data2){
                 var box = $("<div class='box'><div class='pic'><img src="+data2[i].src+"></div></div>");
                  pubu.append(box);
                }
			 }else{
			    alert("no data!!!");
				return false;
			 }
            
            PBL("#pubu",".box",2);
		StartNum=StartNum+1;*/
            alert("出错了，请联系管理员！！！");
		},
        complete:function(){
            ajaxkey = true;
        }
    })
}
//判断请求数据的开关
function getDataCheck(){
    var pubu = $("#pubu");
    var box = $(".box");
    var lastboxHeight = $(box[box.length-1]).offset().top+Math.floor($(box[box.length-1]).outerHeight()/2);
    var documentHeight = $(window).height();
    var scrollTop = $(document).scrollTop();
    return lastboxHeight<documentHeight+scrollTop?true:false;
}
//存储开始请求数据条数的位置
var getStartNum = 0;
var StartNum = 1;
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