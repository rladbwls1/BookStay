<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인 페이지</title>
        <style>
        .error-message {
            color: red;
        }
        .error-border {
            border: 2px solid red;
        }
    </style>
</head>
<body>
    <h1>반갑다 로그인 해라</h1>
<form method="post" action="loginPro.jsp" onsubmit="return validateForm();">
    id : <input type="text" name="id" id="id"><br/>
    <span id="idError" class="error-message"></span><br/>
    pw : <input type="password" name="pw" id="pw"><br/>
    <span id="pwError" class="error-message"></span><br/>
    자동로그인<input type="checkbox" name="cauto" value="1"><br>
    <input type="submit" value="Login">
</form>

    <button onclick="window.location='loginform.jsp'">아이디 | 비밀번호 찾기</button>
    <button onclick="window.location='memberForm.jsp'">회원가입하기</button>

   <script>
    function validateForm() {
        var idInput = document.getElementById("id");
        var pwInput = document.getElementById("pw");
        var id = idInput.value;
        var pw = pwInput.value;
        var idError = document.getElementById("idError");
        var pwError = document.getElementById("pwError");

        // 초기화: 이전 에러 스타일 및 메시지 제거
        idInput.classList.remove("error-border");
        pwInput.classList.remove("error-border");
        idError.innerHTML = "";
        pwError.innerHTML = "";

        if (id.trim() === "") {
            idError.innerHTML = "아이디를 입력하세요";
            idInput.classList.add("error-border");
            return false;
        }

        if (pw.trim() === "") {
            pwError.innerHTML = "비밀번호를 입력하세요";
            pwInput.classList.add("error-border");
            return false;
        }

        return true;
    }
</script>
</body>
</html>