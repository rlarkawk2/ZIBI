<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        // Disable the "카테고리 선택" option
        $("#categorm_form option[value='']").prop("disabled", true);
    });
</script>


<div>
	<div class="d-flex justify-content-center">
		<div class="rounded sc-writeform col-md-4 col-lg-6">
			<form:form action="write" id="sc_write" modelAttribute="secondVO" enctype="multipart/form-data">
				<div>
					<form:label path="sc_title">제목</form:label>
					<form:input path="sc_title" class="w-100 form-control p-3 mb-4" placeholder="제목"/>
					<form:errors path="sc_title" cssClass="error-color"/>
				</div>
				
				<div>
                    <form:label path="sc_category">카테고리</form:label>
                    <form:select path="sc_category" class="w-100 form-select p-3 mb-4" id="categorm_form">
                    	<form:option value="0" disabled="disabled" label="카테고리 선택"/>
       					<form:option value="1" label="의류/액세서리" />
        				<form:option value="2" label="도서/티켓/문구" />
        				<form:option value="3" label="뷰티" />
   	 					<form:option value="4" label="전자기기" />
        				<form:option value="5" label="식품" />
        				<form:option value="6" label="기타" />
                    </form:select>
                </div>
				
				<div>
					<form:label path="sc_price">가격</form:label>
					<form:input path="sc_price" class="w-100 form-control p-3 mb-4" placeholder="판매가격"/>
					<form:errors path="sc_price" cssClass="error-color"/>
				</div>
				
				<div>
					<form:label path="upload">썸네일 이미지</form:label>
					<input type="file" name="upload" id="upload">
				</div>
				
				
				
				<div>
					<form:label path="sc_content">내용을 입력하세요</form:label>
					<form:textarea path="sc_content"/>
					<form:errors path="sc_content" cssClass="error-color"/>
					<script>
						function MyCustomUploadAdapterPlugin(editor){
							editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
								return new UploadAdapter(loader);
							}
						}
					
						ClassicEditor
							.create(document.querySelector('#sc_content'),{
								extraPlugins:[MyCustomUploadAdapterPlugin]
							})
							.then(editor => {
								window.editor = editor;
							})
							.catch(error => {
								console.error(error);
							});
					</script>
				</div>
			
				<div>
					<form:label path="sc_status">상품 상태</form:label>
					<form:radiobutton path="sc_status"  value="1" label="중고" checked="checked"/>
					<form:radiobutton path="sc_status" value="2" label="새상품" />
				</div>
				
				<div>
					<form:label path="sc_way">거래 방법</form:label>
					<form:radiobutton path="sc_way"  value="1" label="직거래" checked="checked"/>
					<form:radiobutton path="sc_way" value="2" label="택배" />
				</div>
				
				<!-- 거래 희망 장소 -->
				<form:label path="sc_address">거래 희망 장소</form:label>
				<form:input path="sc_address" placeholder="주소"/>
				<input type="button" onclick="second_execDaumPostcode()" value="주소 검색"><br>
				
				<form:input path="sc_place" placeholder="거래 장소를 입력하세요"/>
				
				<div id="clickLatlng"></div> 
				<div id="clickLatlng1"></div> 
				
				<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b2c8d108f8ba3676d57626832ac387e&libraries=services"></script>
				<script>
				    var mapContainer = document.getElementById('map'),
				        mapOption = {
				            center: new daum.maps.LatLng(37.537187, 127.005476),
				            level: 5
				        };
				
				    var map = new daum.maps.Map(mapContainer, mapOption);
				    var geocoder = new daum.maps.services.Geocoder();
				    var marker = new daum.maps.Marker({
				        position: new daum.maps.LatLng(37.537187, 127.005476),
				        map: map
				    });
				
				    var clickedCoords = null; //클릭된 좌표를 저장할 변수
				
				    daum.maps.event.addListener(map, 'click', function(mouseEvent) {
				        var coords = mouseEvent.latLng;
				
				        mapContainer.style.display = "block";
				        map.relayout();
				        map.setCenter(coords);
				        marker.setPosition(coords);
				
				        // 클릭된 좌표로 변수 update
				        clickedCoords = {
				            lat: coords.getLat(),
				            lng: coords.getLng()
				        };
				
				        // 좌표 업데이트
				        updateClickLatlng(clickedCoords);
				    });
				
				    function second_execDaumPostcode() {
				        new daum.Postcode({
				            oncomplete: function(data) {
				                var addr = data.address;
				
				                document.getElementById("sc_address").value = addr;
				
				                geocoder.addressSearch(data.address, function(results, status) {
				                    if (status === daum.maps.services.Status.OK) {
				                        var result = results[0];
				                        var coords = new daum.maps.LatLng(result.y, result.x);
				
				                        mapContainer.style.display = "block";
				                        map.relayout();
				                        map.setCenter(coords);
				                        marker.setPosition(coords);
				
				                        // Update the variable with address coordinates
				                        clickedCoords = {
				                            lat: coords.getLat(),
				                            lng: coords.getLng()
				                        };
				
				                        // Update the display with the coordinates
				                        updateClickLatlng(clickedCoords);
				                    }
				                });
				            }
				        }).open();
				    }
				    function updateClickLatlng(coords) {
				        // 좌표에서 주소 가져오기
				        geocoder.coord2Address(coords.lng, coords.lat, function(results, status) {
				            if (status === daum.maps.services.Status.OK) {
				                var address = results[0].address.address_name;
	
				                // id값에 주소 update
				                document.getElementById("sc_address").value = address;
				            }
				            
				            //sc_latitude 및 sc_longitude에 대한 hidden update
				            document.getElementById("sc_latitude").value = coords.lat;
				            document.getElementById("sc_longitude").value = coords.lng;
				            
				            
				            //위도(sc_latitude) , 경도(sc_longitude) 변수에 저장
				            //var sc_latitude = coords.lat;
				            //var sc_longitude = coords.lng;
				            
				          	//좌표 출력   나중에 주석처리
				            var message = '현재 좌표의 위도는 ' + coords.lat + ' 이고, 경도는 ' + coords.lng + ' 입니다';
				            var resultDiv = document.getElementById('clickLatlng');
				            resultDiv.innerHTML = message;
				            
				            
				            /* 삭제하기!!!!!
				            var message1 = 'db 좌표의 위도는 ' + sc_latitude + ' 이고, 경도는 ' + sc_longitude + ' 입니다';
				            var resultDiv1 = document.getElementById('clickLatlng1');
				            resultDiv1.innerHTML = message1;
				            */
				        });
				    }
				</script>
				<!-- 입력한 주소 지도 표시 끝 -->
				<form:hidden path="sc_latitude"/>    
				<form:hidden path="sc_longitude"/>
				<form:button class="w-100 btn btn-light form-control p-3 rounded-pill">상품 등록</form:button>
			</form:form>

		</div>
	</div>
</div>


