<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="resources/loginform.css" type="text/css">
    <style>
    </style>
    <script type="text/javascript">
        function CV_checkIdPattern(str) {
            var idField = document.getElementById("id");
            var idError = document.getElementById("idError");

            if (str.length < 1) {
                idField.classList.add("error-border");
                idError.textContent = "아이디를 입력해주세요.";
                return false;
            } else {
                idField.classList.remove("error-border");
                idError.textContent = "";
                return true;
            }
        }

        function CV_checkPasswordPattern(str) {
            var pwField = document.getElementById("pw");
            var pwError = document.getElementById("pwError");

            if (str.length < 1) {
                pwField.classList.add("error-border");
                pwError.textContent = "비밀번호를 입력해주세요.";
                return false;
            } else {
                pwField.classList remove("error-border");
                pwError.textContent = "";
                return true;
            }
        }

        function validateForm() {
            var id = document.getElementById("id").value;
            var pw = document.getElementById("pw").value;
            var idValid = CV_checkIdPattern(id);
            var pwValid = CV_checkPasswordPattern(pw);

            if (!idValid || !pwValid) {
                return false;
            }
            // 서버로 데이터 전송
            return true;
        }

    
    </script>
</head>

<body style="overflow:hidden;">
    <div class="loginbox">
    		<div class="loginbox_a">
        <div>
            <form method="post" action="loginPro.jsp" onsubmit="return validateForm();">
              	<table class="loginbox_b">
              	<tr  >
              		<td class="tableline">
              		<div class="bookment">
              		<a>
              		북 스테이에 온걸<br/> 환영해요  :)
              			</a>
              		</div>
              		<td>
              	</tr>
              	
              	<tr>
              	<td>
              	<input type="text" name="id" id="id" placeholder="아이디를 입력하세요" style="width:384px; height:45px; border-radius: 8px; margin-top:10px;">
              	    <span id="idError" class="error-message"></span><br/><br/>
              	</td>
              	</tr>
              	
              	<tr>
              	<td>
              	<input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요" style="width:384px; height:45px; border-radius: 8px; margin-top:10px;" ><br/>
                <span id="pwError" class="error-message"></span><br/>
              	</td>
              	</tr>
              	
      		<tr>
      			<td>
      			
      		  <% if (request.getParameter("loginFailed") != null) { %>
                <span class="error-message">아이디나 비밀번호를 다시 확인해주세요.</span><br/>
                <% } %>
                  <div>
                    <input type="checkbox" name="cauto" value="1">자동로그인
                    <input type="submit" value="Login"  class="logininput">
                </div>
      		</td>
      		</tr>   
                </table>
            </form>

        </div>
        <div class="button">
        
        <a href="FindId.jsp" class="button_a">아이디 찾기</a>  | <a href="FindPw.jsp"class="button_b">비밀번호 찾기</a> | <a href="memberForm.jsp"class="button_c">회원가입</a> | <a href="../views/main.jsp"class="button_d"> 홈으로 가기</a>       
        </div>
        </div>
    </div>
</body>

<div class="UjeansHyboy">
    <div id="logo">
        <a href="/BookStay/views/main.jsp">
            BookStay
        </a>
    </div>
    <div class="info">고객센터</div>
</div>

</html>
