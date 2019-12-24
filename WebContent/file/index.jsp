<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>



  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">File Upload</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
		<h3><strong>File Upload</strong></h3><br>
		
		<%-- 파일 업로드할떄 form 엘리먼트에 enctype속성을 만드시 추가해야한다.  --%>
		<%-- enctype="multipart/form-data" 들어가면 request.getParameter로 받을수가없음 --%>
		<form name="f" method="post" enctype="multipart/form-data" action="upload.jsp">
		  
		  <div class="form-group row">
		    <label for="name" class="col-sm-3 col-form-label">File Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="name" name="name" placeholder ="Input File Name">
		    </div>
		  </div>
		  
		  <div class="form-group col-sm-12">
		  	<input type="file" class="form-control" id="file" name="file"/>
		  
		  </div>
		  
		  <%-- 
		  <div class="custom-file col-sm-12">
		    <input type="file" class="custom-file-input" id="validatedCustomFile" required>
		    <label class="custom-file-label" for="validatedCustomFile">Choose file...</label>
		    <div class="invalid-feedback">Example invalid custom file feedback</div>
		  </div>
		   --%>
		  
		</form>
		<div class="text-right">
			
			<%if(memberDto != null) { %>
			<button type="button" id="uploadFile" class="btn btn-outline-success" style="margin-top : 1em">Upload</button>
			<%} %>
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function() {
		$("#uploadFile").click(function(){
			f.submit();
		});
	});
</script>
