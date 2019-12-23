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
	String coin = request.getParameter("coin");
	
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
	
	if(Integer.parseInt(endDate) < Integer.parseInt(startDate)) {
		int sYear = Integer.parseInt(endDate.substring(0, 4));
		int sMonth = Integer.parseInt(endDate.substring(4,6));
		int sDay = Integer.parseInt(endDate.substring(6,8));
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(String.format("%04d",sYear));
		sb.append(String.format("%02d",sMonth-1));
		sb.append(String.format("%02d",sDay));
		
		startDate = sb.toString();
	}
	
	if(coin == null || coin.length() == 0) {
		coin = "bitcoin";
	}
	
	StringBuffer urlSB = new StringBuffer();
	
	urlSB.append("https://coinmarketcap.com/currencies/");
	urlSB.append(coin);
	urlSB.append("/historical-data/?start=");
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



		
			<div class="form-group row" style="text-right">
				<label for="coinTypeSelect" class="col-sm-3"> Coin Type : </label> 
				<select class="form-control col-sm-3" id="coinTypeSelect" name="coinTypeSelect">
					<option value="bitcoin" <%=coin.equals("bitcoin")? "selected":"" %> >bitcoin</option>
					<option value="ethereum" <%=coin.equals("ethereum")? "selected":"" %> >ethereum</option>
					<option value="xrp" <%=coin.equals("xrp")? "selected":"" %> >xrp</option>
					<option value="tether" <%=coin.equals("tether")? "selected":"" %> >tether</option>
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
						<option value="<%=i %>" <%=Integer.parseInt(startDate.substring(0,4))==i? "selected":"" %> ><%=i %></option>
					<%} %>
					</select>
				</div>
				
				<div class="col-sm-3">
					<label> month : </label>
					<select class="form-control" id="sMonth" name="sMonth" >
					<%for(int i=1; i<=12; i++) { %>
						<option value="<%=i %>" <%=Integer.parseInt(startDate.substring(4,6))==i? "selected":"" %>><%=i %></option>
					<%} %>
					</select>
				</div>
				
				<div class="col-sm-3">
					<label> day : </label>
					<select class="form-control" id="sDay" name="sDay">
					<%for(int i=1; i<=31; i++) { %>
						<option value="<%=i %>" <%=Integer.parseInt(startDate.substring(6))==i? "selected":"" %>><%=i %></option>
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
						<option value="<%=i %>" <%=Integer.parseInt(endDate.substring(0,4))==i? "selected":"" %>><%=i %></option>
					<%} %>
					</select>
				</div>
				
				<div class="col-sm-3">
					<label> month : </label>
					<select class="form-control" id="eMonth" name="eMonth" >
					<%for(int i=1; i<=12; i++) { %>
						<option value="<%=i %>" <%=Integer.parseInt(endDate.substring(4,6))==i? "selected":"" %> ><%=i %></option>
					<%} %>
					</select>
				</div>
				
				<div class="col-sm-3">
					<label> day : </label>
					<select class="form-control" id="eDay" name="eDay" >
					<%for(int i=1; i<=31; i++) { %>
						<option value="<%=i %>" <%=Integer.parseInt(endDate.substring(6))==i? "selected":"" %> ><%=i %></option>
					<%} %>
					</select>
				</div>
			</div>
			
		<form name="f" method="get">
			
			<input type="hidden" id="coin" name="coin" value="bitcoin"/>
			<input type="hidden" id="start" name="start" value=""/>
			<input type="hidden" id="end" name="end" value=""/>
		</form>
			
			<div class="text-right" >
					<button type="button" class="btn btn-outline-info" id="chart" style="margin-bottom : 1em; margin-right : 1em">chart</button>
					<button type="button" class="btn btn-outline-success" id="search" style="margin-bottom : 1em">Search</button>
			</div>
		
		


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
			    <% 
			    /* change to date format */
			    String beforeDate = trElement.child(index++).text();
			    String beforeMonth = beforeDate.substring(0,3);
			    int beforeMonthInt = 1;
			    
			    switch(beforeMonth) {
			    case "Jan" : beforeMonthInt = 1; break;
			    case "Feb" : beforeMonthInt = 2; break;
			    case "Mar" : beforeMonthInt = 3; break;
			    case "Apr" : beforeMonthInt = 4; break;
			    case "May" : beforeMonthInt = 5; break;
			    case "Jun" : beforeMonthInt = 6; break;
			    case "Jul" : beforeMonthInt = 7; break;
			    case "Aug" : beforeMonthInt = 8; break;
			    case "Sep" : beforeMonthInt = 9; break;
			    case "Oct" : beforeMonthInt = 10; break;
			    case "Nov" : beforeMonthInt = 11; break;
			    case "Dec" : beforeMonthInt = 12; break;
			    
			    }
			    
			    int beforeDay = Integer.parseInt(beforeDate.substring(4, 6));
			    
			    int beforeYear = Integer.parseInt(beforeDate.substring(8));
			    
			    String afterDate = String.format("%04d/%02d/%02d", beforeYear, beforeMonthInt, beforeDay);
			    
			    %>
			      <td><%=afterDate %></td>
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
			 /* chart */
			 
			 
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
			
			let monthLen = 2;
			let dayLen = 2;
			/* get '0' startDate */
			let startMonth ="";
			for(let i=0;i<monthLen - $("#sMonth").val().length; i++ ){
				startMonth += "0";
			}
			startMonth += $("#sMonth").val();
			
			let startDay ="";
			for(let i=0;i<dayLen - $("#sDay").val().length; i++ ){
				startDay += "0";
			}
			startDay += $("#sDay").val();
			/* end StartDate */
			
			/*  */
			let endMonth ="";
			for(let i=0;i<monthLen - $("#eMonth").val().length; i++ ){
				endMonth += "0";
			}
			endMonth += $("#eMonth").val();
			
			let endDay ="";
			for(let i=0;i<dayLen - $("#eDay").val().length; i++ ){
				endDay += "0";
			}
			endDay += $("#eDay").val();
			/*  */
			
			let startDate = $("#sYear").val()+ startMonth + startDay;
			let endDate = $("#eYear").val()+endMonth + endDay;
			
			$("#start").val(startDate );
			$("#end").val(endDate );
			
			$("#coin").val($("#coinTypeSelect").val());

			f.action = "/crawling/list2.jsp";
			f.submit();
			
		});
		
		
		$("#chart").click(function() {
			
			let monthLen = 2;
			let dayLen = 2;
			/* get '0' startDate */
			let startMonth ="";
			for(let i=0;i<monthLen - $("#sMonth").val().length; i++ ){
				startMonth += "0";
			}
			startMonth += $("#sMonth").val();
			
			let startDay ="";
			for(let i=0;i<dayLen - $("#sDay").val().length; i++ ){
				startDay += "0";
			}
			startDay += $("#sDay").val();
			/* end StartDate */
			
			/*  */
			let endMonth ="";
			for(let i=0;i<monthLen - $("#eMonth").val().length; i++ ){
				endMonth += "0";
			}
			endMonth += $("#eMonth").val();
			
			let endDay ="";
			for(let i=0;i<dayLen - $("#eDay").val().length; i++ ){
				endDay += "0";
			}
			endDay += $("#eDay").val();
			/*  */
			
			let startDate = $("#sYear").val()+ startMonth + startDay;
			let endDate = $("#eYear").val()+endMonth + endDay;
			
			$("#start").val(startDate );
			$("#end").val(endDate );
			
			$("#coin").val($("#coinTypeSelect").val());
			
			f.action = "chart.jsp";
			f.submit();
			
		});
		
		
	});
	



</script>
