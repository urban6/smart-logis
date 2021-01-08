<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css">
<style>
      .map {
        height: 500px;
        width: 100%;
      }
</style>
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>

<body>
	<h2>My map!!!</h2>
	<div id="map" class="map"></div>
	
	<div class="row">
	<div class="col-lg-12 col-xs-4">
		<div class="card" style="flex-direction: row">
			<div class="card-body">
				<div class="col-12 pl-0 pr-0">	<!-- col-12 pl-0 pr-0 	ksh 07-30 -->
				<!-- 	<h4 class="card-title text-white inline-block">최장 대기 수진자</h4> inline-block 	ksh 07-30 -->
				    <h4 class="card-title text-white inline-block">모니터링 대상 수진자</h4>
					<span class="font-normal float-right"> <!-- float-right 	ksh 07-30 -->
						<a href="javascript:;" class="btn-group"  > 
							새로고침
							<i class="ti-reload" style="padding: 3px 4px 0 8px;"></i>
						</a>
					</span>
				</div>
				<div class="float-right d-none">
					<!--  d-none 버튼 숨김 ksh 07-26 -->
					<select id="searchPageRow" class="form-control d-none" onChange="">
						<option value="10" selected="selected">10건</option>
						<option value="15">15건</option>
						<option value="20">20건</option>
						<option value="30">30건</option>
					</select>
				</div>

				<div class="" id="areaLongTimes">
					<table id="" class="table table-striped table-hover table-bordered">
						<thead>
							<tr>
								<th>
								<!-- 	<span class="text-muted">평균 대기</span> -->
								   <span class="text-muted">이탈 횟수</span> 
								</th>
								<th>
									<span class="text-muted">수진번호</span>
								</th>
								<th>
									<span class="text-muted">이름</span>
								</th>
								<th>
									<span class="text-muted">패키지명</span>
								</th>
								<th>
									<span class="text-muted">상태</span>
								</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>
</div>

<div class="row">
		<div class="col-sm-4"> <!-- col-sm-4  ksh 07-30 -->
			<div class="card cursorHand">
				<div class="card-body">
					<div class="col-12 pr-0 pl-0">  <!-- div 추가  ksh 07-30 -->
						<h4 class="card-title text-uppercase col-7 pr-0 pl-0 inline-block" style="font-size: 2.500rem;white-space: nowrap;">검진 중</h4>  <!-- col-7 pr-0 pl-0  inline-block // style="font-size: 2.500rem;white-space: nowrap;" //  ksh 07-30 -->
						<h2 class="mb-0 display-6 col-5 pr-0 pl-0 no-wrap float-right inline-block text-right"> <!-- col-5 pr-0 pl-0 no-wrap float-right inline-block text-right   ksh 07-30 -->
							<a href="javascript:;" class="btn-group d-none" > &nbsp; </a>
							<span class="font-normal" style="font-size: 1.500rem;white-space: nowrap;"> <!-- style="font-size: 1.500rem" // style="font-size: 2.500rem;white-space: nowrap;"  ksh 07-30 -->
								<a href="javascript:;" class="btn-group"  style="font-size:1rem">
									새로고침
									<i class="ti-reload" style="padding: 3px 4px 0 8px;"></i>
								</a>
							</span>
						</h2>
					</div> <!-- div 추가  ksh 07-30 -->
					<div class="d-flex align-items-center mb-2 mt-4">
						<h2 class="mb-0 display-5">
							<i class="icon-people text-info"> </i>
						</h2>
						<div class="ml-auto">
							<h2 class="mb-0 display-6" >
								<span class="font-normal" id="countIng"></span>
							</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-4"> <!-- col-sm-4  ksh 07-30 -->
			<div class="card cursorHand">
				<div class="card-body">
					<div class="col-12 pr-0 pl-0">  <!-- div 추가  ksh 07-30 -->
						<h4 class="card-title text-uppercase col-8 pr-0 pl-0 inline-block" style="font-size: 2.500rem;white-space: nowrap;">검진 완료</h4> <!-- col-7 pr-0 pl-0  inline-block // style="font-size: 2.500rem;white-space: nowrap;" //  ksh 07-30 -->
						<h2 class="mb-0 display-6 col-4 pr-0 pl-0 no-wrap float-right inline-block text-right"> <!-- col-5 pr-0 pl-0 no-wrap float-right inline-block text-right   ksh 07-30 -->
							<span class="font-normal" style="font-size: 1.500rem;white-space: nowrap;"> <!-- style="font-size: 1.500rem"  // style="font-size: 2.500rem;white-space: nowrap;" ksh 07-30 -->
								<a href="javascript:;" class="btn-group" style="font-size:1rem"> <!-- style="padding: 9px 0 0;" 삭제해주세요  /  style="font-size:1.5rem" ksh 07-30 -->
									새로고침
									<i class="ti-reload" style="padding: 3px 4px 0 8px;"></i>
								</a>
								<a href="/management/login/join"><button>asdasdasd</button></a>
							</span>
						</h2>
					</div> <!-- div 추가  ksh 07-30 -->
					<div class="d-flex align-items-center mb-2 mt-4">
						<h2 class="mb-0 display-5">
							<i class="icon-user-following text-info"> </i>
						</h2>
						<div class="ml-auto">
							<h2 class="mb-0display-6" style="font-size: 2.500rem">
								<span class="font-normal" id="countComplete"></span>
							</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-4">  <!-- col-sm-4  ksh 07-30 -->
			<div class="card cursorHand">
				<div class="card-body">
					<div class="col-12 pr-0 pl-0">
					<h4 class="card-title text-uppercase col-8 pr-0 pl-0 inline-block" style="font-size: 2.500rem;white-space: nowrap;">검진 일자</h4>
					</div>
					<div class="d-flex align-items-center mb-2 mt-4">
						<h2 class="mb-0 display-5">
							<span class="text-cyan display-6">
								<i class="ti-clipboard"> </i>
							</span>
						</h2>
						<div class="ml-auto">
							<h2 class="mb-0display-6" style="font-size: 2rem">
								<span class="font-normal" id="countComplete"></span>
							</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$( document ).ready( function(){
		map_init();
		
		$("#map").on("click", function () {
			
			$.ajax( {
				 			url : '/management/map/test' ,
				 			type : 'get' ,
				 			
				 			success : function( data )
				 			{
				 				console.log( data );
				 			} 
				 		} );
	    });
		
	})
	
	var map_init = function(){
		var map = new ol.Map({
	        target: 'map',
	        layers: [
	          new ol.layer.Tile({
	            source: new ol.source.OSM()
	          })
	        ],
	        view: new ol.View({
	          center: ol.proj.fromLonLat([128.872892, 35.226924]),
	          zoom: 15
	        })
			
	      });
		
		map.addLayer(placeMarkerLayer);            //전체 마커 그리기
		addMarker(
	             1
	             , 128.872892
	             , 35.226924
	             , {} 
	             , defaultStyle(PointGpsMarker
	                   , defaultTextStyle("", 13, "12px"))
	             , placeMarkerSource
	             );
		
	};
	
      
	//gps 마커 소스 및 레이어
	var placeMarkerSource = new ol.source.Vector(),
	placeMarkerLayer = new ol.layer.Vector({id: "placeMarkerLayer", source: placeMarkerSource});
      
	
	//지도에 마커 표시
	var addMarker = function(ID, LON, LAT, markerData, markerStyle, source){
	    var marker = new ol.Feature();
	    var point = ol.proj.fromLonLat([LON*1, LAT*1]);
	    marker.setId(ID);
	    marker.data = markerData;
	    marker.setStyle(markerStyle);
	    source.addFeature(marker);
	    marker.setGeometry(new ol.geom.Point(point));
	};
	
	var defaultTextStyle = function(text, offsetY, fontStyle){
		return textStyle(text, offsetY, fontStyle, '#000000', '#FFFFFF');
	};
	
	var createMarker = function(radius, fillColor, strokeColor, strokeWidth, type){
		if(type == 'circle')
			return new ol.style.Circle({
			    radius: radius,
			    fill: fillStyle(fillColor),
			    stroke : strokeStyle(strokeColor, strokeWidth, 0) 
			  });
		else if(type == 'regularShape')
			return new ol.style.RegularShape({
			    radius: radius,
			    fill: fillStyle(fillColor),
			    stroke : strokeStyle(strokeColor, strokeWidth, 0)
			  });
	};
	
	var fillStyle = function(fillColor){
		return new ol.style.Fill({
		    color: fillColor,
	    });
	};

	var strokeStyle = function(strokeColor, strokeWidth, strokeOpacity){
		return new ol.style.Stroke({
			color: strokeColor,
			width: strokeWidth,
			opacity: strokeOpacity
		});
	};

	var defaultStyle = function(imageStyle, textStyle){
		return new ol.style.Style({
	        image: imageStyle
	        , text: textStyle
	        });
	};

    
	var circleMarker = function(radius, fillColor, strokeColor, strokeWidth){
		return createMarker(radius, fillColor, strokeColor, strokeWidth, 'circle');
	};
	
	var PointGpsMarker   = circleMarker(10, '#2F9D27', '#FFFFFF', 0);                            //정위치도착여부에서 사용됨
	
	var defaultTextStyle2 = function(text, offsetY, fontStyle){
		return textStyle(text, offsetY, fontStyle, '#0100FF', '#0100FF');
	};
	
	var textStyle = function(text, offsetY, fontStyle, fontColor, fontStrokeColor,scale){
		return new ol.style.Text({
	        text: text,
	                // 텍스트 색상 설정
	                fill: fillStyle(fontColor),
	                // 텍스트 halo 스타일 설정
	                stroke : strokeStyle(fontStrokeColor, 1, 0),
	                // 텍스트 Font 설정
	                font: fontStyle,
	                // 텍스트 Y축 offset 값 설정
	                offsetY: offsetY,
	                scale: scale
	            });
	};
	
    </script>
</body>
