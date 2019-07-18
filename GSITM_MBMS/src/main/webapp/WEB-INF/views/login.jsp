 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--<!DOCTYPE html>
<html> --%>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>GSITM MBMS 로그인</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/resources/bower_components/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="/resources/bower_components/Ionicons/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/dist/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="/resources/plugins/iCheck/square/blue.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<style>

/* 	.login-box{
		margin : 0 auto;
	}
 */
/*  .hold-transition login-page{
 	height:%;
 } */
 
 
 
</style>

</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
  	<img src="resources/img/gsitm_logo.png">
	<b>MBMS</b><br><span>회의실예약관리시스템</span>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">로그인 정보는 e-HR 정보와 동일합니다. </p>

    <form action="/logincheck" method="post">
      <div class="form-group has-feedback">
        <input type="text" name="emp_no" id="logId" class="form-control" placeholder="사원번호">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" name="emp_pw" id="logPwd" class="form-control" placeholder="비밀번호">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div id="login-alert" style="height: 34px; font-size: 12px; text-align: center">사원번호와 비밀번호를 입력하세요.</div>
      <div class="row">
        <div class="col-xs-8">
          <div class="checkbox icheck">
            <label>
              <input type="checkbox" id="loginChk" name="autoLoginCheck" value="true"> Remember Me
            </label>
          </div>
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <button type="button" id="loginBtn" class="btn btn-primary btn-block btn-flat">Sign In</button>
        </div>
        <!-- /.col -->
      </div>
    </form>

  </div>
  <!-- /.login-box-body -->
  <div class="clear-both"></div>
</div>
<!-- /.login-box -->

<!-- jQuery 3 -->
<script src="/resources/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="/resources/plugins/iCheck/icheck.min.js"></script>
<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' /* optional */
    });
    
    $('#logId, #logPwd').keyup(function(e){
		if(e.keyCode==13){
			$('#loginBtn').trigger('click');
		}
	});
	
	//로그인
	$('#loginBtn').click(function(){
		$('#login-alert').empty();
		
		if($('#logId').val() == "") {
			$('#login-alert').text('아이디를 입력하세요').css('color','red');
			$('#logId').focus();
		} else if($('#logPwd').val() == "") {
			$('#login-alert').text('비밀번호를 입력하세요').css('color','red');
			$('#logPwd').focus();
		} else {
			var isChk = "false";
			if($("#loginChk").is(":checked")) {
				isChk = "true";
			}
			
			$.ajax({
				type : 'POST',
				url : '/logincheck',
				data : {'emp_no' : $('#logId').val()
					,'emp_pw' : $('#logPwd').val()
					,'useCookie' : isChk},
					dataType : 'text',
					success : function(data){
						if(data=='success')
							location.href='/';
						else if(data=='notExist'){
							$('#login-alert').text('존재하지 않는 사원번호입니다.').css('color','red');
						} else if(data=="fail") {
							$('#login-alert').text('비밀번호가 틀렸습니다.').css('color','red');
						} else {
							location.href='/finalProject'+data;
						}
					}
			});
		} // else
	});
  });
</script>
</body>
<!-- </html> -->
