<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@ page pageEncoding="utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
	
	//String name = request.getParameter("name"); => null;
	
	String path = request.getRealPath("/upload/file");
	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH)+1;
	path += File.separator + year + File.separator + month;
	
	File f =new File(path);
	
	if(!f.exists()) {
		f.mkdirs();
	}
	
	// 객체가 생성되는순간 업로드 완료
	MultipartRequest multi = null;
	try {
		multi = new MultipartRequest(
				request,	
				path,							// upload할 디렉토리
				10*1024*1024,					// 업로드할 파일 최대크기
				"utf-8",						// 인코딩 타입
				//파일이이름이 중복되었을떄 파일명 끝에 1,2,3, 순으로 숫자 붙여주는 클래스
				new DefaultFileRenamePolicy()
				);
	}catch(Exception e) {
		e.printStackTrace();
	}
	String name = multi.getParameter("name");
	String fileName = multi.getFilesystemName("file");
	String uploadName = multi.getOriginalFileName("file");
	File f1 = new File(f,fileName);
	
	long fileSize = f1.length()/1024;
	
	
	
	
%>
path : <%=path %><br>
name : <%=name%><br>	<%-- 아래 경로를 db에 넣어야 꺼낼수 있다. db에 넣을떄는 경로포함 주소까지 들어가야 꺼낼 수 있다. --%> 
<img src="/upload/file/<%=year%>/<%=month %>/<%=fileName %>" style="width : 100px; height : 100px"><br>
File System Name : <a href="/upload/file/<%=year%>/<%=month %>/<%=fileName %>" > <%=fileName%> (<%=fileSize %>kb)</a><br>
File Origin Name : <%=uploadName%><br>



