<%@page import="kr.co.acorn.dao.DeptDao"%>
<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@ page pageEncoding="utf-8" %>


<% 
	request.setCharacterEncoding("utf-8");	

	int cNo = Integer.parseInt(request.getParameter("cNo"));
	int cPage = Integer.parseInt(request.getParameter("page"));
	
	int no = Integer.parseInt(request.getParameter("no"));
	String name = request.getParameter("name");
	String loc = request.getParameter("loc");
	
	DeptDto dto = new DeptDto(no,name,loc);
	
	DeptDao dao = DeptDao.getInstance();
	
	boolean isSuccess = dao.update(dto, cNo);
	
	if(isSuccess) {
%>
<script>
	alert("Update Success");
	location.href = "view.jsp?page=<%=cPage%>&no=<%=no%>";
</script>


<%
	} else {
%>
<script>
	alert("DataBase Error");
	history.back(-1)
	<%-- location.href = "view.jsp?page="+<%=cPage%>+"&no="+<%=no%>; --%>
</script>

<%
	}
%>