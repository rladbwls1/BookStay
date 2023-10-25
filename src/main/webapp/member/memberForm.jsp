<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.MemberDAO" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ include file="color.jsp"%>

<% request.setCharacterEncoding("UTF-8");%>
<html>
<head>
<title>회원가입</title> 
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
  
    // 아이디 중복 여부를 판단
    function openConfirmid(userinput) {
        // 아이디를 입력했는지 검사
        if (userinput.id.value == "") {
            alert("아이디를 입력하세요");
            return;
        }
        // url과 사용자 입력 id를 조합합니다.
        url = "confirmId.jsp?id="+userinput.id.value ;
        
        // 새로운 윈도우를 엽니다.
        open(url, "confirm",  "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
    }
    
    

    function validatePassword(inputField) {
        var pw = inputField.value;
        var pwError = document.getElementById("pwError");

        // 비밀번호 유효성 검사
        if (pw.length < 6 || pw.length > 12 || !/^(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[A-Z]).{6,12}$/.test(pw)) {
            pwError.textContent = "비밀번호는 6자 이상 12자 이하, 숫자,특수문자및 대문자를 포함해야 합니다.";
            pwError.style.fontSize = "12px"; // 글자 크기를 12px로 설정
            inputField.style.border = "1px solid red"; // 필드 테두리를 빨간색으로 변경
        } else {
            pwError.textContent = "";
            inputField.style.border = "1px solid black"; // 필드 테두리를 원래 색으로 변경
        }
    }

    function checkIt() {
        var form = document.userinput;
        var id = form.id.value;
        var pw = form.pw.value;
        var name = form.name.value;
        var email = form.email.value;
        var birth = form.birth.value;
        var addr = form.addr.value;
        var pnum = form.pnum.value;

        // 아이디 유효성 검사
        if (id.length < 6 || id.length > 12 || !/^[a-zA-Z0-9]+$/.test(id) ) {
            alert("아이디는 6자 이상 12자 이하, 영문과 숫자만 허용됩니다");
            return false;
        }

        // 나머지 필드의 유효성 검사도 추가하세요.

        // 모든 조건을 통과한 경우 폼을 제출
        return true;
    }
    
    //비밀번호 모자이크 해제/시ㄹ행
    function togglePasswordVisibility() {
    var passwordField = document.getElementById("passwordField");

    if (passwordField.type === "password") {
        passwordField.type = "text"; // 모자이크 해제
    } else {
        passwordField.type = "password"; // 다시 모자이크
    }
}

    
</script>

<body>

<form method="post" action="memberPro.jsp" name="userinput" onSubmit="return checkIt()">
  <table width="600" border="1" cellspacing="0" cellpadding="3" align="center" >
    <tr> 
    <td colspan="2" height="39" align="center" bgcolor="<%=value_c%>" >
       <font size="+1" ><b>회원가입</b></font></td>
    </tr>
   
 

    <tr> 
      <td width="200"> <label >아이디</label></td>
     <td width="400"> 
        <input type="text" name="id" size="10" maxlength="12">
        <input type="button" name="confirm_id" value="ID중복확인" 
        							OnClick="openConfirmid(this.form)">
      </td>
      
    </tr>
    
    <tr> 
 <td width="200"> <label for="pw">비밀번호</label></td>
<td width="400"> 
    <input type="password" id="passwordField" name="pw" size="15" maxlength="12" onblur="validatePassword(this)" style="width:220px;"><button type="button" onclick="togglePasswordVisibility()">비밀번호 표시</button><br/>
    <span id="pwError" style="color: red;"></span>
    
</td>
    <tr>  
      <td width="200">
	<label for="name">이름</label>
		</td>
      <td width="400"> 
        <input type="text" name="name" size="15" maxlength="12" style="width:220px;">
      </td>
    </tr>
    <tr >  
      <td width="400">
		 <label for="email">이메일</label>
		</td>
      <td width="400"> 
        <input type="email" name="email" size="15" maxlength="12"  style="width:220px;">
      </td>
    </tr>
    <tr>  
      <td width="200">
		  <label for="birth">생년월일</label>
	</td>
      <td width="400"> 
        <input type="date" name="birth" size="15" maxlength="12" required style="width:220px;">
      </td>
    </tr>
    <tr>  
      <td width="200">
		  <label for="addr">주소</label>
	</td>
      <td width="400"> 
        <input type="text" name="addr" size="15" maxlength="12" required style="width:220px;">
      </td>
    </tr>
    <tr>  
      <td width="200">
		  <label for="pnum">휴대폰번호</label>
	</td>
      <td width="400"> 
        <input type="text" name="pnum" size="15" maxlength="12"  required style="width:220px;">
      </td>
    </tr>
    
    <tr> 
      <td colspan="2" align="center" bgcolor="<%=value_c%>"> 
          <input type="submit" name="confirm" value="등   록" >
          <input type="reset" name="reset" value="다시입력">
          <input type="button" value="가입안함" onclick="javascript:window.location='main.jsp'">
          <input type="button" value="로그인하기" onclick="javascript:window.location='../login/loginform.jsp'">
      </td>
    </tr>
  </table>
</form>
</body>
</html>