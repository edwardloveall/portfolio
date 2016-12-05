$(document).ready(function() {
  var mainStart = $('body > main').offset().top;
  var windowHeight = $(window).outerHeight();
  var buffer = 100;
  var mainThreshold = mainStart + buffer;
  var instant = 1;
  var referringSite = document.referrer != "";

  if (mainThreshold > windowHeight && referringSite) {
    console.log(mainThreshold);
    $('html, body').animate({ 'scrollTop': mainThreshold }, instant);
  }
});
