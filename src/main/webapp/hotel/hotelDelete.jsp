<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id=(String)session.getAttribute("sid");
if(!id.equals("admin")){
	%>
	<script>
		alert("관리자만 접근할수 있습니다.");
		window.location="/login/main.jsp";
	</script>
	<%
}
int num=Integer.parseInt(request.getParameter("num"));
int re_step=Integer.parseInt(request.getParameter("re_step"));
int ref=Integer.parseInt(request.getParameter("ref"));
hotelDAO dao= new hotelDAO();

if(re_step==1){
		
		dao.deleteHotel(num, re_step);
		dao.priceUpdate(num);
	%>
	<script>
		alert("삭제되었습니다. ");
		history.go(-1);
		
	</script>
	<%
}else{
	 	dao.deleteHotel(num, re_step);
	%>
	<script>
		alert("삭제되었습니다. ");
		window.location="/views/hlist.jsp";
	</script>
	<%
	
}
%>