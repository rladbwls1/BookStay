<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<%@ page import = "hotel.bean.reviewDTO" %>
<%@ page import = "hotel.bean.reviewDAO" %>
<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />
<%@ include file="../views/main_bar.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userId = (String) session.getAttribute("sid");
    reviewDAO rdao = new reviewDAO();
	boolean check = false;
	if(request.getParameter("ref")!=null){
		check=true;
	}
	if(!check){%>
		<script>
			alert("이용고객만 작성 가능합니다.");
			history.go(-1);
		</script>
	<%} 
   if (userId != null) {
        MemberDTO user = dao.myInfo(userId); 
        
        if (user != null) {
                 
%>


    <form action="reviewWritePro.jsp" method="post">
        
        <input type="hidden" id="id" name="<%=userId%>">
   

        <div class="container">
        <div class="form-check" style="text-align: center;">
	    	<div style="margin: 0 auto; text-align: left; width: 200px;">
	        	<img id="img" src="../resources/img/heart0.jpeg" height="35" width="180"><br>
	        </div>
        	<label class="form-check-label" for="flexRadioDefault1"></label>
		</div>
        1<input type="radio" class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" value="1" onclick="changeImg(1)">
        2<input type="radio" class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" value="2" onclick="changeImg(2)">
        3<input type="radio" class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" class="form-check-input" id="flexRadioDefault1" type="radio"value="3" onclick="changeImg(3)">
        4<input type="radio" class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" value="4" onclick="changeImg(4)">
        5<input type="radio" class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" value="5" onclick="changeImg(5)">
        </div>
        <br>

        <label for="content">리뷰 내용</label> <br>
        <textarea id="content" name="content" rows="10" cols="40" required></textarea><br>

        <input type="hidden" name="ref" value="<%= request.getParameter("ref") %>">
        
        <input type="submit" value="작성">
        <button onclick="window.location='/BookStay/views/main.jsp'">취소</button>
    </form>


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
<script>
function changeImg(num){
	if(num==1){
		document.getElementById("img").src="../resources/img/heart1.jpeg";
	}else if(num==2){
		document.getElementById("img").src="../resources/img/heart2.jpeg";
	}else if(num==3){
		document.getElementById("img").src="../resources/img/heart3.jpeg";
	}else if(num==4){
		document.getElementById("img").src="../resources/img/heart4.jpeg";
	}else if(num==5){
		document.getElementById("img").src="../resources/img/heart5.jpeg";
	}
}
</script>