
// gps 마커 소스 및 레이어
    let placeMarkerSource = new ol.source.Vector(),
        placeMarkerLayer = new ol.layer.Vector({id: "placeMarkerLayer", source: placeMarkerSource});

    // 지도에 마커 표시
    const addMarker = function (ID, LON, LAT, markerData, markerStyle, source) {
        const marker = new ol.Feature();
        const point = ol.proj.fromLonLat([LON * 1, LAT * 1]);
        marker.setId(ID);
        marker.data = markerData;
        marker.setStyle(markerStyle);
        source.addFeature(marker);
        marker.setGeometry(new ol.geom.Point(point));
    };

    var defaultTextStyle = function (text, offsetY, fontStyle) {
        return textStyle(text, offsetY, fontStyle, '#000000', '#FFFFFF');
    };

    var createMarker = function (radius, fillColor, strokeColor, strokeWidth, type) {
        if (type == 'circle')
            return new ol.style.Circle({
                radius: radius,
                fill: fillStyle(fillColor),
                stroke: strokeStyle(strokeColor, strokeWidth, 0)
            });
        else if (type == 'regularShape')
            return new ol.style.RegularShape({
                radius: radius,
                fill: fillStyle(fillColor),
                stroke: strokeStyle(strokeColor, strokeWidth, 0)
            });
    };

    var fillStyle = function (fillColor) {
        return new ol.style.Fill({
            color: fillColor,
        });
    };

    var strokeStyle = function (strokeColor, strokeWidth, strokeOpacity) {
        return new ol.style.Stroke({
            color: strokeColor,
            width: strokeWidth,
            opacity: strokeOpacity
        });
    };

    var defaultStyle = function (imageStyle, textStyle) {
        return new ol.style.Style({
            image: imageStyle
            , text: textStyle
        });
    };


    var circleMarker = function (radius, fillColor, strokeColor, strokeWidth) {
        return createMarker(radius, fillColor, strokeColor, strokeWidth, 'circle');
    };

    var PointGpsMarker = circleMarker(10, '#2F9D27', '#FFFFFF', 0);                            //정위치도착여부에서 사용됨

    var defaultTextStyle2 = function (text, offsetY, fontStyle) {
        return textStyle(text, offsetY, fontStyle, '#0100FF', '#0100FF');
    };

    var textStyle = function (text, offsetY, fontStyle, fontColor, fontStrokeColor, scale) {
        return new ol.style.Text({
            text: text,
            // 텍스트 색상 설정
            fill: fillStyle(fontColor),
            // 텍스트 halo 스타일 설정
            stroke: strokeStyle(fontStrokeColor, 1, 0),
            // 텍스트 Font 설정
            font: fontStyle,
            // 텍스트 Y축 offset 값 설정
            offsetY: offsetY,
            scale: scale
        });
    };

    //위경도 받아서 맵 가운데 표시
    function CenterMap(lat, lng) { 
        map.setView(new ol.View({
            center: ol.proj.fromLonLat([lng, lat]),
            zoom: 13
        }));
    }