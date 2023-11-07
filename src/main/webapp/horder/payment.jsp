<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />


<%

MemberDAO mdao = MemberDAO.getInstance();
String id = (String) session.getAttribute("sid");
int grade= mdao.checkGrade(id);

    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("sid"); 

    if (userId != null) {
        MemberDTO user = dao.myInfo(userId); 
        
        if (user != null) {
                 
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    
<html>
<head>
    <title>예약</title>
      <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .form-container {
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            padding: 20px;
            margin: 20px;
            margin-top: 80px; /* margin-top 값을 조정하여 폼을 아래로 이동시킵니다 */
        }
        .form-container form {
            
        }
        h1.display-3 {
    margin-top: 90px; /* 값을 조정하여 <h1>를 아래로 이동시킵니다 */
}
.form-group-row {
        margin-bottom: 10px; /* 원하는 간격을 지정합니다 */
    }
        
    </style>
    <link rel="stylesheet" href="/BookStay/resources/css/list_menu.css"/>
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
		<div><a href="/BookStay/admin/adminMain.jsp">관리자페이지</a></div>
		<%} %>	
	</div>
	<div id="logo">
		<a href="main.jsp">
			BookStay
		</a>
	</div>
	</div>
	 
	
	 <div class="container">
    <div class="jumbotron">
        <div class="container">
        
            <h1 class="display-3">예약 페이지</h1>
        </div>
    </div>
 
        <div class="form-container">
        <form action="processOrder.jsp" class="form-horizontal" method="post" >
           
                    <input name="id" type="hidden" value=<%=userId%>/>
                    <input name="ref" type="hidden" value=<%=request.getParameter("ref") %>>
            
            <div class="form-group row form-group-row">
                <label class="col-sm-2">체크인</label>
                <div class="col-sm-3">
                    <input name="checkin" type="date" class="form-control" />
                </div>
            </div>
            <!-- 여기에 공백을 넣습니다 -->
            <div class="form-group row form-group-row">
                <label class="col-sm-2">체크아웃</label>
                <div class="col-sm-3">
                    <input name="checkout" type="date" class="form-control" />
                </div>
            </div>
            <div class="form-group row form-group-row">
                <label class="col-sm-2">성인 예약 인원</label>
                <div class="col-sm-3">
                    <input name="adult" type="text" class="form-control" />
                </div>
            </div>
            <div class="form-group row form-group-row">
                <label class="col-sm-2">아이 예약 인원</label>
                <div class="col-sm-3">
                    <input name="kid" type="text" class="form-control" />
                </div>
            </div>
            <div class="form-group row form-group-row">
                <label class="col-sm-2">결제</label>
                <div class="col-sm-3">
                    <input name="paytype" type="text" class="form-control" />(yyyy/mm/dd)
                </div>
            </div>
            <div class="form-group row form-group-row" style="display: none;">
                <label class="col-sm-2">상태</label>
                <div class="col-sm-3">
                    <input name="state" type="text" class="form-control" value="1" />
                </div>
            </div>
                    <input type="submit" class="btn btn-primary" value="등록" />
                    <input type="button" class="btn btn-secondary" value="취소" onclick="location.href='../views/main.jsp'" />
                
                </div>
            </div>
        </form>
    </div>
</body>
</html>
<% 	
            
    } else {
%>
<script>
    alert("사용자 정보를 가져오는 중 오류가 발생했습니다.");
    window.location = "/BookStay/member/loginform.jsp";
</script>
<%
    }
    } else {
%>
<script>
    alert("세션이 만료되었거나 로그인하지 않았습니다. 다시 로그인해주세요.");
    window.location = "/BookStay/member/loginform.jsp";
</script>
<%
    }
%>