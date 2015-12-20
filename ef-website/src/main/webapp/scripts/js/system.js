$(function () {
    //
    (function () {
        $('.btn-top-wechat').hover(function () {
            $(this).find('.top-wechat').stop(true).slideDown('fast');
        }, function () {
            $(this).find('.top-wechat').stop(true).slideUp('fast');
        });
        //
        $('.btn-top-nav').hover(function () {
            $(this).find('.ul-details').stop(true).slideDown('fast');
        }, function () {
            $(this).find('.ul-details').stop(true).slideUp('fast');
        });
        //footer二维码
        $('.footer .service .wechat').hover(function () {
            $(this).find('.icon').fadeIn('100');
        }, function () {
            $(this).find('.icon').fadeOut();
        })
    })();
    //
    (function () {
        $('.header .nav li').hover(function () {
            $('.header,.footer').css('z-index', '');
            $(this).find('.bgbor').show();
            $(this).addClass('hover').find('.nav-links').stop().slideDown('fast');
        }, function () {
            $(this).find('.bgbor').hide();
            $(this).removeClass('hover').find('.nav-links').stop().slideUp('fast');
        })
    })();
    //
    (function () {
        var $focus = $('.focus');
        var $btnPrev = $focus.find('.btn-prev');
        var $btnNext = $focus.find('.btn-next');
        var $sliderMain = $('.focus .slider-main');
        var $liImg = $sliderMain.find('li');
        var $liNav = $('.focus .slider-nav li');
        var index = 0;
        var timer = null;
        var iSpeed = 3000;
        $liNav.mousedown(function () {
            clearInterval(timer);
            index = $(this).index();
            $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
            $(this).addClass('active').siblings('li').removeClass('active');
        });
        $liNav.mouseup(function () {
            timer = setInterval(autoFocus, iSpeed);
        })
        $sliderMain.hover(function () {
            clearInterval(timer);
        }, function () {
            timer = setInterval(autoFocus, iSpeed)
        })

        $focus.hover(function () {
            $btnNext.animate({'right': '0'}, 100);
            $btnPrev.animate({'left': '0'}, 100);
        }, function () {
            $btnNext.animate({'right': '-45px'}, 100);
            $btnPrev.animate({'left': '-45px'}, 100);
        })
        //下一页
        $btnNext.mousedown(function () {
            clearInterval(timer);
            autoFocus();
        })
        $btnNext.mouseup(function () {
            timer = setInterval(autoFocus, iSpeed);
        })
        //上一页
        $btnPrev.mousedown(function () {
            clearInterval(timer);
            index--;
            if (index < 0) {
                index = $liImg.length - 1;
            }
            $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
            $liNav.eq(index).addClass('active').siblings('li').removeClass('active');
        })
        $btnPrev.mouseup(function () {
            timer = setInterval(autoFocus, iSpeed);
        })
        function autoFocus() {
            index++;
            if (index > $liImg.length - 1) {
                index = 0;
            }
            $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
            $liNav.eq(index).addClass('active').siblings('li').removeClass('active');
        }

        timer = setInterval(autoFocus, iSpeed);
    })();


    //
    (function () {
        $('.shop-sort .link2 dt').click(function () {
            $(this).toggleClass('active').siblings('dd').stop().slideToggle('fast');
        })
    })();
    //
    (function () {
        var simgLi = $('.preview .slider-img li');
        var BimgLi = $('.preview .slider-main li');
        var index = 0;
        var timer = null;
        simgLi.click(function () {
            clearInterval(timer);
            index = $(this).index();
            BimgLi.eq(index).fadeIn('200').siblings().fadeOut('200');
            $(this).addClass('active').siblings('li').removeClass('active');
        });
        //收藏
        var oBiao = $('.preview .collect .biao');
        //oBiao.hover(function(){
        //    var $span=$(this).siblings('span');
        //    $span.text('添加收藏');
        //    if($span.is('.active')){
        //        $span.text('取消收藏');
        //    }
        //    if($span.is('.hover')){
        //        $span.text('添加收藏');
        //    }
        //})

        //oBiao.find('.icon').toggle(
        //    function(){
        //        var $span=$(this).parents('.biao').siblings('span');
        //        $(this).addClass('icon-active');
        //        $span.attr('class','txt active').text('取消收藏');
        //    },
        //    function(){
        //        var $span=$(this).parents('.biao').siblings('span');
        //        $(this).removeClass('icon-active');
        //        $span.attr('class','txt hover').text('添加收藏');
        //    }
        //);
        //
        $(window).scroll(function () {
            var d = $(document).scrollTop();
            if (d > 900) {
                $('.tab-wrap').parents('.wh').addClass('fixed-tab');
            } else {
                $('.tab-wrap').parents('.wh').removeClass('fixed-tab');
            }
        });
        //
        $('.product-intro .detail .part:last').css({'border': '0'});
        //
        $('.tab-items li a').click(function () {
            var pos = $($(this).attr('href')).offset().top;
            $("html,body").animate({scrollTop: pos}, 500);
            return false;
        });
        //
        $('.itemInfo .ul-list li').click(function () {
            $(this).addClass('active');
        })

        $(".homenew .deduce .list-bottom li .mask,.homenew .max-cat .category .cat-right li .mask,.classify .items .img-small a .mask").parents("a").hover(function () {
            $(this).animate({"opacity": "0.6"}, 200);
        }, function () {
            $(this).animate({"opacity": "1"}, 200);
        });


    })();
    //
    (function () {
        $('#protocol').click(function () {
            $('.thickframe').show();
            return false;
        })
        $('#closeBox,.btnt .btn-img').click(function () {
            $('.thickframe').hide();
            return false;
        })
    })();
    //
    (function () {
        $('#orderNum .item:last tr').css({'border': '0'});
        $('.clearing-site span a').click(function () {
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function () {
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
        $('.clearing-site span a').click(function () {
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function () {
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    })();
    //
    (function () {
        $('.my-order .extra-r>a').click(function () {
            $(this).siblings('.active-pop').show();
            $('.my-order .clase, .my-order .sh-bg').click(function () {
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    })();
    //
    (function () {
        $('.nav-item .title').click(function () {
            $(this).find('.icon').toggleClass('icon-active');
            $(this).siblings('.ul-list').stop().slideToggle(200);
            $(this).parents('.nav-item').find('.ul-list')
        })
    })();
    //
    (function () {
        $(window).scroll(function () {
            var _top = $(window).scrollTop();
            var btnTop = $('.scroll-bar-top');
            if (_top > 200) {
                btnTop.fadeIn();
            } else {
                btnTop.fadeOut();
            }
            btnTop.bind('click', function () {
                $('html,body').stop(true).animate({'scrollTop': '0'}, 300);
            })
        })
    })();
    //商品详情
    (function () {
        //商品详情评价2015116图片
        $('.dis-pic .dis-ol .one-li').click(function () {
            var index = $(this).index()
            $(this).addClass('active').siblings().removeClass('active');
            $(this).parents('.dis-ol').siblings('.box-pic').find('.list-pic').eq(index).show().siblings().hide();
        });
    });


    //购物车
    (function () {
        //优惠券
        $('.btn-coupon').click(function () {
            $('.header,.footer').css('z-index', '-1');
            $(this).toggleClass('active');
            $(this).siblings('.ul-list').slideToggle('fast');
            return false;
        });
    })();

    //010110结算页-计数
    (function () {
        //输入框计数
        var textareaText = $('.my-clearing .page-leaveword input');
        textareaText.keydown(function () {
            var aNum = 45,
                curLength = $(this).val().length,
                txtNmu = $(this).siblings('span');
            if (curLength >= aNum) {
                var num = $(this).val().substr(0, aNum - 1);
                $(this).val(num);
            }
            else {
                txtNmu.text((aNum - 1) - $(this).val().length + '/45')
            }
        });
    })();


    //二期---首页
    (function () {
        //新导航
        var allSort = $('.nav-new .cate .allsort');
        allSort.find('.item').hover(function () {
            $(this).find('h3').addClass('hover');
            $(this).find('.i-mc').stop(true, true).fadeIn(10);
        }, function () {
            $(this).find('h3').removeClass('hover');
            $(this).find('.i-mc').fadeOut(10);
        });

        //新导航分类展开收起
        var navList = $('.nav-new-list');
        navList.find('h2').bind('click', function () {
            navList.find('.allsort').slideToggle(100);
        });

        //轮播图
        (function () {
            var $focus = $('.focus-new');
            var $btnPrev = $focus.find('.btn-prev');
            var $btnNext = $focus.find('.btn-next');
            var $sliderMain = $focus.find('.slider-main');
            var $liImg = $sliderMain.find('li');
            var $liNav = $focus.find('.slider-nav').find('li');
            var index = 0;
            var timer = null;
            var iSpeed = 3000;
            $liNav.mousedown(function () {
                clearInterval(timer);
                index = $(this).index();
                $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
                $(this).addClass('active').siblings('li').removeClass('active');
            });
            $liNav.mouseup(function () {
                timer = setInterval(autoFocus, iSpeed);
            })
            $sliderMain.hover(function () {
                clearInterval(timer);
            }, function () {
                timer = setInterval(autoFocus, iSpeed)
            })

            $focus.find('.hd').hover(function () {
                $btnNext.stop(true, true).animate({'right': '0'}, 100);
                $btnPrev.stop(true, true).animate({'left': '180px'}, 100);
            }, function () {
                $btnNext.stop(true, true).animate({'right': '-134px'}, 100);
                $btnPrev.stop(true, true).animate({'left': '-45px'}, 100);
            })
            //下一页
            $btnNext.mousedown(function () {
                clearInterval(timer);
                autoFocus();
            })
            $btnNext.mouseup(function () {
                timer = setInterval(autoFocus, iSpeed);
            })
            //上一页
            $btnPrev.mousedown(function () {
                clearInterval(timer);
                index--;
                if (index < 0) {
                    index = $liImg.length - 1;
                }
                $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
                $liNav.eq(index).addClass('active').siblings('li').removeClass('active');
            })
            $btnPrev.mouseup(function () {
                timer = setInterval(autoFocus, iSpeed);
            })
            function autoFocus() {
                index++;
                if (index > $liImg.length - 1) {
                    index = 0;
                }
                $liImg.eq(index).fadeIn(500).siblings('li').fadeOut(500);
                $liNav.eq(index).addClass('active').siblings('li').removeClass('active');
            }

            timer = setInterval(autoFocus, iSpeed);
        })();


    })();
    //二期---B020101分类推荐首页
    (function () {
        //
        var shopImg = $('.reco-shop .shop-img'),
            aLi = shopImg.find('li'),
            aLiNum = aLi.length,
            aLiWidth = aLi.eq(0).outerWidth(true),
            oUl = shopImg.find('ul'),
            oUlWidth = aLiWidth * aLiNum,
            index = 0,
            btnPrev = shopImg.find('.btn-prev'),
            btnNext = shopImg.find('.btn-next');

        oUl.css({'width': oUlWidth + 'px'});
        btnNext.bind('click', function () {
            if (index < aLiNum - 5) {
                index++;
                oUl.animate({'margin-left': -index * aLiWidth + 'px'}, 300);
            }
            btnOpacity();
        });
        btnPrev.bind('click', function () {
            if (index > 0) {
                index--;
                oUl.animate({'margin-left': -index * aLiWidth + 'px'}, 300);
            }
            btnOpacity();
        })
        //
        btnOpacity();
        function btnOpacity() {
            if (index == 0) {
                btnPrev.delay(100).animate({'opacity': '0.2'}, 10);
                btnNext.delay(100).animate({'opacity': '1'}, 10);
            } else {

            }
            if (index == aLiNum - 5) {
                btnPrev.delay(100).animate({'opacity': '1'}, 10);
                btnNext.delay(100).animate({'opacity': '0.2'}, 10);
            }
        };


    })();


})
