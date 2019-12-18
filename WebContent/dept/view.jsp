<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

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

   <%-- input content --%>
		<h3><strong>Department Infomation</strong></h3><br>
		
		<form name="f" method="post" >
		  <div class="form-group row">
		    <label for="no" class="col-sm-3 col-form-label">Department Number</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="no" name="no" value="10">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="name" class="col-sm-3 col-form-label">Department Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="name" name="name" value="Accounting">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="loc" class="col-sm-3 col-form-label">Department Location</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="loc" name="loc" value="New York">
		    </div>
		  </div>
		  
		</form>
		<div class="text-right">
			<a href="list.jsp" class="btn btn-outline-info">Goto List</a>
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
			
			f.action = "update.jsp";
			f.submit();
		});
		
		$("#deleteDept").click(function() {
			// 자바 스크립트 유효성 검사  필요없음
			
			f.action = "delete.jsp";
			f.submit();
		});
		
		
	});
</script>

