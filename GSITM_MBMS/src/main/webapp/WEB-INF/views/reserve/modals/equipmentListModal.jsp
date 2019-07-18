<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	table#equipmentListTable th {text-align: center;}
</style>
<div class="modal fade" id="equipmentList-modal">
	<div class="modal-dialog">
	  <div class="modal-content">
	    <div class="modal-header">
	      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	        <span aria-hidden="true">&times;</span></button>
	      <h4 class="modal-title">비품 목록</h4>
	    </div>
	    <div class="modal-body">
	    	<!-- 모달 내용 -->
	    	<div class="row equipmentList-body text-center">
		    	<div class="col-lg-12 equipmentList-md">
		    		<table id="equipmentListTable" class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>비품코드</th>
								<th>비품명</th>
								<th>수량</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${equipments }" var="equipment" varStatus="status">
								<tr role='row'>
									<td>${equipment.eqNo }</td>
									<td>${equipment.eqName }</td>
									<td>
										<input type="hidden" name="eqNo" value="${equipment.eqNo }">
										<div class="input-group number-spinner">
											<span class="input-group-btn">
												<button type="button" class="btn btn-default" data-dir="dwn"><span class="glyphicon glyphicon-minus"></span></button>
											</span>
											<input type="text" name="eqCount" class="form-control text-center" min="0" max="${equipment.eqCount }" value="${equipment.eqCount }" readonly>
											<span class="input-group-btn">
												<button type="button" class="btn btn-default" data-dir="up"><span class="glyphicon glyphicon-plus"></span></button>
											</span>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
		    	</div>
	    	</div>
	    </div>
	    <div class="modal-footer">
	      <button type="button" class="btn btn-primary col-lg-2 pull-right" data-dismiss="modal">확인</button>
	      <button type="button" id="equipmentList-modal-cancel" class="btn btn-default col-lg-2 pull-right" data-dismiss="modal">취소</button>
	    </div>
	  </div>
	  <!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script src="/resources/js/bootstrap-input-spinner.js"></script>
<script>
	var eqList = [];
	$(function(){
		
		var equipmentTable = $('#equipmentListTable').DataTable({
			'lengthChange' : false,
			'searching' : true,
			'ordering' : true,
			'info' : false,
			'autoWidth' : false,
			'order' : [ [ 1, "asc" ] ],
			'destroy': true,
			'dom': '<"top"f>rt<"bottom"p><"clear">',
	        "columnDefs": [
	            {
	                "targets": [ 0 ],
	                "visible": false
	            }
	        ]
		});
		
		// 비품 모달 확인 버튼
		$('#equipmentList-modal').on('click', '.btn-primary', function() {
			let eqListStr = '';
			eqList = [];
			
			if($('#equipmentListTable .dataTables_empty').length == 1) return;
			
			$('#equipmentListTable tbody tr').each(function(index, item){
				let eqNo = $(item).children().eq(1).find('input[name=eqNo]').val();
				let eqName = $(item).children().eq(0).text();
				let eqCount = $(item).children().eq(1).find('input.form-control').val();
				
				eqListStr += eqCount!='0' ?  (eqName+" ("+eqCount+"), ") : "";
				
				eqList.push({"eqNo": eqNo, "eqName": eqName, "eqCount": eqCount});
			});
			if(eqListStr.length > 0) eqListStr = eqListStr.substr(0, eqListStr.length -2);
			
			$('#eqList').val(eqListStr);
		});
		
		// 비품 모달 닫힐때
		$('#equipmentList-modal').on('hide.bs.modal', function (e) {
			eqModalValueSetting();
		});
		
		function eqModalValueSetting() {
			$.each(eqList, function(index, item) {
				$('#equipmentListTable tbody tr').eq(index).find('input.form-control').val(item.eqCount);
			});
		}
		
		/* 비품 수량 스피너 */
		$(document).on('click', '.number-spinner button', function () {    
			var btn = $(this);
				numberInput = btn.closest('.number-spinner').find('input');
				oldValue = numberInput.val().trim();
				let min = parseInt(numberInput.attr('min'));
				let max = parseInt(numberInput.attr('max'));
				newVal = 0;
			
			if (btn.attr('data-dir') == 'up') {
		    	if (oldValue < max) {
					newVal = parseInt(oldValue) + 1;
				} else {
					newVal = max;
				}
			} else {
				if (oldValue > min) {
					newVal = parseInt(oldValue) - 1;
				} else {
					newVal = min;
				}
			}
			numberInput.val(newVal);
		});
		
		// 비품 목록 갱신
		$('#buildingSelect, #roomSelect').change(function() {
			$.ajax({
				url: '/reserve/getOneRoomEquipment',
				type : "POST",
	            data : {"roomNo" : $('#roomSelect').val()},
	            dataType : "json",
	            success : function(data) {
            		equipmentTable.rows().remove();

	            	$.each(data.equipments, function(index, item){
	            		
		            	dataHtml = '<input type="hidden" name="eqNo" value="'+item.eqNo+'">'
		            			+ '<div class="input-group number-spinner">'
		            			+ '<span class="input-group-btn">'
		            			+ '<button type="button" class="btn btn-default" data-dir="dwn"><span class="glyphicon glyphicon-minus"></span></button>'
		            			+ '</span>'
		            			+ '<input type="text" name="eqCount" class="form-control text-center" min="0" max="'+item.eqCount+'" value="'+item.eqCount+'" readonly>'
		            			+ '<span class="input-group-btn">'
		            			+ '<button type="button" class="btn btn-default" data-dir="up"><span class="glyphicon glyphicon-plus"></span></button>'
		            			+ '</span></div>';
		            	
		            	equipmentTable.row.add([item.eqNo, item.eqName, dataHtml]);
	            	});
	            	
	            	equipmentTable.draw();
	            	$('#eqList').val('');
	            	
	            	$('#equipmentList-modal .btn-primary').trigger('click'); // 최초 모든 비품 선택
	            },
	            error: function(data) {
	            	alert(data);
	            }
			});
		});
	});
</script>