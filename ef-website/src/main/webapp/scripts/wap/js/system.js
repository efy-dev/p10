$(function(){
    //ͷ����logoA
    $('#menu').click(function(){
        $(this).find('.line').toggleClass('active');
        $('.menu-list').slideToggle('fast');
    });
    //���ﳵ
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
    //020102���ർ��
    (function(){
        $('.box-hd .ul-index-list>li .item').click(function(){
            $(this).find('.arrow-down').toggleClass('arrow-up');
            $(this).parents('.ul-index-list').siblings('.ul-nav-list').slideToggle('fast');
            return false;
        })
    })();
    //020104��Ʒ����
    (function(){
        //�ղ�
        $('.addfav').click(function(){
            $(this).addClass('addfav-end').find('p').html('���ղ�');
            $('.alert-red-top').slideDown(100,function(){
                setTimeout('$(".alert-red-top").slideUp(50)',3000)
            });
            return false;
        });
        //���빺�ﳵ������
        if($('div').hasClass('details-total-bar')){
            $('footer').css({'padding-bottom':'50px'})
        };
        //���빺�ﳵ-��������-������񵯳���
        $('#btn-cart,#btn-format,#btn-buy').click(function(){
            $('.dialog-des-format').css({'-webkit-transform':'translateY(0)'});
            $('.am-dimmer').show();
            $('.am-active').click(function(){
                $('.dialog-des-format').css({'-webkit-transform':'translateY(110%)'});
                $('.am-dimmer').hide();
            })
            return false;
        })
    })();
    //����
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





})