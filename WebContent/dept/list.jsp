<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.acorn.dao.DeptDao"%>
<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	DeptDao dao = DeptDao.getInstance();

	ArrayList<DeptDto> list = dao.select(0, 5);
	
	

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">DEPT</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">
      
      <h3><strong>Department List</strong></h3><br>


		<table class="table table-hover">
		<colgroup>
			<col width="20%">
			<col width="40%">
			<col width="40%">
		</colgroup>
		  <thead>
		    <tr>
		      <th scope="col">Department Number</th>
		      <th scope="col">Department Name</th>
		      <th scope="col">Department Location</th>
		    </tr>
		  </thead>
		  <tbody>
		  	<%
		  		if(list.size() != 0) {
		  			for(DeptDto dto : list) {
		  			
		  	%>
		  	
		  
		    <tr>
		      <th scope="row"><a href="view.jsp" name="no"><%=dto.getNo() %></a></th>
		      <td><a href="view.jsp"><%=dto.getName() %></a></td>
		      <td><a href="view.jsp"><%=dto.getLoc() %></a></td>
		    </tr>
		    
		    <%
		  			}
		  		} else {
		    %>
		    
		    <tr>
		    	<td colsapn="3"> Don't Exist Data </td>
		    </tr>
		    
		    <%
		    }
		  	%>
		    
		  </tbody>
		</table>

			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<li class="page-item disabled"><a class="page-link" href="#"
						tabindex="-1" aria-disabled="true">Previous</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">Next</a></li>
				</ul>
			</nav>


			<div class="text-right">
				<a href="write.jsp" class="btn btn-outline-success">Sign Up</a>
			</div>
		</div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>
