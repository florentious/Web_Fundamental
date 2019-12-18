<%@ page pageEncoding="utf-8"%>

<%@ include file="../inc/header.jsp"%>

<!-- breadcrumb start -->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>
		<li class="breadcrumb-item active" aria-current="page">Library</li>
	</ol>
</nav>

<!-- breadcrumb end -->

<!-- main start -->

<div class="container">
	<div class="row">
		<div class="col-lg-12">

			<%-- input content --%>
			<strong>home</strong>

			<div class="alert alert-info" role="alert">
				A simple info alert—check it out!
			</div>

			<div class="alert alert-primary" role="alert">
			 	A simple primary alert—check it out!
			</div>

			<ul class="list-group">
			  <li class="list-group-item disabled" aria-disabled="true">Cras justo odio</li>
			  <li class="list-group-item">Dapibus ac facilisis in</li>
			  <li class="list-group-item">Morbi leo risus</li>
			  <li class="list-group-item">Porta ac consectetur ac</li>
			  <li class="list-group-item">Vestibulum at eros</li>
			</ul>
		


		</div>
	</div>
</div>

<!-- main end -->


<%@ include file="../inc/footer.jsp"%>
