<%@page import="hotel.bean.hotelDTO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");
  String id=(String)session.getAttribute("sid");
  int re_step=Integer.parseInt(request.getParameter("re_step"));
  int num=Integer.parseInt(request.getParameter("num"));
  hotelDAO dao = new hotelDAO();
  hotelDTO dto = new hotelDTO();
  dto=dao.getContentMain(num);
  String title=dto.getTitle();
  String content=dto.getContent();
  String contact=dto.getContact();
  String contactfax=dto.getContactfax();
  String roomtype=dto.getRoomtype();
  int aprice=dto.getAprice();
  int kprice=dto.getKprice();
  String img=dto.getImg();
  
  if(!id.equals("admin")){
	  %>
	  <script>
	  	alert("관리자만 접근할수 있습니다.");
	  	window.location="member/main.jsp";
	  </script>
 <%}%>
 <%if(re_step==0){
	 %>
	 <form action="hotelUpdatePro.jsp" method="post" enctype="multipart/form-data">
		 제목 :  <input type="text" name="title" value="<%=title%>"><br>
			내용 :<textarea rows="10" cols="20" name="content"><%=content %></textarea><br>
			연락처 : <input type="text" name="contact" value="<%=contact%>"><br>
		팩스번호 : <input type="text" name="contactfax" value="<%=contactfax%>"><br>
		
		사진 : <input type="file" name="upload1"><br>
			<input type="file" name="upload2"><br>
			<input type="file" name="upload3"><br>
			<input type="file" name="upload4"><br>
			<input type="file" name="upload5"><br>
			<input type="hidden" name="num">
			<input type="hidden" name="re_step">
			<button type="submit">수정</button>
 	</form>
 <%}else{%>
	 <form action="hotelUpdatePro.jsp" method="post" enctype="multipart/form-data">
		제목 :  <input type="text" name="title" value="<%=title%>"><br>
		내용 :<textarea rows="10" cols="20" name="content"><%=content %></textarea><br>
		방종류 : 
				<select name="roomtype">
				<%if(roomtype.equals("스탠다드")) {%>
					<option value="1" selected>스탠다드</option>
					<option value="2">디럭스</option>
					<option value="3">스위트</option>
				<%}else if(roomtype.equals("디럭스")){%>
					<option value="1">스탠다드</option>
					<option value="2" selected>디럭스</option>
					<option value="3">스위트</option>
				<%}else if(roomtype.equals("스위트")){%>
					<option value="1">스탠다드</option>
					<option value="2">디럭스</option>
					<option value="3" selected>스위트</option>
				<%} %>	
				</select><br>
		어른가격 : <input type="number" name="aprice" value="<%=aprice%>">
		아이가격 : <input type="number" name="kprice" value="<%=kprice%>">
		사진 : <input type="file" name="upload"><br>
		<input type="hidden" name="num">
		<input type="hidden" name="re_step">
		<button type="submit">수정</button>
	</form>
	 
	 
 <%}%>
 

