var count = 1;

document.getElementById('cadd').addEventListener('click', function() {
  var popup = document.getElementById('pop');
  var newContent = document.createElement('div');
  count += 1;
  newContent.innerHTML = `
    <h5>객실${count}</h5>
    <p>성인 <input type="number" id="adult${count}" name="adult" value="2"/></p><br>
    <p>어린이 (만 17세 미만) <input type="number" id="kids${count}" name="kids" value="0"/></p>
    <button type="button" class="btn btn-danger cRemove">객실 삭제</button>
  `;
  
  popup.appendChild(newContent);
  updateRoomCount();
  
  newContent.querySelector('.cRemove').addEventListener('click', function() {
    count -= 1;
    popup.removeChild(newContent);
    updateRoomCount();
  });
});
function updateRoomCount() {
  var totalAdults = 0;
  var totalKids = 0;
 
  for (var i = 2; i <= count; i++) {
    adultValue = parseInt(document.getElementById('adult' + i).value);
    kidsValue = parseInt(document.getElementById('kids' + i).value);

    totalAdults += adultValue;
    totalKids += kidsValue;
    alert('총 성인: ' + totalAdults + ', 총 어린이: ' + totalKids);
  }

}
var rortlf = document.getElementById('rortlf');
function updateButtonValue() {
	
  var popBtn = document.getElementById('popBtn');
  var adult = parseInt(document.getElementById('adult').value, 10); // 정수로 변환
  var kids = parseInt(document.getElementById('kids').value, 10); // 정수로 변환
  var totalValue = adult + kids;
  popBtn.value = "객실 " + count + "개, 인원 " + totalValue + "명";
  rortlf.value = count;
}