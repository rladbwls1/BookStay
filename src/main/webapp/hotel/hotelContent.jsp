<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hotel.bean.hotelDTO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link rel="stylesheet" href="/BookStay/resources/css/list_menu.css"/>
<%request.setCharacterEncoding("UTF-8");
MemberDAO mdao = MemberDAO.getInstance();
String id = (String) session.getAttribute("sid");
int grade= mdao.checkGrade(id);

 int ref= Integer.parseInt(request.getParameter("ref"));
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
 mdto=mdao.myInfo(id);
 String heart=mdto.getHeart();
%>
<%
String title = request.getParameter("title");
	String checkin = request.getParameter("checkin");
	String checkout = request.getParameter("checkout");
	int rortlf = Integer.parseInt(request.getParameter("room"));
	int adult = Integer.parseInt(request.getParameter("adult"));
	int kids = Integer.parseInt(request.getParameter("kids"));
	int select = Integer.parseInt(request.getParameter("select"));
	int roomValues = 0;
	int kidsValues = 0;
	int[] roomValue = new int[rortlf];
	int[] kidsValue = new int[rortlf];
	for (int i = 0; i < rortlf; i++) {
		String adultParam = request.getParameter("a" + (i + 1));
	    String kidsParam = request.getParameter("k" + (i + 1));
	    
	    int adultValues = 2; 
	    int kidsValuee = 0; 

	    if (adultParam != null) {
	        adultValues = Integer.parseInt(adultParam);
	    }

	    if (kidsParam != null) {
	        kidsValuee = Integer.parseInt(kidsParam);
	    }

	    roomValues += adultValues;
	    kidsValues += kidsValuee;
	    
	    roomValue[i] = adultValues;
	    kidsValue[i] = kidsValuee; 
	    
	    %>
	    <input type="hidden" id="r<%=i+1%>" value="<%= roomValue[i]%>"/>
	    <input type="hidden" id="k<%=i+1%>" value="<%= kidsValue[i]%>"/>
	<%}
	String pcount = "객실 " + rortlf + "개, 인원 " + (roomValues + kidsValues) + "명";

%>
	<div id="header">
	<div id="login">
		<%if(grade==11) { // 세션이 없다면 수행
    String cid = null, cpw = null, cauto = null;
    Cookie[] cookies = request.getCookies();
  
    	if (cookies != null) {
       		 for (Cookie c : cookies) {
		            if (c.getName().equals("cid")) { cid = c.getValue(); }
		            if (c.getName().equals("cpw")) { cpw = c.getValue(); }
		            if (c.getName().equals("cauto")) { cauto = c.getValue(); }
   				}  
 		   	}
    	if (cid != null && cpw != null && cauto != null) {
    		response.sendRedirect("/BookStay/member/loginPro.jsp");	
    	}
    if (cid == null || cpw == null || cauto == null) { %>
		<div><a href="/BookStay/member/loginform.jsp">로그인</a></div>
		<div><a href="/BookStay/member/memberForm.jsp">회원가입</a></div>
		<%}				
		}if(grade==0 || grade==99){ %>
		<div><a href="/BookStay/member/logout.jsp">로그아웃</a></div>
		<div><a href="/BookStay/member/memberinfo.jsp">MyPage</a></div>
		<%}%>
		<div>고객센터</div>
		<%if(grade==99){ %>
		<div><a href="/BookStay/admin/adminMain.jsp">관리자페이지</a></div>
		<%} %>	
	</div>
	<div id="logo">
		<a href="/BookStay/views/main.jsp">
			BookStay
		</a>
	</div>
	</div>
	<div id="main">
	<div id="search">
	<input type="hidden" id = "tcnt" value="<%= rortlf%>"/>
	<form method="post" id="searchForm">
		<input type="text" name="title" value="<%=title%>" id="title"/>
		<input type="text" name="datetimes" id="date" value="<%=checkin %> - <%=checkout %>" />
		<input type="hidden" id="start" name="checkin" value="<%=checkin %>"/>
		<input type="hidden" id="end" name="checkout" value="<%=checkout %>"/>
		<input type="button" value="<%=pcount %>" id="popBtn"/>
		<div class="popup" id="popup">
		<div id="pop">
			<h5>객실1</h5>
			<div>성인 <input type="number" id="adult1" name="adult" value="<%=adult%>" max="4" min="1"/></div>
			<div>어린이 (만 17세 미만) <input type="number" id="kids1" name="kids" value="<%=kids%>" max="4" min="0"/></div>	
			<%for (int i = 1; i < rortlf; i++) {
			    int adultValue = Integer.parseInt(request.getParameter("a" + (i + 1)));
			    int kidsValue1 = Integer.parseInt(request.getParameter("k" + (i + 1)));
		
			    roomValue[i] = adultValue;
			    kidsValue[i] = kidsValue1;  
			    
	  %>
	  <div id="pop<%=i+1 %>">
	  <hr>
	  <h5>객실<%=i+1%></h5>
    <div>성인 <input type="number" id="adult<%=i+1%>" name="adult<%=i+1%>" value="<%=roomValue[i] %>" max="4" min="1"/></div><br>
    <div>어린이 (만 17세 미만) <input type="number" id="kids<%=i+1%>" name="kids<%=i+1%>" value="<%=kidsValue[i] %>" max="4" min="0"/></div>
    <button type="button" class="btn btn-danger cRemove">객실 삭제</button>
    </div>
    <hr>
	<%}%>
    </div>
			<input type="button" id="cadd" value="객실 추가"/>
			<input type="hidden" id="rortlf" name="rortlf" value="<%=rortlf%>"/>
			<button type="button" id="cad" onclick="eValue">적용</button>
		</div>
		<button id="subb" type="submit"><img src="/BookStay/resources/img/search.png"/></button>
		<input type="hidden" name="category" id="hvalue" value="0"/>
	</form>
	<div id="p"></div>
	</div>
</div>
<hr />
<%=maindto.getTitle() %><br>
<%=maindto.getAddress() %><br>
<%=maindto.getAprice() %>
<button type="button" onclick="window.location='../review/hotelWriteForm.jsp?ref=<%=ref%>'">후기</button>
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
	%>
	<form action="../admin/payment.jsp" method="post">
	<input type="hidden" name="ref" value="<%=ref%>">
	<%=dto.getRoomtype()%>
	<%if(grade==99){
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
%><%if(grade==99){%>
<button type="button" onclick="window.location='hotelWriteForm.jsp?ref=<%=ref%>&block=<%=block%>'">방 등록</button>
<%} %>
<script src="/BookStay/resources/js/ee.js"></script>
<script src="/BookStay/resources/js/ee2.js"></script>
<script src="/BookStay/resources/js/date.js"></script>
<script src="/BookStay/resources/js/popup.js"></script>
<script src="/BookStay/resources/js/count.js"></script>
<script src="/BookStay/resources/js/menubar.js"></script>

