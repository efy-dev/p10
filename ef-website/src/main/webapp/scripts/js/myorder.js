$(function(){
    //����

    //�ҵĶ���
    (function(){
        $('#orderNum .item:last tr').css({'border':'0'});
        $('.clearing-site span .btn-cart-add').click(function(){
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            // return false;
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

})

//�ջ���ַ
$(function(){
    $('.my-order .extra-r>a').click(function(){
        $(this).siblings('.active-pop').show();
        $('.my-order .clase, .my-order .sh-bg').click(function(){
            $(this).parents('.active-pop').hide();
        })
        return false;
    })
})
//������Ϣ
$(function(){
    $('#act-q').click(function(){
        $(this).siblings('.list-express').slideToggle();

    })
})
//�����е����Ǵ��js
//������ѡ��
$(function(){
    $('.evaluation .mutual .parameter .data .data-list .tally .djml').click(function(){
        $(this).toggleClass('cl-active')
    })
})
//�����ť
$(function(){
    $('.act-ui').click(function(){
        $(this).parents('.table').siblings('.mutual').slideToggle();
        return false;
    })
})
//�󶨰�ť
$(function(){
    $('.kd').click(function(){
        $(this).parents('.binding').sibling('.binding-list').slideToggle();
    })
})

$(function(){
    $('#cart-coupon').find('.btn-coupon').click(function(){
        alert('asd')
        $('#cart-coupon').find('.ul-list').slideDown();
        return false;
    })
})


//dingdan zuobiandianjijs

$(function(){
    $('.my-order .order-nav .layout-li li').click(function(){
        alert('asdsasad')
        $(this).addClass('liul').siblings().removeClass('liul');
    })
})


//huadongxianshi
$(function(){
    $('.my-clearing .page-default').mouseenter(function(){
        $(this).find('.jc-hc').show();
    })
    $('.my-clearing .page-default').mouseleave(function(){
        $(this).find('.jc-hc').hide();
    })

})
$(function(){
    $('.edit-act').click(function(){
        $(this).parent().find('.apt').show();

    })
})


$(function(){
    $('.but-bil').click(function(){
        alert('sadasdsa')
        $(this).parent().find('.common-popup').show()
    })
})


/*
var GradList = document.getElementById("quacorgrading").getElementsByTagName("input");
for(var i=0;i < GradList.length;i++){
    GradList[i].onmouseover = function(){
        for(var Qi=0;Qi<GradList.length;Qi++){
            GradList[Qi].style.backgroundPosition = '-36px -21px';
        }
        for(var Qii=0;Qii<this.name;Qii++){
            GradList[Qii].style.backgroundPosition = '-5px -21px';
        }
        document.getElementById("QuacorGradingValue").innerHTML = '<b><font size="5" color="#fd7d28">'+this.name+'</font></b>分';
    }
}*/
