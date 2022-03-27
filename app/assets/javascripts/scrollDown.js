(function () {
  let nav = document.querySelector("nav.main");
  let contentStart = nav.offsetTop + nav.offsetHeight;
  let windowHeight = window.outerHeight;
  let threshold = windowHeight * 0.7;
  let instant = 1;
  let referringSite = document.referrer != "";

  if (contentStart > threshold && referringSite) {
    window.scroll({ top: contentStart });
  }
})();
