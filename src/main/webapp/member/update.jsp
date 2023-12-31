<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />

<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />
<jsp:setProperty property="*" name="dto" />
<%
request.setCharacterEncoding("UTF-8");
String sid = (String) session.getAttribute("sid");
dto.setId(sid);

// MemberDTO 객체에서 정보를 가져와서 필드에 저장
	 String pw = request.getParameter("pw");
	 String email = request.getParameter("email");
    String addr = request.getParameter("addr");
    String pnum = request.getParameter("pnum");
    String name = request.getParameter("name");
																//1030 도준 수정
%>

<html>
<head>
<script>


function combineAndSubmit() {
    // 비밀번호 필드와 확인 필드를 가져옵니다.
    const passwordField = document.getElementById('passwordField').value;
    const password2 = document.getElementById('password2').value;

    // 비밀번호를 입력하지 않은 경우
    if (passwordField === "") {
        alert("비밀번호를 입력해주세요.");
        return; // 함수 종료
    }

    // 비밀번호 일치 여부 확인 ==기능실패
    if (passwordField !== password2) {
        alert("비밀번호가 일치하지 않습니다. 확인해주세요.");
        return; // 함수 종료
      
    }

    // 비밀번호가 일치하면 폼 제출 또는 다른 처리 코드를 추가하세요.



	
	
	
    const emailInput = document.getElementById('email');
    const emaillist = document.getElementById('emaillist');

    if (emaillist.value === 'type') {
        // 사용자가 이메일을 수동으로 입력하도록 선택한 경우
        const emailtxt = document.getElementById('emailtxt').value;
        const combinedEmail = emailInput.value + "@" + emailtxt;
        emailInput.value = combinedEmail;
        
        
        
    }
}
// 이메일 목록에서 선택 시 이메일 입력 필드 업데이트
function updateEmail() {
    const emaillist = document.getElementById('emaillist');
    const emailInput = document.getElementById('email');

    if (emaillist.value !== 'type') {
        // 스크롤에서 선택한 경우
        const selectedDomain = emaillist.value;
        emailInput.value = emailInput.value.split('@')[0] + selectedDomain;
    }
}

// 나머지 함수는 그대로 유지됩니다.



        // 아이디 중복 여부를 판단
        function openConfirmid(userinput) {
            // 아이디를 입력했는지 검사
            if (userinput.id.value == "") {
                alert("아이디를 입력하세요");
                return;
            }
            if (userinput.id.value == "guest") {
                alert("사용이 불가한 아이디입니다");
                return;
            }
            // url과 사용자 입력 id를 조합합니다.
            url = "confirmId.jsp?id="+userinput.id.value ;
            
            // 새로운 윈도우를 엽니다.
            open(url, "confirm",  "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
        }
        
    
     // 비밀번호 유효성 검사 및 비밀번호 모자이크 제어 함수
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
  
  

     
         
         //휴대폰번호 유효성 검사 
 function formatPhoneNumber(input) {
    // 휴대폰 번호에서 숫자만 남기고 다른 문자 제거
    var phoneNumber = input.value.replace(/\D/g, '');

    // 휴대폰 번호에 하이픈 추가
    if (phoneNumber.length >= 3 && phoneNumber.length <= 6) {
        phoneNumber = phoneNumber.replace(/(\d{3})(\d{0,4})/, '$1-$2');
    } else if (phoneNumber.length >= 7) {
        phoneNumber = phoneNumber.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3');
    }

    input.value = phoneNumber;
} 
        

</script>

<style>
	.UjinsHypboy{
	
		 box-sizing: border-box;
            width: 100%;
            height: 80px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            top: 0;
            left: 0;
            padding: 0 20px;
	
	}
</style>
    <link rel="stylesheet" href="/BookStay/resources/css/update.css" type="text/css">
</head>
<body>
   <div class="UjinsHypboy">
        <div id="logo">
            <a href="/BookStay/views/main.jsp">BookStay</a>
        </div>
        <div class="info">고객센터</div>
    </div>
<form method="post" action="updatePro.jsp">
    <table border="1" class="table-container">
    
    	<tr >
    	  <td colspan="3" style="text-align:center;">
    	  		<div id="font">	<font size="+4" >	<%=name%>님 환영합니다  !  </font></div>
    	  <td>
    	</tr>
    				<tr>
    					<td colspan="3" class="welcome">
    							수정하실 정보를 입력하세요 
    					</td>
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
                    <input type="password" id="password2" name="pw2" size="15"  class="inputText"   placeholder="변경하실 비밀번호를 입력하세요" onblur="validatePassword(this, 'pwError2')" >
                    <button type="button" onclick="togglePasswordVisibility('password2')" class="pwcheck">비밀번호 표시</button><br/>
                    <span id="pwError2" style="color: red;"></span>
                </td>
            </tr>
          <tr>
                <td width="400" class="hiddenshow">
                    <label for="email">이메일</label>
                </td>
                
	                <td width="400">
			 
			    <input type="text" id="email" class="inputText" placeholder="변경하실 이메일을 입력하시오"  name="email" size="14" />
			    <select class="box" id="emaillist" name="emaillist" onchange="updateEmail()">
			        <option value="type">직접 입력</option>
			        <option value="@naver.com">@naver.com</option>
			        <option value="@google.com">@google.com</option>
			        <option value="@hanmail.net">@hanmail.net</option>
			        <option value="@nate.com">@nate.com</option>
			        <option value="@kakao.com">@kakao.com</option>
			    </select>


	                </td>
            </tr>
  
  			 <tr>
                <td width="200" class="hiddenshow">
                    <label for="addr">주소</label>
                </td>
                <td width="400">
                    <input type="text" name="addr"  class="inputText"  size="15"  required   id="address" placeholder="변경하실 주소를 입력하세요 ">
                    <button type="button" class="btn" onclick="searchAddress()">주소검색</button>
                      <div id="result"></div>
                    
                </td>
            </tr>
        	<tr>
	                <td width="200" class="hiddenshow">
	                    <label for="pnum">변경할 휴대폰 번호</label>
	                </td>
	                <td >
	                    <input type="text" name="pnum"   style="width:70%;" size="15" placeholder="변경할 휴대폰번호"  class="inputText"  required  maxlength="13" oninput="formatPhoneNumber(this);">
	                </td>
            </tr>
        <tr>
             <td  class="hiddenshow"></td>
          		<td>
          		<input type="submit" name="confirm" value="등   록" onclick="combineAndSubmit()" class="sumitinput"/><br/>
          		   <a href="/BookStay/member/loginform.jsp" class="button_a">로그인하기</a>&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp<a href="/BookStay/views/main.jsp" class="button_b">메인으로</a>&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp<a href="/BookStay/member/update.jsp" class="button_c">Reset</a>
          		
          		</td>
        </tr>
    </table>
</form>


</body>
</html>