<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="hotel.bean.MemberDAO"%>
<%
MemberDAO mdao = MemberDAO.getInstance();
String id = (String) session.getAttribute("sid");
int grade= mdao.checkGrade(id);
%>    
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="/BookStay/resources/css/main_bar.css"/>
</head>
<body>
<div id="header">
   <div id="login">
      <%if(grade==11) { // 세션이 없다면 수행
    String cid = null, cpw = null, cauto = null;
    Cookie[] cookies = request.getCookies();
  
       if (cookies != null) {
              for (Cookie c : cookies) {
                  if (c.getName().equals("cid")) { cid = c.getValue(); }
                  if (c.getName().equals("cpw")) { cpw = c.getValue(); }
                  if (c.getName().equals("cauto")) { cauto = c.getValue(); }
               }  
             }
       if (cid != null && cpw != null && cauto != null) {
          response.sendRedirect("/BookStay/member/loginPro.jsp");   
       }
    if (cid == null || cpw == null || cauto == null) { %>
<div><button class="btn"><a href="/BookStay/member/loginform.jsp">로그인</a></button></div>
		<div><button class="btn"><a href="/BookStay/member/memberForm.jsp">회원가입</a></button></div>
		<%}				
		}if(grade==0 || grade==99){ %>
		<div><button class="btn"><a href="/BookStay/member/logout.jsp">로그아웃</a></button></div>
		<div class="dropdown">
		  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
		    MyPage
		  </button>
		  <ul class="dropdown-menu">
		    <li><a class="dropdown-item" href="../member/memberinfo.jsp">회원정보</a></li>
		    <li><a class="dropdown-item" href="../board/myQuestion.jsp">나의 질문</a></li>
		  </ul>
		</div>
		<%}%>
		<div class="dropdown">
		  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
		    고객센터
		  </button>
		  <ul class="dropdown-menu">
		    <li><a class="dropdown-item" href="../board/notice.jsp">공지사항</a></li>
		    <li><a class="dropdown-item" href="../board/QnAList.jsp">자주하는질문</a></li>
		  </ul>
		</div>
		<!-- <div><a href="/BookStay/board/notice.jsp">고객센터</a></div> -->
		<%if(grade==99){ %>
		<div><a href="/BookStay/admin/adminMain.jsp">관리자페이지</a></div>
		<%} %>	
	</div>
	<div id="logo">
		<a href="../views/main.jsp">
			BookStay
		</a>
	</div>
	</div>
	<hr id="hr"/>
</body>
</html>