$(function(){
	$('.box').hover(function(){
		$(this).children(".BG").css('background','none');
		$(this).children(".txt").css('background','#fff').css('color','#000')
		$(this).children(".img-mutual-text1").css('color','#000').find('a').css('color','#000');
		$(this).children("a:link,a:visited").css('color','#000');
	},function(){
		$(this).children(".BG").css('background','rgba(60,96,140,0.3)');
		$(this).children(".txt").css({'background':''});
		$(this).children(".img-mutual-text1").css('color','#fff').find('a').css('color','#fff');
		$(this).children("a:link,a:visited").css('color','#fff');
	})
})

