
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />
<jsp:setProperty property="*" name="dto" />
<%
request.setCharacterEncoding("UTF-8");
String checkid=request.getParameter("id");

%>

<%@ include file="../views/main_bar.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>


<style>

#font{
   
   margin-bottom:5px;
   margin-top:10px;
}

    

/* 헤더 끝 */
.table-container{
    width: 600px;
    height: 330px;
    margin: 0 auto;
    background-color: #F2F2F2;
    margin-top: 100px;
    border: none;
}

table {
    border: white;
    width: 65%; /* 수정: 테이블 폭을 80%로 조정 */
    margin:  10px 0; /* 테이블을 가운데 정렬 */
    border-collapse: collapse;
    background-color: white;
    text-decoration: none;
    font-size: 14px;
    color: black;
    border-radius: 15px;
}
.hiddenshow{
   display: none;
}

td {    
   
   margin:5px;
   width:110%;
    text-align: center;
    font-family: Arial, sans-serif;
    font-size: 14px;
}



table tr a {
    color: #999999;
    text-decoration: none;
}



/* submit 버튼 */
.sumitinput {
margin-top:10px;
margin-bottom:10px;
    width: 25%;
    background-color: #198754;
    height: 40px;
    border-radius: 8px;
    color: white;
    border: none;
    cursor: pointer;
}

.sumitinput:hover {
    background-color: #157347;
}


.pwcheck {
    width: 20%;
    color:white;
    background-color: #636363
;
    height: 35px;
    border-radius: 8px;
     color:white;
    border: none;
    cursor: pointer;
}

.idcheck:hover {
    background-color: 
#C9C9C9;
}

.pwcheck:hover {
    background-color:
#C9C9C9;
}




.inputText {
   left:0;
   margin-left:0px;
    width: 38%;
    height: 40px;
    border-radius: 8px;
    margin-top: 2px;
}

.text{
   margin-bottom:30px;
   margin-top:10px;
   background-color: none;
}





</style>
    <script>
        // 비밀번호 필드 유효성 검사 및 확인 함수
        function validatePassword(inputField, errorId) {
            var pw = inputField.value;
            var pwError = document.getElementById(errorId);

            if (pw.length < 6 || pw.length > 12 || !/^(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[A-Z]).{6,12}$/.test(pw)) {
                pwError.textContent = "비밀번호는 6자 이상 12자 이하, 숫자, 특수문자 및 대문자를 포함해야 합니다.";
                pwError.style.fontSize = "12px"; // 글자 크기를 12px로 설정
                inputField.style.border = "1px solid red"; // 필드 테두리를 빨간색으로 변경
            } else {
                pwError.textContent = "";
                inputField.style.border = "1px solid black"; // 필드 테두리를 원래 색으로 변경
            }
        }

        // 비밀번호 모자이크 해제/실행 함수
        function togglePasswordVisibility(inputFieldId) {
            var passwordField = document.getElementById(inputFieldId);

            if (passwordField.type === "password") {
                passwordField.type = "text"; // 모자이크 해제
            } else {
                passwordField.type = "password"; // 다시 모자이크
            }
        }

        // 비밀번호 확인 및 전송 함수
        function combineAndSubmit() {
            // 비밀번호 필드와 확인 필드를 가져옵니다.
            const passwordField = document.getElementById('passwordField');
            const password2 = document.getElementById('password2');

            // 비밀번호를 입력하지 않은 경우
            if (passwordField.value === "") {
                alert("비밀번호를 입력해주세요.");
                return; // 함수 종료
            }

            // 비밀번호 일치 여부 확인
            if (passwordField.value !== password2.value) {
                alert("비밀번호가 일치하지 않습니다. 확인해주세요.");
                return; // 함수 종료
            }

            // 여기에 추가적인 유효성 검사나 서버로의 전송 로직을 추가할 수 있습니다.
            // 만약 이 페이지에서 서버로의 전송이 필요하다면, 이곳에 AJAX 또는 form submit 로직을 추가하실 수 있습니다.

            // 예: document.forms[0].submit(); 또는 AJAX를 사용하여 서버로 데이터를 전송합니다.
        }
    </script>

<form method="post" action="updatePwPro.jsp">
	<input type="hidden" name="id" value="<%=checkid%>">
    <table border="1" class="table-container">
    	
       <tr>
         <td colspan="3" style="text-align:center;">
            <div id="font"><font size="+1">수정 하실 비밀번호를 입력하세요</font></div>
         </td>
       </tr>
       <tr>
         <td colspan="3" class="welcome"></td>
       </tr>
       <tr>
         <td width="200" class="hiddenshow">
           <label for="pw">변경 할 비밀번호</label>
         </td>
         <td width="400">
           <input type="password" id="passwordField" name="pw" size="15" placeholder="변경하실 비밀번호를 입력하세요" class="inputText" onblur="validatePassword(this, 'pwError')"  >
           <button type="button" onclick="togglePasswordVisibility('passwordField')" class="pwcheck">비밀번호 표시</button><br/>
           <span id="pwError" style="color: red;"></span>
         </td>
       </tr>
       <tr>
         <td width="200" class="hiddenshow">
           <label for="pw">비밀번호 확인</label>
         </td>
         <td width="400">
           <input type="password" id="password2" name="pw2" size="15" class="inputText" placeholder="변경하실 비밀번호를 입력하세요" onblur="validatePassword(this, 'pwError2')" >
           <button type="button" onclick="togglePasswordVisibility('password2')" class="pwcheck">비밀번호 표시</button><br/>
           <span id="pwError2" style="color: red;"></span>
         </td>
       </tr>
       <tr>
         <td class="hiddenshow"></td>
         <td>
           <input type="submit" name="confirm" value="등   록" onclick="combineAndSubmit()" class="sumitinput"/><br/>
         </td>
       </tr>
    </table>
</form>




</body>
</html>