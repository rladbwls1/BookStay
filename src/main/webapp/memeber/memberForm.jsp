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
</script>


<body>

<form method="post" action="memberPro.jsp" name="userinput" onSubmit="return checkIt()">
  <table width="600" border="1" cellspacing="0" cellpadding="3" align="center" >
    <tr> 
    <td colspan="2" height="39" align="center" bgcolor="<%=value_c%>" >
       <font size="+1" ><b>회원가입</b></font></td>
    </tr>
   
    <tr> 
      <td width="200" bgcolor="<%=value_c%>"><b>아이디 입력</b></td>
      <td width="400" bgcolor="<%=value_c%>">&nbsp;</td>
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
      <td width="200"> 
  	<label for="pw">비밀번호</label>
  </td>
      <td width="400" > 
        <input type="password" name="pw" size="15" maxlength="12">
      </td>
    <tr>  
      <td width="200">
	<label for="name">이름</label>
		</td>
      <td width="400"> 
        <input type="text" name="name" size="15" maxlength="12">
      </td>
    </tr>
    <tr>  
      <td width="200">
		 <label for="email">이메일</label>
		</td>
      <td width="400"> 
        <input type="email" name="email" size="15" maxlength="12">
      </td>
    </tr>
    <tr>  
      <td width="200">
		  <label for="birth">생년월일</label>
	</td>
      <td width="400"> 
        <input type="date" name="birth" size="15" maxlength="12" required>
      </td>
    </tr>
    <tr>  
      <td width="200">
		  <label for="addr">주소</label>
	</td>
      <td width="400"> 
        <input type="text" name="addr" size="15" maxlength="12" required>
      </td>
    </tr>
    <tr>  
      <td width="200">
		  <label for="pnum">휴대폰번호</label>
	</td>
      <td width="400"> 
        <input type="text" name="pnum" size="15" maxlength="12"  required>
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
