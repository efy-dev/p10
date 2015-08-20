$(function(){	
	//首页--轮播图效果
	function indexAnimate(){
	    var sliderMainLi=$('.focus .slider-main li');
	    var sliderNav=$('.focus .slider-nav');
	    var sliderNavLi=sliderNav.find('li');
	    sliderNavLi.eq(0).addClass('active');
	    var timer=null;
	    var _index=0;
	    sliderMainLi.eq(0).show();
	    sliderNavLi.hover(function(){
	        clearInterval(timer);
	        _index=$(this).index();
	        sliderMainLi.stop().eq($(this).index()).fadeIn().siblings().fadeOut();
	        $(this).addClass('active').siblings().removeClass('active');
	    },function(){
	        timer=setInterval(autoBanner,3000);
	    })
	    function autoBanner(){
	        _index++;
	        if(_index>=4){
	            _index=0;
	        }
	        sliderMainLi.stop().eq(_index).fadeIn().siblings().fadeOut();
	        sliderNavLi.eq(_index).addClass('active').siblings().removeClass('active');
	    }
	    timer=setInterval(autoBanner,3000);
	};indexAnimate();
	//首页--传承人轮播效果
	function passPerson(){
	    var goodUl=$('#item2 .goods-list ul');
	    var goodLi=$('#item2 .goods-list ul').find('li');
	    var goodLiSize=goodLi.length;
	    var goodLiWidth=goodUl.find('li').outerWidth(true);
	    var goodNum=$('#item2 .goods-num li');
	    var btnNext=$('#item2 .next');
	    var btnPrev=$('#item2 .prev');
	    var iSpeed=400;
	    goodUl.css({'width':+goodLiSize*goodLiWidth+'px'});
	    goodLi.find('.item-img').hover(function(){
	    	$(this).addClass('active');
	    },function(){
	    	$(this).removeClass('active');
	    })
	    goodNum.hover(function(){
	        goodUl.stop().animate({'margin-left':-$(this).index()*goodLiWidth+'px'},iSpeed)
	        $(this).addClass('active').siblings().removeClass('active');
	    })
	    var _index=0;
	    btnNext.click(function(){
	        _index++;
	        if(_index>=goodLiSize){
	            _index=0;
	        }
	        goodUl.stop().animate({'margin-left':-_index*goodLiWidth+'px'},iSpeed);
	        goodNum.eq(_index).addClass('active').siblings().removeClass('active');
	    });
	    btnPrev.click(function(){
	        _index--;
	        if(_index<0){
	            _index=goodLiSize-1;
	        }
	        goodUl.stop().animate({'margin-left':-_index*goodLiWidth+'px'},iSpeed);
	        goodNum.eq(_index).addClass('active').siblings().removeClass('active');
	    });
	};passPerson();
	//右侧悬浮菜单
	function sliderMenu(){
		var topHeight=$('.topbar').outerHeight(true)+$('.logo-search').outerHeight(true)+$('.focus').outerHeight(true);
		var sliderMenuHeight=$(document).outerHeight(true)-topHeight-$('.footer').outerHeight();
	    $('.slider-menu').css({'height':sliderMenuHeight+'px'});
	    $('.slider-menu .top').click(function(){
	        $('html,body').animate({'scrollTop':0},400);
	    });

		var arr = [0];//把sectit对应的几个位置标示出来
		$('.iscroll').each(function(){
			var offsettop = $(this).offset().top;
			//火狐有半个像素的情况，故取整
			arr.push(parseInt(offsettop));
		});
		
		$(window).scroll(function(){
			var d = parseInt($(document).scrollTop());
			for(var i = 0 ; i < arr.length ; i ++){
				if(arr[i]>=d){
					break;
				}
			}
			//给ul加fixed属性
			if(d>topHeight+46){
				$('.slider-menu ul').css({'position':'fixed','top':'0'});
			}else if(d<topHeight){
				$('.slider-menu ul').css({'position':'absolute','top':'46px'});
			}
			//判断offsetTop值  来加class="cur"
			$('.slider-menu li').each(function(){
				var i = $(this).index();
				if(d>=arr[i]){
					$('.slider-menu li').eq(i-1).addClass('cur').siblings('li').removeClass('cur');
				}
			})
		});
		$('.slider-menu .item').click(function(){
			var i = $(this).index()+1;
			$('html,body').animate({'scrollTop' : arr[i]+'px'},300);
		});
	};sliderMenu();
	//首页----产品展示
    $('.pro-lists .item').hover(function(){
        $(this).addClass('active');
    },function(){
        $(this).removeClass('active');
    });
	//品类首页新----
    $('.list-pro-item .item').hover(function(){
        $(this).addClass('active');
    },function(){
        $(this).removeClass('active');
    });


})




	












