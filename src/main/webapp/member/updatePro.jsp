<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<jsp:useBean id="member" class="hotel.bean.MemberDTO" >
<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<% request.setCharacterEncoding("UTF-8"); %>

<%
    String sid = (String) session.getAttribute("sid");
 
    MemberDAO manager = MemberDAO.getInstance();
    int updateResult = manager.updateMember(member);
    String pw = request.getParameter("pw"); // 비밀번호 받기
    String pw2 = request.getParameter("pw2"); // 비밀번호 확인 받기
    String email = request.getParameter("email"); // 이메일 받기
    String addr = request.getParameter("addr"); // 주소 받기
    String pnum = request.getParameter("pnum"); // 휴대폰 번호 받기
 
%>

<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr> 
    <td height="39" align="center">
  </tr>
  <tr>
    <td align="center"> 
      <p>
        <% if (updateResult == 1) { 
        	manager.humanRelease(sid);%>
          <script>alert("수정이 잘되었습니다");
      	window.location="../views/main.jsp";
      	</script>
              		
        <% } else { %>
          <script>alert("오류가 있습니다 다른 업무보시는동안  부리나게 방법을 찾아보겠습니다 ");
          
          window.location="/BookStay/views/main.jsp";</script>
              			
        <% } %>
      </p>
    </td>
  </tr>
  <tr>
    <td> 
      <form>
        <input type="button" value="메인으로" onclick="window.location='../views/main.jsp'">
      </form>
    </td>
  </tr>
</table>
