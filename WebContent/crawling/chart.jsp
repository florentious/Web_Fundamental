<%@page import="java.util.Date"%>
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
%>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['line']});
      google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('date', 'Date');
      data.addColumn('number', 'close');
        <%
        for (int i = 0; i < elements.size(); i++) {
			Element trElement = elements.get(i);
			int index = 0;
			
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
		    
		    //String afterDate = String.format("%04d/%02d/%02d", beforeYear, beforeMonthInt, beforeDay);
		    
		    double open = Double.parseDouble(trElement.child(index++).text().replaceAll(",",""));
		    double high = Double.parseDouble(trElement.child(index++).text().replaceAll(",",""));
		    double low = Double.parseDouble(trElement.child(index++).text().replaceAll(",",""));
		    double close = Double.parseDouble(trElement.child(index++).text().replaceAll(",",""));
		    double volume = Double.parseDouble(trElement.child(index++).text().replaceAll(",",""));
		    double marketCap = Double.parseDouble(trElement.child(index++).text().replaceAll(",",""));
		 	
        %>

      data.addRows([
    	  [new Date('<%=beforeYear%>','<%=beforeMonthInt%>','<%=beforeDay%>'), <%=close%> ]
      ]);

      	<%
        }
      	%>
      
      var options = {
        chart: {
        	title: '<%=coin%> Chart <%=startDate%> ~ <%=endDate%>',
          subtitle: 'Close'
        },
        width: 900,
        height: 500,
        axes: {
          x: {
            0: {side: 'top'}
          }
        }
      };

      var chart = new google.charts.Line(document.getElementById('line_top_x'));

      chart.draw(data, google.charts.Line.convertOptions(options));
    }
  </script>





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
   
   		<h3><strong>Crawling Chart</strong></h3><br>

		<div id="line_top_x"></div>



      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

