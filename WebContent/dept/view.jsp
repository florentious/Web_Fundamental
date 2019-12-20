<%@page import="kr.co.acorn.dao.DeptDao"%>
<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	String tempPage = request.getParameter("page");
	String tempNo = request.getParameter("no");
	
	// 이상하게 치는 양반을 위한 방안
	if(tempPage == null || tempPage.length() == 0) {
		tempPage="1";
	}
	
	if(tempNo == null || tempNo.length() == 0) {
		response.sendRedirect("list.jsp?page="+tempPage);
		return;
	}
	
	int cPage = 0;
	int cNo = 0;
	
	try{
		cPage = Integer.parseInt(tempPage);		
	} catch(NumberFormatException e) {
		cPage = 1;
	}
	
	try {
		cNo = Integer.parseInt(tempNo);		
	} catch(NumberFormatException e) {
		response.sendRedirect("list.jsp?page="+cPage);
		return;
	}
	
	
	DeptDao dao = DeptDao.getInstance();
	DeptDto dto = dao.select(cNo);
	
	if(dto == null) {
		response.sendRedirect("list.jsp?page="+cPage);
		return;
	}
	
	

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="list.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">DEPT</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
		<h3><strong>Department Infomation</strong></h3><br>
		
		<form name="f" method="post" >
		  <div class="form-group row">
		    <label for="no" class="col-sm-3 col-form-label">Department Number</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="no" name="no" value="<%=dto.getNo()%>">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="name" class="col-sm-3 col-form-label">Department Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="name" name="name" value="<%=dto.getName()%>">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="loc" class="col-sm-3 col-form-label">Department Location</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="loc" name="loc" value="<%=dto.getLoc()%>">
		    </div>
		  </div>
		  
		  <!-- page 넘길때 조정해서 알아서 넘기는 코드 -->
		  <input type="hidden" name="page" value="<%=cPage %>"/>
		  
		</form>
		<div class="text-right">
			<button type="button" id="prevPage" class="btn btn-outline-info">Go Back</button>
			<button type="button" id="updateDept" class="btn btn-outline-success">Update</button>
			<button type="button" id="deleteDept" class="btn btn-outline-danger">Delete</button>
			
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
<%@ include file ="../inc/footer.jsp" %>


<script>
	$(function() {
		//$("#no").focus();
		$("#updateDept").click(function() {
			// 자바스크립트 유효성검사 필요없음
			if($("#no").val().length==0) {
				alert("Input Department Number");
				$("#no").focus();
				return;
			}
			
			if($("#name").val().length==0) {
				alert("Input Department Name");
				$("#name").focus();
				return;
			} 
			if($("#loc").val().length==0) {
				alert("Input Department Location");
				$("#loc").focus();
				return;
			} 
			
			f.action = "update.jsp?cNo=<%=cNo%>";
			f.submit();
		});
		
		$("#deleteDept").click(function() {
			// 자바 스크립트 유효성 검사  필요없음
			
			f.action = "delete.jsp?cNo=<%=cNo%>";
			f.submit();
		});
		
		$("#prevPage").click(function() {
			// 이전가라는 코드(스크립트 내에)
			history.back(-1);
		});
		
	});
</script>

