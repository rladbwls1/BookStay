<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");
 session.setAttribute("sid", "admin");
 String id = (String)session.getAttribute("sid");
 if(id==null){
	 %>
	 <script>
	 	alert("로그인을 먼저해주세요");
	 	window.location="/login/main.jsp";
	 </script>
	 <%
 }
%>

<form name="form"action="writePro.jsp" method="post" onsubmit="return q_check(event);">
<input type="hidden" name="id">
<input type="hidden" name="category" value="30">
제목<input type="text" id="title "name="title"><br/>
내용<br/>
<textarea rows="6" cols="30" id="content" name="content"></textarea>
<button type="submit">작성</button>
</form>

<script>
function q_check(this){
	event.preventDefault();
	var t = document.getElementById("title");
	if(t.value.length<1){
		alert("제목을 작성해주세요");
		t.focus();
		return false;
	}
	return true;
	}

</script>
