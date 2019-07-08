<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="/meeting/resources/css/swiper.min.css">
 <style>
   
    .swiper-container {
     /*  width: 100%; */
      height: 100%;
    }
    .swiper-slide {
      text-align: center;
      font-size: 18px;

      /* Center slide text vertically */
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
    }
  </style>
<main class="app-content">
<div class="app-title">
		<div>
			<h1><i class="fa fa-calendar"></i>예약이력</h1>
			<p>
				회의실 예약 전체 현황 목록입니다.
			</p>
		</div>
		<ul class="app-breadcrumb breadcrumb">
			<li class="breadcrumb-item">
			<i class="fa fa-home fa-lg"></i>
			</li>
			<li class="breadcrumb-item">
			<a>예약이력</a>
			</li>
			<li class="breadcrumb-item">
			<a href="/meeting/recognition/waitForRecognition">예약현황</a>
			</li>
		</ul>
	</div>
<div class="row">
	<div class="swiper-container">
    <div class="swiper-wrapper">
      <button class="swiper-slide btn btn-primary">Slide 1</button>
      <button class="swiper-slide btn btn-primary">Slide 2</button>
      <button class="swiper-slide btn btn-primary">Slide 3</button>
      <button class="swiper-slide btn btn-primary" >Slide 4</button>
      <button class="swiper-slide btn btn-primary">Slide 5</button>
      <button class="swiper-slide btn btn-primary">Slide 6</button>
      <button class="swiper-slide btn btn-primary">Slide 7</button>
      <button class="swiper-slide btn btn-primary">Slide 8</button>
      <button class="swiper-slide btn btn-primary">Slide 9</button>
      <button class="swiper-slide btn btn-primary">Slide 10</button>
    </div>
    <!-- Add Pagination -->
    <div class="swiper-pagination"></div>
  </div>
</div>
</main>
<script src="/meeting/resources/js/swiper.min.js"></script>
<script>
    var swiper = new Swiper('.swiper-container', {
      slidesPerView: 3,
      spaceBetween: 30,
      freeMode: true,
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
    });
  </script>