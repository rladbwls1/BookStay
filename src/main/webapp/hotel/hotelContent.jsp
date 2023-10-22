<%@page import="java.util.ArrayList"%>
<%@page import="hotel.bean.hotelDTO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");
session.setAttribute("sid", "admin");
String id = (String)session.getAttribute("sid");
 request.setCharacterEncoding("UTF-8");
 int ref= Integer.parseInt(request.getParameter("ref"));
 String checkin= request.getParameter("checkin");
 String checkout= request.getParameter("checkout");
 String adult= request.getParameter("adult");
 String kids= request.getParameter("kids");
 hotelDAO dao = new hotelDAO();
 hotelDTO maindto=dao.getContentMain(ref);
 ArrayList<hotelDTO> list=dao.getContent(ref);
 String mainimg=maindto.getImg();
 String[] imgArray= mainimg.split(",");
%>
<hr />
<%=maindto.getTitle() %><br>
<%=maindto.getAddress() %><br>
<%=maindto.getAprice() %>
<a href="">후기</a><a href="">찜목록</a>
<%for(int i=0;i<imgArray.length; i++){
	%>
		<img src="/BookStay/upload/<%=imgArray[i]%>">
	<%
} %>

<hr/>
<% 
for(hotelDTO dto : list){
	%>
	<form action="/horder/reserveForm.jsp" method="post">
	<%=dto.getRoomtype()%>
	<%if(id.equals("admin")){
	%>
	<button type="button" onclick="window.location='hotelUpdateForm.jsp?num=<%=dto.getNum()%>&re_step=<%=dto.getRe_step()%>&ref=<%=ref%>'">수정</button>
	<button type="button" onclick="window.location='hotelDelete.jsp?num=<%=dto.getNum()%>&re_step=<%=dto.getRe_step()%>&ref=<%=ref%>'">삭제</button>
	<%	
	} %> 
	<button type="submit">예약</button><br />
	<%=dto.getContent() %><br />
	성인 : <%=dto.getAprice() %><br />
	아동 : <%=dto.getKprice()%><br />
	<img src="/BookStay/upload/<%=dto.getImg()%>">
	</form>
	<hr />
	<%
	
}
%>
<button type="button" onclick="window.location='hotelWriteForm.jsp?ref=<%=ref%>'">방 등록</button>
<script>

</script>

