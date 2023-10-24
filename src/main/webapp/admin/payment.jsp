<%@ page contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("UTF-8");

if(session.getAttribute("sid")==null){
	%>
	<sciprt>
		alert("로그인 후 이용해주세");
		window.location="member/main.jsp";
	</sciprt>	
	<%
}
String id = (String)session.getAttribute("sid");
%>
<html>
<head>
    <title>배송 정보</title>
</head>
<body>
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">예약 페이지</h1>
        </div>
    </div>
    <div class="container">
        <form action="processOrder.jsp" class="form-horizontal" method="post">
            <input type="hidden" name="cartId" />
            <input type="hidden" name="id" value=<%=id%>>
            <div class="form-group row">
                <label class="col-sm-2">체크인</label>
                <div class="col-sm-3">
                    <input name="checkin" type="text" class="form-control" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">체크아웃</label>
                <div class="col-sm-3">
                    <input name="checkout" type="text" class="form-control" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">성인 예약 인원</label>
                <div class="col-sm-3">
                    <input name="adult" type="text" class="form-control" oninput="document.querySelector('input[name=adultcount]').value = this.value;" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">아이 예약 인원</label>
                <div class="col-sm-3">
                    <input name="kid" type="text" class="form-control" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">결제 방식</label>
                <div class="col-sm-3">
                    <input name="paytype" type="text" class="form-control" />(yyyy/mm/dd)
                </div>
            </div>
            <div class="form-group row" style="display: none;">
                <label class="col-sm-2">상태</label>
                <div class="col-sm-3">
                    <input name="state" type="text" class="form-control" value="1" />
                </div>
            </div>
            <div class="form-group row" style="display: none;">
                <label class="col-sm-2">성인 수</label>
                <div class="col-sm-3">
                    <input name="adultcount" type="text" class="form-control" id="adultCountInput" readonly />
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-offset-2 col-sm-10">
                    <a href="./cart.jsp?cartId=<%=request.getParameter("cartId")%>" class="btn btn-secondary" role="button"> 이전 </a>
                    <input type="submit" class="btn btn-primary" value="등록" />
                    <a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
