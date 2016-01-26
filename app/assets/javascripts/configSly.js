var sly;

function configSly() {
  var slyOptions = {
    horizontal: true,
    itemNav: 'forceCentered',
    mouseDragging: true,
    smart: true,
    speed: 300,
    touchDragging: true
  };
  sly = new Sly('nav.main', slyOptions).init();
  sly.activate(1, true);
  $('nav.main a').on('click', function(e) {
    sly.activate($(this));
    e.preventDefault();
  });
}
