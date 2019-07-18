<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	/* .notice_col1 { width: 10%; }
	.notice_col2 { width: 10%; }
	.notice_col3 { width: 10%; } 
	.notice_col4 { width: 50%; } 
	.notice_col5 { width: 10%; } */

	@media (max-width: 768px) { 
		.mobileDisabled{
			display:none;
		}
	}
</style>

<!-- 아래 테이블 내림차순 정렬하는 자바스크립트 -->
<script type="text/javascript">
	$(document).ready(function() {
		
	    $('#example1').DataTable( {
	        "order": [[ 0, "desc" ]]
	    	
	    } );
	   
	    
	} );
</script>






<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			공지사항
		</h1>
		<ol class="breadcrumb">
			<li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Notice</li>
		</ol>
	</section>










	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box box-primary">
					
					<div class="box-header">
						<h3 class="box-title">MBMS 공지사항</h3>
						<div class="pull-right box-tools">
						
						<!-- 운영자만 공지작성버튼 보이게 -->
						<c:choose>
							<c:when test="${isAdmin}">
							 	<form action="noticeInsertForm" method="post">
									<button type="submit" class="btn btn-primary">
			                 		 	<i class="fa fa-plus"></i>　공지 작성
			                 		</button>
	                 			</form>
							</c:when>
							<c:otherwise> 
								<form action="noticeList" method="get">
									<button type="submit" class="btn btn-primary" disabled>
			                 		 	<i class="fa fa-plus"></i>　작성하려면 운영자로 로그인하세요
			                 		</button>
	                 			</form>
							</c:otherwise>
						</c:choose>
							
	                 		
	                 		
	                 		
	                 		
	                	</div>
					</div>
					
					
	                
					<!-- /.box-header -->
					<div class="box-body">
						
						<table id="example1" class="table table-bordered table-striped">
							<thead>
							
								<tr>
									<th class = "notice_col1 mobileDisabled">번호</th>
									<th class = "notice_col2 mobileDisabled">사번</th>
									<th class = "notice_col3">작성자</th>
									<th class = "notice_col4">제목</th>
									<th class = "notice_col5">작성일</th>
								</tr>
							</thead>
							<tbody>
	
								<c:forEach var="noticeDTO" items="${noticeList}">
									<tr>
										
										
											<td class="mobileDisabled">${noticeDTO.noticeNo}</td>
											<td class="mobileDisabled">${noticeDTO.writerEmpNo}</td>
											<td>${noticeDTO.writerEmpName} ${noticeDTO.writerEmpPosition}</td>
											<td><a href='noticeDetail?noticeNo=${noticeDTO.noticeNo}'>${noticeDTO.noticeSubject}</a></td>
											<td>${noticeDTO.noticeDate}</td>
										
										
									</tr>
								</c:forEach>
								
								
								
								
							</tbody>
							<!-- <tfoot>
								<tr>
									<th>글번호</th>
									<th>작성자</th>
									<th>제목</th>
									<th>첨부</th>
									<th>작성일</th>
								</tr>
							</tfoot> -->
						</table>
					</div>
					<!-- /.box-body -->
				</div>
				<!-- /.box -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!-- page script -->
<script>
	$(function() {
		$('#example1').DataTable() 
		$('#example2').DataTable({
			'paging' : true,
			'lengthChange' : false,
			'searching' : false,
			'ordering' : true,
			'info' : true,
			'autoWidth' : false
		})
	})
</script>