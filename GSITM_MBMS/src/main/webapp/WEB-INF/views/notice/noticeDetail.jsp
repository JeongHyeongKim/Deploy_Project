<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
figure img {max-width:600px; height:auto;}

	.btn_del_upd {display: inline-block;}
	
	.mailbox-read-message{
		min-height:150px;
	}



</style>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        공지사항
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 공지사항</a></li>
        <li class="active">공지사항 상세보기</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">공지사항 상세보기</h3>

              <div class="box-tools pull-right">
              	<c:if test="${!isFirstNo}">
					 <a href='noticeDetail?noticeNo=${prevNoticeNo}' class="btn btn-box-tool" data-toggle="tooltip" title="Previous"><i class="fa fa-chevron-left"> </i> 이전글</a>
				</c:if>
				<c:if test="${!isLatestNo}">
					<a href='noticeDetail?noticeNo=${nextNoticeNo}' class="btn btn-box-tool" data-toggle="tooltip" title="Next"> 다음글 <i class="fa fa-chevron-right"></i></a>
				</c:if>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body no-padding">
              <div class="mailbox-read-info">
                <h3>${noticeDTO.noticeSubject}</h3>
                <h5>작성자: ${noticeDTO.writerEmpName} ${noticeDTO.writerEmpPosition} ( ${noticeDTO.writerEmpNo} )
                  <span class="mailbox-read-time pull-right">작성일 : ${noticeDTO.noticeDate}</span>
                </h5>
              </div>
              <!-- /.mailbox-read-info -->

              <div class="mailbox-read-message">

                <p>${noticeDTO.noticeContent}</p>

              </div>
              <!-- /.mailbox-read-message -->
            </div>
            <!-- /.box-body -->
            <!-- <div class="box-footer">
              <ul class="mailbox-attachments clearfix">
                <li>
                  <span class="mailbox-attachment-icon"><i class="fa fa-file-pdf-o"></i></span>

                  <div class="mailbox-attachment-info">
                    <a href="#" class="mailbox-attachment-name"><i class="fa fa-paperclip"></i> Sep2014-report.pdf</a>
                        <span class="mailbox-attachment-size">
                          1,245 KB
                          <a href="#" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a>
                        </span>
                  </div>
                </li>
                <li>
                  <span class="mailbox-attachment-icon"><i class="fa fa-file-word-o"></i></span>

                  <div class="mailbox-attachment-info">
                    <a href="#" class="mailbox-attachment-name"><i class="fa fa-paperclip"></i> App Description.docx</a>
                        <span class="mailbox-attachment-size">
                          1,245 KB
                          <a href="#" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a>
                        </span>
                  </div>

                </li>
 				
              </ul>
              첨부파일 구현해라@@@@@@@@@@@@@@
            </div> -->
            <!-- /.box-footer -->
            <div class="box-footer">
              <div class="pull-right">
              
              
              
         <%--      	<c:choose>
					<c:when test="${isAdmin}">
						<form action="noticeInsertForm" method="post">
							<button type="submit" class="btn btn-primary">
			                 	<i class="fa fa-plus"></i>　공지 작성
			                 </button>
	                 	</form>
					</c:when>
					<c:otherwise>
						<form action="noticeInsertForm" method="post">
							<button type="submit" class="btn btn-primary" disabled>
			                 	<i class="fa fa-plus"></i>　작성하려면 운영자로 로그인하세요
			                 </button>
	                 	</form>
					</c:otherwise>
				</c:choose> --%>
              
              
              
              
              <form action="noticeDelete" method="post" class = "btn_del_upd">
              	<input type="hidden" name="noticeNo" value="${noticeDTO.noticeNo}">
              	<c:choose>
					<c:when test="${isAdmin}">
	            		<button type="submit" class="btn btn-default"><i class="fa fa-trash-o"></i> 삭제</button>
	            	</c:when>
	            	<c:otherwise>
	            		<button type="button" class="btn btn-default" disabled><i class="fa fa-trash-o"></i> 삭제</button>
	            	</c:otherwise>
				</c:choose>
              </form>
             
              
              <form action="noticeUpdateForm" method="post" class = "btn_del_upd">
              	<input type="hidden" name="noticeNo" value="${noticeDTO.noticeNo}">
              	<c:choose>
					<c:when test="${isAdmin}">
	            		<button type="submit" class="btn btn-default"><i class="fa fa-pencil-square-o"></i> 수정</button>
	            	</c:when> 
	            	<c:otherwise>
	            		<button type="button" class="btn btn-default" disabled><i class="fa fa-pencil-square-o"></i> 수정</button>
	            	</c:otherwise>
				</c:choose>
              </form>
                
              	
              </div><!-- 
                <button type="button" class="btn btn-default"><i class="fa fa-reply"></i> 답글 달기(구현?)</button>
                <button type="button" class="btn btn-default"><i class="fa fa-share"></i> 공유(구현?)</button> -->
            <button type="button"onclick="location.href='noticeList' " class="btn btn-default"><i class="fa fa-bars"></i> 목록</button>
            </div>
            <!-- /.box-footer -->
          </div>
          <!-- /. box -->
        </div>
        <!-- /.col -->
      </div> 
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->