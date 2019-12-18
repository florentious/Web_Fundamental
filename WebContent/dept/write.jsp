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
		<h3><strong>Insert Department</strong></h3><br>
		
		<form name="f" method="post" action="save.jsp">
		  <div class="form-group row">
		    <label for="no" class="col-sm-3 col-form-label">Department Number</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="no" name="no">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="name" class="col-sm-3 col-form-label">Department Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="name" name="name">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="loc" class="col-sm-3 col-form-label">Department Location</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="loc" name="loc">
		    </div>
		  </div>
		  
		</form>
		<div class="text-right">
			<a href="list.jsp" class="btn btn-outline-info">Goto List</a>
			<button type="button" id="saveDept" class="btn btn-outline-success">Sign Up</button>
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function() {
		$("#no").focus();
		$("#saveDept").click(function() {
			// 자바 스크립트 유효성 검사
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
			
			f.submit();
		});
	});
</script>
