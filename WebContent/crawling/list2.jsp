<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="kr.co.acorn.dto.BitcoinDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.acorn.dao.BitcoinDao"%>
<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%	
	request.setCharacterEncoding("utf-8");

	String startDate = request.getParameter("start");
	String endDate = request.getParameter("end");
	
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	
	if(endDate == null || endDate.length() == 0) {
		endDate = sdf.format(cal.getTime());
	}
	
	if(startDate == null || startDate.length() ==0) {
		int sYear = Integer.parseInt(endDate.substring(0, 4));
		int sMonth = Integer.parseInt(endDate.substring(4,6));
		int sDay = Integer.parseInt(endDate.substring(6,8));
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(String.format("%04d",sYear));
		sb.append(String.format("%02d",sMonth-1));
		sb.append(String.format("%02d",sDay));
		
		startDate = sb.toString();
	}
	
	StringBuffer urlSB = new StringBuffer();
	
	urlSB.append("https://coinmarketcap.com/currencies/bitcoin/historical-data/?start=");
	urlSB.append(startDate);
	urlSB.append("&end=");
	urlSB.append(endDate);
	
	String url = urlSB.toString();
	
	Document doc = null;
	
	try {
		doc = Jsoup.connect(url).get();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	Elements elements = doc.select(".cmc-table__table-wrapper-outer table tbody tr");
	
	int cYear = cal.get(Calendar.YEAR);
	
%>


  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Crawling</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
   
   		<h3><strong>Crawling</strong></h3><br>



		<form name="fSearch" method="get">
			<div class="form-group">
				<label for="coinType">Coin Type</label> <select class="form-control" id="coinType">
					<option>bitCoin</option>
				</select>
			</div>
		
		<%-- start Year --%>
			<div class="form-group row" >
				<div class="col-sm-3">
					<label >Start Year : </label>
				</div>
				<div class="col-sm-3">
					<label> year : </label>
					<select class="form-control" id="sYear" name="sYear" >
					<%for(int i=cYear; i>=2010; i--) { %>
						<option value="<%=i %>" ><%=i %></option>
					<%} %>
					</select>
				</div>
				
				<div class="col-sm-3">
					<label> month : </label>
					<select class="form-control" id="sMonth" name="sMonth" >
					<%for(int i=1; i<=12; i++) { %>
						<option value="<%=i %>"><%=i %></option>
					<%} %>
					</select>
				</div>
				
				<div class="col-sm-3">
					<label> day : </label>
					<select class="form-control" id="sDay" name="sDay">
					<%for(int i=1; i<=31; i++) { %>
						<option value="<%=i %>"><%=i %></option>
					<%} %>
					</select>
				</div>
			</div>
	
		<%-- End Year --%>
			<div class="form-group row" >
				<div class="col-sm-3">
					<label >End Year : </label>
				</div>
				<div class="col-sm-3">
					<label> year : </label>
					<select class="form-control" id="eYear" name="eYear" >
					<%for(int i=cYear; i>=2010; i--) { %>
						<option value="<%=i %>"><%=i %></option>
					<%} %>
					</select>
				</div>
				
				<div class="col-sm-3">
					<label> month : </label>
					<select class="form-control" id="eMonth" name="eMonth" >
					<%for(int i=1; i<=12; i++) { %>
						<option value="<%=i %>"><%=i %></option>
					<%} %>
					</select>
				</div>
				
				<div class="col-sm-3">
					<label> day : </label>
					<select class="form-control" id="eDay" name="eDay" >
					<%for(int i=1; i<=31; i++) { %>
						<option value="<%=i %>"><%=i %></option>
					<%} %>
					</select>
				</div>
			</div>
			
			<input type="hidden" id="start" name="start" value=""/>
			<input type="hidden" id="end" name="end" value=""/>
			
			<div class="text-right" >
					<button type="button" class="btn btn-outline-success" id="search" style="margin-bottom : 1em">Search</button>
			</div>
		</form>
		
		


	<table class="table table-hover">
		<colgroup>
			<col width="20%" />
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="20%"/>
			<col width="20%"/>
		</colgroup>
		  <thead>
		    <tr>		  		
		      <th scope="col">Date</th>
		      <th scope="col">Open</th>
		      <th scope="col">High</th>
		      <th scope="col">Low</th>
		      <th scope="col">Close</th>
		      <th scope="col">Volume</th>
		      <th scope="col">Market Cap</th>		      
		    </tr>
		  </thead>
		  <tbody>
		 
		 <%
		 if(elements.size() != 0) {
			 for (int i = 0; i < elements.size(); i++) {
				Element trElement = elements.get(i);
				int index = 0;
			 
		 %>
		 
		  <!-- 	<form id="f" method="post"> -->
			    <tr>			    	
			      <td><%=trElement.child(index++).text() %></td>
			      <td><%=trElement.child(index++).text() %></td>
			      <td><%=trElement.child(index++).text() %></td>
			      <td><%=trElement.child(index++).text() %></td>
			      <td><%=trElement.child(index++).text() %></td>
			      <td><%=trElement.child(index++).text() %></td>
			      <td><%=trElement.child(index++).text() %></td>
			    </tr>
		   <!--  </form> -->
		    
		    <%
			 	}
			 }else {
		    %>
		    
		    <tr>
		    	<td colspan="7"> Don't Exist Data </td>
		    </tr>
		    
		 	<%} %>
		    
		  </tbody>
		</table>
		<%-- 
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
           --%>
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function () {
		$("#search").click(function() {
			
			let startDate = $("#sYear").val()+$("sMonth").val()+$("sDay").val();
			let endDate = $("#eYear").val()+$("eMonth").val()+$("eDay").val();
			
			$("#start").val(startDate );
			$("#end").val(endDate );

			
			
			fSearch.action = "/crawling/list2.jsp";
			fSearch.submit();
			
		});
		
		
	});
	



</script>
