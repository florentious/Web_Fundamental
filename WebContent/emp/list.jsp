
<%@page import="kr.co.acorn.dto.EmpDto"%>
<%@page import="kr.co.acorn.dao.EmpDao"%>
<%@page import="java.util.ArrayList"%>

<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	String tempPage = request.getParameter("page");
	//String tempLen = request.getParameter("len");

	int cPage = 0;
	// cPage = Integer.parseInt(temp_page); 하면 이상하면 
	
	int start = 0;
	int len = 10;
	int totalRows = 0;
	int totalPage = 0; 
	int startPage = 0;
	int endPage = 0;
	int pageLength = 3;
	
	int pageNum = 0;
	
	// page값을 공개로 넣기 때문에 코드값에 막넣는 경우에 대해 예외처리하기 위해서 조정함
	if(tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}
	try {
		cPage = Integer.parseInt(tempPage);
	} catch(NumberFormatException e) {
		cPage = 1;
	}
	/* 
	if(tempLen == null || tempLen.length() == 0) {
		len = 2;
	}
	try {
		len = Integer.parseInt(tempLen);
	} catch(NumberFormatException e) {
		len = 2;
	}
	 */
	
	
	
	
	EmpDao dao = EmpDao.getInstance();

	totalRows = dao.getTotalRows();
	
	
	totalPage = totalRows % len ==0 ? totalRows/len : totalRows/len +1;
	if(totalPage == 0) {
		totalPage = 1;
	}
	
	if(cPage > totalPage) {
		response.sendRedirect("list.jsp?page=1");
		return;
	}
	
	/*
	if(cPage > totalPage) {
		cPage=1;
	}
	*/
	
	start = (cPage-1)*len ;
	
	
	int currentBlock = cPage % pageLength == 0 ? cPage/pageLength : cPage/pageLength+1;
	int totalBlock = totalPage % pageLength == 0 ? totalPage/pageLength : totalPage/pageLength+1;
	startPage = 1 + (currentBlock - 1) * pageLength;
	endPage = pageLength + (currentBlock-1)*pageLength;
	
	if(currentBlock == totalBlock) {
		endPage = totalPage;
	}
	
	/* 
	startPage = cPage % pageLength == 0 ? 1 + (cpage/pageLength - 1) * pageLength  : 1 + (cpage/pageLength ) * pageLength;
	endPage = totalPage > (startPage + pageLength -1 )? (startPage + pageLength -1 ) : totalPage;
	 */
	ArrayList<EmpDto> list = dao.select(start, len);
	 
	pageNum = totalRows-((cPage-1)*len);
	

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Employer</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">
      
      <h3><strong>Employer List</strong><small>( total : <%=totalRows %> )</small></h3><br>
      
      <div class="text-right"></div>


		<table class="table table-hover">
		<colgroup>
			<col width="5%" />
			<col width="5%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="15%"/>
			<col width="20%"/>
			<col width="15%"/>
		</colgroup>
		  <thead>
		    <tr>		  		
		      <th scope="col">#</th>
		      <th scope="col">Employer Number</th>
		      <th scope="col">Name</th>
		      <th scope="col">Job</th>
		      <th scope="col">Manager</th>
		      <th scope="col">Department Name </th>
		      <th scope="col">HireDate</th>		      
		    </tr>
		  </thead>
		  <tbody>
		 
		 <%
		 if(list.size() != 0) {
			for(EmpDto dto : list) {
		 
		 %>
		 
		  	<form id="f" method="post">
			    <tr>			    	
			      <td><%=pageNum-- %></td>
			      <td scope="row"><a href="view.jsp?page=<%=cPage%>&no=<%=dto.getNo()%>"><%=dto.getNo() %></a></td>
			      <td><%=dto.getName() %></td>
			      <td><%=dto.getJob() %></td>
			      <td><%=dto.getMgr() %></td>
			      <td><a href="../dept/view.jsp?no=<%=dto.getDeptDto().getNo()%>"><%=dto.getDeptDto().getName() %></td>
			      <td><%=dto.getHireDate() %></td>
			    </tr>
		    </form>
		    
		    <%
				}
			 } else {
			
		    %>
		    
		    <tr>
		    	<td colspan="7"> Don't Exist Data </td>
		    </tr>
		    
		 	<%} %>
		    
		  </tbody>
		</table>

			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<% if(currentBlock == 1) { %>
						<li class="page-item disabled">
						<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>					
						</li>
					<% }else { %>
						<li class="page-item">
						<a class="page-link" href="list.jsp?page=<%=startPage-1 %>">Previous</a>
						</li>
					<%} %>
					
					<%for(int i = startPage;i<=endPage;i++) { %>
					<li class="page-item <%if(cPage==i){ %>active<% }%>"><a class="page-link" href="list.jsp?page=<%=i%>"><%=i%></a></li>
					<%} %>
					<% if(currentBlock == totalBlock) { %>
						<li class="page-item disabled">
						<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Next</a>
						</li>
					<% } else { %>
						<li class="page-item">
						<a class="page-link" href="list.jsp?page=<%=endPage+1%>">Next</a>
						</li>
					<%} %>	
					
				</ul>
			</nav>


			<div class="text-right">
				<a href="write.jsp?page=<%=cPage %>" class="btn btn-outline-success">Sign Up</a>
			</div>
		</div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>



