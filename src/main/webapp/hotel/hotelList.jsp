<%@page import="hotel.bean.hotelDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");
session.setAttribute("sid", "admin");

hotelDAO dao = new hotelDAO();
ArrayList<hotelDTO> list = dao.test();
for(hotelDTO dto : list){
	String img=dto.getImg();
	if(img!=null){
	String [] arrayimg = img.split(",");%>
	}
	<img src="BookStay/upload/<%=arrayimg[0]%>">
	<%//dao.priceUpdate(dto.getNum());%>	
	<%=dto.getTitle()%><%=dto.getAprice()%>원
	<a href="hotelContent.jsp?ref=<%=dto.getRef()%>">예약</a>
	<button onclick="window.location='Delete.jsp?num=<%=dto.getNum()%>&re_step=<%=dto.getRe_step()%>'">삭제</button>
	<hr />
<% }}%>
<button onclick="window.location='hotelWriteForm.jsp'">등록 </button>


