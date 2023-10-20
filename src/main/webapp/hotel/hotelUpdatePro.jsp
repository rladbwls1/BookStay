<%@page import="hotel.bean.hotelDTO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id = (String)session.getAttribute("sid");
String path=request.getRealPath("/upload");
int max = 1024 * 1024 * 10;
DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
String enc="UTF-8";
MultipartRequest mr = new MultipartRequest(request,path,max,enc,df);
hotelDAO dao = new hotelDAO();
int num=Integer.parseInt(mr.getParameter("num"));
int re_step=Integer.parseInt(mr.getParameter("re_step"));
String img="";
hotelDTO getdto = new hotelDTO();
hotelDTO setdto = new hotelDTO();
getdto=dao.getContentMain(num);
if(!id.equals("admin")){
	%>
	<script>
		alert("관리자만 접근할수 있습니다.");
		window.location="/login/main.jsp";
	</script>
	<%
}
if(re_step==0){
	String upload1=mr.getFilesystemName("upload1");
	String upload2=mr.getFilesystemName("upload2");
	String upload3=mr.getFilesystemName("upload3");
	String upload4=mr.getFilesystemName("upload4");
	String upload5=mr.getFilesystemName("upload5");
	String [] arrayupload = {upload1,upload2,upload3,upload4,upload5};
	String getimg = getdto.getImg();
	String[] arrayimg=getimg.split(",");
	for(int i=0;i<arrayupload.length;i++){
		if(arrayupload[i]==null){
			break;
		}
		arrayimg[i]=arrayupload[i];
	}
	for(int i=0;i<arrayimg.length; i++){
		if(arrayimg[i]==null){
			break;
		}	
		img+=","+arrayupload[i];
	}
	setdto.setNum(num);
	setdto.setTitle(mr.getParameter("title"));
	setdto.setContent(mr.getParameter("content"));
	setdto.setContact(mr.getParameter("contact"));
	setdto.setContactfax(mr.getParameter("contactfax"));
	setdto.setImg(img);
	dao.updateContent(setdto);
	response.sendRedirect("views/hlist.jsp");
}else{
	String upload=mr.getFilesystemName("upload");
	if(upload!=null){
	img=mr.getParameter("upload");
	}
	setdto.setNum(num);
	setdto.setTitle(mr.getParameter("title"));
	setdto.setContent(mr.getParameter("content"));
	setdto.setRoomtype(mr.getParameter("roomtype"));
	setdto.setAprice(Integer.parseInt(mr.getParameter("aprice")));
	setdto.setKprice(Integer.parseInt(mr.getParameter("kprice")));
	setdto.setImg(img);
	dao.updateContent(setdto);
	dao.priceUpdate(num);
	response.sendRedirect("hotelContent.jsp?num="+num);
}%>