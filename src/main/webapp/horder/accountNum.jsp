<%@page import="hotel.bean.adminDAO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@page import="hotel.bean.HOrderDTO"%>
<%@page import="hotel.bean.HOrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/BookStay/resources/css/accountnum.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%@ include file="../views/main_bar.jsp" %>
<%request.setCharacterEncoding("UTF-8");
HOrderDAO odao = new HOrderDAO();
hotelDAO hotel = new hotelDAO();

int renum = odao.getRecentOrder(id);
int totalpay = hotel.getRoomPrice(renum);
HOrderDTO dto = odao.getOrder(renum);
int paid = dto.getPaid();
adminDAO dao = adminDAO.getInstance();
dao.reserveStatusUpdate(renum,totalpay,paid);
String state="";
if(dto.getState()==0){
	state="입금중";
}else if(dto.getState()==1){
	state="입금완료";
}
%>
<div id="list">
<h2>현금 결제</h2>
<table id="tb">
	<tr>
		<td>고객명</td>
		<td><%=dto.getName() %></td>
	</tr>
	<tr>
		<td>체크인</td>
		<td><%=dto.getCheckin() %></td>
	</tr>
	<tr>
		<td>체크아웃</td>
		<td><%=dto.getCheckout() %></td>
	</tr>
	<tr>
		<td>예약인원</td>
		<td>어른 : <%=dto.getAdult() %>명/ 아이 : <%=dto.getKid() %>명</td>
	</tr>
	<tr>
		<td>결제금액</td>
		<td><%=dto.getAdult()%>원</td>
	</tr>
	<tr>
		<td>결제방식</td>
		<td><%=dto.getPaytype() %></td>
	</tr>
	<tr>
		<td>진행상태</td>
		<td><%=state %></td>
	</tr>
</table>
<button type="button" id="btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
  계좌번호 확인
</button>
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">계좌번호</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       계좌번호(TEST)<br/>
       은행 : 가상은행 <br/>
       계좌번호 : 111-2222-3333
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">확인</button>
      </div>
    </div>
  </div>
</div>
</div>
