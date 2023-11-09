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
    	String id = (String)session.getAttribute("sid");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pnum = request.getParameter("pnum");
        String pw = request.getParameter("pw");
        String addr = request.getParameter("addr");
        dto.setId(id);
        dto.setName(name);
        dto.setEmail(email);
        dto.setPnum(pnum);
        dto.setPw(pw);
        dto.setAddr(addr);


    MemberDAO manager = MemberDAO.getInstance();

    
    int updateResult = manager.updateMember(dto);

    // 변경 결과에 따라 메시지를 표시하고 적절한 페이지로 리디렉션
    if (updateResult == 1) { 
           manager.humanRelease(id);%>
          <script>alert("수정이 잘되었습니다");
         window.location="../views/main.jsp";
         </script>
        <% } else { %>
          <script>alert("오류가 있습니다 다른 업무보시는동안  부리나게 방법을 찾아보겠습니다 ");
          window.location="/BookStay/views/main.jsp";</script>
        <% } %>
</body>
</html>