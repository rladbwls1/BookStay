<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<%@ page import="hotel.bean.hotelDTO" %>
<%@ page import="hotel.bean.hotelDAO" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="dao" class="hotel.bean.HOrderDAO" />
<jsp:useBean id="dto" class="hotel.bean.HOrderDTO" />

<%
MemberDAO mdao = MemberDAO.getInstance();
String id = (String) session.getAttribute("sid");
int grade= mdao.checkGrade(id);

    request.setCharacterEncoding("UTF-8");

    String orderId = (String) session.getAttribute("sid"); 
    

    if (orderId != null) {
        List<HOrderDTO> orders = dao.getOrders(orderId); 
        

        if (orders != null && !orders.isEmpty()) {
            
            

            
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
 <link rel="stylesheet" href="/BookStay/resources/css/list_menu.css"/>
<head>
    <title>어서오세요</title>
    
    <h2></h2>
</head>
<body>
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
      <div><a href="/BookStay/admin/adminmain.jsp">관리자페이지</a></div>
      <%} %>   
   </div>
   <div id="logo">
      <a href="/BookStay/views/main.jsp">
         BookStay
      </a>
   </div>
   </div>
   <style>
   
body {
   padding-top: 20px; /* 페이지의 상단 여백을 늘립니다. */
}

#header {
    margin-bottom: 100px; /* 헤더 아래에 여백을 추가합니다. */
}


#table {
    margin-top: 50px; /* 컨텐츠 영역을 아래로 이동시킵니다. */
}

</style>

<div class="col-md-3" style="width:200px; height:150px; border:100px; float:left; margin-left: 300px;">
<!-- 사이드 바 메뉴-->
  <!-- 패널 타이틀1 -->
<div  class="panel panel-info">
    <div  class="panel-heading">
      <h3  class="panel-title">나의 정보</h3>
    </div>
    <!-- 사이드바 메뉴목록1 -->
    <ul  class="list-group">
    <li  class="list-group-item"><a href="/BookStay/member/memberinfo.jsp">마이페이지</a></li>
      <li class="list-group-item"><a href="/BookStay/board/myQuestion.jsp">나의 질문</a></li>
      <li  class="list-group-item"><a href="/BookStay/member/logout.jsp">로그아웃</a></li>
      
    </ul>
</div>
 </div>
<div class="mx-auto p-2" style="width: 800px;">
<div class="w-200 p-1">

<div class="h4 pb-2 mb-8 text-dark border-bottom border-dark">
    예약 내역 확인
</div>

<% 
hotelDAO hotelDAO = new hotelDAO();

for(HOrderDTO order : orders) { 
String reg = new SimpleDateFormat("yyyy-MM-dd").format(order.getReg());
               String checkin = order.getCheckin().substring(0,11);
               String checkout = order.getCheckout().substring(0,11);
               
               int ref = order.getRef(); 
                hotelDTO hotelInfo = hotelDAO.getContentMain(ref);
               %>
<div class="mx-auto p-2" style="width: 800px;">
<div class="w-200 p-1">

   
<table class="table">

<div class="h4 pb-2 mb-4 text-dark border-bottom border-dark">
    
</div>
  <thead>
    <tr>
      
      <th scope="col">예약 번호</th>
      <th scope="col">체크인 날짜</th>
      <th scope="col">체크아웃 날짜</th>
      <th scope="col">예약 인원</th>
      <th scope="col">아이</th>
      <th scope="col">결제수단</th>
      <th scope="col">호텔 이름</th>
      <th scope="col">호텔 주소</th>
      <th scope="col">가격</th>
      <th scope="col">전화번호</th>
      
    </tr>
  </thead>
  <tbody>
    <tr>
      

        
        <td><%= order.getRenum() %></td>
   
    
        <td><%= checkin %></td>
    
    
        
        <td><%= checkout %></td>
    
        
        <td><%= order.getAdult() %></td>
    
        
        <td><%= order.getKid() %></td>
   
        
        <td><%= order.getPaytype() %></td>
    
        
        <td><%= hotelInfo.getTitle() %></td>
    
        
        <td><%= hotelInfo.getAddress() %></td>
   
        
        <td><%= hotelInfo.getPrice() %></td>
   
     
        
        <td><%= hotelInfo.getContact() %></td>
    
    <%} %>
</table> </br>
<input type="button" class="btn btn-success" value="뒤로가기" onclick="location.href='memberinfo.jsp'">
<input type="button" class="btn btn-success" value="로그아웃" onclick="location.href='logout.jsp'">
</div>
</div>
</body>
</html>
<%
        } else {
%>
<script>
    alert("예약 내역이 존재하지 않습니다.");
    window.location = "memberinfo.jsp";
</script>
<%
        }
    } else {
%>
<script>
    alert("세션이 만료되었거나 로그인하지 않았습니다. 다시 로그인해주세요.");
    window.location = "loginform.jsp";
</script>
<%
    }
%>