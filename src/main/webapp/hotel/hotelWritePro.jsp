<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");
String path=request.getRealPath("upload");
int max = 1024 * 1024 * 10;
DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
String enc="UTF-8";
MultipartRequest mr = new MultipartRequest(request,path,max,enc,df);

String upload1=mr.getFilesystemName("upload1");
String upload2=mr.getFilesystemName("upload2");
String upload3=mr.getFilesystemName("upload3");
String upload4=mr.getFilesystemName("upload4");
String upload5=mr.getFilesystemName("upload5");
String [] upload = {upload1,upload2,upload3,upload4,upload5};
String img="";
int count=0;
for(int i=0;i<upload.length; i++){
	if(upload[i]!=null){
		count++;
	}
}
for(int i=0;i<count;i++){
	img+=","+upload[i];
}
img=img.substring(1);
/* Enumeration en = mr.getFileNames();
String img="";
while(en.hasMoreElements()){
	img+=","+mr.getFilesystemName("upload");
} */
//img=img.substring(2);
System.out.println(img);



%>

