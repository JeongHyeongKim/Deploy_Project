<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	@media (max-width: 768px) { 
		.mobileDisabled{display:none;}
	}
</style>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>결재 관리</h1>
		<ol class="breadcrumb">
			<li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">ApprovalList</li>
		</ol>
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">전체</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<div class="row">
							<div class="col-sm-3">
								<label for="roomTypeSelect">승인 여부</label>
								 <select name="approvalStatus" id="approvalStatus" class="form-control">
									<option value="">전체</option>
									<option value="1차 승인 대기">1차 승인 대기</option>
									<option value="2차 승인 대기">2차 승인 대기</option>
									<option value="승인 완료">승인 완료</option>
									<option value="반려">반려</option>
								</select>
							</div>
							<div class="col-sm-6"></div>
						</div>
						<table id="approvalTable" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th class="mobileDisabled">에약번호</th>
									<th class="mobileDisabled">회의구분</th>
									<th>회의내용</th>
									<th>장소</th>
									<th>시작일자</th>
									<th>종료일자</th>
									<th class="mobileDisabled">신청자</th>
									<th>승인현황</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${approvalList }" var="approval" varStatus="status">
									<tr role='row'>
										<td class="mobileDisabled">${approval.reserveNo }</td>
										<td class="mobileDisabled">${approval.category }</td>
										<td>${approval.purpose }</td>
										<td>${approval.roomDTO.buildingDTO.buildName } ${approval.roomDTO.roomFloor }층 ${approval.roomDTO.roomName }</td>
										<td>${approval.startDate }</td>
										<td>${approval.endDate }</td>
										<td class="mobileDisabled">${approval.employeeDTO.empName }</td>
										<td>
											<c:if test="${approval.approval1Yn == 0 }">1차 승인 대기</c:if>
											<c:if test="${approval.approval1Yn == 1 && approval.approval2Yn == 0 }">2차 승인 대기</c:if>
											<c:if test="${approval.approval1Yn == 1 && approval.approval2Yn == 1 }">승인 완료</c:if>
											<c:if test="${approval.approval1Yn == 2 || approval.approval2Yn == 2 }">반려</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
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
		var table;
		
		var tableOptions = {
			'paging' : true,
			'lengthChange' : false,
			'searching' : true,
			'ordering' : true,
			'info' : true,
			'autoWidth' : true,
			'order' : [ [ 0, "desc" ] ],
			"destroy": true,
			"pagingType" : "full_numbers"
		};
		
		table = $('#approvalTable').DataTable(tableOptions);
		$('#approvalTable tbody').on('click', 'tr', function () {
	        var rowData = table.row( this ).data();
			location.href='/approval/approvalDetail/'+rowData[0];
		})
		
		$('#approvalStatus').change(function(){
			$('input[type=search]').val($(this).val());
			$('input[type=search]').trigger('keyup');
		});
		
	})
</script>