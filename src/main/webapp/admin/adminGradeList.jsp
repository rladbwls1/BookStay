<%@page import="hotel.bean.adminDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hotel.bean.MemberDTO"%>
<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.adminDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>    
<link rel="stylesheet" href="/BookStay/resources/css/admingradelist.css"/>  
<%@ include file="../views/main_bar.jsp" %>  
<%request.setCharacterEncoding("UTF-8");
MemberDAO dao = new MemberDAO();
adminDAO adao = adminDAO.getInstance();
adminDTO dto1 = adao.getPreView();
if(grade!=99){%>
<script>
    alert("관리자페이지입니다");
    window.location="/BookStay/views/main.jsp";
</script>
<%}
ArrayList<MemberDTO> list = null;
String keyword=request.getParameter("keyword");
String check=request.getParameter("check");
if(check==null||check.equals("0")){
	if(keyword==null){
	list = adao.getAllMember();
	}else{
		list=adao.serchGrade(keyword);
	}
}else if(keyword!=null){
		list = adao.serchGrade(Integer.parseInt(check),keyword);
}
if(keyword==null){
	keyword="";
}
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
	    <a class="nav-link active" aria-current="page">등급/관리 조회</a>
	  </li>
	</ul>
<form id="form" >
<select name="check" id="check">
	<option value="0">전체</option>
	<option value="1">아이디</option>
	<option value="2">이름</option>
</select>
<input type="text" id="text" name="keyword" value="<%=keyword%>">
<button id="btn5">검색</button>
</form>
<form action="adminGradePro.jsp" method="post">
<table id="tb">
 <tr>
 	<th>아이디</td>
 	<th>이름</td>
 	<th>현재 등급</td>
 	<th>변경할 등급</td>
 </tr>

<%

for(MemberDTO d : list){%>
	<tr>
		<td><%=d.getId()%></td>
	 	<td><%=d.getName()%></td>
	 	<td><%=d.getGrade() %></td>
	 	<td><select name="grade" id="grade">
	 		<option value="0">일반</option>
	 		<option value="81">휴먼</option>
	 		<option value="82">블랙</option>
	 		<option value="99">관리자</option>
	 	</select><button type="submit" class="cg">변경하기</button></td>
	 	<input type="hidden" name="id" value="<%=d.getId()%>">
	</tr>
<%}%>
</table>
</form>
</div>
</div>
</div>