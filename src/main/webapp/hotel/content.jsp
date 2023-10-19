<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="hotel.bean.hotelDTO"/>
<%
 request.setCharacterEncoding("UTF-8");
 int ref= Integer.parseInt(request.getParameter("ref"));
 String checkin= request.getParameter("checkin");
 String checkout= request.getParameter("checkout");
 String adult= request.getParameter("adult");
 String kids= request.getParameter("kids");
 hotelDAO dao = new hotelDAO();
 dto=dao.getMainList(ref);
 String img=dto.getImg();
 String[] imgArray= img.split(",");
 
%>
<hr />
<%=dto.getTitle() %><br>
<%=dto.getAddress() %><br>
<%=dto.getAprice() %>
<a href="">후기</a><a href="">찜목록</a>
<%for(int i=0;i<imgArray.length; i++){
	%>
		<img src="">	
	
	<%
} %>





