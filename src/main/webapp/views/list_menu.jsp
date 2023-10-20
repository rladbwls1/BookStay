<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String checkin = request.getParameter("checkin");
	String checkout = request.getParameter("checkout");
	int adult = Integer.parseInt(request.getParameter("adult"));
	System.out.println(adult);
	int kids = Integer.parseInt(request.getParameter("kids"));
	System.out.println(kids);
	int select = Integer.parseInt(request.getParameter("select"));
	System.out.println(select);
	String pcount = "객실, 인원 " + (adult + kids) + "명";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/Hotel/resources/css/list_menu.css"/>
</head>
<body>
	<body>
	<div id="login">
		<div><a href="login.jsp">로그인</a></div>
		<div><a href="memberForm.jsp">회원가입</a></div>
		<div>예약확인</div>
		<div>고객센터</div>
	</div>
	<div id="main">
		<a href="main.jsp"><img id="logo" src="/Hotel/resources/img/logo.svg"/></a>
	</div>
	<div id="button">
	  <div class="button-link">
	    <a href="main.jsp">
	      <img id="home" src="/Hotel/resources/img/home.svg" alt="홈" />
	      <span>홈</span>
	    </a>
	  </div>
	  <div class="button-link">
	    <a href="mypage.jsp">
	      <img id="mypage" src="/Hotel/resources/img/mypage.svg" alt="마이" />
	      <span>마이</span>
	    </a>
	  </div>
	</div>
	<div id="main">
	<form method="post" id="searchForm">
		<input type="text" name="title" value="<%=title%>"/>
		<input type="text" name="datetimes" value="<%=checkin %> - <%=checkout %>" />
		<input type="hidden" id="start" name="checkin" value="<%=checkin %>"/>
		<input type="hidden" id="end" name="checkout" value="<%=checkout %>"/>
		<input type="button" value="<%=pcount %>" id="popBtn"/>
		<div class="popup" id="popup">
			<h5>객실</h5>
			<p>성인 <input type="number" name="adult" value="<%=adult%>"/></p><br>
			<p>어린이 (만 17세 미만) <input type="number" name="kids" value="<%=kids%>"/></p>
			<input type="button" id="cBtn" onclick="updateButtonValue()" value="적용">
		</div>
		<button id="sbtn" type="submit" class="btn btn-success">검색하기</button>
		<input type="hidden" name="category" id="hvalue" value="0"/>
	</form>
</div>
</body>
<script>
    var form = document.getElementById('searchForm');
    var titleInput = form.querySelector('input[name="title"]');
    var checkinInput = form.querySelector('input[name="checkin"]');
    var checkoutInput = form.querySelector('input[name="checkout"]');
    var adultInput = form.querySelector('input[name="adult"]');
    var kidsInput = form.querySelector('input[name="kids"]');
    var startInput = form.querySelector('input[name="checkin"]'); 
    var endInput = form.querySelector('input[name="checkout"]');
    
    document.getElementById('sbtn').addEventListener('click', function () {
      var titleValue = titleInput.value;
      var checkinValue = checkinInput.value;
      var checkoutValue = checkoutInput.value;
      var adultValue = adultInput.value;
      var kidsValue = kidsInput.value;
      var startValue = startInput.value;
      var endValue = endInput.value;
      var selectValue = "<%= select%>"
      
      form.action = 'hlist.jsp?title=' + titleValue + '&checkin=' + startValue + '&checkout=' + endValue
	  + '&adult=' + adultValue + '&kids=' + kidsValue + '&select=1&check=1,2,3,4'; 
    });
</script>
<script src="/Hotel/resources/js/date.js"></script>
<script src="/Hotel/resources/js/popup.js"></script>
<script src="/Hotel/resources/js/count.js"></script>
</html>