window.onscroll = function() {
  var menu = document.getElementById("ul1");
  var header = document.getElementById("header");
  if (window.pageYOffset > header.clientHeight) {
    menu.classList.add("fixed-menu");
  } else {
    menu.classList.remove("fixed-menu");
  }
};