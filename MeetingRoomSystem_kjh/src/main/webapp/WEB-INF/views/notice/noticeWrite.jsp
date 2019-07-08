<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- <script>
    	$(function(){
    		$('#noticeSubmit').on("click",function(){
    			var form = $('#noticeForm').serialize();
       		 $.ajax({
       		   	 
       		       url:"/meeting/notice/write",
       		       method :"post",
       		       data : form,
       		       success : function(data){
       		         console.log("cc")
       		       }
       		    })
    		})
    	});
    </script> -->
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
	<div class="row" style="padding-top:20px">
		<div class="col-md-12">
          <div class="tile" >
           <h3 class="tile-title" style="padding-bottom:10px; border-bottom:1px solid #ddd">공지사항을 작성하여 주십시오</h3>
           <form action="/meeting/notice/write" method="POST" id="noticeForm">
              <div class="tile-body"><!-- 
              		<input type="hidden" name="noticeId" id="noticeId">
              		<input type="hidden" name="noticeDate" id="noticeDate"> -->
              		<input type="hidden" name="_csrf" value="${_csrf.token}">
	          		<div class="form-group">
						<label class="control-label">제목</label> 
						<input
							class="form-control" type="text"
							placeholder="Enter Notice Title" name="noticeTitle" id="noticeTitle" autocomplete="off">
					</div>
					
					<div class="form-group">
	                    <label class="control-label">작성자</label>
	                    <input class="form-control" type="text" id="noticeWriter" name="noticeWriter" autocomplete="off" readonly>
	                </div>
	                
					<div class="form-group">
						<label class="control-label">내용</label>
						<textarea class="form-control" rows="4"
							placeholder="Enter Notice Content" name="noticeContent" id="noticeContent" ></textarea>
					</div>
	                
	                
	                <div class="tile-footer">
                       <div>
                          <button class="btn btn-primary" type="submit" id="noticeSubmit"><i class="fa fa-fw fa-lg fa-check-circle"></i>확인</button>
                          <a class="btn btn-secondary" href="/meeting/notice/list/1"><i class="fa fa-fw fa-lg fa-times-circle"></i>취소</a>
                       </div>
                    </div>
          	  </div>
          	</form>
          </div>
        </div>
    </div>
</main>
<script>
$(function(){
	/* var today = new Date();
	$('#noticeDate').attr("value",today); */

$.ajax({
    url:"/meeting/users/getCurrentId",
    method :"post",
    data : "_csrf=${_csrf.token}",
    success : function(data){
       var emp = data
       $('#noticeWriter').attr("value",emp.empId);
    }
 })
 
 
});
</script>