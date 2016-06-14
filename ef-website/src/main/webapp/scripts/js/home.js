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
                $(this).stop().animate({'opacity':'0.6'},200)
            },function () {
                $(this).stop().animate({'opacity':'1'},200)
            })
        }
    })();
    //轮播图
    /*    (function () {
     var slide=$('#slide2016'),
     imgLi=slide.find('.img').find('li'),
     numLi=slide.find('.num').find('li'),
     timer=null,
     index=0,
     iSpeed=3000,
     imgLigth = imgLi.length,
     prev = $(".prev"),
     next = $(".next");
     //鼠标滑过
     $("#slide2016").hover(function () {
     clearInterval(timer);
     $(".click").stop().animate({opacity:1},500)
     },function(){
     timer=setInterval(autoSlide,iSpeed)
     $(".click").stop().animate({opacity:0},500)
     });
     imgLi.eq(0).show();
     //自动播放
     timer=setInterval(autoSlide,iSpeed)
     //按下
     numLi.mousedown(function () {
     clearInterval(timer)
     index=$(this).index();
     imgLi.eq(index).stop(true).fadeIn().siblings('li').fadeOut();
     $(this).addClass('active').siblings('li').removeClass('active');
     });
     //
     numLi.mouseup(function () {
     timer=setInterval(autoSlide,iSpeed);
     index=$(this).index();
     imgLi.eq(index).fadeIn().siblings('li').fadeOut()
     $(this).addClass('active').siblings('li').removeClass('active');
     });

     //右点击
     next.click(function () {
     autoSlide()
     })
     //左点击方法
     prev.click(function () {
     index--;
     if(index<0){
     index = numLi.length-1;
     play()
     }else{
     play()
     }
     })
     //auto方法
     function autoSlide(){
     index++;
     if(index>=numLi.length){index=0}
     imgLi.eq(index).fadeIn().siblings('li').fadeOut();
     numLi.eq(index).addClass('active').siblings('li').removeClass('active');
     }
     function play() {
     imgLi.eq(index).stop().fadeIn().siblings('li').fadeOut();
     numLi.eq(index).addClass('active').siblings('li').removeClass('active');
     }

     })();*/
    //全部商品
    (function () {
        var cate=$('#cate'),
            dt=cate.find('.dt'),
            dd=cate.find('.dd');
        //展开
        dt.click(function () {
            $(this).find('i').toggleClass('icon-arrow-up');
            dd.css("z-index","300");
            dd.slideToggle('fast');
            return false;
        });
        //收起
        // cate.hover(function () {
        //     $(this).find('i').removeClass('icon-arrow-up')
        //     dd.delay(1000).slideUp('fast');
        // })
        //鼠标滑过效果
        var Li = $(".home .recommend .cate .dd .layer li");
        Li.hover(function(){
            if($(this).hasClass("title")){
                $(this).removeClass("active")
            }else{
                $(this).addClass("active")
            }
        },function(){
            $(this).removeClass("active")
        })
    })();

    //非遗百科
    (function () {
        var oDiv=$('#wiki-pro'),
            oUl=oDiv.find('ul'),
            oLi=oDiv.find('li'),
            oLiWidth=oLi.width()+24,
            oLiSize=oLi.length,
            prev=oDiv.find('.prev'),
            next=oDiv.find('.next'),
            cur=0;


        //初始化ul的width
        oUl.css('width',oLiWidth*oLiSize+'px');

        //向左侧移动
        prev.click(function () {
            cur--
            console.log(cur)
            if(cur>=0){
                oUl.animate({'margin-left':-cur*oLiWidth+'px'},500);
            }else{
                cur=0;
            }
            return false;
        });
        //向右侧移动
        next.click(function () {
            cur++
            if(cur<=oLiSize-3){
                oUl.animate({'margin-left':-cur*oLiWidth+'px'},500);
            }else{
                cur=oLiSize-3;
            }

            console.log(cur)
            return false;
        })


    })();
    //下拉框
    (function(){
        var Option = $(".option");
        var OpLi   = Option.find("li");
        var Select = $(".select");
        Select.click(function(){
            var opt = $(this).siblings(".option");
            opt.css("z-index","100")
            if(opt.css("display")=="none"){
                $(this).addClass("top");
                opt.slideDown();
            }else{
                $(this).removeClass("top");
                opt.slideUp();
            }
        });

        OpLi.click(function(){
            var opt = $(this).siblings(".option")
            var li = $(this).text();
            ($(this).parent(".option")).siblings(".select").html(li).removeClass("top");
            ($(this).parent(".option")).hide();

        })

    })();
    //限制字数
    (function(){
        function txtT(id,len){
            id.each(function(){
                var txt = $(this).text().length;//获取当前容器的字符数
                $(this).text($(this).text().substr(0,len)).append("...")
            })
        }
        txtT($(".mofg .mbody .mlist .list .dbody .mtext .content"),100);
    })();
    //2016.6.2新底部效果
    //返回底部
    (function(){
        $(".foretop").click(function(){
            $('html,body').animate({'scrollTop':0},500);
        });
    })();
    //二维码
    (function(){
        var Icon = $(".efy-icon");
        Icon.css({
            display:'none'
        })
        $(".newphone").hover(function(){
            Icon.stop().fadeIn();
        },function(){
            Icon.stop().fadeOut();
        })
    })()

})