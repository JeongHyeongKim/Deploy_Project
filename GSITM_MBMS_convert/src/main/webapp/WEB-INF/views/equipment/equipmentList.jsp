<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.form-group{
		display: inline-block;
   		width: 100%;
	}
	@media (max-width: 768px) { 
		.mobileDisabled{display:none;}
		.bt_col { width: 20%; }
	}
</style>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>비품 리스트</h1>
		<ol class="breadcrumb">
			<li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Notice</li>
		</ol>
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">비품 목록</h3>
						<div class="pull-right box-tools">
						<input type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#modal-default_eqInsert"
										value="비품등록하기" />
							</div>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<div class="row">
							<div class="col-sm-3">
								<label for="buildingSelect">지사</label> <select
									name="buildingSelect" id="buildingSelect" class="form-control"  onchange="selectBuilding(this.options[this.selectedIndex].value)">
									<option value="">전체</option>
									<c:forEach var="building" items="${buildings }">
									<c:if test="${room.roomNo!=0 }">
										<option value="${building.buildName }">${building.buildName }</option>
									</c:if>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-3">
							<label for="buildingSelect">회의실</label> 
								<select name="roomSelect" id="roomSelect" class="form-control">
								<option value="">전체</option>
										<c:forEach var="building" items="${buildings }" varStatus="status">
												<c:forEach var="room" items="${building.rooms }">
														<option class="building${building.buildName }" value="${room.roomName }">${room.roomName }</option>
												</c:forEach>
										</c:forEach>
									</select>
							</div>
							<div class="col-sm-6"></div>
						</div>
						<table id="equipmentListTable"
							class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>비품이름</th>
									<th>갯수</th>
									<th>회의실이름</th>
									<th class="mobileDisabled">지사이름</th>
									<th class="bt_col">비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="equipment">
									<tr>
										<td>${equipment.EQNAME }</td>
										<td>${equipment.EQCOUNT }</td>
										<td>${equipment.ROOMNAME }</td>
										<td class="mobileDisabled">${equipment.BUILDNAME }</td>
										
										<td class="bt_col"><input type="button" class="btn btn-default btn-sm"
											data-toggle="modal"
											data-target="#modal-warning_${equipment.EQNO}" value="수정하기">

											<input type="button" class="btn btn-default btn-sm"
											data-toggle="modal"
											data-target="#modal-danger_${equipment.EQNO}" value="삭제하기">


											<div class="modal modal-default fade"
												id="modal-danger_${equipment.EQNO}">
												<!-- 삭제 modal div -->
												<!-- Modal Div -->
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal"
																aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
															<h4 class="modal-title">비품삭제하기</h4>
														</div>
														<div class="modal-body">
															<p> [${equipment.EQNAME }] 을 정말로 삭제하시겠습니까? 
																<br> ${equipment.BUILDNAME }의  ${equipment.ROOMNAME } 회의실에 비치된 ${equipment.EQCOUNT }개의 ${equipment.EQNAME } 입니다.</p>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-default"
																data-dismiss="modal">취소</button>
															<button type="button" class="btn btn-danger"
																onclick="location.href='/equipment/equipmentDelete?eqNo=${equipment.EQNO}'">삭제하기</button>
														</div>
													</div>
													<!-- /.modal-content -->
												</div>
												<!-- /.modal-dialog -->
											</div> <!-- /.modal --></td>
									</tr>

									<div class="modal modal-default fade"
										id="modal-warning_${equipment.EQNO}">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title">비품 수정하기</h4>
												</div>
												<div class="modal-body">
													<form role="form" action="/equipment/equipmentUpdate"
														method="post">
														<input type="hidden" name="eqNo" value="${equipment.EQNO }"> 
														<!-- text input -->
														
															<div class="col-xs-6">
																<label>비품이름</label> 
																	<input type="text" class="form-control eqeq" name="eqName"
																	 required placeholder="${equipment.EQNAME }"
																	 value="${equipment.EQNAME }">
															</div>
														
															<div class="col-xs-6">
																<label>비품 갯수</label>
																	<input type="number" class="form-control eqeq" name="eqCount" 
																	 required placeholder="${equipment.EQCOUNT }"
																	 value="${equipment.EQCOUNT }">
															</div>

														<div class="form-group" align=center>
															<input type="button" class='btn btn-default' value="닫기"
																data-dismiss="modal"> <input type="reset"
																class='btn btn-danger' value="다시쓰기"> <input
																type="submit" class='btn btn-success' value="완료">
														</div>
													</form>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-outline pull-left"
														data-dismiss="modal">Close</button>
													<button type="button" class="btn btn-outline">Save
														changes</button>
												</div>
											</div>
											<!-- /.modal-content -->
										</div>
										<!-- /.modal-dialog -->
									</div>
									<!-- /.modal -->
								</c:forEach>
								
							</tbody>
							
						</table>
						<jsp:include page="../modal/Modal.jsp"></jsp:include>
						
						<div class="modal fade" id="modal-default_eqInsert">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">비품 등록하기</h4>
									</div>
									<div class="modal-body">
										<form role="form" action="/equipment/equipmentInsert"
											method="post">
										<!-- text input -->

										<div class="row">
											<div class="col-xs-6">
												<label>비품이름</label>
											</div>
											<div class="col-xs-6">
												<label>비품갯수</label>
											</div>
											<div class="col-xs-6">
												<input type="text" class="form-control" name="eqName" required>
											</div>

											<div class="col-xs-6">
												<input type="number" class="form-control" name="eqCount" required>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-3">
											</div>
											<div class="col-xs-6">
											<label>회의실 목록</label>
											<c:forEach var="building" items="${buildings }" varStatus="status">
													<br><label>${building.buildName }</label><br>													
												<c:forEach var="room" items="${building.rooms }">
													<c:if test="${room.roomNo!=0 }">
														<input type="checkbox" class="building${building.buildNo }" value="${room.roomNo }" name="roomList" id="${room.roomNo }">
														<label for="${room.roomNo	}" }>${room.roomName }</label>
													</c:if>	
												</c:forEach>
										</c:forEach>
											</div>
										</div>

										<div class="form-group"></div>
									</div>

									<div class="form-group" align=center>
									<input type="button" class='btn btn-default' value="닫기"
											data-dismiss="modal">
											<input type="reset" class='btn btn-danger' value="다시쓰기">
										<input type="submit" class='btn btn-success' value="완료">
										
										
									</div>
									</form>
									<div class="modal-footer">
									
									</div>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->

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
	$(document).ready(function() {
	
		$('#equipmentListTable').DataTable({
			'paging' : true,
			'lengthChange' : false,
			'searching' : true,
			'ordering' : true,
			'info' : true,
			'autoWidth' : true
		})
	

		$(".eqeq").click(function() {
			$(this).val("");
			
		})
	})
	$(document).on(
			'change',
			'#buildingSelect, #roomSelect',
			function() {
				$("input[type='search']").val(
						$("#buildingSelect").val() + " "
								+ $("#roomSelect").val());
				$("input[type='search']").trigger('keyup');
			});

	function selectBuilding(buildNo) {
		$('#roomSelect option').hide();
		$('#roomSelect').find('.building' + buildNo).show();
		$('#roomSelect').val(
				$('#roomSelect').find('.building' + buildNo).first().val());
		$('#roomSelect').trigger('change');
	}
</script>