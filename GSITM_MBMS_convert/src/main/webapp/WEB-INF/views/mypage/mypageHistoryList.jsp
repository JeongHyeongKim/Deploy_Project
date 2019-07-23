<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        예약 이력
        <small>지금까지의 예약 이력입니다.</small>
      </h1>
		<ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">My Page</a></li>
        <li class="active">예약이력</li>
      	</ol> 
    </section>

	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-md-3">
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">조건 검색</h3>
						<br>
					</div>
					<form id="availableHistoryList" method="get" action="/mypage/mypageHistoryDetail">
					<div class="box-body">
						<!-- Date and time range -->
						<div class="form-group">
							<label>예약 날짜</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-clock-o"></i>
								</div>
								<input type="text" class="form-control pull-right" id="reservationtime" name="timeSelect">
							</div>
							<!-- /.input group -->
						</div> 
			            <br><input type="submit" class="btn  btn-info col-sm-12" id="availableRoomSearchBtn" value="검색">
					</div><br>
					</form>
					<!-- /.box-body -->
				</div>
				<!-- /.box -->
			</div>
			<!-- /.col(left:col-md-3) -->
	<div class="col-md-9">
	<div class="box box-primary">
	<!-- /.content-wrapper -->	
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
					<!-- /.box-header -->
					<div class="box-body">
					<input type="button" onClick="location.href='/mypage/mypageHistoryList'"
							class="btn btn-primary" value="검색 초기화" style="float: right;" />
						<table id="example1" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th class = "">예약일</th>
									<th class = "">회의 구분</th>
									<th class = "">회의명</th>
									<th class = "">비고</th>
									
								</tr>
							</thead>
			               <tbody>
							<c:forEach var="MypageDTO" items="${mypageHistoryList}">
								<tr>
									<td>${MypageDTO.startDate}</td>
									<td>${MypageDTO.category}</td>
									<td>${MypageDTO.title}</td>
									<td>
										<button type="button" class="btn btn-default btn-sm" onclick="location.href='/approval/approvalDetail/${MypageDTO.reserveNo}'"
							          	data-target="#modal-default_${MypageDTO.reserveNo}">상세 예약 정보</button>
									
										<div class="modal fade" id="modal-default_${MypageDTO.reserveNo}">
														<!-- 예약 상세보기 modal div -->
													<div class="modal-dialog">
														<div class="modal-content">
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal"
																	aria-label="Close">
																	<span aria-hidden="true">&times;</span>
																</button>
					
																<h4 class="modal-title">상세 예약내역</h4>
															</div>
													<div class="modal-body">
														<p><strong>예약 신청 내역</strong></p>
														<p>예약 신청일 : ${MypageDTO.reserveDate}</p>
														<p>회의 일정 : <fmt:formatDate value="${MypageDTO.startDate }" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${MypageDTO.endDate }" pattern="yyyy-MM-dd HH:mm"/>
														<p>회의 장소 : ${MypageDTO.buildName} ${MypageDTO.roomName}</p>
														<p>회의명 및 목적 : ${MypageDTO.title} / ${MypageDTO.purpose}</p>
														<p>참석자 : ${MypageDTO.empName} 외 ${MypageDTO.empCount-1}명</p>
														<p>간식 신청 여부 : ${MypageDTO.snackYn} </p>
														
														<br><p><strong>예약 승인 내역</strong></p>
															<p>1차 결재 : 
														        <c:if test="${MypageDTO.approval1Yn == 0 }">
																	<span>미승인</span>
																</c:if>
																<c:if test="${MypageDTO.approval1Yn == 1 }">
																	<span style = "color:blue">승인 완료</span> (${MypageDTO.approval1Date})
																</c:if>
																<c:if test="${MypageDTO.approval1Yn == 2 }">
																	<span>반려 (반려 사유 : ${MypageDTO.reason})</span>
																</c:if>
										        			</p>        
									        
													        <p>2차 결재 : 
															    <c:if test="${MypageDTO.approval2Yn == 0 }">
																	<span>미승인</span>
																</c:if>
																<c:if test="${MypageDTO.approval2Yn == 1 }">
																	<span style = "color:blue">승인 완료</span> (${MypageDTO.approval1Date})
																</c:if>
																<c:if test="${MypageDTO.approval2Yn == 2 }">
																	<span>반려 (반려 사유 : ${MypageDTO.reason})</span>
																</c:if>
															</p>
															
															<p>비용 결제 : 
														        <c:if test="${MypageDTO.paymentYn == 0 }">
																	<span>미결제</span>
																</c:if>
																<c:if test="${MypageDTO.paymentYn == 1 }">
																	<span>결제 완료</span>
																</c:if>
																(${MypageDTO.reservePrice} 원)
									        				</p>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-default pull-right"
															data-dismiss="modal">닫기</button>
													</div>
													</div>
												<!-- /.modal-content -->
												</div>
												<!-- /.modal-dialog -->
												</div>
									
									</td>
								</tr>
							</c:forEach>
							</tbody>			               		       
						</table>
					</div>
					<!-- /.box-body -->
				<!-- /.box -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</section>
	<!-- /.content -->
	<!-- /.content-wrapper -->
				</div>	
				<!-- /. box -->	
			</div>
			<!-- /.col(right:col-md-9) -->
			</div>
			</section>
		</div>
		<!-- /.row -->

<script>
	$(function() {
		/** DatePicker **/
		$('#reservationtime').daterangepicker({
			timePicker : false,
			format : 'YYYY/MM/DD',
			locale: {format : 'YYYY/MM/DD'},
	      	startDate: moment().add(0, 'year'),
	      	endDate: moment().add(0, 'year')     	
		})
	})
</script>

<script>
	$(function() {
		$('#example1').DataTable({
			'paging' : true,
			'lengthChange' : false,
			'searching' : false,
			'ordering' : true,
			'info' : true,
			'autoWidth' : false
		})
	})
</script>