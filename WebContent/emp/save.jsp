<%@page import="kr.co.acorn.dao.DeptDao"%>
<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@ page pageEncoding="utf-8" %>

<% 
	request.setCharacterEncoding("utf-8"); // 한글이 깨지니까
	
	int no = Integer.parseInt(request.getParameter("no"));
	String name = request.getParameter("name");
	String loc = request.getParameter("loc");
		
	
	DeptDto dto = new DeptDto(no,name,loc);
	DeptDao dao = DeptDao.getInstance();
	
	boolean isSuccess = dao.insert(dto);
	
	if(isSuccess) {
	
%>
		
<script>
	alert("Insert complete");
	location.href="list.jsp?page=1";
</script>
<% } else { %>
<script>
	alert("DataBase Error");	
	history.back(-1);
</script>
<% }%>
	