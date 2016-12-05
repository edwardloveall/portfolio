$(document).ready(function() {
  var mainStart = $('body > main').offset().top;
  var windowHeight = $(window).outerHeight();
  var buffer = 100;
  var mainThreshold = mainStart / 2;
  var instant = 1;
  var referringSite = document.referrer != "";

  if (mainThreshold < windowHeight && referringSite) {
    $('html, body').animate({ 'scrollTop': mainStart }, instant);
  }
});
