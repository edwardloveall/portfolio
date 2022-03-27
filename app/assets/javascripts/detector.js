import * as bowser from "./bowser";

function browserInitials() {
  var name = bowser.name.toLowerCase();
  var words = name.split(" ");
  var initials = "";

  for (var i = 0; i < words.length; i++) {
    initials += words[i][0];
  }

  return initials;
}

function browserMajorVersion() {
  var version = bowser.version;
  var major = version.replace(/\..+/, "");

  return "v" + major;
}

(function () {
  document.body.classList.add(browserInitials(), browserMajorVersion());
})();
