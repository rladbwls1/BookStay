<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous">
</script>
<style>
	#popup {
  max-height: 500px;
  overflow-y: auto; 
}
</style>

<div id="pop2">
<h5>객실2</h5>
    <p>성인 <input type="number" id="adult2" name="adult2" value="2" max="4" min="1"/></p><br>
    <p>어린이 (만 17세 미만) <input type="number" id="kids2" name="kids2" value="0" max="4" min="0"/></p>
    <button type="button" class="btn btn-danger cRemove">객실 삭제</button>
</div>
<div id="pop3">
<h5>객실3</h5>
    <p>성인 <input type="number" id="adult2" name="adult2" value="2" max="4" min="1"/></p><br>
    <p>어린이 (만 17세 미만) <input type="number" id="kids2" name="kids2" value="0" max="4" min="0"/></p>
    <button type="button" class="btn btn-danger cRemove">객실 삭제</button>
</div>
<div id="pop4">
<h5>객실4</h5>
    <p>성인 <input type="number" id="adult2" name="adult2" value="2" max="4" min="1"/></p><br>
    <p>어린이 (만 17세 미만) <input type="number" id="kids2" name="kids2" value="0" max="4" min="0"/></p>
    <button type="button" class="btn btn-danger cRemove">객실 삭제</button>
</div>
<script>
const deleteButtons = document.querySelectorAll('.cRemove');

//각 "객실 삭제" 버튼에 이벤트 리스너를 할당합니다.
deleteButtons.forEach((button) => {
 button.addEventListener('click', function () {
     // 클릭된 버튼의 부모 요소를 찾아서 삭제합니다.
     const pop = this.closest('div');
     pop.parentNode.removeChild(pop);
 });
});
</script>