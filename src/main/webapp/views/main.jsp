<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.hotelDTO" %>
<%@ page import="hotel.bean.hotelDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.ArrayList" %>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel_Main</title>
<link rel="stylesheet" href="/BookStay/resources/css/main.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%
	String id="";
	if(session.getAttribute("sid")==null){
		id="guest";
	}else{
		id=(String)session.getAttribute("sid");
	}
%>
<script>
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
<%
	hotelDAO dao = new hotelDAO();
	Date currentDate = new Date();
	
	// SimpleDateFormat을 사용하여 원하는 형식으로 변환
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	String start = dateFormat.format(currentDate);
	
	// 내일 날짜 구하기
	Calendar calendar = Calendar.getInstance();
	calendar.setTime(currentDate);
	calendar.add(Calendar.DATE, 1); // 현재 날짜에 1일을 더함
	
	Date tomorrowDate = calendar.getTime();
	
	// SimpleDateFormat을 사용하여 내일 날짜를 원하는 형식으로 변환
	String end = dateFormat.format(tomorrowDate);
	ArrayList<hotelDTO> block = dao.HotelBlock(start, end); 
	StringBuilder block1 = new StringBuilder();
	int size = block.size(); // block의 크기를 미리 계산
	
	for (int i = 0; i < size; i++) {
	    hotelDTO dto = block.get(i);
	    block1.append(String.valueOf(dto.getRef()));
	    if (i < size - 1) {
	        block1.append(",");
	    }
	}
	String block2 = block1.toString();
%>
<%@ include file="../views/menu.jsp" %>
<div id="bg">
<div id="login">
		<div><a href="login.jsp">로그인</a></div>
		<div><a href="memberForm.jsp">회원가입</a></div>
		<div>예약확인</div>
		<div>고객센터</div>
	</div>
<div id="bg_img">
	<swiper-container class="mySwiper" pagination="true" pagination-clickable="true" navigation="true" space-between="30"
    centered-slides="true" autoplay-delay="2500" autoplay-disable-on-interaction="false">
    <swiper-slide><img src="/BookStay/resources/img/bg1.gif"/></swiper-slide>
    <swiper-slide><img src="/BookStay/resources/img/bg2.jpg"/></swiper-slide>
    <swiper-slide><img src="/BookStay/resources/img/bg3.jpg"/></swiper-slide>
    <swiper-slide><img src="/BookStay/resources/img/bg4.jpg"/></swiper-slide>
  </swiper-container>
</div>
	<div id="main">
		<a href="main.jsp"><img id="logo" src="/BookStay/resources/img/logo.svg"/></a>
	</div>
	<div id="button">
	  <div class="button-link">
	    <a href="main.jsp">
	      <img id="home" src="/BookStay/resources/img/home.svg" alt="홈" />
	      <span>홈</span>
	    </a>
	  </div>
	  <div class="button-link">
	    <a href="mypage.jsp">
	      <img id="mypage" src="/BookStay/resources/img/mypage.svg" alt="마이" />
	      <span>마이</span>
	    </a>
	  </div>
	</div>

  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-element-bundle.min.js"></script>
<div id="main1">
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
			<input type="button" id="cad" value="적용"/>
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
	String[] types = {"서울", "부산", "제주도", "인천", "여수", "수원", "대전", "광주", "대구", "속초"};

	for(int i=0; i <types.length; i++){
		list = dao.hothotel(types[i]);
		String loc = types[i];
	%>
	<div id="list<%=i+1%>" class="list" style="<%= ( i == 0) ? "display:block;" : "display:none;" %>">
	 <%
	 for(hotelDTO dto : list){
	 %> 
	 <a id="hoth" href="/BookStay/hotel/hotelContent.jsp?title=<%=dto.getTitle()%>&ref=<%=dto.getRef()%>&block=<%=block2%>">
	 <div>
		<img src="/BookStay/upload/<%= dto.getImg() %>" style="width:100px;"/>
		<%= dto.getTitle() %>
		<%= dto.getKprice() %>
	</div>
	</a>
	<% }%>
		<button type="button" onclick="loc('<%=loc%>');">
		<%=loc%> 호텔 전체 보기</button>	 
	</div>
<%}%>
</div>
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
</html>