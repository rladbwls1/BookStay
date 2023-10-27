<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />

<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("sid"); // 사용자 아이디 가져오기

    if (userId != null) {
        MemberDTO user = dao.myInfo(userId); // 사용자 정보 조회
        

        if (user != null) {
            // 여기서 user 객체를 사용하여 사용자 정보에 접근할 수 있습니다.
             if ("admin".equals(userId)) {
            
%>
<%@ include file="../views/menu.jsp" %>
<html>
<head>
    <title>어서오세요</title>
</head>
<body>
<h2>마이페이지</h2>
<hr />

<button onclick="window.location='myQuestion.jsp'">1:1문의글 보기</button>
<hr />
<table border="1">
    <tr>
        <td>아이디</td>
        <td><%= userId %></td>
    </tr>
    <tr>
        <td>비밀번호</td>
        <td><%= user.getPw() %></td>
    </tr>
    <tr>
        <td>이름</td>
        <td><%= user.getName() %></td>
    </tr>
    <tr>
        <td>이메일</td>
        <td><%= user.getEmail() %></td>
    </tr>
    <tr>
        <td>생일</td>
        <td><%= user.getBirth() %></td>
    </tr>
    <tr>
        <td>주소</td>
        <td><%= user.getAddr() %></td>
    </tr>
    <tr>
        <td>전화번호</td>
        <td><%= user.getPnum() %></td>
    </tr>
</table>
<input type="button" value="뒤로가기" onclick="location.href='/BookStay/views/main.jsp'">
<a href="logout.jsp">로그아웃</a>
<a href="/BookStay/admin/adminlist.jsp">관리자 예약 내역 확인</a>
</body>

<% 	
             }
        } else {
    %>
    <script>
        alert("사용자 정보를 가져오는 중 오류가 발생했습니다.");
        window.location = "loginform.jsp";
    </script>
    <%
        }
        } else {
    %>
    <script>
        alert("세션이 만료되었거나 로그인하지 않았습니다. 다시 로그인해주세요.");
        window.location = "loginform.jsp";
    </script>
    <%
        }
    %>