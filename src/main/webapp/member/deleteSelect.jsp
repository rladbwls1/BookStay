<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>


<jsp:useBean id="dao" class="hotel.bean.MemberDAO"/>
<jsp:useBean id="dto" class="hotel.bean.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>
<h1>계정 삭제를 원하시면 아이디와 비밀번호를 입력해주세요</h1>
<%
	MemberDAO manager = MemberDAO.getInstance();
			request.setCharacterEncoding("utf-8");
		String sid= (String)session.getAttribute("sid");
			dto.setId(sid);

%>

<%
	//	String id=request.getParameter("id");// 
	
	//MemberDTO 객체에서 정보를 가져와서 필드에 저장
	String pw = request.getParameter("pw");

%>
<form action="deleteAndInsertPro.jsp" method="post">
    <label for="id">아이디: </label>
    <input type="text" name="id" id="id" required>
    <br />
    <label for="pw">비밀번호: </label>
    <input type="password" name="pw" id="pw" required>
    <br />
    <button type="submit">삭제</button>
</form>

<button onclick="window.location='loginform.jsp'">로그인다시 하기  </button>
<button onclick="window.location='Findidpw.jsp'">아이디 | 비밀번호 찾기 </button>
<button onclick="window.location='../views/main.jsp'">메인 </button>