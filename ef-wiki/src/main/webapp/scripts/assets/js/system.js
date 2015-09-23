$(function(){
    //头部无logoA
    $('#menu').click(function(){
        $(this).find('.line').toggleClass('active');
        $('.menu-list').slideToggle('fast');
    });
    //
    //动态--关注--分类导航
    (function(){
        var tabsNav=$('.dis-q1-tabs .tabs-nav-1');
        var tabsBd=$('.tabs-bd .am-tab-panel')
        tabsNav.find('.item').click(function(){
            var index=$(this).index();
            $(this).addClass('active').siblings('.item').removeClass('active');
            tabsBd.eq(index).show().siblings('.am-tab-panel').hide();
        })
        tabsNav.find('.item-class').click(function(){
            tabsNav.hide().siblings('.tabs-nav-2').show();
            return false
        })
    })();

    //大师---作品
    (function(){
        var oParent=$('.master-works');
        oParent.find('.user').css('height',oParent.find('.img-bg').height()+'px');
        oParent.find('.user-nav li').click(function(){
            $(this).addClass('active').siblings('li').removeClass('active');
            $(this).append('<i class="user-arrow-up"></i>').siblings('li').find('.user-arrow-up').remove();
        });
        //
        $('img').load(function(){
            var box = $('.item');
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


    })();



})