<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.MemberDAO" %>   
<%@ page import="hotel.bean.MemberDTO" %>
<% 
    String sid = (String) session.getAttribute("sid");
    String id = request.getParameter("pw");
%><!DOCTYPE html>
<html>
<head>

    <title>비밀번호 확인</title>
    <!-- JavaScript 코드 -->
    <script>
    function CV_checkPasswordPattern(str) {
        var pwField = document.getElementById("pw");
        var pwError = document.getElementById("pwError");

        if (str.length < 1) {
            pwField.classList.add("error-border");
            pwError.textContent = "비밀번호를 입력해주세요.";
            return false;
        } else {
            pwField.classList.remove("error-border");
            pwError.textContent = "";
            return true;
        }
    }
    function validateForm() {
        var pw = document.getElementById("pw").value;
        var pwValid = CV_checkPasswordPattern(pw);

        if (!pwValid) {
            return false;
        }
        // 서버로 데이터 전송
        return true;
    }
    </script>
        <link rel="stylesheet" href="/BookStay/resources/css/updateFirst.css" type="text/css">
</head>
<body>
        <form action="updateFirstPro.jsp" method="post"  onsubmit="return validateForm();">    
   			 <table border="1">
            <tr>
                <td class="hiddenshow"> </td>
                <td>
                    <div class="checkplease">  	
                    	 <div class="mainment"> 회원정보 수정</div><br/>
                        회원정보 확인을 위해 비밀번호를 입력해주세요
                    </div>
                </td>
            </tr>
          
          
            <tr>
                <td class="hiddenshow"><label for="pw">비밀번호</label></td>
                <td>
                    <input type="password" id="pw" name="pw" class="inputText" placeholder="비밀번호를 입력하세요" size="15" onblur="validatePassword(this, 'pwError')"> <br/>
                    <span id="pwError"  class="error-message"  style="color:red;"></span>
                </td>
            </tr>
          
            <tr>
                <td class="hiddenshow"> </td>
               
                <td>
                    <button type="submit" onclick="combineAndSubmit()" name="confirm" class="sumitinput">입력</button><br/>
                    <a href="/BookStay/member/FindPw.jsp" class="button_a">비밀번호 찾기</a>
                </td>
            </tr>
            <input type="hidden" name="id" value="<%= sid %>">
            </table>
        </form>
    
</body>
</html>