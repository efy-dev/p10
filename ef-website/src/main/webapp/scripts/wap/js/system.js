$(function(){
    //
    (function(){
        $('.btn-top-wechat').hover(function(){
            $(this).find('.top-wechat').stop(true).slideDown('fast');
        },function(){
            $(this).find('.top-wechat').stop(true).slideUp('fast');
        });
        //footer二维码
        $('.footer .service .wechat').hover(function(){
            $(this).find('.icon').fadeIn('100');
        },function(){
            $(this).find('.icon').delay(2000).fadeOut();
        })
    })();
    //
    (function(){
        $('.header .nav li').hover(function(){
            $('.header,.footer').css('z-index','');
            $(this).find('.bgbor').show();
            $(this).addClass('hover').find('.nav-links').stop().slideDown('fast');
        },function(){
            $(this).find('.bgbor').hide();
            $(this).removeClass('hover').find('.nav-links').stop().slideUp('fast');
        })
    })();
    //
    (function(){
        var $sliderMain=$('.focus .slider-main');
        var $liImg=$sliderMain.find('li');
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
        $sliderMain.hover(function(){
            clearInterval(timer);
        },function(){
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
    //����
    (function(){
        $('.shop-sort .link2 dt').click(function(){
            $(this).toggleClass('active').siblings('dd').stop().slideToggle('fast');
        })
    })();
    //
    (function(){
        var simgLi=$('.preview .slider-img li');
        var BimgLi=$('.preview .slider-main li');
        var index=0;
        var timer=null;
        simgLi.click(function(){
            clearInterval(timer);
            index=$(this).index();
            BimgLi.eq(index).fadeIn('200').siblings().fadeOut('200');
            $(this).addClass('active').siblings('li').removeClass('active');
        });
        //收藏
        var oBiao=$('.preview .collect .biao');
        oBiao.hover(function(){
            var $span=$(this).siblings('span');
            $span.text('添加收藏');
            if($span.is('.active')){
                $span.text('取消收藏');
            }
            if($span.is('.hover')){
                $span.text('添加收藏');
            }
        })

        oBiao.find('.icon').toggle(
            function(){
                var $span=$(this).parents('.biao').siblings('span');
                $(this).addClass('icon-active');
                $span.attr('class','txt active').text('取消收藏');
            },
            function(){
                var $span=$(this).parents('.biao').siblings('span');
                $(this).removeClass('icon-active');
                $span.attr('class','txt hover').text('添加收藏');
            }
        );
        //
        $(window).scroll(function(){
            var d=$(document).scrollTop();
            if(d>900){
                $('.tab-wrap').parents('.wh').addClass('fixed-tab');
            }else{
                $('.tab-wrap').parents('.wh').removeClass('fixed-tab');
            }
        });
        //
        $('.product-intro .detail .part:last').css({'border':'0'});
        //
        $('.tab-items li a').click(function(){
            var pos=$($(this).attr('href')).offset().top;
            $("html,body").animate({scrollTop:pos},500);
            return false;
        });
        //
        $('.itemInfo .ul-list li').click(function(){
            $(this).addClass('active');
        })
    })();
    //
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
    //
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
    //
    (function(){
        $('.my-order .extra-r>a').click(function(){
            $(this).siblings('.active-pop').show();
            $('.my-order .clase, .my-order .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    })();
    //
    (function(){
        $('.nav-item .title').click(function(){
            $(this).find('.icon').toggleClass('icon-active');
            $(this).siblings('.ul-list').stop().slideToggle(200);
            $(this).parents('.nav-item').find('.ul-list')
        })
    })();
    //
    (function(){
        $(window).scroll(function(){
            var _top=$(window).scrollTop();
            var btnTop=$('.scroll-bar-top');
            if(_top>200){
                btnTop.fadeIn();
            }else{
                btnTop.fadeOut();
            }
            btnTop.click(function(){
                $('body').stop(true).animate({'scrollTop':'0'},300);
            })
        })
    })();
    //购物车
    (function(){
        //优惠券
        $('.btn-coupon').click(function(){
            $('.header,.footer').css('z-index','-1');
            $(this).toggleClass('active');
            $(this).siblings('.ul-list').slideToggle('fast');
            return false;
        });
    })();
    //010110结算页-计数
    (function(){
        //输入框计数
        var textareaText=$('.my-clearing .page-leaveword input');
        textareaText.keydown(function(){
            var aNum=45;
            var curLength=$(this).val().length;
            var txtNmu=$(this).siblings('span');
            if(curLength>=aNum){
                var num=$(this).val().substr(0,aNum-1);
                $(this).val(num);
            }
            else{
                txtNmu.text((aNum-1)-$(this).val().length+'/45')
            }
        });
    })();
})
