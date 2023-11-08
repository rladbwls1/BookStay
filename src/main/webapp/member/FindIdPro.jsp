<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />

<jsp:setProperty property="*" name="dto" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Recovery</title>
</head>
<body>
  <% 
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String pnum = request.getParameter("pnum");
    
    // 이름, 이메일, 휴대폰 번호를 사용하여 아이디를 찾습니다.
    String id = MemberDAO.getInstance().findId(name, email, pnum);
    System.out.println(name+","+email+","+pnum);
    System.out.println(id);
    
	//asd, asd@naver.com, 123-1 = abcdefg
    if (id == null) {
    %>
    <script>
        alert("입력한 정보가 일치하지 않습니다. 다시 입력해주세요.");
        // 데이터가 일치하지 않을 때 현재 페이지에 남음
        // 현재 페이지에 다시 데이터 입력을 받는 폼을 두는 등의 방법으로 구현할 수 있음
    </script>
    <%
    } else {
        // 데이터가 일치하는 경우 Dispatcher 방식으로 FindIdShow.jsp로 이동
    	 response.sendRedirect("FindIdShow.jsp?id=" + id);
    }
%>
</body>
</html>
