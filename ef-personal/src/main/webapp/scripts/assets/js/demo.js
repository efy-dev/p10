window.onload=function(){
$('.box').each(function(){
		$(this).mouseover(function(){
			$(this).children(".BG").css('background','none');
			$(this).children(".txt").css('background','#fff').css('color','#000')
			/*$(this).children(".img-mutual-text1").css('color','#000');*/
            $(this).children(".img-mutual-text1-a").css('color','#000');
		});
	});

$('.box').each(function(){
		$(this).mouseout(function(){
			$(this).children(".BG").css('background','rgba(60,96,140,0.3)');
			//$('.BG').css('background','rgba(60,96,140,0.3)');
			$(this).children(".txt").css('background','url(scripts/assets/images/tx12.gif) bottom').css('color','#fff')
			/*$(this).children(".img-mutual-text1").css('color','#fff');*/
            $(this).children(".img-mutual-text1-a").css('color','#fff');
		});
	})
}
