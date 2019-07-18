<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<header class="main-header">
	<!-- Logo -->
	<a href="/" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
		<span class="logo-mini"><b>M</b>BMS</span> <!-- logo for regular state and mobile devices -->
		<span class="logo-lg"><b>MBMS</b></span>
	</a>
	<!-- Header Navbar: style can be found in header.less -->
	<nav class="navbar navbar-static-top">
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="push-menu"
			role="button"> <span class="sr-only">Toggle navigation</span> <span
			class="icon-bar"></span> <span class="icon-bar"></span> <span
			class="icon-bar"></span>
		</a>

		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- Messages: style can be found in dropdown.less-->
				<li class="dropdown messages-menu">
					<a href="#logoutModal" class="dropdown-toggle" data-toggle="modal" >
						<i class="fa fa-fw fa-sign-out"></i>  LOGOUT 
					</a>
				</li>
			</ul>
		</div>
	</nav>
</header>

<div class="modal fade" id="logoutModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">LOGOUT</h4>
			</div>
			<div class="modal-body">
				<p>정말 로그아웃 하시겠습니까?</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="logout-confirm-ok">확인</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script>
	$(function(){
		$('#logout-confirm-ok').click(function(){
			$.ajax({
				type : 'GET',
				url : '/logout',
				dataType : 'text',
				success : function(data){
					document.location.href = '/login'; 
				}
			});
		});
	});
</script>