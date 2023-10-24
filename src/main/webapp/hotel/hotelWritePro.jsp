<%@page import="hotel.bean.hotelDAO"%>
<%@page import="hotel.bean.hotelDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="hotel.bean.hotelDTO"/>
<%request.setCharacterEncoding("UTF-8");
String id = (String)session.getAttribute("sid");
if(!id.equals("admin")){
	%>
	<script>
		alert("관리자만 접근할수 있습니다.");
		window.location="../member/main.jsp";
	</script>
	<%
	
} 
String path=request.getRealPath("/upload");
int max = 1024 * 1024 * 10;
DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
String enc="UTF-8";
MultipartRequest mr = new MultipartRequest(request,path,max,enc,df);
hotelDAO dao = new hotelDAO();

String img="";
String service="";
if(mr.getParameter("re_step").equals("1")){
	String upload=mr.getFilesystemName("upload");
	dto.setAddress(mr.getParameter("address"));
	dto.setType(mr.getParameter("type"));
	dto.setTitle(mr.getParameter("title"));
	dto.setContent(mr.getParameter("content"));
	dto.setContactfax(mr.getParameter("contactfax"));
	dto.setContact(mr.getParameter("contact"));
	dto.setRef(Integer.parseInt(mr.getParameter("ref")));
	dto.setRoomtype(mr.getParameter("roomtype"));
	dto.setAprice(Integer.parseInt(mr.getParameter("aprice")));
	dto.setKprice(Integer.parseInt(mr.getParameter("kprice")));
	dto.setImg(upload);
	dao.hotelContentInsert(dto);
	int ref=Integer.parseInt(mr.getParameter("ref"));
	dao.priceUpdate(ref);
	response.sendRedirect("hotelContent.jsp?ref="+ref);
}else{
	String upload1=mr.getFilesystemName("upload1");
	String upload2=mr.getFilesystemName("upload2");
	String upload3=mr.getFilesystemName("upload3");
	String upload4=mr.getFilesystemName("upload4");
	String upload5=mr.getFilesystemName("upload5");
	String [] arrayupload = {upload1,upload2,upload3,upload4,upload5};
	String [] arrayservice = mr.getParameterValues("services");
	for(int i=0;i<arrayupload.length; i++){
		if(arrayupload[i]==null){
			break;
		}	
		img+=","+arrayupload[i];
	}
	for(int i=0;i<arrayservice.length;i++){
		service+=","+arrayservice[i];
	}
	service=service.substring(1);
	img=img.substring(1);
	String fax="";
	if(mr.getParameter("contactfax")==null){
	fax=" ";
	}else{
		fax=mr.getParameter("contactfax");
	}
	dto.setAddress(mr.getParameter("address"));
	dto.setType(mr.getParameter("type"));
	dto.setTitle(mr.getParameter("title"));
	dto.setContent(mr.getParameter("content"));
	dto.setContactfax(fax);
	dto.setContact(mr.getParameter("contact"));
	dto.setService(service);
	dto.setImg(img);
	dao.hotelMainInsert(dto);
	response.sendRedirect("hotelList.jsp");
}
%>

