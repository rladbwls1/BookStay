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
	function loc(v1){
		var v2 = document.getElementById('start').value;
		var v3 = document.getElementById('end').value;
		var v4 = document.getElementById('adult1').value;
		var v5 = document.getElementById('kids1').value;
		var v6 = document.getElementById('rortlf').value;
		document.location.href = 'hlist.jsp?title='+v1+'&checkin='+v2+'&checkout='+v3+'&adult='+v4+'&kids='+v5+'&room='+v6+'&select=2&check=1,2,3,4';
	}
</script>
</head>
<body>

<%@ include file="menu.jsp" %>
<% session.setAttribute("sid",  "admin"); %>
<div id="main">
	<img src="/BookStay/resources/img/header.png" id="main_img">
	<form method="post" id="searchForm">
		<input type="text" id="text" name="title"/>
		<input type="text" id="date" name="datetimes"/>
		<input type="hidden" id="start" name="checkin"/>
		<input type="hidden" id="end" name="checkout"/>
		<input type="button" value="객실 1개, 인원 2명" id="popBtn"/>
		<div class="popup" id="popup">
		<div id="pop">
			<h5>객실1</h5>
			<p>성인 <input type="number" id="adult1" name="adult" value="2" max="4" min="1"/></p><br>
			<p>어린이 (만 17세 미만) <input type="number" id="kids1" name="kids" value="0" max="4" min="0"/></p>
		</div>
			<input type="button" id="cadd" value="객실 추가"/>
			<input type="hidden" id="rortlf" name="rortlf" value="1"/>
			<input type="button" id="cBtn" onclick="updateButtonValue()" value="적용"/>
		</div>
		<button id="sub" type="submit" class="btn btn-success">검색하기</button>
		<input type="hidden" name="category" value="0"/>
	</form>
	<div id="p"></div>
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
		<img src="/BookStay/upload/<%= dto.getImg() %>" style="width:100px;"/>
		<%= dto.getTitle() %>
		<%= dto.getKprice() %>
	</div>
	<% }%>
		<button type="button" onclick="loc('<%=loc%>');">
		<%=loc%> 호텔 전체 보기</button>	 
	</div>
<%}%>
</div>
</body>
<script src="/BookStay/resources/js/aa.js"></script>
<script src="/BookStay/resources/js/today.js"></script>
<script src="/BookStay/resources/js/count.js"></script>
<script src="/BookStay/resources/js/btn.js"></script>
<!--  
<script>
	var form = document.getElementById('searchForm');
	var titleInput = form.querySelector('input[name="title"]');
	var checkinInput = form.querySelector('input[name="checkin"]');
	var checkoutInput = form.querySelector('input[name="checkout"]');
	var adultInput = form.querySelector('input[name="adult"]');
	var kidsInput = form.querySelector('input[name="kids"]');
	var startInput = form.querySelector('input[name="checkin"]'); 
	var endInput = form.querySelector('input[name="checkout"]');
	var rortlf = form.querySelector('input[name="rortlf"]');
	
	document.getElementById('sub').addEventListener('click', function () {
	  var titleValue = titleInput.value;
	  var checkinValue = checkinInput.value;
	  var checkoutValue = checkoutInput.value;
	  var adultValue = adultInput.value;
	  var kidsValue = kidsInput.value;
	  var startValue = startInput.value;
	  var endValue = endInput.value;
	  var rorValue = rortlf.value;
      var hselect = 0;
      
	  form.action = 'hlist.jsp?title=' + titleValue + '&checkin=' + startValue + '&checkout=' + endValue
	  + '&adult=' + adultValue + '&kids=' + kidsValue + '&room=' + rorValue + '&select=1&check=1,2,3,4'; 
    });
</script>-->
<script src="/BookStay/resources/js/date.js"></script>
<script src="/BookStay/resources/js/popup.js"></script>
<script src="/BookStay/resources/js/pop.js"></script>
</html>