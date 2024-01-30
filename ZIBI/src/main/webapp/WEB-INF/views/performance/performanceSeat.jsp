<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hyun/choose.seat.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- ticketing_num 저장 -->
<c:forEach var="ticketing" items="${pickTicketing}" varStatus="status">
	<div id="ticketing-num" style="display:none;">${ticketing.ticketing_num}</div>
</c:forEach>
<!--  -->


<!-- 영화 정보 / 인원 선택 Start -->
<div class="container-fluid contact py-6">
	<div class="container">
		<h2>영화 정보</h2>
		<c:forEach var="cinema" items="${pickCinema}" varStatus="status">
			<div>${cinema.cinema_location1} ${cinema.cinema_location2} ${cinema.cinema_theater}</div>
		</c:forEach>
		<c:forEach var="performance" items="${pickPerformance}" varStatus="status">
			<div>${performance.performance_title}</div>
			<div>${performance.performance_age}</div>
		</c:forEach>
		<c:forEach var="ticketing" items="${pickTicketing}" varStatus="status">
			<div>예매 정보: ${ticketing.ticketing_date} ${ticketing.ticketing_start_time}</div>
		</c:forEach>
		<br>
		<h2>인원 선택</h2>
		<div>
			<span class="people">성인</span>
			<span class="people adult-minus">-</span>
			<span class="people adult-num">0</span>
			<span class="people adult-plus">+</span>
		</div>
		<div>
			<span class="people">청소년</span>
			<span class="people teenage-minus">-</span>
			<span class="people teenage-num">0</span>
			<span class="people teenage-plus">+</span>
		</div>
		<div>
			<span class="people">우대</span>
			<span class="people treatement-minus">-</span>
			<span class="people treatement-num">0</span>
			<span class="people treatement-plus">+</span>
		</div>
	</div>
</div>
<br><br><br>
<!-- 영화 정보/ 인원 선택 End -->


<c:forEach var="cinema" items="${pickCinema}" varStatus="status">
	<div>행 : ${cinema.cinema_row}</div>
	<div>열 : ${cinema.cinema_col}</div>
</c:forEach>


<!-- 좌석 선택 Start -->
<div class="container-fluid contact py-6 wow bounceInUp" data-wow-delay="0.1s">
	<div class="container">
		<h2>좌석 선택</h2>
		<div id="seat">
			<!-- <div style="display:inline-block;width:50px;height:50px;border:1px solid black;"></div> -->
			
		</div>
	</div>
</div>
<!-- 좌석 선택 End -->




<br><br><br><br><br><br><br><br>


<!-- 총 금액 Start -->
<div class="container-fluid contact py-6 wow bounceInUp" data-wow-delay="0.1s">
	<div class="container">
	<c:forEach var="cinema" items="${pickCinema}" varStatus="status">
		<div>일반 : ${cinema.cinema_adult}</div>
		<div>청소년 : ${cinema.cinema_teenage}</div>
		<div>우대 : ${cinema.cinema_treatment}</div>
	</c:forEach>
	<div>총 금액 : </div>
	</div>
</div>
<!-- 총 금액 End -->


<form action="submitSeat" method="post">
	
	<input type="submit" value="결제하기">
</form>