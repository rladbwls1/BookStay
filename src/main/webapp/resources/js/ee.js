var popBtn = document.getElementById("popBtn");
var popup = document.querySelector(".popup");
var cBtn = document.getElementById("cBtn");
var cR = document.querySelector('.cRemove');

popBtn.addEventListener("click", function(){
	if(popup.classList.contains('on')){
		popup.classList.remove('on');
	}else{
		popup.classList.add('on');
	}
});
/*
document.addEventListener("click", function(event) {
  if (!popup.contains(event.target) && event.target !== popBtn && event.target !== cBtn && event.target !== cR) {
    popup.classList.remove('on');
  }
});
*/
cBtn.addEventListener("click", function(){
	if(popup.classList.contains('on')){
		popup.classList.remove('on');
	}else{
		popup.classList.add('on');
	}
});