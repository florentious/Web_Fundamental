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
	
	if(memberDto != null) {
		response.sendRedirect("/index.jsp");
		return;
	}

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="list.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Member</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
		<h3><strong>Sign up Member</strong></h3><br>
		
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
		      <input type="text" class="form-control " id="name" name="name">
		      <div id="nameMessage"></div>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="email" class="col-sm-3 col-form-label">E-mail</label>
		    <div class="col-sm-9">
		      <input type="email" class="form-control" id="email" name="email">
		      <div id="emailMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="password" class="col-sm-3 col-form-label">Password</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="password" name="password">
		      <div id="passwordMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="rePassword" class="col-sm-3 col-form-label">Password Confirm</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="rePassword" name="rePassword">
		      <div id="rePasswordMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="phone" class="col-sm-3 col-form-label">Phone</label>
		    <div class="col-sm-9">
		      <input type="tel" class="form-control" id="phone" name="phone">
		      <div id="phoneMessage"></div>
		    </div>
		  </div>
		  
		  <input type="hidden" name="checkEmail" id="checkEmail" value="no"/>
		  
		</form>
		<div class="text-right">
			<a href="list.jsp?page=<%=cPage %>" class="btn btn-outline-info">Goto List</a>
			
			<button type="button" id="saveMember" class="btn btn-outline-success">Sign Up</button>
			
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function() {
		$("#name").focus();
		$("#saveMember").click(function() {
			// 자바 스크립트 유효성 검사
			if($("#name").val().length==0) {
				$("#name").addClass("is-invalid");
				$("#nameMessage").html("<span class='text-danger'>Input Name</span>");
				$("#name").focus();
				return;
			}
			
			let regEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			
			if($("#email").val().length==0) {
				$("#email").addClass("is-invalid");
				$("#emailMessage").html("<span class='text-danger'>Input E-mail</span>");
				$("#email").focus();
				return;
			}
			
			if(regEmail.test($("#email").val()) == false) {
				$("#email").addClass("is-invalid");
				$("#emailMessage").html("<span class='text-danger'>Input Correct E-mail Type</span>");
				$("#email").focus();
				return;
			}
			
			
			if($("#password").val().length==0) {
				$("#password").addClass("is-invalid");
				$("#passwordMessage").html("<span class='text-danger'>Input Password</span>");
				$("#password").focus();
				return;
			}			
			if($("#rePassword").val().length==0) {
				$("#rePassword").addClass("is-invalid");
				$("#rePasswordMessage").html("<span class='text-danger'>Input Password Confirm</span>");
				$("#rePassword").focus();
				return;
			}
			
			
			if($("#password").val() != $("#rePassword").val()) {
				$("#rePassword").addClass("is-invalid");
				$("#rePasswordMessage").html("<span class='text-danger'>Input Same Password</span>");
				$("#rePassword").val('');
				$("#rePassword").focus();
				return;
			}
			
			
			if($("#phone").val().length==0) {
				$("#phone").addClass("is-invalid");
				$("#phoneMessage").html("<span class='text-danger'>Input Phone</span>");
				$("#phone").focus();
				return;
			}
			
			
			if($("#checkEmail").val() == "no") {
				return;
			}
			
			f.action ="save.jsp";
			f.submit();
		});
		
		
		$("#name").keyup(function() {
			$("#name").removeClass("is-invalid");
			$("#nameMessage").html('');
		});
		$("#email").keyup(function() {
			$("#email").removeClass("is-invalid");
			$("#emailMessage").html('');
			
			//primary key 이기 때문에 확인
			let regEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			if(regEmail.test($("#email").val())) {
				$.ajax({
					type : "GET",
					url : 'check_email_ajax.jsp?email='+ $("#email").val(),
					dataType : 'json',
					error : function(){
						
					},
					
					success : function(json) {
						//json => {"result" : "ok or fail"}
						
						// success insert db data->ok
						if(json.result == "ok") {
							$("#emailMessage").html("<span class='text-success'>Can use E-mail</span>");
							$("#checkEmail").val("yes");
						} else {
							$("#email").addClass("is-invalid");
							$("#emailMessage").html("<span class='text-danger'>Duplicate E-mail already, Re-Input Another one</span>");
							$("#checkEmail").val("no");
						}
					}
					
				});
			}
			
		});
		$("#password").keyup(function() {
			$("#password").removeClass("is-invalid");
			$("#passwordMessage").html('');
		});
		$("#rePassword").keyup(function() {
			$("#rePassword").removeClass("is-invalid");
			$("#rePasswordMessage").html('');
			/* 
			// 즉시 비밀번호 확인하는 코드
			if($("#password").val() != $(rePassword).val()) {
				$("#rePassword").addClass("is-invalid");
				$("#rePasswordMessage").html("<span class='text-danger'>Input Same Password and Password Confirm</span>");
			} else {
				$("#rePassword").removeClass("is-invalid");
				$("#rePasswordMessage").html('');
			}
			 */
		});
		$("#phone").keyup(function() {
			$("#phone").removeClass("is-invalid");
			$("#phoneMessage").html('');
		});
		
		
		
		
	});
</script>
