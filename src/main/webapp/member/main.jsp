<%@page import="hotel.bean.MemberDTO" %>
<%@page import="hotel.bean.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String sid = (String) session.getAttribute("sid");

if(sid==null) { // 세션이 없다면 수행
    String cid = null, cpw = null, cauto = null;
    Cookie[] cookies = request.getCookies();
  
    	if (cookies != null) {
       		 for (Cookie c : cookies) {
		            if (c.getName().equals("cid")) { cid = c.getValue(); }
		            if (c.getName().equals("cpw")) { cpw = c.getValue(); }
		            if (c.getName().equals("cauto")) { cauto = c.getValue(); }
   				}
       	  response.sendRedirect("loginPro.jsp"); 
		 }
    
    if (cid == null || cpw == null || cauto == null) {
%>

<h1>로그인 전 화면</h1>
<button onclick="window.location='loginform.jsp'">로그인</button>
<button onclick="window.location='memberForm.jsp'">회원가입</button>

<%
    }
} else {

%>


 
<h1>로그인 후 화면</h1>
 <h1>[<%=sid%>]님</h1>
<button onclick="window.location='logout.jsp'">로그아웃</button>
<button onclick="window.location='memberinfo.jsp'">마이페이지</button>
<button onclick="window.location='../views/main.jsp'">메인</button>
<%
}
%>
</body>
</html>