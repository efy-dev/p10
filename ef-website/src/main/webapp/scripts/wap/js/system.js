$(function(){
    //头部无logoA
    $('#menu').click(function(){
        $(this).find('.line').toggleClass('active');
        $('.menu-list').slideToggle('fast');
    });
    //购物车
    (function(){
        $('.icon-delete').click(function(){
            $('.alert-delete').fadeIn('fast');
        })

        $('.edit-dete').click(function(){
            $('.alert-delete').fadeIn('fast');
            return false;
        })

        if($('div').hasClass('payment-total-bar')){
            $('article').css({'padding-bottom':'50px'})
        }
    })();
    //订单礼物弹出框
    (function(){
        $("#add-dext").click(function(){
            $(this).siblings(".add-ress").show();
            return false
        });
        $(".add-ress .bg").click(function(){
            $(this).parents().find(".add-ress").hide();
        });
        $(".gift .new-yierqiu .ul-list li a").click(function(){
            $(this).parent().addClass("add-btn1").siblings().removeClass()
        })

        $(".gift .edit-txt1,.gift .edit-txt2").click(function(){
            $(this).siblings('.add-cart').fadeIn().show();
            var text=$(".gift .add-cart textarea").val();
            var counter=text.length;
            $(".leaveword-num1 em,.leaveword-num2 em").text(50-counter);
            $(document).keyup(function() {
                var text=$(".gift textarea").val();
                var counter=text.length;
                $(".leaveword-num1 em,.leaveword-num2 em").text(50-counter);
            });
        });
        $(".gift .add-cart .cancel").click(function(){
            $(this).parents().find('.add-cart').fadeOut().hide()
            return false
        })
        $(".gift .elect .add-c1").click(function(){
            $(this).siblings(".gift  .elect span").toggleClass("active")
            $(".gift .detailed .font-1").slideToggle()
        })
        $(".gift .elect .add-c2").click(function(){
            $(this).siblings(".gift  .elect span").toggleClass("active")
            $(".gift .detailed .font-2").slideToggle()
        })
        $(".my-evaluate .score .score-star .star .a-star").dblclick(function(){
            $(".my-evaluate .score .score-star .star .a-star").removeClass("ye-star");
        });
        $("#nobtn").removeAttr('href');
        $("#nobtn").removeAttr('onclick');

        /*   $('.cart-coupons .ul-list').each(function(){
         var $input=$(this).find('input');

         $(this).find('li').click(function(){
         $input.removeAttr('checked');
         $(this).find('input').prop('checked','checked');
         })
         })
         */




    })
        //商品评价
    (function(){

        $('.my-evaluate .score .score-star .star li').click(function(){
            $(this).toggleClass('active');
        });
    });
    //020102分类导航
    (function(){
        $('.box-hd .ul-index-list>li .item').click(function(){
            $(this).find('.arrow-down').toggleClass('arrow-up');
            $(this).parents('.ul-index-list').siblings('.ul-nav-list').slideToggle('fast');
            return false;
        })
    })();
    //020104商品详情
    (function(){
        //收藏
        $('.addfav').click(function(){
            $(this).addClass('addfav-end').find('p').html('已收藏');
            $('.alert-red-top').slideDown(100,function(){
                setTimeout('$(".alert-red-top").slideUp(50)',3000)
            });
            return false;
        });
        //加入购物车悬浮层
        if($('div').hasClass('details-total-bar')){
            $('footer').css({'padding-bottom':'50px'})
        };
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
        //加入购物车-立即购买-调出规格弹出层
        $('#btn-cart,#btn-format,#btn-buy').click(function(){
            $('body').css('overflow','hidden');
            $('.dialog-des-format').css({'-webkit-transform':'translateY(0)'});
            $('.am-dimmer').show();
            //关闭
            $('.am-active,.dialog-des-format .format-close').click(function(){
                $('body').css('overflow','');
                $('.dialog-des-format').css({'-webkit-transform':'translateY(110%)'});
                $('.am-dimmer').hide();
                //添加内容
                $('.details .des-format span.color').html(secColor.html());
                $('.details .des-format span.size').html(secSize.html());
            });
            //
            var dlColorA=$('.dialog-des-format .des-scroll .dl-color a');
            var dlSizeA=$('.dialog-des-format .des-scroll .dl-size a');
            var secColor=$('.dialog-des-format .dl-des dd span.sec-color');
            var secSize=$('.dialog-des-format .dl-des dd span.sec-size');
            //点击颜色
            dlColorA.click(function(){
                $(this).addClass('active').siblings('a').removeClass('active');
                secColor.show().html($(this).html())
                return false;
            });
            //点击尺寸
            dlSizeA.click(function(){
                $(this).addClass('active').siblings('a').removeClass('active');
                secSize.show().html($(this).html())
                return false;
            })
            return false;
        });
        //分享
        (function(){
            $('.details .des-title a.share,.my-colonel .iwill .txt4 .txcon,.packet .button .ad,#btn').click(function(){
                $('#cover').show();
                $(".custom-header").css("z-index","0");
                return false;
            });
            $('#cover').click(function(){
                $(this).hide();
                $(".custom-header").css("z-index","");
            })

            $("#line").click(function(){
                $("#cover2").show();
                $(".custom-header").css("z-index","0");
            })
            $("#cover2 .text-co2 .covbtn").click(function(){
                $(this).parents("#cover2").hide()
                $(".custom-header").css("z-index","");
            })
            $("#cover2 .bg").click(function(){
                $(this).parents("#cover2").hide()
                $(".custom-header").css("z-index","");
            })
        })();
        (function(){
            $("#covbtn").click(function(){
                $("#cover3").show();
                $(".custom-header").css("z-index","0");
            })
            $("#cover3 .bg").click(function(){
                $(this).parents("#cover3").hide()
                $(".custom-header").css("z-index","");
            })
        })();

        //详情和评论-弹出轮播图

        $('.list-img li').on('click',function(){
            var $swiper=$('#swiper');
            //$(this).parents('.list-img')
            $swiper.find('.am-slides').html($(this).parents('.list-img').html())
            //计算弹出框中图片的定位
            var swiperImg=$('#swiper .am-slides img');
            swiperImg.each(function(){
                var imgHeight=$(this).height();
                $(this).css({'margin-top':-imgHeight/2+'px'});
            })

            $swiper.css({'z-index':'102'});
            $swiper.animate({'opacity':'1'},100);

            //初始化
            $('.swiper').flexslider({
                animation: "slide",
                animationLoop: false,
                // smoothHeight: true,
                animationSpeed: 600,
                slideshow: false
            });
            //关闭弹出框
            $swiper.find('.icon-close').on('click',function(){
                $swiper.css({'z-index':'-1'});
                $swiper.animate({'opacity':'0'},100);
            })
        });
    })();
    //订单
    (function(){
        $('#btn-coupon').click(function(){
            $('body,document').css('overflow','hidden');
            $('#order-total').each(function(){
                $(this).show();
                $(this).find('.overbg').click(function(){
                    $(this).parent('#order-total').hide();
                    $('body,document').css('overflow','');
                })
            })

        });

        $('.btn-edit-addres').click(function(){
            $('body,document').css('overflow','hidden');
            $('#order-address').show();
            $('.cart-btn').click(function(){
                $(this).parents('#order-address').hide();
                $('body,document').css('overflow','visible');
            })


            return false;
        })
    })();

    //我的团---我的订单tab
    (function(){
        $('.discount .employ a').click(function(){
            $(this).addClass('yhq-active').siblings().removeClass('yhq-active');
        })

        var mdli = $('.m-order .order-title li');
        var mdbox = $('.m-order .order-content .od-tab1')
        var time = null;
        mdli.click(function(){
            var mthis=$(this);
            mthis.addClass('active').siblings().removeClass('active')
            var index = mthis.index();
            mdbox.eq(index).show().siblings().hide();
        })
    })();
    //开团详情tab
    (function(){
        var coli = $('.colonel-table .c-title ul li')
        var cobox = $('.colonel-table .c-content .co-page')
        coli.click(function(){
            var index = $(this).index()
            $(this).addClass('active').siblings().removeClass('active')
            cobox.eq(index).show().siblings().hide();
        });
        //打开领券地址-----计算页面的高度
        var bodyH=$('body').height();
        $('.coupon-sc').css({'height':(bodyH-55)+'px'});
        if($('div').hasClass('coupon-sc')){
            $('body').css('height','100%');
            $('.login-reg').css({'margin-top':(bodyH-55)+'px'})
        };
        $(".ag-list .ag-new li").click(function(){
            var _bsthis = $(this).index();
            $(this).addClass("active").siblings().removeClass();
            $(".ag-new2 .ag-ck").eq(_bsthis).show().siblings().hide()

        })

    })();
    //优惠-----优惠券tab
    (function(){
        var yhli = $('.coupon-tab .c-tab ul li')
        var yhbox = $('.coupon-tab .c-page .box')
        yhli.click(function(){
            var index = $(this).index()
            $(this).addClass('active').siblings().removeClass('active')
            yhbox.eq(index).show().siblings().hide();
        })
    })();
    //秒杀
    (function(){
        //02移动商城/0201商城前台/秒杀—即将开始
        $('.seckill .s-list .items:last').css('border-bottom','0');
        //秒杀-详情页-已结束-----------展开
        var $info=$('.seckill .s4 .info')
        var $ul=$info.find('ul');
        var $li=$ul.find('li');
        $ul.css('height',$li.outerHeight()*4+'px');

        $info.find('.zk').bind('click',function(){
            $(this).hide().siblings('a').show();
            $ul.animate({'height':$li.outerHeight()*$li.size()+'px'},200);
            return false;
        });
        $info.find('.sq').bind('click',function(){
            $(this).hide().siblings('a').show();
            $ul.animate({'height':$li.outerHeight()*4+'px'},200);
            return false;
        });
    })();
    //分享页面好友点击
    (function(){
        var add =  $(".extended .t-use-top").height();
        var center =  add/2;
        var text =  center-9;
        $(".extended .t-use-top .user-text strong").css("top",text);
    })();
    (function(){
        $(".t-use-center ul li .state-3").parent("li").css({margin:"0",padding:"0"})
    })();
    (function(){
        var banheight = $(".colonel-pic .c-page").height();
        var banhei = banheight+12
        var maxhei = banhei+7
        $(".olli ol.am-control-nav.am-control-paging").css("bottom",maxhei)
    })();
    (function(){
        $(".weachat-tab .wea-tab .wea-icon").click(function(){
            var _index = $(this).index();
            $(this).addClass("active").siblings().removeClass("active");
            $(".wea-box .fiy-box").eq(_index).show().siblings().hide();

        })
    })();
    //微信问题-背景高度
    (function(){
        var bd = $("body").height();
        $(".wechat-bg").css("min-height",bd)
    })();
    //微信问题选项
    (function(){
        var _this =$(".addae").index()-1;
        var _index = $(".topic").length;
        $(".topic .topic-txt.topic-txt .bg-link").click(function(){
            _this++;
            $(".topic").eq(_this).addClass("active").siblings().removeClass("active");
            if(_this == _index){
                window.location.href="http://www.baidu.com"
            }
        });
    })();
});