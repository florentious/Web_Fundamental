<%@page import="kr.co.acorn.dao.EmpDao"%>
<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@page import="kr.co.acorn.dto.EmpDto"%>
<%@ page pageEncoding="utf-8" %>

<% 
	request.setCharacterEncoding("utf-8"); // 한글이 깨지니까
	
	//int no = Integer.parseInt(request.getParameter("no"));
	int no = 0;
	String name = request.getParameter("name");
	String job = request.getParameter("job");
	int mgr = Integer.parseInt(request.getParameter("mgr")); 
	
	int sal = Integer.parseInt(request.getParameter("sal"));
	int comm = Integer.parseInt(request.getParameter("comm"));
	int deptNo = Integer.parseInt(request.getParameter("deptno"));
	
	
	EmpDao dao = EmpDao.getInstance();
	
	no = dao.getMaxNextNo();
	
	
	DeptDto deptDto = new DeptDto();
	deptDto.setNo(deptNo);
	
	EmpDto dto = new EmpDto(no,name,job,mgr,null,sal,comm, deptDto);
	
	
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
	