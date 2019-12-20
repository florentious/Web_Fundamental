<%@page import="kr.co.acorn.dto.EmpDto"%>
<%@page import="kr.co.acorn.dao.EmpDao"%>
<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@ page pageEncoding="utf-8" %>


<% 
	request.setCharacterEncoding("utf-8");	

	int cNo = Integer.parseInt(request.getParameter("cNo"));
	int cPage = Integer.parseInt(request.getParameter("page"));
	
	int no = Integer.parseInt(request.getParameter("no"));
	String name = request.getParameter("name");
	String job = request.getParameter("job");
	int mgr = Integer.parseInt(request.getParameter("mgr")); 
	
	int sal = Integer.parseInt(request.getParameter("sal"));
	int comm = Integer.parseInt(request.getParameter("comm"));
	int deptNo = Integer.parseInt(request.getParameter("deptno"));
	
	DeptDto deptDto = new DeptDto(deptNo,null,null);
	
	EmpDto dto = new EmpDto(no,name,job,mgr,null,sal,comm, deptDto);
	
	EmpDao dao = EmpDao.getInstance();
	
	boolean isSuccess = dao.update(dto);
	
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