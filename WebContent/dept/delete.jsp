<%@page import="kr.co.acorn.dao.DeptDao"%>
<%@ page pageEncoding="utf-8" %>

<%
	request.setCharacterEncoding("utf-8");		

	int cPage = Integer.parseInt(request.getParameter("page"));
	int no = Integer.parseInt(request.getParameter("cNo"));
	
	
	DeptDao dao = DeptDao.getInstance();
	
	boolean isSuccess = dao.delete(no);
	
	
	if(isSuccess) {
	
%>
<script>
	alert("delete complete");
	location.href="list.jsp?page=<%=cPage%>";
</script>

<%
	} else {
%>
<script>
	alert("Database Error");
	history.back(-1);
</script>

<%
	}
%>