<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hotel.bean.hotelDTO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%request.setCharacterEncoding("UTF-8");
MemberDAO mdao = MemberDAO.getInstance();
String sid = (String) session.getAttribute("sid");
int id= mdao.checkGrade(sid);
 int ref= Integer.parseInt(request.getParameter("ref"));
 String checkin= request.getParameter("checkin");
 String checkout= request.getParameter("checkout");
 String adult= request.getParameter("adult");
 String kids= request.getParameter("kids");
 hotelDAO dao = new hotelDAO();
 hotelDTO maindto=dao.getContentMain(ref);
 ArrayList<hotelDTO> list=dao.getContent(ref);
 String mainimg=maindto.getImg();
 String block = "0";
 System.out.println(request.getParameter("block"));
 if(request.getParameter("block")!=null){
  block = request.getParameter("block");
		 }
 
 String[] imgArray={"default1.jpg","default2.jpg","default3.jpg","default4.jpg","default5.jpg"};
 if(!dao.checkNull(mainimg)){
 if(mainimg.contains(",")){
	 imgArray=mainimg.split(",");
 }
 }
 MemberDTO mdto = new MemberDTO();
 mdto=mdao.myInfo(sid);
 String heart=mdto.getHeart();
%>
<%@ include file="../views/menu.jsp" %>
<hr />
<%=maindto.getTitle() %><br>
<%=maindto.getAddress() %><br>
<%=maindto.getAprice() %>
<button type="button" onclick="">후기</button>
<% if(heart!=null&&heart.contains(Integer.toString(ref))){%>
<button type="button" onclick="window.location='../member/heartPro.jsp?num=<%=maindto.getNum()%>&ref=<%=ref%>'">찜취소하기</button>
<%}else{ %>
<button type="button" onclick="window.location='../member/heartPro.jsp?num=<%=maindto.getNum()%>&ref=<%=ref%>'">찜하기</button>
<%} %>
<%for(int i=0;i<imgArray.length; i++){
	%>
		<img src="/BookStay/upload/<%=imgArray[i]%>">
	<%
} %>

<hr/>
<% 
for(hotelDTO dto : list){
	System.out.println(dto.getNum());
	%>
	<form action="../admin/payment.jsp" method="post">
	<%=dto.getRoomtype()%>
	<%if(id==99){
	%>
	<button type="button" onclick="window.location='hotelUpdateForm.jsp?num=<%=dto.getNum()%>&re_step=<%=dto.getRe_step()%>&ref=<%=ref%>'">수정</button>
	<button type="button" onclick="window.location='hotelDelete.jsp?num=<%=dto.getNum()%>&re_step=<%=dto.getRe_step()%>&ref=<%=ref%>'">삭제</button>
	<%	
	} %>
	<%if(block.contains(Integer.toString(dto.getNum()))) {%>
	<button type="button" disabled>예약불가</button><br />
	<%}else{ %> 
	<button type="submit">예약</button><br />
	<%} %>
	<%=dto.getContent() %><br />
	성인 : <%=dto.getAprice() %><br />
	아동 : <%=dto.getKprice()%><br />
	<img src="/BookStay/upload/<%=dto.getImg()%>">
	</form>
	<hr />
	<%
	
}
%><%if(id==99){%>
<button type="button" onclick="window.location='hotelWriteForm.jsp?ref=<%=ref%>&block=<%=block%>'">방 등록</button>
<%} %>
<script>

</script>

