<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@ page pageEncoding="utf-8" %>

<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

  <title>Our Site!</title>
</head>

<body>
  <!-- navbar start -->
  <nav class="navbar navbar-expand-lg navbar-dark " style="background-color: #563d7c;">
    <a class="navbar-brand" href="/index.jsp">Home</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02"
      aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
<%
	// 해당부분을 강조하기 위해서 시작값이 다름- 해당위치에 있다는 것을 강조하기 위해서
	String uri = request.getRequestURI();
	String contextPath = request.getContextPath();
	
%>

    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
      <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
        <li class="nav-item <%if(uri.startsWith("/dept/")) {%>active<%} %>">
          <a class="nav-link" href="<%=contextPath %>/dept/list.jsp">Department Manager <span class="sr-only">(current)</span></a>
        </li>
        
        <li class="nav-item <%if(uri.startsWith("/emp/")) {%>active<%} %>">
          <a class="nav-link" href="<%=contextPath %>/emp/list.jsp">Employer Manager <span class="sr-only">(current)</span></a>
        </li>
        
        <li class="nav-item <%if(uri.startsWith("/crawling/")) {%>active<%} %>">
          <a class="nav-link" href="<%=contextPath %>/crawling/list.jsp">Crawling <span class="sr-only">(current)</span></a>
        </li>
        
        <li class="nav-item <%if(uri.startsWith("/member/")) {%>active<%} %>">
          <a class="nav-link" href="<%=contextPath %>/member/list.jsp">Member <span class="sr-only">(current)</span></a>
        </li>
        
        <li class="nav-item <%if(uri.startsWith("/file/")) {%>active<%} %>">
          <a class="nav-link" href="<%=contextPath %>/file/index.jsp">File Up/DownLoad <span class="sr-only">(current)</span></a>
        </li>
        
        <li class="nav-item <%if(uri.startsWith("/notice/")) {%>active<%} %>">
          <a class="nav-link" href="<%=contextPath %>/notice/list.jsp">Notice</a>
        </li>
      </ul>
      
      <ul class="navbar-nav">
      <%
      	MemberDto memberDto = (MemberDto)session.getAttribute("member");	
      	
      	if(memberDto == null) {
      %>
      	<li class="nav-item">
      		<a class="nav-link" href="/member/write.jsp"> Sign Up</a>
      	</li>
      	
      	<li class="nav-item">
      		<a class="nav-link" href="/member/login.jsp"> Log In</a>
      	</li>
      
      <%
     	 } else {
      %>
      	<li class="nav-item">
      		<a class="nav-link" href="/member/view.jsp?email=<%=memberDto.getEmail()%>"><%=memberDto.getName() %> </a>
      	</li>
      	
      	<li class="nav-item">
      		<a class="nav-link" href="/member/logout.jsp"> Log Out</a>
      	</li>
      	
      
      <% } %>
      </ul>
      
      
    </div>
  </nav>
  <!-- navbar end -->
  
  
  