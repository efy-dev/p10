$(function(){
    //导航
    (function(){
        $('.header .nav li').hover(function(){
           $(this).find('.bgbor').show();
           $(this).addClass('hover').find('.nav-links').stop().slideDown('fast');
        },function(){
            $(this).find('.bgbor').hide();
            $(this).removeClass('hover').find('.nav-links').stop().slideUp('fast');
        })
    })();
    //焦点图
    (function(){
        var $liImg=$('.focus .slider-main li');
        var $liNav=$('.focus .slider-nav li');
        var index=0;
        var timer=null;
        var iSpeed=3000;
        $liNav.mousedown(function(){
            clearInterval(timer);
            index=$(this).index();
            $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
            $(this).addClass('active').siblings('li').removeClass('active');
        });
        $liNav.mouseup(function(){
            timer=setInterval(autoFocus,iSpeed);
        })
        function autoFocus(){
            index++;
            if(index>$liImg.length-1){index=0;}
            $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
            $liNav.eq(index).addClass('active').siblings('li').removeClass('active');
        }
        timer=setInterval(autoFocus,iSpeed);
    })();
    //排序
    (function(){
        $('.shop-sort .link2 dt').click(function(){
            $(this).toggleClass('active').siblings('dd').stop().slideToggle('fast');
        })
    })();
    //商品详情页
    (function(){
        var simgLi=$('.preview .slider-img li');
        var BimgLi=$('.preview .slider-main li');
        var index=0;
        var timer=null;
        var iSpeed=3000;
        simgLi.click(function(){
            clearInterval(timer);
            index=$(this).index();
            BimgLi.eq(index).fadeIn('200').siblings().fadeOut('200');
            $(this).addClass('active').siblings('li').removeClass('active');
        });
        //收藏
        var $add=$('.preview .collect .icon');
        var $hover=$add.siblings('.hover');
        var $active=$add.siblings('.active');
        $add.hover(function(){
            $(this).addClass('icon-active');
            if($active.is(':hidden')){
                $hover.show();
            }else{
                $hover.hide();
            }
        },function(){
            $(this).removeClass('icon-active');
        });
        $add.click(function(){
            $(this).addClass('icon-active2');
            $hover.hide();
            $active.show();
        })
        //固定导航
        $(window).scroll(function(){
            var d=$(document).scrollTop();
            if(d>900){
                $('.tab-wrap').css({'position':'fixed','top':'0'})
            }else{
                $('.tab-wrap').css({'position':'','top':''})
            }
        });
        $('.product-intro .detail .part:last').css({'border':'0'});
        //描点
        $('.tab-items li a').click(function(){
            var pos=$($(this).attr('href')).offset().top;
            $("html,body").animate({scrollTop:pos-75},500);
            return false;
        });
        //规格选中
        $('.itemInfo .ul-list li').click(function(){
            $(this).addClass('active');
        })

    })();
    //注册--协议
    (function(){
        $('#protocol').click(function(){
            $('.thickframe').show();
            return false;
        })
        $('#closeBox,.btnt .btn-img').click(function(){
            $('.thickframe').hide();
            return false;
        })
    })();
    //我的订单
    (function(){
        $('#orderNum .item:last tr').css({'border':'0'});
        $('.clearing-site span a').click(function(){
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
        $('.clearing-site span a').click(function(){
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    })();
    //收货地址
    (function(){
        $('.my-order .extra-r>a').click(function(){
            $(this).siblings('.active-pop').show();
            $('.my-order .clase, .my-order .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    })();
    //商品搜索
    (function(){
        $('.nav-item .title').click(function(){
            $(this).find('.icon').toggleClass('icon-active');
            $(this).siblings('.ul-list').stop().slideToggle(200);
            $(this).parents('.nav-item').find('.ul-list')
        })
    })();
    //商品详情页（精品）
    (function(){
        //二级导航
        var menuFineList=$('#menu-fine-list');
        var ulList=menuFineList.find('.ul-list');
        var navLinks=menuFineList.find('.nav-links');
        var navLinksWidth=(navLinks.find('ul').width()*navLinks.find('ul').length)+251; //计算二级菜单宽度
        navLinks.css({'width':navLinksWidth+'px','right':-navLinksWidth+'px'});
        ulList.hide();
        $('#menu-fine .nav-icon').click(function(){
            $(this).hide().siblings('a').show();
            menuFineList.css({'opacity':'1','z-index':'6'});
            ulList.stop(true,true).slideDown(200);
            //
            menuFineList.find('.active').hover(function(){
                navLinks.stop(true).animate({'right':'0'},300);
            },function(){
                navLinks.stop(true).animate({'right':-navLinksWidth+'px'},300);
            });
            menuFineList.find('.mask').click(function(){
                $('#menu-fine .nav-icon-active').hide().siblings('a').show();
                menuFineList.stop(true).animate({'opacity':'0','z-index':'0'});
                ulList.stop(true).slideUp(200);
            })
            $('#menu-fine .nav-icon-active').click(function(){
                $(this).hide().siblings('a').show();
                menuFineList.stop(true).animate({'opacity':'0','z-index':'0'});
                ulList.stop(true).slideUp(200);
            })
        })
        //页面概览-详情-鉴赏-技艺-保养点击
        var index=0;
        var iSpeed=300;
        var nav=$('.nav-share .nav');
        var navLi=nav.find('li');//二级导航
        var btnArrowDown=$('.section .btn-arrow-down'); //居中向下按钮
        var bodyHtml=$('body');//页面
        var wH=bodyHtml.height();//页面高度
        //如果页面刷新则页面滚动到最顶部
        if(bodyHtml.not(".scroll")){
            bodyHtml.animate({'scrollTop':0},100);
        }
        //悬浮导航
        navLi.click(function(){
            index=$(this).index();
            bodyNavRun();
        })
        //商品详情页--鼠标滚轮
        var Time=new Date();
        $(document).mousewheel(function(ev,dir){
            //dir 判断鼠标滚动的方向   向下为  负数   向上为正数
            if(new Date()-Time>500){
                Time=new Date();
                if(dir<0){
                    index++;
                    if(index>5){
                        index=5;
                    }
                }else{
                    index--;
                    if(index<0){
                        index=0;
                    }
                }
                bodyNavRun();
            }
        });
        //点击向下图标
        btnArrowDown.click(function(){
            index++;
            bodyNavRun();
        })
        //判断导航（概览-详情-鉴赏-技艺-保养）各个页面中的状态以及页面滚动距离
        function bodyNavRun(){
            bodyHtml.addClass('scroll');//刷新页面回到页面顶部
            nav.removeClass('nav3');//相关藏品和立即购买页面：去掉悬浮导航上的class=nav3
            if(index==2){nav.addClass('nav2');}  //悬浮导航到鉴赏部分：增加class=nav2  背景
            if(index!=2){nav.removeClass('nav2');} //悬浮导航到鉴赏部分：去除class=nav2
            if(index>3){btnArrowDown.fadeOut();}//到达保养页面后  向下按钮消失
            if(index<4){btnArrowDown.fadeIn();}//离开保养页面后 向下按钮显示
            if(index==5){nav.addClass('nav3');}

            navLi.eq(index).addClass('active').siblings().removeClass('active');
            bodyHtml.stop(true).animate({'scrollTop':index*(wH-88)},iSpeed); //页面滚动距离
            btnsCollect();  //收藏
            sectionFocus(); //section2 鉴赏左侧轮播图
        }
        btnsCollect();
        //点击立即收藏
        function btnsCollect(){
            $('.btns-collect').click(function(){
                index=5;
                nav.addClass('nav3');
                navLi.eq(index).addClass('active').siblings().removeClass('active');
                bodyHtml.stop(true).animate({'scrollTop':index*(wH-88)},iSpeed); //页面滚动距离

                btnArrowDown.fadeOut(); //向下按钮消失
                var section5Part1=$('.section5 .part1');
                var section5Part2=$('.section5 .part2');
                //相关收藏
                section5Part1.find('.related-collect').click(function(){
                    section5Part1.stop(true).animate({'left':'-100%'},iSpeed);
                    section5Part2.stop(true).animate({'left':'0'},iSpeed);
                    return false;
                });
                section5Part2.find('.related-collect').click(function(){
                    section5Part1.stop(true).animate({'left':'0'},iSpeed);
                    section5Part2.stop(true).animate({'left':'100%'},iSpeed);
                    return false;
                });

                return false;
            });
        };
        //section2 鉴赏左侧轮播图
        function sectionFocus(){
            var ulImgLi=$('.section2 .ul-img li');
            var ulNumLi=$('.section2 .ul-num li');
            var ulSnumLi=$('.section2 .ul-snum li');
            var infoTab=$('.section2 .info-tab');
            ulImgLi.eq(0).show();
            infoTab.eq(0).show();
            ulNumLi.click(function(){
                $(this).addClass('active').siblings('li').removeClass('active');
                ulImgLi.eq($(this).index()).fadeIn().siblings('li').fadeOut();
                infoTab.eq($(this).index()).fadeIn().siblings('.info-tab').fadeOut();
                ulSnumLi.eq(1).html($(this).index()+1);
            })
        }
    })();

})
