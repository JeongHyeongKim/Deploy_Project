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
		<h1>회의실 소개</h1>
		<ol class="breadcrumb">
			<li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">RoomList</li>
		</ol>
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">
						<c:if test="${param.buildingSelect eq null }">전체</c:if>
						<c:if test="${param.buildingSelect ne null }">검색 결과</c:if>
						</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<div class="row">
							<div class="col-sm-3">
								<label for="buildingSelect">지사</label>
								<select name="buildingSelect" id="buildingSelect" class="form-control"
								 ${param.buildingSelect ne null || param.roomTypeSelect ne null ? 'disabled' : '' }>
									<option value="">전체</option>
									<c:forEach var="building" items="${buildings }">
										<option value="${building.buildNo }">${building.buildName }</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="roomTypeSelect">구분</label>
								 <select name="buildingTypeSelect" id="roomTypeSelect" class="form-control"
								  ${param.buildingSelect ne null || param.roomTypeSelect ne null ? 'disabled' : '' }>
									<option value="">전체</option>
									<option value="회의실">회의실</option>
									<option value="교육실">교육실</option>
								</select>
							</div>
							<div class="col-sm-6"></div>
						</div>
						<table id="roomListTable" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th class="mobileDisabled">회의실 사진</th>
									<th>회의실명</th>
									<th>주요시설</th>
									<th>수용인원</th>
									<th>요금</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${rooms }" var="room" varStatus="status">
									<tr role='row'>
										<td class="mobileDisabled"><img src='${room.roomImg }' style="width: 300px;"></td>
										<td>${room.roomName }</td>
										<td>
											<c:forEach items="${room.equipments }" var="equip">
												<c:if test="${equip.eqCount ne 0}">
												${equip.eqName } (${equip.eqCount })<br>
												</c:if>
											</c:forEach>
										</td>
										<td>${room.roomNumEmp }명</td>
										<td>시간당 ${room.roomPrice }원</td>
										<td><input type="button" class="btn btn-danger btn-sm reserveBtn" id="${room.roomNo }"
											value="예약 하기"></td>
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

<form action="/reserve/reserveForm" method="post" id="reserveListForm">
	<input type="hidden" id="selectedRoomNo" name="roomNo">
	<input type="hidden" id="type" name="type">
</form>

<!-- page script -->
<script>
	$(function() {
		var table;
		$('#buildingSelect').val('${param.buildingSelect}');
		$('#roomTypeSelect').val('${param.roomTypeSelect}');
		
		table = $('#roomListTable').DataTable({
			'paging' : true,
			'lengthChange' : false,
			'searching' : false,
			'ordering' : true,
			'info' : true,
			'autoWidth' : true,
			'order' : [ [ 1, "desc" ] ],
			"destroy": true,
			"pagingType" : "full_numbers"
		});
		
		//조건별 회의실 검색
	      $(document).on('change', '#buildingSelect, #roomTypeSelect', function(){
	         $.ajax({
	            type : "POST",
	            url : "/reserve/roomSearch",
	            data : {"buildNo" : $('#buildingSelect').val(),
	                  "roomType" : $('#roomTypeSelect').val()},
	            dataType : "json",
	            success : function(data) {
				//alert(JSON.stringify(data));
	               
	               $('#roomListTable tbody').empty();
					table.clear().destroy();
	               
	               $.each(data.rooms, function(index,item){
	            	   console.log(item);
	            	   let eqStr = "";
	            	   $.each(item.equipments, function(i, d){
	            		   if(d.eqCount!=0)
	            		   	eqStr += d.eqName+" ("+d.eqCount+")<br>";
	            	   });
	            	   
	            	   console.log(eqStr);
	            	   
	                  $('<tr/>').append($('<td/>').append($('<img/>', {
	                     src : item.roomImg,
	                     class : 'mobileDisabled',
	                     style : 'width: 300px'
	                  }))).append($('<td/>', {
	                     text : item.roomName
	                  })).append($('<td/>', {
	                     html : eqStr
	                  })).append($('<td/>', {
	                     text : item.roomNumEmp+"명"
	                  })).append($('<td/>', {
	                     text : '시간당 '+item.roomPrice+'원'
	                  })).append($('<td/>').append($('<input/>', {
	                     type : 'button',
	                     'class' : 'btn btn-danger btn-sm reserveBtn',
	                     id : item.roomNo,
	                     value : '예약 하기'
	                  }))).appendTo($('#roomListTable tbody'));
	               });
	               
	               $('.box-title').text($('#buildingSelect :selected').text());
	               
	               table = $('#roomListTable').DataTable({
	       			'paging' : true,
	       			'lengthChange' : false,
	       			'searching' : false,
	       			'ordering' : true,
	       			'info' : true,
	       			'autoWidth' : true,
	       			'order' : [ [ 1, "desc" ] ],
	       			"destroy": true,
	       			"pagingType" : "full_numbers"
	       		});
	            },
	            error : function(data) {
	               alert('error');
	            }
	         });
	      });
		
		//예약하기 버튼 클릭
		$('.content').on('click', '.reserveBtn', function(){
			if(location.pathname=='/reserve/roomList') $('#type').val('remove');
			$('#selectedRoomNo').val(this.id);
			$('#reserveListForm').submit();
		});
		
	})
</script>