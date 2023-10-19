<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");
session.setAttribute("sid", "admin");
String id = (String)session.getAttribute("sid");
if(!id.equals("admin")){
	%>
	<script>
		alert("관리자만 접근할수 있습니다.");
		window.location="/login/main.jsp";
	</script>
	<%
	
} %>
<form action="hotelWritePro.jsp" method="post" enctype="multipart/form-data">
	제목 :  <input type="text" name="title"><br>
	내용 :<textarea rows="10" cols="20" name="content"></textarea><br>
	숙박업소 타입:<select name="type">
			  	<option value="호텔">호텔 </option>
			  	<option value="리조트">리조트 </option>
			  	<option value="모텔">모텔 </option>
			  	<option value="기타숙소">기타숙소 </option>
			  </select>
	숙박업소 주소 : <input type="text" name="address">
	사진 : <input type="file" name="upload1"><br>
		<input type="file" name="upload2"><br>
		<input type="file" name="upload3"><br>
		<input type="file" name="upload4"><br>
		<input type="file" name="upload5"><br>
	서비스 :<br> 
	레스토랑<input type="checkbox" name="services" value="레스토랑">
	스파<input type="checkbox" name="services" value="스파">
	바다전망<input type="checkbox" name="services" value="바다전망">
	해변접근<input type="checkbox" name="services" value="해변접근">
	비지니스시설<input type="checkbox" name="services" value="비지니스시설"><br />
	엘리베이터<input type="checkbox" name="services" value="엘리베이터">
	금연 숙박 시설<input type="checkbox" name="services" value="금연 숙박 시설">
	테라스<input type="checkbox" name="services" value="테라스">
	24시간 운영 프런트 데스크<input type="checkbox" name="services" value="24시간 운영 프런트 데스크">
	무료 셀프 주차<input type="checkbox" name="services" value="무료 셀프 주차"><br />
	프런트 데스크의 안전 금고<input type="checkbox" name="services" value="프런트 데스크의 안전 금고">
	짐 보관 서비스<input type="checkbox" name="services" value="짐 보관 서비스">
	웨딩 서비스<input type="checkbox" name="services" value="웨딩 서비스">
	시설 내 스파 서비스<input type="checkbox" name="services" value="시설 내 스파 서비스">
	포터/벨보이<input type="checkbox" name="services" value="포터/벨보이"><br />
	무료 WiFi<input type="checkbox" name="services" value="무료 WiFi">
	다국어 구사 가능 직원<input type="checkbox" name="services" value="다국어 구사 가능 직원">
	드라이클리닝/세탁 서비스<input type="checkbox" name="services" value="드라이클리닝/세탁 서비스">
	세탁 시설<input type="checkbox" name="services" value="세탁 시설">
	아침 식사 가능(요금 별도)<input type="checkbox" name="services" value="아침 식사 가능(요금 별도)"><br />
	ATM/은행업무<input type="checkbox" name="services" value="ATM/은행업무">
	컴퓨터 스테이션<input type="checkbox" name="services" value="컴퓨터 스테이션">
	롤인 샤워(일부 객실)<input type="checkbox" name="services" value="롤인 샤워(일부 객실)">
	간편 체크아웃<input type="checkbox" name="services" value="간편 체크아웃">
	간편 체크인<input type="checkbox" name="services" value="간편 체크인"><br />
	24시간 운영 피트니스 시설<input type="checkbox" name="services" value="24시간 운영 피트니스 시설">
	피트니스 시설<input type="checkbox" name="services" value="피트니스 시설">
	회의실<input type="checkbox" name="services" value="회의실">
	무료 주차 대행<input type="checkbox" name="services" value="무료 주차 대행">
	시설 내 쇼핑몰<input type="checkbox" name="services" value="시설 내 쇼핑몰"><br />
	도서관<input type="checkbox" name="services" value="도서관">
	주차(공간 제한)<input type="checkbox" name="services" value="주차(공간 제한)">
	루프탑 테라스<input type="checkbox" name="services" value="루프탑 테라스">
	<input type="submit" value="등록">
</form>


































    