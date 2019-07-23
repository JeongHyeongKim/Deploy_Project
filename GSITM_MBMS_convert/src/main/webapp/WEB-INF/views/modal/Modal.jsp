<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="modal fade" id="insertCompleteModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">등록성공!</h4>
				</div>
				<div class="modal-body">
					<p>등록완료!</p>
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
	<!-- /.modal -->

	<div class="modal fade" id="updateCompleteModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">수정성공!</h4>
				</div>
				<div class="modal-body">
					<p>수정완료!</p>
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
	<!-- /.modal -->

	<div class="modal fade" id="deleteCompleteModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">삭제 성공!</h4>
				</div>
				<div class="modal-body">
					<p>삭제완료!</p>
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
	<!-- /.modal -->

	<div class="modal fade" id="modal-default_buildInsert">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">근무지 등록하기</h4>
				</div>
				<div class="modal-body">
					<form role="form" action="/building/buildingInsert" method="post">
						<!-- text input -->
						<div class="form-group">
							<label>근무지이름</label> <input type="text" class="form-control"
								name="buildName" placeholder="Enter ...">
						</div>

						<label>우편 번호</label>
						<div class="row">
							<div class="col-xs-3">
								<input type="text" class="form-control" name="buildPost"
									onclick="execPostCode();">
							</div>
							<div class="col-xs-4">
								<input type="button" class="btn btn-default" value="검색하기"
									onclick="execPostCode();">
							</div>
						</div>

						<div class="form-group">
							<label>근무지 주소</label>
							<div class="row">
								<div class="col-xs-7">
									<input type="text" class="form-control" name="buildAddr"
										onclick="execPostCode();">
								</div>
							</div>
						</div>

						<div class="form-group" align=center>
							<input type="button" class="btn btn-default" data-dismiss="modal"
								value="닫기" /> <input type="reset" class='btn btn-danger'
								value="다시쓰기"> <input type="submit"
								class='btn btn-success' value="완료">
						</div>
					</form>

				</div>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	

	</body>
<script>
$(document).ready(function() {
	
	var type = '${param.type}';
	if(type=='insert') 
		$("#insertCompleteModal").modal();
	else if(type=='update')
		$("#updateCompleteModal").modal();
	else if(type=='delete')
		$("#deleteCompleteModal").modal();
})
</script>
</html>
