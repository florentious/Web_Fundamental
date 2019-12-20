<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	int cPage = 0;
	String tempPage = request.getParameter("page");
	
	if(tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}
	try {
		cPage = Integer.parseInt(tempPage);
	} catch(NumberFormatException e) {
		cPage = 1;
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
		<h3><strong>Insert Employer</strong></h3><br>
		
		<form name="f" method="post" >
		
		 <%--  <div class="form-group row">
		    <label for="no" class="col-sm-3 col-form-label">Employer Number</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="no" name="no">
		    </div>
		  </div> --%>
		  
		  <div class="form-group row">
		    <label for="name" class="col-sm-3 col-form-label">Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="name" name="name">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="job" class="col-sm-3 col-form-label">Job</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="job" name="job">
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="mgr" class="col-sm-3 col-form-label">Manager</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="mgr" name="mgr">
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="sal" class="col-sm-3 col-form-label">Salary</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="sal" name="sal">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="comm" class="col-sm-3 col-form-label">commission</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="comm" name="comm">
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="deptno" class="col-sm-3 col-form-label">Department Number</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="deptno" name="deptno">
		    </div>
		  </div>
		  
		  
		</form>
		<div class="text-right">
			<a href="list.jsp?page=<%=cPage %>" class="btn btn-outline-info">Goto List</a>
			<button type="button" id="saveEmp" class="btn btn-outline-success">Sign Up</button>
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function() {
		$("#no").focus();
		$("#saveEmp").click(function() {
			// 자바 스크립트 유효성 검사
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
			
			f.action ="save.jsp?page=<%=cPage%>";
			
			f.submit();
		});
	});
</script>
