<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.hotelDTO" %>
<%@ page import="hotel.bean.hotelDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel_Main</title>
<link rel="stylesheet" href="/Hotel/resources/css/main.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>

<%@ include file="menu.jsp" %>
<% session.setAttribute("sid", "admin"); %>
<div id="main">
	<img src="/Hotel/resources/img/header.png" id="main_img">
	<form method="post" id="searchForm">
		<input type="text" id="text" name="title"/>
		<input type="text" id="date" name="datetimes"/>
		<input type="hidden" id="start" name="checkin"/>
		<input type="hidden" id="end" name="checkout"/>
		<input type="button" value="객실 1개, 인원 2명" id="popBtn"/>
		<div class="popup" id="popup">
			<h5>객실</h5>
			<p>성인 <input type="number" name="adult" value="2"/></p><br>
			<p>어린이 (만 17세 미만) <input type="number" name="kids" value="0"/></p>
			<input type="button" id="cadd" value="객실 추가"/>
			<input type="button" id="cBtn" onclick="updateButtonValue()" value="적용"/>
		</div>
		<button id="sub" type="submit" class="btn btn-success">검색하기</button>
		<input type="hidden" name="category" value="0"/>
	</form>
</div>
<div id="h_content">
	<h2>도시별 인기 호텔</h2>
	<div id="hot_hotel">
		<button class="hobtn" id="hobtn1" data-target="list1">서울</button>
		<button class="hobtn" data-target="list2">부산</button>
		<button class="hobtn" data-target="list3">제주도</button>
		<button class="hobtn" data-target="list4">인천</button>
		<button class="hobtn" data-target="list5">여수</button>
		<button class="hobtn" data-target="list6">수원</button>
		<button class="hobtn" data-target="list7">대전</button>
		<button class="hobtn" data-target="list8">광주</button>
		<button class="hobtn" data-target="list9">대구</button>
		<button class="hobtn" data-target="list10">속초</button>
	</div>
	<%
	request.setCharacterEncoding("UTF-8");
	ArrayList<hotelDTO> list;
	hotelDAO dao = new hotelDAO();
	String[] types = {"서울", "부산", "제주도", "인천", "여수", "수원", "대전", "광주", "대구", "속초"};

	for(int i=0; i <types.length; i++){
		list = dao.hothotel(types[i]);
		String loc = types[i];
	%>
	<div id="list<%=i+1%>" class="list" style="<%= ( i == 0) ? "display:block;" : "display:none;" %>">
	 <%
	 for(hotelDTO dto : list){
	 %> 
	 <div>
		<img src="/Hotel/upload/<%= dto.getImg() %>" style="width:100px;"/>
		<%= dto.getTitle() %>
		<%= dto.getKprice() %>
		<input type="hidden" id="loc" value="<%=loc %>"/>	
	</div>
	<% }%>
		<button type="button" onclick="location();">
		<%=loc%>호텔 전체 보기</button>	 
	</div>
<%}%>
</div>
</body>
<script src="/Hotel/resources/js/today.js"></script>
<script src="/Hotel/resources/js/btn.js"></script>
<script>
	var form = document.getElementById('searchForm');
	var titleInput = form.querySelector('input[name="title"]');
	var checkinInput = form.querySelector('input[name="checkin"]');
	var checkoutInput = form.querySelector('input[name="checkout"]');
	var adultInput = form.querySelector('input[name="adult"]');
	var kidsInput = form.querySelector('input[name="kids"]');
	var startInput = form.querySelector('input[name="checkin"]'); 
	var endInput = form.querySelector('input[name="checkout"]');
	
	document.getElementById('sub').addEventListener('click', function () {
	  var titleValue = titleInput.value;
	  var checkinValue = checkinInput.value;
	  var checkoutValue = checkoutInput.value;
	  var adultValue = adultInput.value;
	  var kidsValue = kidsInput.value;
	  var startValue = startInput.value;
	  var endValue = endInput.value;
      var hselect = 0
	  form.action = 'hlist.jsp?title=' + titleValue + '&checkin=' + startValue + '&checkout=' + endValue
	  + '&adult=' + adultValue + '&kids=' + kidsValue + '&select=1&check=1,2,3,4'; 
    });
	var loc1 = document.getElementById('location');
	function location(){
		var locValue = loc1.value;
		document.location.href='hlist.jsp?title=' + locValue + '&checkin=' + startValue + '&checkout=' + endValue
			  + '&adult=' + adultValue + '&kids=' + kidsValue + '&select=1&check=1,2,3,4';		
	}
</script>
<script>
	function su(){
		var hotel = document.getElementById('hothotel');
		var su = hotel.querySelector('button[name="su"]');
		var suValue = su.value;
		alert(suValue);
	}
</script>
<script>
</script>
<script src="/Hotel/resources/js/count.js"></script>
<script src="/Hotel/resources/js/date.js"></script>
<script src="/Hotel/resources/js/popup.js"></script>
<script src="/Hotel/resources/js/pop.js"></script>
</html>