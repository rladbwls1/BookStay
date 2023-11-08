<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@page import="hotel.bean.hotelDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="hotel.bean.hotelDTO"/>
<%request.setCharacterEncoding("UTF-8");
MemberDAO mdao = MemberDAO.getInstance();
String sid = (String) session.getAttribute("sid");
int id= mdao.checkGrade(sid);
if (id!=99){
	 %>
	  <script>
	  	alert("관리자만 접근할수 있습니다.");
	  	window.location="../views/main.jsp";
	  </script>
<%}
String path=request.getRealPath("/upload");
int max = 1024 * 1024 * 10;
DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
String enc="UTF-8";
MultipartRequest mr = new MultipartRequest(request,path,max,enc,df);
hotelDAO dao = new hotelDAO();

String img="";
String service="";
if(mr.getParameter("re_step").equals("1")){
	String block="";
	if(mr.getParameter("block")!=null){
		block=mr.getParameter("block");
	}else{
		block="0";
	}
	String upload="default.gif";
	if(mr.getFilesystemName("upload")!=null){
		upload=mr.getFilesystemName("upload");
	}
	dto.setAddress(mr.getParameter("address"));
	dto.setType(mr.getParameter("type"));
	dto.setTitle(mr.getParameter("title"));
	dto.setContent(mr.getParameter("content"));
	dto.setContactfax(mr.getParameter("contactfax"));
	dto.setContact(mr.getParameter("contact"));
	dto.setRef(Integer.parseInt(mr.getParameter("ref")));
	dto.setRoomtype(mr.getParameter("roomtype"));
	dto.setPrice(Integer.parseInt(mr.getParameter("price")));
	dto.setImg(upload);
	dao.hotelContentInsert(dto);
	int ref=Integer.parseInt(mr.getParameter("ref"));
	dao.priceUpdate(ref);
	response.sendRedirect("hotelContent.jsp?ref="+ref+"&block="+block+"&room=1&adult=2&kids=0&select=1&checkin=2023-01-01&checkout=2023-01-02&title=test");
}else{
	String upload1="default.gif";
	String upload2="default.gif";
	String upload3="default.gif";
	if(mr.getFilesystemName("upload3")!=null){
		if(mr.getFilesystemName("upload2")!=null){
			if(mr.getFilesystemName("upload1")!=null){
				upload1=mr.getFilesystemName("upload1");
				upload2=mr.getFilesystemName("upload2");
				upload3=mr.getFilesystemName("upload3");
			}else if(mr.getFilesystemName("upload1")==null){
				upload1=mr.getFilesystemName("upload2");
				upload2=mr.getFilesystemName("upload3");
			}
		}else if (mr.getFilesystemName("upload2")==null){
			if(mr.getFilesystemName("upload1")!=null){
				upload1=mr.getFilesystemName("upload1");
				upload2=mr.getFilesystemName("upload3");
			}else if(mr.getFilesystemName("upload1")==null){
				upload1=mr.getFilesystemName("upload3");
			}
		}
	else if(mr.getFilesystemName("upload3")==null){
		if(mr.getFilesystemName("upload2")!=null&&mr.getFilesystemName("upload1")!=null){
			upload1=mr.getFilesystemName("upload1");
			upload2=mr.getFilesystemName("upload2");
		}else if(mr.getFilesystemName("upload2")==null&&mr.getFilesystemName("upload1")!=null){
			upload1=mr.getFilesystemName("upload1");
		}else if(mr.getFilesystemName("upload2")!=null&&mr.getFilesystemName("upload1")==null){
			upload1=mr.getFilesystemName("upload2");
		}
		}
		
	}
	
	String [] arrayupload = {upload1,upload2,upload3};
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
	response.sendRedirect("/BookStay/admin/adminHotelList.jsp?check=1");
}
%>

