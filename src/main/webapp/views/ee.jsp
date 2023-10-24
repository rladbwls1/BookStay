<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body><%@ page language="java" contentType="text/html; charset=UTF-8"
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

<!-- Button trigger modal -->
<button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="popup" id="popup">
        <div id="pop">
          <h5 id="roomCnt">객실1</h5>
          <p>성인 <input type="number" id="adult" name="adult" value="2"/></p><br>
          <p>어린이 (만 17세 미만) <input type="number" id="kids" name="kids" value="0"/></p>
          </div>
          <div id="roomCount">총 객실 수: 1</div>
          <button type="button" id="cadd" class="btn btn-secondary">객실 추가</button>
          <button type="button" id="cBtn" class="btn btn-primary">적용</button>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="/Hotel/resources/js/ee.js"></script>
<table border="1">
  <tr>
    <td colspan="3"><input type="checkbox" id="checkAll">전체 선택</td>  
  </tr>
  <tr>
    <td> <input type="checkbox" class ="chk"> Option 1<br></td>
    <td> <input type="checkbox" class ="chk"> Option 2<br></td>
    <td> <input type="checkbox" class ="chk"> Option 3<br></td>
  </tr>
</table>
 
<script src="/Hotel/resources/js/checkbox.js"></script>
 
</body>
</html>