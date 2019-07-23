<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>관리자 비용 관리
      <small>관리하고 있는 회의실의 비용 결제 현황입니다.</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
        <li><a href="#">DEPARTMENT HEAD</a></li>
        <li class="active">관리자 비용 관리</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">비용 결제 리스트</h3>
              
                <input type="button" onclick="tableToExcel('example2')" class="btn btn-primary" value="EXCEL로 내보내기" style="float: right;" /> 
            </div>
            <!-- /.box-header -->
            <div id="dvData">
            <div class="box-body">
             
             
              <table id="example2" class="table table-bordered table-hover">
                
                <thead>
                <tr>
                  <th>예약 일자</th>
                  <th>회의명</th>
                  <th>주관 부서</th>
                  <th>비용(원)</th>  
                  <!-- <th>비고</th> -->
                </tr>
                </thead>
                                
                <tbody>
				<c:forEach var="PaymentDTO" items="${paymentList}">
					
					<tr>
						<td>${PaymentDTO.startDate}</td>
						<td>${PaymentDTO.title}</td>
						<td>${PaymentDTO.deptName}</td>						
						<td><fmt:formatNumber value="${PaymentDTO.cost}" pattern="#,###원"></fmt:formatNumber></td>
					</tr>
				</c:forEach>
				</tbody>
				
				<tfoot>
				<tr>
				<th>총 실결제금액</th>
					<th></th><th></th>
					<c:set var = "sum" value = "0" />
					<c:forEach var="PaymentDTO" items="${paymentList}">
					<c:set var= "sum" value="${sum + PaymentDTO.cost}"/>
					</c:forEach>
					<th> <fmt:formatNumber value="${sum}" pattern="#,###원"></fmt:formatNumber></th>		
					
				</tfoot>  
				      
              </table>
					
              </div>
            </div>
           </div>            
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
       	</div>
       </section>
        <!-- /.col -->
    </div>
      <!-- /.row -->

<script>
	$(function() {
		$('#example2').DataTable({
			'paging' : true,
			'lengthChange' : true,
			'searching' : false,
			'ordering' : true,
			'info' : true,
			'autoWidth' : false
		})
	})
</script>

<script>
// 	$('#example2').tableExport({
// 		,mfileName:"비용 결제 목록_" + new Date().toISOString().replace(/[\-\:\.]/g, "")
// 		,type:'excel'
// 		,excelstyles:['background-color', 'font-weight', 'text-align', 'width', 'font-size']
// 		,mso: { styles:['background-color', 'font-weight', 'text-align', 'width', 'font-size']
// 				,worksheetName: "비용 결제 목록"
// 				,fileFormat: "xlsx"}
// 		,ignoreRow:null
// 		,ignoreColumn: [7]
// 		,htmlContent: false
// 		,exportHiddenCells: true
// 	});
</script>

<script>
//엑셀로 내보내기
	function tableToExcel(id) {
	    var data_type = 'data:application/vnd.ms-excel;charset=utf-8';
	    var table_html = encodeURIComponent(document.getElementById(id).outerHTML);
	 
	    var a = document.createElement('a');
	    a.href = data_type + ',%EF%BB%BF' + table_html;
	    a.download = '비용 결제 리스트'+'.xls';
	    a.click();
	}
</script>