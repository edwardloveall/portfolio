// i11 - Internet Explorer 11
// m12 - Microsoft Edge (12)
// s9 - Safari 9
// f47 - Firefox 47
// c51 - Chrome 51
// o30 - Opera 30

$(document).ready(function() {
  $('body').addClass(browserInitials());
})

function browserInitials() {
  var firstLetter = bowser.name[0].toLowerCase();
  var version = bowser.version.replace(/\..+/, '')

  return firstLetter + version;
}
