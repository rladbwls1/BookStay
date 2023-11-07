<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@page import="hotel.bean.adminDAO"%>
<%@page import="hotel.bean.adminDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<jsp:useBean id="dto" class="hotel.bean.hotelDTO"/>
<link rel="stylesheet" href="/BookStay/resources/css/hotelwriteform.css"/>
<%@ include file="../views/main_bar.jsp" %>
<%request.setCharacterEncoding("UTF-8");
if (grade!=99){
	 %>
	  <script>
	  	alert("관리자만 접근할수 있습니다.");
	  	window.location="../views/main.jsp";
	  </script>
<%}%>
<%	hotelDAO dao = new hotelDAO();
	adminDAO dao1=adminDAO.getInstance();
	adminDTO dto1 = dao1.getPreView();
	if(request.getParameter("ref")==null){
%>
<div id="list">
	<ul id="ul1">
 <li><button id="bn1" type="button" onclick="window.location='/BookStay/admin/adminMain.jsp'">요약정보</button></li>
	  <li><button id="bn2" type="button" onclick="window.location='/BookStay/admin/adminlist.jsp'">예약목록 </button></li>
	  <li><button id="bn3" type="button" onclick="window.location='/BookStay/board/notice.jsp'">공지사항 </button></li>
	  <li><button id="bn4" type="button" onclick="window.location='/BookStay/board/QnAList.jsp'">자주하는질문 </button></li>
	  <li><button id="bn5" type="button" onclick="window.location='/BookStay/board/myQuestion.jsp'">1:1문의[<%=dto1.getNoanswer() %>] </button></li>
	  <!-- 
	  <li><button id="bn6" type="button" onclick="window.location='/BookStay/hotel/hotelWriteForm.jsp'">숙박업소 글등록</button></li>
	   -->
	  <li><button id="bn6" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=2'">숙박업소 게시글 정보 </button></li>
	  <li><button id="bn7" type="button" onclick="window.location='/BookStay/admin/adminGradeList.jsp'">등급 관리/조회</button></li>
	</ul>
	<div id="f1">
	<div id="tbcal">
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link active" aria-current="page">숙박업소 글등록</a>
	  </li>
	</ul>
		<div id="btn4">
<button class="d" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=2'">등록완료된 숙소</button><hr />
<button class="d" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=1'">등록중인 숙소</button>
<button id="chk" type="button" onclick="window.location='/BookStay/hotel/hotelWriteForm.jsp'">숙소 등록</button>
	</div>
<form action="hotelWritePro.jsp" id="form1" method="post" enctype="multipart/form-data">
	<input type="hidden" name="check" value="1">
	<table id="tb">
	<tr>
		<td class="t">제목</td>
		<td><input type="text" name="title"></td>
	</tr>
	<tr>
		<td class="t">내용</td>
		<td><textarea rows="10" cols="20" name="content"></textarea></td>
	</tr>
	<tr>
		<td class="t t1">숙박업소 타입</td>
		<td>
			<select id="sel" name="type">
			  	<option value="호텔">호텔 </option>
			  	<option value="리조트">리조트 </option>
			  	<option value="모텔">모텔 </option>
			  	<option value="기타숙소">기타숙소 </option>
			 </select>
		</td>
	</tr>
	<tr>
		<td class="t">숙박업소 주소</td>
		<td><input type="text" name="address"></td>
	</tr>
	<tr>
		<td class="t">연락처</td>
		<td><input type="text" name="contact"></td>
	</tr>
	<tr>
		<td class="t">팩스번호</td>
		<td><input type="text" name="contactfax"></td>
	</tr>
	<tr>
		<td class="t">사진</td>
		<td class="t2"><input class="file" type="file" name="upload1"><br>
		<input class="file" type="file" name="upload2"><br>
		<input class="file" type="file" name="upload3"></td>
	</tr>
	<tr>
		<td class="t">서비스</td>
		<td id="service">
		<div class="ser"><input type="checkbox" name="services" value="레스토랑">레스토랑</div>
		<div class="ser"><input type="checkbox" name="services" value="스파">스파</div>
		<div class="ser"><input type="checkbox" name="services" value="바다전망">바다전망</div>
		<div class="ser"><input type="checkbox" name="services" value="해변접근">해변접근</div>
		<div class="ser"><input type="checkbox" name="services" value="비지니스시설">비지니스시설</div>
		<div class="ser"><input type="checkbox" name="services" value="엘리베이터">엘리베이터</div>
		<div class="ser"><input type="checkbox" name="services" value="금연 숙박 시설">금연 숙박 시설</div>
		<div class="ser"><input type="checkbox" name="services" value="테라스">테라스</div>
		<div class="ser"><input type="checkbox" name="services" value="24시간 운영 프런트 데스크">24시간 운영 프런트 데스크</div>
		<div class="ser"><input type="checkbox" name="services" value="무료 셀프 주차">무료 셀프 주차</div>
		<div class="ser"><input type="checkbox" name="services" value="프런트 데스크의 안전 금고">프런트 데스크의 안전 금고</div>
		<div class="ser"><input type="checkbox" name="services" value="짐 보관 서비스">짐 보관 서비스</div>
		<div class="ser"><input type="checkbox" name="services" value="웨딩 서비스">웨딩 서비스</div>
		<div class="ser"><input type="checkbox" name="services" value="시설 내 스파 서비스">시설 내 스파 서비스</div>
		<div class="ser"><input type="checkbox" name="services" value="포터/벨보이">포터/벨보이</div>
		<div class="ser"><input type="checkbox" name="services" value="무료 WiFi">무료 WiFi</div>
		<div class="ser"><input type="checkbox" name="services" value="다국어 구사 가능 직원">다국어 구사 가능 직원</div>
		<div class="ser"><input type="checkbox" name="services" value="드라이클리닝/세탁 서비스">드라이클리닝/세탁 서비스</div>
		<div class="ser"><input type="checkbox" name="services" value="세탁 시설">세탁 시설</div>
		<div class="ser"><input type="checkbox" name="services" value="아침 식사 가능(요금 별도)">아침 식사 가능(요금 별도)</div>
		<div class="ser"><input type="checkbox" name="services" value="ATM/은행업무">ATM/은행업무</div>
		<div class="ser"><input type="checkbox" name="services" value="컴퓨터 스테이션">컴퓨터 스테이션</div>
		<div class="ser"><input type="checkbox" name="services" value="롤인 샤워(일부 객실)">롤인 샤워(일부 객실)</div>
		<div class="ser"><input type="checkbox" name="services" value="간편 체크아웃">간편 체크아웃</div>
		<div class="ser"><input type="checkbox" name="services" value="간편 체크인">간편 체크인</div>
		<div class="ser"><input type="checkbox" name="services" value="24시간 운영 피트니스 시설">24시간 운영 피트니스 시설</div>
		<div class="ser"><input type="checkbox" name="services" value="피트니스 시설">피트니스 시설</div>
		<div class="ser"><input type="checkbox" name="services" value="회의실">회의실</div>
		<div class="ser"><input type="checkbox" name="services" value="무료 주차 대행">무료 주차 대행</div>
		<div class="ser"><input type="checkbox" name="services" value="시설 내 쇼핑몰">시설 내 쇼핑몰</div>
		<div class="ser"><input type="checkbox" name="services" value="도서관">도서관</div>
		<div class="ser"><input type="checkbox" name="services" value="주차(공간 제한)">주차(공간 제한)</div>
		<div class="ser"><input type="checkbox" name="services" value="루프탑 테라스">루프탑 테라스</div>
		</td>
	</tr>
	</table>
	<input type="hidden" name="re_step" value="0">
	<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
	<br>
	<input type="submit" id="c3" value="등록">
</form>
</div>
</div>
</div>
<%}else{ 
int ref = Integer.parseInt(request.getParameter("ref"));
dto=dao.getContentMain(ref);%>
<div id="list2">
<h2>호텔방 등록</h2>
<form id="form2" action="hotelWritePro.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="<%=dto.getType()%>">
	<input type="hidden" name="title" value="<%=dto.getTitle()%>">
	<input type="hidden" name="address" value="<%=dto.getAddress()%>">
	<input type="hidden" name="contact" value="<%=dto.getContact()%>">
	<input type="hidden" name="contactfax" value="<%=dto.getContactfax()%>">
	<input type="hidden" name="re_step" value="1">
	<input type="hidden" name="service" value="<%=dto.getService()%>">
	<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
	<input type="hidden" name="ref" value="<%=ref%>">
	<input type="hidden" name="block" value="<%=request.getParameter("block")%>">
	<table id="tb2">
		<tr>
			<td class="title2">방종류</td>
			<td>
			<select id="sel2" name="roomtype">
				<option value="스탠다드">스탠다드</option>
				<option value="디럭스">디럭스</option>
				<option value="스위트">스위트</option>
			</select>
			</td>
		</tr>
		<tr>
			<td class="title2">인당 가격</td>
			<td><input type="number" name="price"></td>
		</tr>
		<tr>
			<td class="title2">사진</td>
			<td><input type="file" name="upload"></td>
		</tr>
	</table>
	<button id="btn2" type="submit">등록</button>
	</form>
</div>
<%} %>

    