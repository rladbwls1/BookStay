<%@page import="hotel.bean.hotelDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");
hotelDAO dao = new hotelDAO();
ArrayList<hotelDTO> list = dao.test();
boolean result=false;
for(hotelDTO dto : list){
	String img=dto.getImg();
	int [] block ={46,47};
	result=dao.checkRoom(block,1,dto.getRef());
	
	if(img!=null){
	String [] arrayimg = img.split(",");%>
	}
	<img src="BookStay/upload/<%=arrayimg[0]%>">
	result = <%=result %>
	<%//dao.priceUpdate(dto.getNum());%>	
	<%=dto.getTitle()%>&nbsp;<%=dto.getAprice()%>원
	<a href="hotelContent.jsp?ref=<%=dto.getRef()%>">예약</a>
	<button onclick="window.location='Delete.jsp?num=<%=dto.getNum()%>&re_step=<%=dto.getRe_step()%>'">삭제</button>
	<hr />
<% }}%>
<button onclick="window.location='hotelWriteForm.jsp'">등록 </button>


