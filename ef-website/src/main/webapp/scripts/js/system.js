$(function(){
    //
    (function(){
        $('.btn-top-wechat').hover(function(){
            $(this).find('.top-wechat').stop(true).slideDown('fast');
        },function(){
            $(this).find('.top-wechat').stop(true).slideUp('fast');
        })
    })();
    //
    (function(){
        $('.header .nav li').hover(function(){
            $(this).find('.bgbor').show();
            $(this).addClass('hover').find('.nav-links').stop().slideDown('fast');
        },function(){
            $(this).find('.bgbor').hide();
            $(this).removeClass('hover').find('.nav-links').stop().slideUp('fast');
        })
    })();
    //
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
            $(this).find('.icon').addClass('icon-hover');
        },function(){
            $(this).find('.icon').removeClass('icon-hover');
        });
        oBiao.click(function(){
            var oCllect=$(this).parents('.collect');
            $(this).find('.icon').toggleClass('icon-active');
            oCllect.find('span.hover').remove();
            if(oCllect.find('span').is('.active')){
                oCllect.find('span.active').remove();
                oCllect.append('<span class="txt hover">添加收藏</span>');
            }else{
                oCllect.append('<span class="txt active">取消收藏</span>');
            }
        })
        //�
        $(window).scroll(function(){
            var d=$(document).scrollTop();
            if(d>900){
                $('.tab-wrap').parents('.wh').addClass('fixed-tab');
            }else{
                $('.tab-wrap').parents('.wh').removeClass('fixed-tab');
            }
        });
        $('.product-intro .detail .part:last').css({'border':'0'});
        //���
        $('.tab-items li a').click(function(){
            var pos=$($(this).attr('href')).offset().top;
            $("html,body").animate({scrollTop:pos},500);
            return false;
        });
        //
        $('.itemInfo .ul-list li').click(function(){
            $(this).addClass('active');
        })
        //计算轮播图===图片大小进行定位
        //var bigGlassli=$('.product-intro .itemInfo .preview .slider-main li');
        //var bigGlassliImg=bigGlassli.find('img');
        //bigGlassli.find('.zoom-section').css({'margin-left':-bigGlassliImg.width()/2+'px'})
        //bigGlassli.find('.mousetrap').css({'width':'800px'})

    })();
    //�
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
    //�
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
    //�ջ���ַ
    (function(){
        $('.my-order .extra-r>a').click(function(){
            $(this).siblings('.active-pop').show();
            $('.my-order .clase, .my-order .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    })();
    //��Ʒ����
    (function(){
        $('.nav-item .title').click(function(){
            $(this).find('.icon').toggleClass('icon-active');
            $(this).siblings('.ul-list').stop().slideToggle(200);
            $(this).parents('.nav-item').find('.ul-list')
        })
    })();
    //�Ҳ�������
    (function(){

        $(window).scroll(function(){
            var _top=$(window).scrollTop();
            var btnTop=$('.scroll-bar-top');
            if(_top>200){
                btnTop.fadeIn();
            }else{
                btnTop.fadeOut();
            }

            if(_top>$(document).height()-900){

                $('.scroll-bar').css({'bottom':'200px'})
            }


            btnTop.click(function(){
                $('body').stop(true).animate({'scrollTop':'0'},300);
            })
        })
    })();

    //购物车
    (function(){
        $('#cart-coupon').find('.btn-coupon').click(function(){
            $(this).toggleClass('active');
            $(this).siblings('.ul-list').slideToggle('fast');
            return false;
        })
    })();



})
