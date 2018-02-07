$(document).on('scroll', function(){
	if($(document).scrollTop() > 300 && !$('header').hasClass('sticky')){
		$('header').addClass('sticky');
	}
	else if ($(document).scrollTop() < 300 && $('header').hasClass('sticky')){
		$('header').removeClass('sticky');
	}
})

$(document).on('mousedown','a',function(e){
	if ($(this).attr('href') != undefined && $(this).attr('href') != '' && /(#\w+$)/.test($(this).attr('href'))){
		var samePage = /(\w)+(?=#\w+$)/.exec($(this).attr('href'))
		samePage = samePage[0]
		if (samePage === pageClass){
			e.preventDefault();
			var element = /(#\w+$)/.exec($(this).attr('href'))
			element = element[0]
			$('html,body').stop().animate({
				scrollTop:$(element).offset().top - 100,
				easing: 'swing',
			},500)
		}
	}
})
	// Set the date we're counting down to
	var countDownDate = ''

	// Update the count down every 1 second
	var x = setInterval(function() {

	  // Get todays date and time
	  var now = new Date().getTime();

	  // Find the distance between now an the count down date
	  var distance = countDownDate - now;

	  // Time calculations for days, hours, minutes and seconds
	  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
	  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

	  // Display the result in the element with id="demo"
	  console.log(days + "d " + hours + "h " + minutes + "m " + seconds + "s ")
	  $('#countdown-timer .countdown-days').html(days)
	  $('#countdown-timer .countdown-hours').html(hours)
	  $('#countdown-timer .countdown-minutes').html(minutes)
	  $('#countdown-timer .countdown-seconds').html(seconds)
	  //document.getElementById("demo").innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";

	  // If the count down is finished, write some text 
	  if (distance < 0) {
	    clearInterval(x);
	    //document.getElementById("demo").innerHTML = "EXPIRED";
	  }
	}, 1000);


$(document).ready(function(){
	if ($('#date-container').attr('data-date') != undefined){
		countDownDate = new Date($('#date-container').attr('data-date'))
	}
	if (window.location.hash){
		$('html, body').stop().animate({
			scrollTop: $(window.location.hash).offset().top -100,
			easing: 'swing'
		},500)
	}
})
