<%@page import="hotel.bean.hotelDAO"%>
<%@page import="oracle.jdbc.internal.OracleConnection.XSSessionOperationCode"%>
<%@page import="hotel.bean.adminDAO"%>
<%@page import="hotel.bean.HOrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");
String id = (String)session.getAttribute("sid");
HOrderDAO odao = new HOrderDAO();
hotelDAO hotel = new hotelDAO();

int renum = odao.getRecentOrder(id);
int totalpay = hotel.getRoomPrice(renum);
int paid = hotel.getRoomPrice(renum);
adminDAO dao = adminDAO.getInstance();
dao.reserveStatusUpdate(renum,totalpay,paid);
%>
 
<script>
	alert("결제가 완료 되었습니다.");
	window.location="/BookStay/member/memberlist.jsp";
</script>



