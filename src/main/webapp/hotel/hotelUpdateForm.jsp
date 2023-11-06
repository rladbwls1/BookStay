<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.hotelDTO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%@ include file="../views/main_bar.jsp" %>
<link rel="stylesheet" href="/BookStay/resources/css/hotelupdateform.css"/>
<% request.setCharacterEncoding("UTF-8");
if (grade!=99){
	
	 %>
	  <script>
	  	alert("관리자만 접근할수 있습니다.");
	  	window.location="../views/main.jsp";
	  </script>
<%}%>
 <%
  int re_step=Integer.parseInt(request.getParameter("re_step"));
  int num=Integer.parseInt(request.getParameter("num"));
  int ref=Integer.parseInt(request.getParameter("ref"));
  hotelDAO dao = new hotelDAO();
  hotelDTO dto = new hotelDTO();
  dto=dao.getContentMain(num);
  String title=dto.getTitle();
  String content=dto.getContent();
  String contact=dto.getContact();
  String contactfax=dto.getContactfax();
  String roomtype=dto.getRoomtype();
  int price=dto.getPrice();
  String img=dto.getImg();
  %>
  <div id="list">
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
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="ref" value="<%=ref%>">
			<input type="hidden" name="re_step" value="<%=re_step%>">
			<button type="submit">수정</button>
 	</form>
 <%}else{%>
 	<h2>호텔방 수정</h2>
	 <form id="form1" action="hotelUpdatePro.jsp" method="post" enctype="multipart/form-data">
	 <table id="tb">
	 	<tr>
	 		<td class="title">제목</td>
	 		<td><input type="text" name="title" value="<%=title%>"></td>
	 	</tr>
	 	<tr>
	 		<td class="title">내용</td>
	 		<td><textarea rows="10" cols="20" name="content"><%=content %></textarea></td>
	 	</tr>
	 	<tr>
	 		<td class="title">방종류</td>
	 		<td>
				<select id="sel" name="roomtype">
				<%if(roomtype.equals("스탠다드")) {%>
					<option value="스탠다드" selected>스탠다드</option>
					<option value="디럭스">디럭스</option>
					<option value="스위트룸">스위트룸</option>
				<%}else if(roomtype.equals("디럭스")){%>
					<option value="스탠다드">스탠다드</option>
					<option value="디럭스" selected>디럭스</option>
					<option value="스위트룸">스위트룸</option>
				<%}else if(roomtype.equals("스위트룸")){%>
					<option value="스탠다드">스탠다드</option>
					<option value="디럭스">디럭스</option>
					<option value="스위트룸" selected>스위트룸</option>
				<%} %>	
				</select>
			</td>
	 	</tr>
	 	<tr>
	 		<td class="title">가격</td>
	 		<td><input type="number" name="aprice" value="<%=price%>"></td>
	 	</tr>
	 	<tr>
	 		<td class="title">사진</td>
	 		<td><input type="file" name="upload"></td>
	 	</tr>
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="re_step" value="<%=re_step%>">
		</table>
		<button id="btn" type="submit">수정</button>
	</form>
 <%}%>
 </div>

