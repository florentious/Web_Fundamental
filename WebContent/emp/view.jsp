<%@page import="kr.co.acorn.dto.EmpDto"%>
<%@page import="kr.co.acorn.dao.EmpDao"%>
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
	
	
	EmpDao dao = EmpDao.getInstance();
	EmpDto dto = dao.select(cNo);
	
	if(dto == null) {
		response.sendRedirect("list.jsp?page="+cPage);
		return;
	}
	
	

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="list.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Employer</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
		<h3><strong>Employer Details</strong></h3><br>
		
		<form name="f" method="post" >
		  <div class="form-group row">
		    <label for="no" class="col-sm-3 col-form-label">Employer Number</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" readonly id="no" name="no" value="<%=dto.getNo()%>">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="name" class="col-sm-3 col-form-label">Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="name" name="name" value="<%=dto.getName()%>">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="job" class="col-sm-3 col-form-label">Job</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="job" name="job" value="<%=dto.getJob()%>">
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="mgr" class="col-sm-3 col-form-label">Manager</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="mgr" name="mgr" value="<%=dto.getMgr()%>">
		    </div>
		  </div>

		  <div class="form-group row">
		    <label for="hiredate" class="col-sm-3 col-form-label">HireDate</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" readonly id="hiredate" name="hiredate" value="<%=dto.getHireDate()%>">
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="sal" class="col-sm-3 col-form-label">Salary</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="sal" name="sal" value="<%=dto.getSal()%>">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="comm" class="col-sm-3 col-form-label">commission</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="comm" name="comm" value="<%=dto.getComm()%>">
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="deptno" class="col-sm-3 col-form-label">Department Number</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="deptno" name="deptno" value="<%=dto.getDeptDto().getNo()%>">
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="dname" class="col-sm-3 col-form-label">Department Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" readonly id="dname" name="dname" value="<%=dto.getDeptDto().getName()%>">
		    </div>
		  </div>
		  
		  
		  <!-- page 넘길때 조정해서 알아서 넘기는 코드 -->
		  <input type="hidden" name="page" value="<%=cPage %>"/>
		  
		</form>
		<div class="text-right">			
			<button type="button" id="prevPage" class="btn btn-outline-info">Go Back</button>
			<button type="button" id="updateEmp" class="btn btn-outline-success">Update</button>
			<button type="button" id="deleteEmp" class="btn btn-outline-danger">Delete</button>
			
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
<%@ include file ="../inc/footer.jsp" %>


<script>
	$(function() {
		//$("#no").focus();
		$("#updateEmp").click(function() {
			// 자바스크립트 유효성검사 필요없음
			// 자바 스크립트 유효성 검사
			if($("#no").val().length==0) {
				alert("Input Employer Number");
				$("#no").focus();
				return;
			}
			if($("#name").val().length==0) {
				alert("Input Name");
				$("#name").focus();
				return;
			}
			if($("#job").val().length==0) {
				alert("Input Job");
				$("#job").focus();
				return;
			}
			if($("#sal").val().length==0) {
				alert("Input Salary ");
				$("#sal").focus();
				return;
			}
			if($("#deptno").val().length==0) {
				alert("Input Department Number");
				$("#deptno").focus();
				return;
			}
			
			f.action = "update.jsp?cNo=<%=cNo%>";
			f.submit();
		});
		
		$("#deleteEmp").click(function() {
			// 자바 스크립트 유효성 검사  필요없음
			
			f.action = "delete.jsp?cNo=<%=cNo%>";
			f.submit();
		});
		
		$("#prevPage").click(function() {
			history.back(-1);
		});
		
		
	});
</script>

