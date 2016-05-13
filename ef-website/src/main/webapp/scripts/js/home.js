$(function(){
	//大首页
	(function(){
	if($('div').hasClass('home')){
        var home=$('.home');
        home.find('.close').click(function(){
            $(this).parent('.clinks').slideUp(100);
            return false;
        });
        home.find('.imgbg').hover(function(){
            $(this).animate({'opacity':'0.6'},200)
        },function () {
            $(this).animate({'opacity':'1'},200)
        })
    }
	})();

	//轮播图
	(function(){
		  //获取节点
        var prev = $(".m-box .m-txt  .prev"),//左按钮
              next = $(".m-box .m-txt  .next"),//右按钮
              anime = $(".home .m-box .m-animate ul"),//动画选项
              an_li   = anime.find("li"),
              anime_l = $(".home .m-box .m-animate ul li").length,
              anime_w = $(".home .m-box .m-animate ul li").width(),
              anime_max = anime_l*anime_w,//动画层的宽度
              speed =  400,//速度
              t_index = 0,//序号
              times = null;
              //
              $(".home .m-box").bind({
                    mouseenter:function(){
                         clearInterval(times)
                     },
                     mouseleave:function(){
                        times = setInterval(aotoplay,5000)
                     }
              })
              //初始化
             Initialize ()
             times = setInterval(aotoplay,5000)
              //右点击
              next.click(function(){
                anime.stop().animate({
                        left:-anime_w
                },speed,function(){
                    anime.css('left','0px');
                    anime.append($(".home .m-box .m-animate ul li:first"));
                    //复制图片上数据
                    $(".home .m-box .m-top .m-content h5").html($(this).find("li img").attr("date-h"));
                    $(".home .m-box .m-top .m-content p").html($(this).find("li img").attr("date-txt"));
                    $(".home .m-box .m-txt .m-page span").html($(this).find("li").attr("date-id"))
                })
              })
              //左点击
              prev.click(function(){
               anime.prepend($(".home .m-box .m-animate ul li:last"));
               anime.css("left",-anime_w).stop().animate({left:0},speed,function(){
                    $(".home .m-box .m-top .m-content h5").html($(this).find("li img").attr("date-h"));
                    $(".home .m-box .m-top .m-content p").html($(this).find("li img").attr("date-txt"));
                    $(".home .m-box .m-txt .m-page span").html($(this).find("li").attr("date-id"))
               });
              })
              //序号  
               function Initialize(){
                //给动画层设置宽
                  anime.css({
                                    width:anime_max
                                    })
                 //给每个li设置序号 
                   for(var i = 0;i<anime_l;i++){
                                an_li[i].setAttribute("date-id",i+1)
                          }
                 //设置总序号         
                  $(".home .m-box .m-txt .m-page strong").html(anime_l);
                  $(".home .m-box .m-txt .m-page span").html(an_li.attr("date-id"));
                 }
             //自动
               function aotoplay(){
                        anime.animate({
                                 left:-anime_w
                                },speed,function(){
                                anime.css('left','0px');
                                anime.append($(".home .m-box .m-animate ul li:first"));
                                $(".home .m-box .m-top .m-content h5").html($(this).find("li img").attr("date-h"));
                                $(".home .m-box .m-top .m-content p").html($(this).find("li img").attr("date-txt"));
                                $(".home .m-box .m-txt .m-page span").html($(this).find("li").attr("date-id"))
                        })
                }
	})();
    //新闻列表
    (function(){
      //自动高度
      $(".home .news .west-pic .w-list span.works").css({
        height:"auto",
        lineHeight:18+"px"
      })
    })()
})