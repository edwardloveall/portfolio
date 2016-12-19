$(document).ready(function() {
  var nav = $('nav.main');
  var contentStart = nav.offset().top + nav.outerHeight();
  var windowHeight = $(window).outerHeight();
  var threshold = windowHeight * .7;
  var instant = 1;
  var referringSite = document.referrer != "";

  if (contentStart > threshold && referringSite) {
    $('html, body').animate({ 'scrollTop': contentStart }, instant);
  }
});
