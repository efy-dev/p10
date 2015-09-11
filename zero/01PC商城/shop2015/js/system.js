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
    //商品详情页
    (function(){
        //给html和body加style

        //点击
        var index=0;
        var iSpeed=300;
        var nav=$('.nav-share .nav');
        var navLi=nav.find('.navli');
        var secOneLeft=$('.section1 .sec-left');
        var bodyHtml=$('body');
        var wH=bodyHtml.height();  //计算浏览器的高度
        //如果页面刷新则页面滚动到最顶部
        if(bodyHtml.not(".scroll")){
            bodyHtml.animate({'scrollTop':0},100);
        }
        //立即收藏
        btnsCollect();
        navLi.click(function(){
            index=$(this).index();
            bodyHtml.addClass('scroll');
            bodyHtml.animate({'scrollTop':index*(wH-88)},iSpeed);
            nav.removeClass('nav3');
            $(this).addClass('active').siblings('li').removeClass('active');
            //详情
            if(index==1){
                secOneLeft.animate({'margin-left':'0'},iSpeed);
            }
            //鉴赏
            if(index==2){
                nav.addClass('nav2');
            }
            if(index!=2){
                nav.removeClass('nav2');
            }
            //收藏
            btnsCollect();
        })
        //section1----详情
        $('.section1 .icon-close').click(function(){
            secOneLeft.animate({'margin-left':'-100%'},iSpeed);
        })
        //section2 鉴赏
        sectionFocus();
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
        //点击立即收藏
        function btnsCollect(){
            $('.section .btns-collect').click(function(){
                var section5Part1=$('.section5 .part1');
                var section5Part2=$('.section5 .part2');
                nav.addClass('nav3');
                bodyHtml.animate({'scrollTop':5*(wH-88)},iSpeed);
                //相关收藏
                section5Part1.find('.related-collect').click(function(){
                    section5Part1.animate({'left':'-100%'},iSpeed);
                    section5Part2.animate({'left':'0'},iSpeed);
                    return false;
                });
                section5Part2.find('.related-collect').click(function(){
                    section5Part1.animate({'left':'0'},iSpeed);
                    section5Part2.animate({'left':'100%'},iSpeed);
                    return false;
                });
                return false;
            });
        }

        //商品详情页--鼠标滚轮
        var Time=new Date();
        $(document).mousewheel(function(ev,dir){
            //dir 判断鼠标滚动的方向   向下为  负数   向上为正数
            if(new Date()-Time>500){
                Time=new Date();
                if(dir<0){
                    index++;
                    //index%=5;
                    if(index>4){
                        index=4;
                    }
                }else{
                    index--;
                    if(index<0){
                        index=0;
                    }
                }
                //详情
                if(index==1){
                    secOneLeft.animate({'margin-left':'0'},iSpeed);
                }
                //鉴赏
                if(index==2){
                    nav.addClass('nav2');
                }
                if(index!=2){
                    nav.removeClass('nav2');
                }

                nav.removeClass('nav3');

                navLi.eq(index).addClass('active').siblings().removeClass('active');
                $('body').stop(true).animate({'scrollTop':index*(wH-88)+'px'},iSpeed);
            }

        })
    })();
})
