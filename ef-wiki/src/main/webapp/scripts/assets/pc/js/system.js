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
    })();
    //订单
    (function(){
        $('.btn-coupons').click(function(){
            $('body,document').css('overflow','hidden');
            $('#order-total').show().css({'top':($('.order-total').position().top-120)+'px'});
            $('.cart-btn').click(function(){
                $(this).parents('.alert-delete').hide();
                $('body,document').css('overflow','visible');
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




    $('img').load(function(){
        var box = $('.craft-page');
        var boxHeight = {
            leftBox:[],
            centerBox:[],
            rightBox:[]
        }

        for(var i=0;i<box.length;i++){
            var now = i%3;		//now的值为0，1，2

            switch(now){
                case 0:
                    box.eq(i).css('left','10px');
                    boxHeight.leftBox.push(box.eq(i).height());
                    var now2 = Math.floor(i/3);

                    if(now2==0){
                        box.eq(i).css('top',0);
                    }else{
                        var total = 0;
                        for(var j=0;j<now2;j++){
                            total += boxHeight.leftBox[j]+10;
                        }
                        box.eq(i).css('top',total+'px')
                    }

                    break;

                case 1:
                    box.eq(i).css('left','270px');
                    boxHeight.centerBox.push(box.eq(i).height());
                    var now2 = Math.floor(i/3);

                    if(now2==0){
                        box.eq(i).css('top',0);
                    }else{
                        var total = 0;
                        for(var j=0;j<now2;j++){
                            total += boxHeight.centerBox[j]+10;
                        }
                        box.eq(i).css('top',total+'px')
                    }
                    break;

                case 2:
                    box.eq(i).css('left','530px');
                    boxHeight.rightBox.push(box.eq(i).height());
                    var now2 = Math.floor(i/3);

                    if(now2==0){
                        box.eq(i).css('top',0);
                    }else{
                        var total = 0;
                        for(var j=0;j<now2;j++){
                            total += boxHeight.rightBox[j]+10;
                        }
                        box.eq(i).css('top',total+'px')
                    }
                    break;
            }
        }
    });




});
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


