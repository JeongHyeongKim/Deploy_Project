<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
    <!-- Twitter meta-->
    <meta property="twitter:card" content="summary_large_image">
    <meta property="twitter:site" content="@pratikborsadiya">
    <meta property="twitter:creator" content="@pratikborsadiya">
    <!-- Open Graph Meta-->
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="Vali Admin">
    <meta property="og:title" content="Vali - Free Bootstrap 4 admin theme">
    <meta property="og:url" content="http://pratikborsadiya.in/blog/vali-admin">
    <meta property="og:image" content="http://pratikborsadiya.in/blog/vali-admin/hero-social.png">
    <meta property="og:description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
    <title>GSITM - </title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="/meeting/resources/css/main.css">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body class="app sidebar-mini rtl">
    <!-- Navbar-->   
    <header class="app-header">
    <a class="app-header__logo" href="/meeting/reservation/list/br_0001"><img src="/meeting/resources/img/logo.png" style="width:200px; height:50px; margin-left:-10px;"></a>
		<!-- Sidebar toggle button-->
		<a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
      <!-- Navbar Right Menu-->
      <ul class="app-nav">
        <!-- User Menu-->

      </ul>
      <form action="/meeting/users/logout" method="POST">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button class="btn btn-primary" type="submit" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Logout"><i class="fa fa-user fa-lg"></i></button>
	    </form> 
    </header>
   
    
    <!-- Page specific javascripts-->
     <!-- Essential javascripts for application to work-->
    <script src="/meeting/resources/js/jquery-3.2.1.min.js"></script>
    <script src="/meeting/resources/js/popper.min.js"></script>
    <script src="/meeting/resources/js/bootstrap.min.js"></script>
    
    <!-- The javascript plugin to display page loading on top-->
    <!-- Google analytics script-->
    <script type="text/javascript">
    $('[data-toggle="tooltip"]').tooltip();
      if(document.location.hostname == 'pratikborsadiya.in') {
         (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
         (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
         m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
         })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
         ga('create', 'UA-72504830-1', 'auto');
         ga('send', 'pageview');
      }
    </script>
    <script type="text/javascript">
   $(function(){
	  /* 
	   $("#logout").on("click",function(){
  			$.ajax({
  				url:"/meeting/users/logout",
  				type : "post",
  				data : "_csrf=${_csrf.token}"
  			})
  		}) */
   })
   		
   </script>
  </body>
</html>