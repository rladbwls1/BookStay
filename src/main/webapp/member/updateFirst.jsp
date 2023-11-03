<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.MemberDAO" %>   
<%@ page import="hotel.bean.MemberDTO" %>
<% 
    String sid = (String) session.getAttribute("sid");
    String id = request.getParameter("pw");
%>
<!DOCTYPE html>
<html>
<head> 
<!-- JavaScript 코드 -->
<script>
function confirmPasswordAndCloseModal() {
    var password = document.getElementById('pw').value; // 비밀번호 입력값을 가져옵니다.

    // 여기에서 비밀번호 유효성 검사를 수행합니다.
    // 유효성 검사에 통과하면 모달 창을 닫습니다.

    if (유효성검사에통과) {
        window.parent.closeModal(); // 모달 창을 닫는 함수 호출
        window.parent.location.reload(); // 부모 페이지를 새로 고치는 코드
        return false; // 폼의 기본 동작을 중지합니다.
    } else {
        alert('유효하지 않은 비밀번호입니다.');
        return false; // 폼의 기본 동작을 중지합니다.
    }
}
</script>

    <title>비밀번호 확인</title>
</head>
<body>
    <h1>회원정보수정을 하시려면 확인을 위해 비밀번호를 입력해주세요</h1>
     <form action="updateFirstPro.jsp" method="post">
        <label for="pw">비밀번호: </label>
        <input type="password" name="pw" id="pw"   placeholder="비밀번호를 입력하세요 " required>
        <input type="hidden" name="id" value="<%= sid %>" >
        <button type="submit">입력</button>
    </form>
     <button onclick="window.parent.closeModal()">뒤로가기</button>
    <button onclick="window.location='loginform.jsp'">아이디 | 비밀번호 찾기 </button>

</body>
</html>
