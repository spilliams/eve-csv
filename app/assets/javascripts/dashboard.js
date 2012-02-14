$(document).ready(function(){
	$(".tab-nav-link").click(function(){
		c=$(this).attr('id').split('-')[0];
		$(".tab-active").removeClass('tab-active');
		$("#tab-"+c).addClass('tab-active');
	});
});