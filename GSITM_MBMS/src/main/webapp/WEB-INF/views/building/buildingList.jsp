<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript"
	src="../../../resources/dist/js/postSearch.js"></script>
<style>
	@media (max-width: 768px) { 
		.mobileDisabled{display:none;}
		.bt_col { width: 20%; }
	}
</style>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>근무지 리스트</h1>
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
						<h3 class="box-title">근무지 목록</h3>
						<div class="pull-right box-tools">
	                 		<input type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#modal-default_buildInsert"
										value="근무지등록하기" />
	                	</div>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<table id="buildingListTable"
							class="table table-bordered table-hover">
							<thead>
								<tr>
									<th class="mobileDisabled">건물번호</th>
									<th>건물이름</th>
									<th>주소</th>
									<th class="mobileDisabled">우편번호</th>
									<th class="bt_col">비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="building">
									<tr>
										<td class="mobileDisabled">${building.buildNo }</td>
										<td>${building.buildName }</td>
										<td>${building.buildAddr }</td>
										<td class="mobileDisabled">${building.buildPost }</td>
										<td class="bt_col">
											<button type="button" class="btn btn-default btn-sm"
												data-toggle="modal"
												data-target="#modal-info_${building.buildNo }">
												회의실정보</button> 
												<input type="button" class="btn btn-default btn-sm"
											data-toggle="modal" data-target="#modal-warning_${building.buildNo}" value="수정하기">

											<input type="button" class="btn btn-default btn-sm"
											data-toggle="modal"
											data-target="#modal-danger_${building.buildNo}" value="삭제하기">


											<div class="modal modal-default fade"
												id="modal-danger_${building.buildNo}">
												<!-- 삭제 modal div -->
												<!-- Modal Div -->
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal"
																aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
															<h4 class="modal-title">근무지 삭제하기</h4>
														</div>
														<div class="modal-body">
															<p>${building.buildName }을(를) 정말로 삭제하시겠습니까?</p>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-default"
																data-dismiss="modal">취소</button>
															<button type="button" class="btn btn-danger"
																onclick="location.href='/building/buildingDelete?buildNo=${building.buildNo}'">삭제하기</button>
														</div>
													</div>
													<!-- /.modal-content -->
												</div>
												<!-- /.modal-dialog -->
											</div> <!-- /.modal -->
										</td>
									</tr>

									<div class="modal modal-default fade"
										id="modal-info_${building.buildNo }">
										<!-- 건물 상세보기 modal div -->
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title">${building.buildName }회의실내역</h4>
												</div>
												<div class="modal-body">
													
														<ul>
														<c:forEach items="${building.rooms }" var="room">
															<c:if test="${room.roomName==null }">
																[ ${building.buildName } ] 지사에 존재하는 회의실이 없습니다.
															</c:if>
															<c:if test="${room.roomName!=null }">
																<li>[ ${room.roomName } ] 회의실</li>
															</c:if>
														</c:forEach>
														</ul>
													
													
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default"
														data-dismiss="modal">닫기</button>

												</div>
											</div>
											<!-- /.modal-content -->
										</div>
										<!-- /.modal-dialog -->
									</div>
									<!-- /.modal -->
									
									<div class="modal modal-default fade"
										id="modal-warning_${building.buildNo}">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title">근무지 수정하기</h4>
												</div>
												<div class="modal-body">
													<form role="form" action="/building/buildingUpdate"
														method="post">
														<!-- text input -->
														<div class="form-group">
															<input type="hidden" name="buildNo"
																value="${building.buildNo }"> <label>근무지이름</label>
															<input type="text" class="form-control" name="buildName" 
																value="${building.buildName }" placeholder="${building.buildName }" required>
														</div>

														<label>우편 번호</label>
														<div class="row">
															<div class="col-xs-3">
																<input type="text" class="form-control" name="buildPost"
																	placeholder="${building.buildPost }"
																	onclick="execPostCode();" required
																	value="${building.buildPost }">
															</div>
															<div class="col-xs-4">
																<input type="button" class="btn btn-default"
																	value="검색하기" onclick="execPostCode();">
															</div>
														</div>

														<div class="form-group">
															<label>근무지 주소</label>
															<div class="row">
																<div class="col-xs-7">
																	<input type="text" class="form-control"
																		name="buildAddr" required placeholder="${building.buildAddr }"
																		onclick="execPostCode();"
																		value="${building.buildAddr }">
																</div>
															</div>
														</div>

														<div class="form-group" align=center>
															<button type="button" class="btn btn-default"
															data-dismiss="modal">닫기</button>
															 <input type="reset"
																class='btn btn-danger' value="다시쓰기"> <input
																type="submit" class='btn btn-success' value="완료">

														</div>
													</form>
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
		$('#example1').DataTable()
		$('#buildingListTable').DataTable({
			'paging' : true,
			'lengthChange' : true,
			'searching' : true,
			'ordering' : true,
			'info' : true,
			'autoWidth' : false
		})
		$("input[name='buildName']").on("click",function(){
			//alert($("#buildName").val())
			$("input[name='buildName']").val("");
		})
		$('.modal').on('hidden.bs.modal', function (e) { 
		    $(this).find('form')[0].reset() 
		});
	})
</script>