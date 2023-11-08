<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<jsp:useBean id="member" class="hotel.bean.MemberDTO">
</jsp:useBean>

<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />
<jsp:setProperty property="*" name="dto" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경 결과</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%
    // 비밀번호를 입력 폼에서 받아옴
  String checkid = request.getParameter("checkid");

        String pw = request.getParameter("pw");


    MemberDAO manager = MemberDAO.getInstance();

    
    int updateResult = manager.updateOnlyPw(checkid,pw);

    // 변경 결과에 따라 메시지를 표시하고 적절한 페이지로 리디렉션
    if (updateResult == 1) {
        // 비밀번호 변경 성공
%>
        <script>
            alert("비밀번호 변경이 완료되었습니다.");
            window.location = "/BookStay/views/main.jsp";
        </script>
<%
    } else {
        // 비밀번호 변경 실패
%>
        <script>
            alert("비밀번호 변경 중에 오류가 발생했습니다.");
            window.location = "/BookStay/member/loginform.jsp";
        </script>
<%
    }
%>
</body>
</html>
