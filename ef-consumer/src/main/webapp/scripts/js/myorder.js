$(function(){
    (function(){
        $('#orderNum .item:last tr').css({'border':'0'});
        $('.clearing-site span .btn-cart-add').click(function(){
            $('.header-new,.topbar,.nav-new-list,.footernew').css('z-index','-1');
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
            })
            // return false;
        })
    })();
    //
    (function(){
        $('.my-order .extra-r>a').click(function(){
            $('.header-new,.topbar,.nav-new-list,.footernew').css('z-index','-1');
            $('.header,.footer').css('z-index','-1');
            $(this).siblings('.active-pop').show();
            $('.my-order .clase, .my-order .sh-bg').click(function(){
                $(this).parents('.active-pop').hide();
                $('.header,.footer').css('z-index','');
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
    /*$('.my-order .extra-r>a').click(function(){
     $(this).siblings('.active-pop').show();
     $('.my-order .clase, .my-order .sh-bg').click(function(){
     $(this).parents('.active-pop').hide();
     })
     return false;
     });*/
    //
    $('#act-q').click(function(){
        $(this).siblings('.list-express').slideToggle();
    })
    //
    $('.evaluation .mutual .parameter .data .data-list .tally .djml').click(function(){
        $(this).toggleClass('cl-active')
    });
    //
    $('.act-ui').click(function(){
        $(this).parents('.table').siblings('.mutual').slideToggle();
        return false;
    });
    //
    $('.kd').click(function(){
        $(this).parents('.binding').sibling('.binding-list').slideToggle();
    })
    //dingdan zuobiandianjijs
    $('.my-order .order-nav .layout-li li').click(function(){
        $(this).addClass('liul').siblings().removeClass('liul');
    })
    //huadongxianshi
    $('.my-clearing .page-default').mouseenter(function(){
        $(this).find('.jc-hc').show();
    })
    $('.my-clearing .page-default').mouseleave(function(){
        $(this).find('.jc-hc').hide();
    });
    //
    $('.edit-act').click(function(){
        $(this).parent().find('.apt').show();

    });
    //
    $('.but-bil').click(function(){
        alert('sadasdsa')
        $(this).parent().find('.common-popup').show()
    })
    //��������
    $('.help-order .page .left dt').click(function(){
        $(this).toggleClass('active');
        $(this).siblings('dd').slideToggle('fast');
    })
    //�ҵĿ�ȯ
    $('.my-kj .am-tabs-nav .ul-list li.items').click(function(){
        var amTabPanel=$(this).parents('.ul-list').siblings('.am-tabs-bd');
        var $index=$(this).index();
        $(this).addClass('active').siblings('.items').removeClass('active');
        amTabPanel.find('.am-tab-panel').eq($index).show().siblings('.am-tab-panel').hide();
        return false
    })
    //�ҵ����۵���
    $(".evaluation .addbtn").click(function(){
        $(this).parents(".data-list").siblings(".evaluation .addcon").show();
        $(".evaluation .addbtn").hide()
    })
    //010213��ȯ����
    $('#efeiyi-dh').click(function(){
        $(this).siblings('.ytacu').show();
        $('.ytacu .dh .no').click(function(){
            $(this).parent().parent().parent().parent().find('.ytacu').hide();
        })
        return false
    })
    //010213��ȯ����2
    $('#efeiyi-dh').click(function(){
        $(this).siblings('#ytacu2').show();
        $('.ytacu .cg .btn').click(function(){
            $(this).parent().parent().parent().parent().find('#ytacu2').hide();
        })
        return false
    })
    $('.my-kj .am-tabs-nav .ul-list li.items1').mouseenter(function(){
        $(this).addClass('active').siblings().removeClass('active')
    })
    /*  var GradList = document.getElementById("quacorgrading").getElementsByTagName("input");*/
    var GradList = $(".quacorgrading input");
    for(var i=0;i < GradList.length;i++){
        GradList[i].onmouseover = function(){
            for(var Qi=0;Qi<GradList.length;Qi++){
                GradList[Qi].class.backgroundPosition = '-36px -21px';
            }
            for(var Qii=0;Qii<this.name;Qii++){
                GradList[Qii].style.backgroundPosition = '-5px -21px';
            }
        }
    }
    $(function(){
        var dlwidth = $(".recommend .carousel .car-content").outerWidth(true);
        var dllist = $(".recommend .carousel dl").size();
        var nuke = 0;

        $("#a_car-right").click(function(){
            $("#a_car-left").removeClass("hover")
            if(nuke>dllist-5){
                nuke=dllist-5;
                $(this).addClass("hover")
            }else{
                nuke++;
                $(".recommend .carousel .detall").stop().animate({"left":-nuke*dlwidth},500)
            }
        })
        $("#a_car-left").click(function(){
            $("#a_car-right").removeClass("hover")
            if(nuke<=0){
                nuke=0;
                $(this).addClass("hover")
            }else{
                nuke--;
                $(".recommend .carousel .detall").stop().animate({"left":-nuke*dlwidth},500)
            }
        })
    })
    //�ҵ�yifeiyi���̺���Ʒ�ղ�
    $(".efeiyi-collect .efeiyi-head .efeiyi-right li").click(function(){
        var _myindex = $(this).index();
        $(this).addClass("active").siblings().removeClass("active");
        $(".efeiyi-col-box .efeiyi-col-tab").eq(_myindex).show().siblings().hide()
    })
    //�ҵ�yifeiyi���̺���Ʒ�ղض���1
    var lilist = $(".efeiyi-col-box .add1-tab .efeiyi-col-tzoom .efeiyi-tzoom-list ul li").size()
    var liwidth = $(".efeiyi-col-box .efeiyi-col-tab .efeiyi-col-tzoom .efeiyi-tzoom-list ul li").outerWidth(true);
    var dhul = $(".efeiyi-col-box .efeiyi-col-tab .efeiyi-col-tzoom .efeiyi-tzoom-list ul")
    var linull = 0;
    $(".efeiyi-col-box .add-rigt").click(function(){
        $(".efeiyi-col-box .add-left").removeClass("add")
        if(linull>=lilist-4){
            $(this).addClass("add")
            linull=lilist-4;
        }else{
            linull++;
            dhul.animate({"left":-linull*liwidth},500)
        }
    })
    $(".efeiyi-col-box .add-left").click(function(){
        $(".efeiyi-col-box .add-rigt").removeClass("add")
        if(linull<=0){
            $(this).addClass("add")
            linull=0;
        }else{
            linull--;
            dhul.animate({"left":-linull*liwidth},500)
        }
    })
})