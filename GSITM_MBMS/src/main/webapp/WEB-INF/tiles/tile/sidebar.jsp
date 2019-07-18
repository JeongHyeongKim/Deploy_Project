<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="/resources/dist/img/GSprofile.png"
					class="img-circle" alt="User Image">
			</div>
			<div class="pull-left info">
				<p>${login.empName} ${login.empPosition} </p>
				<a href="#"><i class="fa fa-circle text-success"></i>
					${login.empNo}
					<c:if test="${isAdmin}"> <span class="label label-danger"> 관리자</span></c:if>
					<c:if test="${isApprover}"><span class="label label-success"> 결재자</span></c:if>
				</a>
			</div>
		</div>

		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu" data-widget="tree">
			<!-- 사용자 -->
			<li class="header">EMPLOYEE</li>
			<!-- 공지사항 -->
			<li><a href="/notice/noticeList"><i class="fa fa-book"></i>
					<span>공지사항</span> <span class="pull-right-container"> 
					<!-- <span class="label label-primary pull-right">4</span> -->
				</span>
			</a></li>
			<!-- 회의실 -->
			<li class="treeview"><a href="#"> <i class="fa fa-calendar"></i>
					<span>회의실</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="/reserve/roomList"><i class="fa fa-circle-o"></i> 
							회의실 소개</a></li>
					<li><a href="/reserve/reserveSearchForm"><i class="fa fa-circle-o"></i>
							회의실 예약</a></li>
					<!--  
					<li><a href="/reserve/reserveForm"><i class="fa fa-circle-o"></i>
							회의실 예약</a></li>
					 -->
					 
				</ul></li>
			<!-- 마이페이지 -->
			<li class="treeview"><a href="#"> <i class="fa fa-user"></i>
					<span>마이페이지</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="/mypage/mypageStatusList"><i class="fa fa-circle-o"></i> 
							예약 현황</a></li>
					<li><a href="/mypage/mypageHistoryList"><i class="fa fa-circle-o"></i>
							예약 이력</a></li>
			</ul></li>
			
			<c:if test="${isApprover || isAdmin}"> 
				<!-- 상위결재자 -->
				<li class="header">APPROVER</li>
				<li><a href="/approval/approvalList"><i class="fa fa-circle-o text-red"></i> <span>결재 관리</span></a></li>
				
				
				<c:if test="${isAdmin}">
				<li><a href="/payment/paymentList"><i class="fa fa-circle-o text-yellow"></i> <span>관리자 비용 관리</span></a></li>
				</c:if>
				
				<c:if test="${isApprover}">
				<li><a href="/payment/approverPaymentList"><i class="fa fa-circle-o text-green"></i> <span>결재자 비용 관리</span></a></li>
				</c:if>
			</c:if>
			
			<c:if test="${isAdmin}">
				<!-- 관리자 -->
				<li class="header">MANAGER</li>
				<!-- 회의실 -->
				<li class="treeview"><a href="#"> <i class="fa fa-gears"></i>
						<span>회의실 관리</span> <span class="pull-right-container">
							<i class="fa fa-angle-left pull-right"></i>
					</span>
				</a>
					<ul class="treeview-menu">
						<li><a href="/building/buildingList"><i class="fa fa-circle-o"></i> 
								근무지 관리</a></li>
						<li><a href="/room/roomManageList"><i class="fa fa-circle-o"></i>
								회의실 관리</a></li>
						<!--
						<li><a href="/equipment/equipmentList"><i class="fa fa-circle-o"></i>
								비품 관리</a></li>
						-->
					</ul></li>
				<!-- 회의실 -->
				<li class="treeview"><a href="#"> <i class="fa fa-bar-chart"></i>
						<span>예약 관리</span> <span class="pull-right-container">
							<i class="fa fa-angle-left pull-right"></i>
					</span>
				</a>
					<ul class="treeview-menu">
						<li><a href="/stats/statsHistory"><i class="fa fa-circle-o"></i> 
								예약 현황 관리</a></li>
						<li><a href="/stats/statsFiltering"><i class="fa fa-circle-o"></i>
								예약 통계</a></li>
					</ul></li>
			</c:if>
				
		</ul>
		<!-- GSITM 로고 -->
		<div class="sidebar-logo">
			<div class="image">
				<img src="/resources/img/gsitm_logo.png"
					class="img-circle" alt="GSITM logo">
			</div>
		</div>
	</section>
	<!-- /.sidebar -->
</aside>

<script>
	$(function(){
		
		var treeviewmenu = $('a[href="'+location.pathname+'"]').parent().parent();
		var treeview = $('a[href="'+location.pathname+'"]').parent().parent().parent();
		$('.treeview').removeClass('menu-open');
		treeview.addClass('menu-open');
		treeviewmenu.css('display', 'block');
		$('a[href="'+location.pathname+'"]').parent().addClass('active');
		
	});
</script>