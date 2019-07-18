<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<style>
	.box-header{margin-bottom: 0px;}
	#example1{margin-bottom: 0px;}
	
	@media (max-width: 768px) { 
		.mobileDisabled{display:none;}
	}
	.participation-list > li > a:hover {background-color: white;}
	
	th {background-color: #f9f9f9}
</style>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
   <!-- Content Header (Page header) -->
   <section class="content-header">
      <h1>회의실 예약 
      <c:if test="${isAdmin || isApprover}">결재</c:if>
      <c:if test="${!isAdmin && !isApprover}">확인</c:if>
      </h1>
      <ol class="breadcrumb">
         <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
         <li><a href="#">DEPARTMENT HEAD</a></li>
         <li class="active">결재 관리</li>
      </ol>
   </section>

   <!-- Main content -->
   <section class="content">
      <div class="row">
         <div class="col-md-10 col-md-offset-1 col-xs-12">
            <div class="box">
               <div class="box-header">
                  <div class="col-md-6 col-md-offset-6 col-xs-12">
                     <table id="example1" class="table table-bordered text-center">
                        <thead>
                           <tr>
                              <th width="30%">기안</th>
                              <th width="30%">1차 결재</th>
                              <th width="30%">2차 결재</th>
                           </tr>
                        </thead>
                        <tbody>
                           <tr>
                              <td>
                              	${approvalDTO.employeeDTO.empName }<br>
                              	<fmt:formatDate value="${approvalDTO.reserveDate }" pattern="yyyy-MM-dd"/>
                              </td>
                              <td>
                              	${approval1Emp.empName }<br>
                              	<c:choose>
									<c:when test = "${approvalDTO.approval1Yn eq 0}">
										-
									</c:when>
									<c:when test = "${approvalDTO.approval1Yn eq 1}">
										<fmt:formatDate value="${approvalDTO.approval1Date }" pattern="yyyy-MM-dd"/>
									</c:when>
									<c:when test = "${approvalDTO.approval1Yn eq 2}">
										반려
									</c:when>
								</c:choose>
                              </td>
                              <td>
                              	${approval2Emp.empName }<br>
                              	<c:choose>
									<c:when test = "${approvalDTO.approval2Yn eq 0}">
										-
									</c:when>
									<c:when test = "${approvalDTO.approval2Yn eq 1}">
										<fmt:formatDate value="${approvalDTO.approval2Date }" pattern="yyyy-MM-dd"/>
									</c:when>
									<c:when test = "${approvalDTO.approval2Yn eq 2}">
										반려
									</c:when>
								</c:choose>
                              </td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
               <!-- /.box-header -->
               <div class="row">
                  <div class="box-body">
                  	<div class="col-lg-12 col-xs-12">
                     <table id="approvalDetailTable" class="table table-bordered text-center">
                        <tr>
                           <th>회의실명</th>
                           <td>${approvalDTO.roomDTO.buildingDTO.buildName } ${approvalDTO.roomDTO.roomFloor }층 ${approvalDTO.roomDTO.roomName }</td>
                        </tr>
                        <tr>
                           <th>회의 구분</th>
                           <td>${approvalDTO.category }</td>
                        </tr>
                        <tr>
                           <th>회의 내용</th>
                           <td>${approvalDTO.purpose }</td>

                        </tr>
                        <tr>
                           <th>이용 시간</th>
							<td><fmt:formatDate value="${approvalDTO.startDate }" pattern="yyyy-MM-dd"/> ~
								<fmt:formatDate value="${approvalDTO.endDate }" pattern="yyyy-MM-dd"/> 
							</td>
                        </tr>
 
 				<!--  참석 인원 삭제  -->
 				
                        <tr>
                           <th>사용 목적</th>
                           <td>${approvalDTO.purpose}</td>
                        </tr>

 				<!--  비품 목록 삭제  -->

                        <tr>
                           <th>다과 준비 여부</th>
                           <td>
                           		<c:choose>
									<c:when test="${approvalDTO.snackYn eq Y }">
										신청
									</c:when>
									<c:otherwise>
										미신청
									</c:otherwise>
                           		</c:choose>
							</td>
                        </tr>
                        <tr>
                        	<th>총 비용</th>
                        	<td><fmt:formatNumber value="${approvalDTO.reservePrice }" pattern="#,### 원"></fmt:formatNumber></td>
                        </tr>

                     </table>
					<!-- 버튼 부분 -->
					<div class="text-center button-panel">
						<c:if test="${(approvalDTO.approval1Yn == 0 && approvalDTO.approval1EmpNo == login.empNo) || (approvalDTO.approval1Yn == 1 && approvalDTO.approval2Yn == 0 && approvalDTO.approval2EmpNo == login.empNo) }">
							<button type="button" data-toggle="modal" data-target="#approval-modal" class="btn btn-primary">승인</button>
							<button type="button" data-toggle="modal" data-target="#refuse-modal" class="btn btn-danger">반려</button>
						</c:if>
						<c:if test="${isAdmin || isApprover}">
							<a type="button" class="btn btn-default" href="/approval/approvalList">
								목록
							</a>
						</c:if>
						<c:if test="${!(isAdmin || isApprover)}">
							<a type="button" class="btn btn-default" href="/mypage/mypageStatusList">
								확인
							</a>
						</c:if>
					</div>
                    </div>
                  </div>
	               <br>
               </div>
            </div>
            <!-- /.box-body -->
         </div>
         <!-- /.box -->
      </div>
      <!-- /.col -->
      <!-- /.row -->
   </section>
   <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!-- modal -->
<div class="modal fade" id="approval-modal">
	<div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">예약 승인</h4>
              </div>
              <form id="refuseForm">
	              <div class="modal-body">
	                예약을 승인하시겠습니까?
	              </div>
	              <div class="modal-footer">
	                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-primary" id="approvalBtn">승인</button>
	              </div>
              </form>
            </div>
            <!-- /.modal-content -->
          </div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- modal -->
<div class="modal fade" id="refuse-modal">
	<div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">예약 반려</h4>
              </div>
              <form id="refuseForm">
	              <div class="modal-body">
	                <textarea rows="5" id="reason" name="reason" class="form-control" placeholder="반려 사유를 작성하세요. 해당 사유는 신청자에게 메일로 전송됩니다." style="resize: none"></textarea>
	              </div>
	              <div class="modal-footer">
	                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-primary" id="refuseBtn">반려</button>
	              </div>
              </form>
            </div>
            <!-- /.modal-content -->
          </div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script>

	/* 모달 사라졌을 때 입력 값 초기화 */
	$('#refuse-modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset();
	});
	
	$(function(){
		$('#approvalBtn').on('click', function(){
			$('#approval-modal').modal('hide');
			$.ajax({
                url : "/approval/approval",
                type : "POST",
                dataType: "json",
                data : {
                   reserveNo : '${approvalDTO.reserveNo}',
                   colName : '${approvalDTO.approval1Yn}'=='0' ? 'approval1' : 'approval2'
                }, success : function(data) {
                	swal("회의실 예약 요청이 승인되었습니다.").then((result) => {
                		location.href='/approval/approvalDetail/${approvalDTO.reserveNo}';
	        		});
                }
             });
		});
		
		$('#refuseBtn').on('click', function(){
			$('#refuse-modal').modal('hide');
			$.ajax({
                url : "/approval/refuse",
                type : "POST",
                dataType: "json",
                data : {
                   reserveNo : '${approvalDTO.reserveNo}',
                   reason : $("#reason").val(),
                   colName : '${approvalDTO.approval1Yn}'=='0' ? 'approval1' : 'approval2'
                }, success : function(data) {
                	swal("회의실 예약 요청이 반려되었습니다.").then((result) => {
	                   location.href='/approval/approvalDetail/${approvalDTO.reserveNo}';
	        		});
                }
             });
		});
	})
</script>