<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.acorn.hello.dto.MemberManagerDto"%>
<%@page import="kr.co.acorn.hello.dao.MemberManagerDao"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">


<title>memberList</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");	

	String tempPage = request.getParameter("page");
	int cPage = 0;
	int start = 0;
	int len = 3;
	
	int startPage = 0;
	int endPage = 0;
	
	int currentBlock = 0;
	int totalBlock = 0;
	int pageLength = 3;
	int totalPage = 0;
	
	
	if(tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}
	
	try {
		cPage = Integer.parseInt(tempPage);
	} catch(NumberFormatException e) {
		cPage = 1;
	}
	
	MemberManagerDao dao = MemberManagerDao.getInstance();
	
	 
	int totalRows = dao.getTotal();
	
	//totalPage = totalRows % len ==0  ? totalRows % len == 0 ? totalRows/len : (totalRows/len+1);
	
	totalPage = totalRows % len ==0 ? totalRows/len : totalRows/len +1;
	
	if(totalPage == 0) {
		totalPage = 1;
	}
	
	if(cPage > totalPage) {
		response.sendRedirect("memberManagerList.jsp");
		return;
	}
	
	
	
	start = (cPage-1)*len;
	int totalIndex = totalRows - ((cPage-1)*len);
	
	currentBlock = cPage % pageLength == 0 ? cPage/pageLength : cPage/pageLength+1 ;
	totalBlock = totalPage % pageLength == 0? totalPage/pageLength : totalPage/pageLength+1;
	
	startPage = 1 + (currentBlock -1) * pageLength;
	endPage = pageLength + (currentBlock-1)*pageLength;
	
	if(currentBlock == totalBlock) {
		endPage = totalPage;
	}
	
	ArrayList<MemberManagerDto> list = dao.select(start,len);
	
	
	

%>
	<h3>Member list</h3>
	<form id="f" method="post">
		<table>
			<colgroup>
				<col width="20"/>
				<col width="40%"/>			
				<col width="40%"/>			
			</colgroup>
			
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">id</th>
					<th scope="col">name</th>
				</tr>
			</thead>
			<tbody>
				<!-- data from db -->
				
				<%if(list.size() != 0) {
					for(MemberManagerDto dto : list) {
					%>
				
				<tr>
					<td><%=totalIndex-- %></td>
					<td><%=dto.getId() %></td>
					<td><%=dto.getName() %></td>					
				</tr>
				
				<%
					} 
					
				}else { %>
				<!-- data is empty -->
				<tr>
					<td colspan="3"> don't exist data </td>
				</tr>
				
				<%} %>
			</tbody>
		</table>

		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="#">Previous</a></li>
				<%for(int i=startPage;i<=endPage;i++) { %>
				<li class="page-item"><a class="page-link" href="memberManagerList.jsp?page=<%=i%>"><%=i %></a></li>
				<%} %>
				<li class="page-item"><a class="page-link" href="#">Next</a></li>
			</ul>
		</nav>



		<button>sign up</button>
	
	</form>



	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
</body>
</html>