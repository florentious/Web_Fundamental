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
	String url = "https://coinmarketcap.com/currencies/bitcoin/historical-data/";
	
	Document doc = null;
	
	try {
		doc = Jsoup.connect(url).get();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	Elements elements = doc.select(".cmc-table__table-wrapper-outer table tbody tr");
	
	BitcoinDao dao = BitcoinDao.getInstance();
	
	for (int i = 0; i < elements.size(); i++) {
		Element trElement = elements.get(i);
		int index = 0;
		String date = trElement.child(index++).text();
		float open = Float.parseFloat(trElement.child(index++).text().replace(",", ""));
		float high = Float.parseFloat(trElement.child(index++).text().replace(",", ""));
		float low = Float.parseFloat(trElement.child(index++).text().replace(",", ""));
		float close = Float.parseFloat(trElement.child(index++).text().replace(",", ""));
		long volume = Long.parseLong(trElement.child(index++).text().replace(",", ""));
		long cap = Long.parseLong(trElement.child(index++).text().replace(",", ""));
			
		dao.insert(new BitcoinDto(date,open,high,low,close,volume,cap));
		
	}

 	//int total = dao.getTotal();
 	
	ArrayList<BitcoinDto> list = dao.select();
	

%>


  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Library</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->


  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
   
   		<h3><strong>Crawling</strong></h3><br>
   
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
		 
		 
		 if(list.size() != 0) {
			 for(BitcoinDto dto : list) {
				 
			 
		 %>
		 
		  	<form id="f" method="post">
			    <tr>			    	
			      <td><%=dto.getDate() %></td>
			      <td><%=dto.getOpen() %></td>
			      <td><%=dto.getHigh() %></td>
			      <td><%=dto.getLow() %></td>
			      <td><%=dto.getClose() %></td>
			      <td><%=dto.getVolume() %></td>
			      <td><%=dto.getMarketCap() %></td>
			    </tr>
		    </form>
		    
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
