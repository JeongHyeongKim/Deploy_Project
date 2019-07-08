<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript">
	$(function(){
		var notice = JSON.parse('${notice}');
		console.log(notice);
		$("#noticeTitle").text("[공지]"+notice.noticeTitle);
		$("#noticeContent").text(notice.noticeContent);
		$("#noticeWriter").text("[작성자]"+notice.noticeWriter);
		
		 var noticeURL = window.location.href;
         var splitId = noticeURL.split("/");
         var noticeId = splitId[splitId.length-1];
         
		$("#noticeDelete").on("click",function(){

            $.ajax({
                url:"/meeting/notice/delete/" + noticeId,
                data : "_csrf=${_csrf.token}",
                method:"post",
                success:function(data) {
                	location.href= "/meeting/notice/list/1"
                }, error:function(){
                	console.log("error")
                }
			})
		
		})
	
		$("#noticeUpdate").on("click", function(){
			location.href = "/meeting/notice/update/" + noticeId ;
			
		})
	})
</script>
<style type="text/css">
	#Writer{
		margin-left : 75%;
		
	}
</style>

<main class="app-content">
	<div class="app-title">
		<div>
			<h1><i class="fa fa-calendar"></i>공지사항</h1>
			<p>
				공지사항을 확인하세요.
			</p>
		</div>
		<ul class="app-breadcrumb breadcrumb">
			<li class="breadcrumb-item">
			<i class="fa fa-home fa-lg"></i>
			</li>
			<li class="breadcrumb-item">
			<a href="/meeting/notice/list/1">공지사항</a>
			</li>
			
		</ul>
	</div>
  <div class="row">
	<div class="col-md-12">
          <div class="tile">
            <h3 class="tile-title"></h3>
            <div class="tile-body">
              <form>
                <!-- <div class="form-group" >
                  <label class="control-label"><h3 id="noticeTitle"></h3></label>
                  <label class="control-label"id="noticeWriter"></label>
                </div> -->
                <div class="tile-title-w-btn">
	              <h3 class="title" id="noticeTitle"></h3>
	              <label class="control-label" id="noticeWriter"></label>
	            </div>
	            <hr>
	            <div class="tile-body">
	              <label class="control-label" id="noticeContent"></label>
	              
	            </div>
              <!--  <hr>
                <div class="form-group">
                  <label class="control-label" id="noticeContent"></label>
                </div> -->
               
              </form>
            </div>
            <security:authorize access="hasRole('ROLE_ADMIN')">
	            <div class="tile-footer">
	              <button class="btn btn-primary" type="button" id="noticeUpdate"><i class="fa fa-fw fa-lg fa-check-circle"></i>글수정</button>&nbsp;&nbsp;&nbsp;
	              <button class="btn btn-secondary" type="button" id="noticeDelete"><i class="fa fa-fw fa-lg fa-check-circle"></i>글삭제</button>
	            </div>
            </security:authorize>
          </div>
        </div>
     </div>
</main>
