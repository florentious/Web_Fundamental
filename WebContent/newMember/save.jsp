
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>

<% 
	request.setCharacterEncoding("utf-8"); // 한글이 깨지니까
	
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String pwd = request.getParameter("password");
	String phone = request.getParameter("phone");
	
	
	MemberDao dao = MemberDao.getInstance();
	
	MemberDto dto = new MemberDto(email, name, pwd, phone);
	
	
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
	