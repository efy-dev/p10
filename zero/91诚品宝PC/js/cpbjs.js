$(function () {
	$('.search-home .title a').click(function () {
	     $(this).addClass('active').siblings().removeClass('active');
	});
	//查看证书部分
	$('.item-info .row a').click(function(){
		$('body').append('<div class="search-dialog"><div class="content"><div class="title"><i class="icon close" title="关闭"></i><img src="images/logo.png" width="140" alt="" /></div><div class="img"><img src="'+$(this).attr('href')+'" alt="" /></div><div class="info">'+$(this).attr('title')+'</div></div><div class="overlay"></div>');
		$('.overlay, .search-dialog .close').click(function(){
			$('.search-dialog').remove();
		})
		return false;
	})
	//详情页终--产品二维码展示
	$('.search-result .item li .acode').click(function(){
		return false;
	})
	$('.search-result .item li .acode').hover(function(){
		$(this).append('<span class="wechat"><i class="icon"></i><img src="'+$(this).attr('href')+'" alt="" /></span>');
		return false;
	},function(){
		$(this).find('.wechat').fadeOut();
	});

})