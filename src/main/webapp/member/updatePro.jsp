<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

+<jsp:useBean id="member" class="hotel.bean.MemberDTO" >
<jsp:setProperty name="member" property="*" />
</jsp:useBean>
<% request.setCharacterEncoding("UTF-8");%>

<%
	String id = (String) session.getAttribute("sid");

	member.setId(id);
	
	MemberDAO manager = MemberDAO.getInstance();
	
		manager.updateMember(member);

%><table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr > 
    <td height="39"  align="center">
  </tr>
  <tr>
    <td  align="center"> 
      <p>입력하신 내용대로 수정이 완료되었습니다.</p>
    </td>
  </tr>
  <tr>
    <td  > 
      <form>
	    <input type="button" value="메인으로" onclick="window.location='main.jsp'">
      </form>
    </td>
  </tr>
</table>