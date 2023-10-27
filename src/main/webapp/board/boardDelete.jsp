<%@page import="hotel.bean.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
if(!session.getAttribute("sid").equals("admin")){
	%>
	<script>
		alert("관리자만 접근할수 있습니다.");
		window.location="/login/main.jsp";
	</script>
	<%
	
} %>
<%
boardDAO dao = boardDAO.getInstance();
int num = Integer.parseInt(request.getParameter("num"));
int category = Integer.parseInt(request.getParameter("category"));
dao.boardDelete(num,category);
if(category==10){%>
%>
<script>
	alert("삭제 되었습니다.");
	window.location="notice.jsp";
</script>
<%}else if(category >= 20 && category<30){%>
<script>
	alert("삭제 되었습니다.");
	window.location="QnAList.jsp?category=<%=category%>";
</script>
<%}else if(category ==30){%>
	<script>
	alert("삭제 되었습니다.");
	window.location="myQuestion.jsp";
</script>
<%}%>