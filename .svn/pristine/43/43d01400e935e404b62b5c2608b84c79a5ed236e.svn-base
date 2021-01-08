/*  Amchart 테마 설정  */

	/* -- theme_01 --*/
	//  Light(basic) + Legend (유/무)+ Scrollbar(유/무)   
	//  Line, Area, Column, Bar, Value(오른쪽축), Pie, Gauge 
	//  배경 단색

	/* -- theme_02 --*/
	//  Light(basic) + Legend (유/무)+ Scrollbar(유/무)   
	//  Line, Area, Column, Bar, Value(오른쪽축)
	//  배경 줄무늬

	/* -- theme_03 --*/
	//  Light(basic) + Legend (유/무)+ Scrollbar(유/무)   
	//  Line, Area, Column, Bar, Value(오른쪽축)
	//  배경색 투명 
	//  x,y축 숨기기

	/* -- theme_04 --*/
	//  Area - Gradient Fill  (Single Data)                           

	/* -- theme_05 --*/
	//  Dark(basic) + Legend (유/무)+ Scrollbar(유/무) 
	//  Line, Area, Column, Bar, Value(오른쪽축), Pie, Gauge  
	//  배경색 단색   

	/* -- theme_06 --*/
	//  Dark(basic) + Legend (유/무)+ Scrollbar(유/무) 
	//  Column, Bar
	//  배경색 단색 
	//  x,y축 숨기기

	/* -- theme_07 --*/
	//  Micro chart (line, bar, pie)



/* -- theme_01 --*/
AmCharts.themes.theme_01 = {
	themeName: "theme_01",
	AmChart: {
		color: "#000000", // x,y축 텍스트컬러
		backgroundAlpha: 0,
		backgroundColor:"#FFFFFF"
	},
	AmCoordinateChart: {
		colors: ["#fd625e","#50c14e","#feea66","#87d0f1","#7d7e7e","#515a5a"] // graph color
	},
	AmSerialChart: {
		plotAreaFillAlphas:1,
		plotAreaFillColors:"#f7f8fa", // x,y안쪽 영역 배경컬러
		//plotAreaBorderAlpha: 1,
		//plotAreaBorderColor: "#555555", // 그래프 영역 Border 컬러
		autoMargins:true,
		autoMarginOffset:10,
		marginTop: 25, //autoMargins:true 일때도 설정 가능
		marginRight: 25, //autoMargins:true 일때도 설정 가능
		//marginBottom: 35, //autoMargins:true 일때는 개별 설정 안됨
		//marginLeft: 50, //autoMargins:true 일때는 개별 설정 안됨
		startDuration: 0.2, //애니메이션 속도
		startEffect: "elastic" //애니메이션 스타일
		//sequencedAnimation: false //애니메이션 없음
	},
	AxisBase: { //x축, y축, grid style
		fontSize: 10,
		axisColor: "#000000", // x,y축 line color
		axisAlpha: 1,
		gridColor: "#E7E7E7", // line color
		gridAlpha: 1,
		tickLength: 4,// label line 길이
		titleBold: false,
		titleColor: "#808080",
		titleFontSize : 11
	},
	CategoryAxis: { //x축
		autoWrap: true,//텍스트 행처리 auto
		gridPosition: "start",
		startOnAxis: true, // grid start 지점 지정
		equalSpacing: true, // grid start 지점 지정
		parseDates: true, // x축 date-related에 의한 정의 줄임
		boldPeriodBeginning: false,
		minHorizontalGap: 50, // minimum cell width
		gridAlpha: 0,
		labelOffset: -2,
		tickPosition: "start", //colum 차트 tick 지정
		tickLength: 5 // label line 길이
	},
	ValueAxis: { //y축
		dashLength: 3 // line dash
	},
	ChartScrollbar: {
		dragIcon: "dragIconRectBig", //드래그 아이콘 모양 변경 "dragIconRoundBig"//드래그 아이콘 모양 변경
		dragIconHeight: 30,
		dragIconWidth: 30,
		scrollbarHeight: 10,
		backgroundColor: "#d4d4d4"
	},
	ChartCursor: {
		cursorColor: "#000000",//마우스 오버시 세로 라인&selection 컬러
		color: "#FFFFFF",
		cursorAlpha: 0.5, //세로 라인
		selectionAlpha: 0.1
	},
	AmBalloon: {
		borderThickness: 1.5,
		fillAlpha: 1,
		shadowAlpha: 0, // shadow 디폴트 값없애기
		//fontSize: 11,
		//horizontalPadding: 10,
		verticalPadding: 1	
	},
	AmLegend: {
		align: "right",
		autoMargins: false, 
		marginTop: -10,
		color: "#808080",
		markerSize: 10,
		markerType: "circle",
		spacing: 35,
		equalWidths: false,
		valueText: ""
		//valueAlign: "left",
		//switchColor:"#000000"
	},
	AmGraph: { //"graphs"속성 설정
		lineThickness: 1.2,  // line graph 두깨
		lineAlpha: 1,  // line graph 투명도
		columnWidth: 0.4 //%
	},
	AmPieChart: {
		colors: ["#12b3a5", "#f65177", "#7d7e7e"],
		radius: "30%",
		innerRadius: "70%",
		labelRadius: 15,
		labelTickColor: "#555555",
		color: "#808080",
		fontSize: 11,
		pullOutOnlyOne: true
	},
	AmAngularGauge: {
		adjustSize: false,
		gaugeY: 150,// 전체 div height사이즈 대비 y 위치 지정
		color: "#808080",
		marginTop: 20 //전체 div에서 gauge 사이즈 줄이기
	},
	GaugeArrow: {
		color: "#2d344c",
		borderAlpha: 0,
		nailRadius: 10,
		radius: "55%", //바늘 길이
		startWidth: 19
	},
	GaugeAxis: {
		axisAlpha: 0,
		endAngle: 90,
		endValue: 112,
		fontSize: 10,
		inside: false, //텍스트 원 밖으로
		labelOffset: 8,
		labelsEnabled: false, //텍스트 숨기기
		minorTickLength: 72, //원두깨
		startAngle: -90,
		startValue: 10, //시작값이 0이 아닐때 값 지정
		tickAlpha: 0,
		tickThickness: 0,
	},
	AmRectangularChart : {
		zoomOutButtonColor: "#e5e5e5",
		zoomOutButtonRollOverAlpha: 0.5,
		zoomOutButtonImageSize: 15
	},
	Label:{//기타 텍스트 정보를 삽입
		color: "#AAB3B3", //텍스트컬러
		size: 1
	}
};

/* -- theme_02 --*/
AmCharts.themes.theme_02 = {
	themeName: "theme_02",
	AmChart: {
		color: "#555555" // x,y축 텍스트컬러
		//backgroundAlpha: 0,
		//backgroundColor:"#FFFFFF"
	},
	AmCoordinateChart: {
		colors: ["#50dc35", "#f3800f", "#ffc000", "#40b5ff", "#2579ce", "#bc73ef", "#f875de", "#bcbcbc"] // graph color
	},
	AmSerialChart: {
		//plotAreaFillAlphas:1,
		//plotAreaFillColors:"#FFFFFF", // x,y안쪽 영역 배경컬러
		autoMargins:true,
		autoMarginOffset:10,
		marginTop: 25, //autoMargins:true 일때도 설정 가능
		marginRight: 25, //autoMargins:true 일때도 설정 가능
		//marginBottom: 35, //autoMargins:true 일때는 개별 설정 안됨
		//marginLeft: 50, //autoMargins:true 일때는 개별 설정 안됨
		startDuration: 0.2, //애니메이션 속도
		startEffect: "elastic" //애니메이션 스타일
	},
	AxisBase: { //x축, y축, grid style
		fontSize: 11,
		axisColor: "#555555", // x,y축 line color
		axisAlpha: 1,
		//gridColor: "#00000", // line color
		gridAlpha: 0,
		labelOffset: 2,
		tickLength: 0,// label line 길이
		titleBold: false,
		titleColor: "#808080",
		titleFontSize : 11
	},
	CategoryAxis: { //x축
		autoWrap: true,//텍스트 행처리 auto
		gridPosition: "start",
		startOnAxis: true, // grid start 지점 지정
		equalSpacing: true, // grid start 지점 지정
		parseDates: true, // x축 date-related에 의한 정의 줄임
		boldPeriodBeginning: false,
		minHorizontalGap: 50, // minimum cell width
		gridAlpha: 0,
		labelOffset: 0,
		tickPosition: "start", //colum 차트 tick 지정
		tickLength: 0 // label line 길이
	},
	ValueAxis: { //y축
		fillColor: "#eceff3",
		fillAlpha: 1
	},
	ChartScrollbar: {
		dragIcon: "dragIconRectSmall", //드래그 아이콘 모양 변경 "dragIconRoundBig"//드래그 아이콘 모양 변경
		dragIconHeight: 20,
		dragIconWidth: 18,
		scrollbarHeight: 6,
		backgroundColor: "#d4d4d4"
	},
	ChartCursor: {
		cursorColor: "#cc0000",//마우스 오버시 세로 라인&selection 컬러
		color: "#FFFFFF",
		cursorAlpha: 0.5, //세로 라인
		selectionAlpha: 0.1
	},
	AmBalloon: {
		adjustBorderColor: false,
		color: "#FFFFFF",
		borderThickness: 0,
		fillAlpha: 1,
		//shadowAlpha: 0, // shadow 디폴트 값없애기
		//fontSize: 11,
		//horizontalPadding: 10,
		verticalPadding: 4	
	},
	AmLegend: {
		align: "right",
		autoMargins: false, 
		marginTop: -10,
		color: "#808080",
		markerSize: 10,
		markerType: "square",
		spacing: 35,
		equalWidths: false,
		valueText: ""
	},
	AmGraph: { //"graphs"속성 설정
		lineThickness: 1.2,  // line graph 두깨
		lineAlpha: 1,  // line graph 투명도
		columnWidth: 0.3 //%
	},
	AmPieChart: {
		colors: ["#12b3a5", "#f65177", "#7d7e7e"],
		radius: "30%",
		innerRadius: "70%",
		labelRadius: 15,
		labelTickColor: "#555555",
		color: "#808080",
		fontSize: 11,
		pullOutOnlyOne: true
	},
	AmAngularGauge: {
		adjustSize: false,
		gaugeY: 150,// 전체 div height사이즈 대비 y 위치 지정
		color: "#808080",
		marginTop: 20 //전체 div에서 gauge 사이즈 줄이기
	},
	GaugeArrow: {
		color: "#2d344c",
		borderAlpha: 0,
		nailRadius: 10,
		radius: "55%", //바늘 길이
		startWidth: 19
	},
	GaugeAxis: {
		axisAlpha: 0,
		endAngle: 90,
		endValue: 112,
		fontSize: 10,
		inside: false, //텍스트 원 밖으로
		labelOffset: 8,
		labelsEnabled: false, //텍스트 숨기기
		minorTickLength: 72, //원두깨
		startAngle: -90,
		startValue: 10, //시작값이 0이 아닐때 값 지정
		tickAlpha: 0,
		tickThickness: 0,
	},
	AmRectangularChart : {
		zoomOutButtonColor: "#e5e5e5",
		zoomOutButtonRollOverAlpha: 0.5,
		zoomOutButtonImageSize: 15
	},
	Label:{//기타 텍스트 정보를 삽입
		color: "#AAB3B3", //텍스트컬러
		size: 1
	}
};

/* -- theme_03 --*/
AmCharts.themes.theme_03 = {
	themeName: "theme_03",
	AmChart: {
		color: "#000000", // x,y축 텍스트컬러
		//backgroundAlpha: 0,
		//backgroundColor:"#FFFFFF"
	},
	AmCoordinateChart: {
		colors: ["#fd625e","#50c14e","#feea66","#87d0f1","#7d7e7e","#515a5a"] // graph color
	},
	AmSerialChart: {
		//plotAreaFillAlphas:1,
		//plotAreaFillColors:"#FFFFFF", // x,y안쪽 영역 배경컬러
		//plotAreaBorderAlpha: 1,
		//plotAreaBorderColor: "#555555", // 그래프 영역 Border 컬러
		autoMargins:true,
		autoMarginOffset:10,
		marginTop: 25, //autoMargins:true 일때도 설정 가능
		marginRight: 25, //autoMargins:true 일때도 설정 가능
		//marginBottom: 35, //autoMargins:true 일때는 개별 설정 안됨
		//marginLeft: 50, //autoMargins:true 일때는 개별 설정 안됨
		startDuration: 0.2, //애니메이션 속도
		startEffect: "elastic" //애니메이션 스타일
	},
	AxisBase: { //x축, y축, grid style
		fontSize: 10,
		axisColor: "#babbbf", // x,y축 line color
		axisAlpha: 0,
		//gridColor: "#E7E7E7", // line color
		gridAlpha: 0,
		labelOffset: 2,
		tickLength: 0,// label line 길이
		titleBold: false,
		titleColor: "#808080",
		titleFontSize : 11
	},
	CategoryAxis: { //x축
		autoWrap: true,//텍스트 행처리 auto
		gridPosition: "start",
		startOnAxis: true, // grid start 지점 지정
		equalSpacing: true, // grid start 지점 지정
		parseDates: true, // x축 date-related에 의한 정의 줄임
		boldPeriodBeginning: false,
		minHorizontalGap: 50, // minimum cell width
		axisAlpha: 1,
		gridAlpha: 0,
		labelOffset: 0,
		tickPosition: "start", //colum 차트 tick 지정
		tickLength: 0 // label line 길이
	},
	ValueAxis: { //y축
		labelsEnabled: false //텍스트 숨기기
	},
	ChartScrollbar: {
		dragIcon: "dragIconRectBig", //드래그 아이콘 모양 변경 "dragIconRoundBig"//드래그 아이콘 모양 변경
		dragIconHeight: 30,
		dragIconWidth: 30,
		scrollbarHeight: 10,
		backgroundColor: "#d4d4d4"
	},
	ChartCursor: {
		cursorColor: "#000000",//마우스 오버시 세로 라인&selection 컬러
		color: "#FFFFFF",
		cursorAlpha: 0.5, //세로 라인
		selectionAlpha: 0.1
	},
	AmBalloon: {
		borderThickness: 1.5,
		fillAlpha: 1,
		shadowAlpha: 0, // shadow 디폴트 값없애기
		//fontSize: 11,
		//horizontalPadding: 10,
		verticalPadding: 1	
	},
	AmLegend: {
		align: "right",
		autoMargins: false, 
		marginTop: -10,
		color: "#808080",
		markerSize: 10,
		markerType: "circle",
		spacing: 35,
		equalWidths: false,
		valueText: ""
		//valueAlign: "left",
		//switchColor:"#000000"
	},
	AmGraph: { //"graphs"속성 설정
		lineThickness: 1.2,  // line graph 두깨
		lineAlpha: 1,  // line graph 투명도
		columnWidth: 0.4 //%
	},
	AmPieChart: {
		colors: ["#12b3a5", "#f65177", "#7d7e7e"],
		radius: "30%",
		innerRadius: "70%",
		labelRadius: 15,
		labelTickColor: "#555555",
		color: "#808080",
		fontSize: 11,
		pullOutOnlyOne: true
	},
	AmAngularGauge: {
		adjustSize: false,
		gaugeY: 150,// 전체 div height사이즈 대비 y 위치 지정
		color: "#808080",
		marginTop: 20 //전체 div에서 gauge 사이즈 줄이기
	},
	GaugeArrow: {
		color: "#2d344c",
		borderAlpha: 0,
		nailRadius: 10,
		radius: "55%", //바늘 길이
		startWidth: 19
	},
	GaugeAxis: {
		axisAlpha: 0,
		endAngle: 90,
		endValue: 112,
		fontSize: 10,
		inside: false, //텍스트 원 밖으로
		labelOffset: 8,
		labelsEnabled: false, //텍스트 숨기기
		minorTickLength: 72, //원두깨
		startAngle: -90,
		startValue: 10, //시작값이 0이 아닐때 값 지정
		tickAlpha: 0,
		tickThickness: 0,
	},
	AmRectangularChart : {
		zoomOutButtonColor: "#e5e5e5",
		zoomOutButtonRollOverAlpha: 0.5,
		zoomOutButtonImageSize: 15
	},
	Label:{//기타 텍스트 정보를 삽입
		color: "#AAB3B3", //텍스트컬러
		size: 1
	}
};

/* -- theme_04 --*/
AmCharts.themes.theme_04 = {
	themeName: "theme_04",
	AmChart: {
		color: "#000000", // x,y축 텍스트컬러
		//backgroundAlpha: 0,
		//backgroundColor:"#FFFFFF"
	},
	AmCoordinateChart: {
		colors: ["#0d0d0d"], // graph color
		patterns:[
		{"url":"themes/theme_04/pattern1.png", "width":4, "height":250} //png 이미지 사이즈와 색 수정 필요! 
		]
	},
	AmSerialChart: {
		//plotAreaFillAlphas:1,
		//plotAreaFillColors:"#FFFFFF", // x,y안쪽 영역 배경컬러
		autoMargins:true,
		autoMarginOffset:0,
		marginTop: 0, //autoMargins:true 일때도 설정 가능
		marginRight: 0, //autoMargins:true 일때도 설정 가능
		//startDuration: 0.2, //애니메이션 속도
		//startEffect: "elastic" //애니메이션 스타일
		sequencedAnimation: false //애니메이션 없음
	},
	AxisBase: { //x축, y축, grid style
		axisThickness: 0,
		axisAlpha: 0,
		gridAlpha: 0,
		labelsEnabled: false,
		titleBold: false,
		titleColor: "#808080",
		titleFontSize : 11
	},
	CategoryAxis: { //x축
		startOnAxis: true, // grid start 지점 지정
		axisAlpha: 0,
		gridAlpha: 0
	},
	ChartScrollbar: {
		dragIcon: "dragIconRectBig", //드래그 아이콘 모양 변경 "dragIconRoundBig"//드래그 아이콘 모양 변경
		dragIconHeight: 30,
		dragIconWidth: 30,
		scrollbarHeight: 10,
		backgroundColor: "#d4d4d4"
	},
	ChartCursor: {
		cursorColor: "#000000",//마우스 오버시 세로 라인&selection 컬러
		categoryBalloonEnabled: false,
		color: "#FFFFFF",
		cursorAlpha: 0.5, //세로 라인
		selectionAlpha: 0.1,
		//zoomable: false
	},
	AmBalloon: {
		color: "#FFFFFF",
		borderThickness: 0,
		fillAlpha: 1,
		fillColor: "#37344d",
		shadowAlpha: 0, // shadow 디폴트 값없애기
		fontSize: 10,
		horizontalPadding: 6,
		verticalPadding: 4	
	},
	AmLegend: {
		align: "right",
		autoMargins: false, 
		marginTop: -10,
		color: "#808080",
		markerSize: 10,
		markerType: "circle",
		spacing: 35,
		equalWidths: false,
		valueText: ""
		//valueAlign: "left",
		//switchColor:"#000000"
	},
	AmGraph: { //"graphs"속성 설정
		lineThickness: 1.2,  // line graph 두깨
		lineAlpha: 1,  // line graph 투명도
	},
	AmRectangularChart : {
		zoomOutButtonColor: "#e5e5e5",
		zoomOutButtonRollOverAlpha: 0.5,
		zoomOutButtonImageSize: 15
	},
	Label:{//기타 텍스트 정보를 삽입
		color: "#AAB3B3", //텍스트컬러
		size: 1
	}
};

/* -- theme_05 --*/
AmCharts.themes.theme_05 = {
	themeName: "theme_05",
	AmChart: {
		color: "#878AA1", // x,y축 텍스트컬러
		//backgroundAlpha: 1,
		//backgroundColor:"#2d344c"
	},
	AmCoordinateChart: {
		colors: ["#0087FA", "#9A35D1","#FEEA66","#F65177","#7D7E7E","#515A5A"] // graph color
	},
	AmSerialChart: {
		//plotAreaFillAlphas:0,
		//plotAreaFillColors:"#FFFFFF", // x,y안쪽 영역 배경컬러
		plotAreaBorderAlpha: 1,
		plotAreaBorderColor: "#43495f", // 그래프 영역 Border 컬러
		autoMargins:true,
		autoMarginOffset:20,
		marginTop: 30, //autoMargins:true 일때도 설정 가능
		marginRight: 35, //autoMargins:true 일때도 설정 가능
		//marginBottom: 35, //autoMargins:true 일때는 개별 설정 안됨
		//marginLeft: 50, //autoMargins:true 일때는 개별 설정 안됨
		startDuration: 0.2, //애니메이션 속도
		startEffect: "elastic" //애니메이션 스타일
		//sequencedAnimation: false //애니메이션 없음
	},
	AxisBase: { //x축, y축, grid style
		fontSize: 10,
		axisColor: "#43495f", // x,y축 line color
		axisAlpha: 1,
		gridColor: "#43495f", // line color
		gridAlpha: 1,
		tickLength: 0,// label line 길이
		labelOffset:4,
		titleBold: false,
		titleColor: "#878AA1",
		titleFontSize : 10
	},
	CategoryAxis: { //x축
		autoWrap: true,//텍스트 행처리 auto
		gridPosition: "start",
		startOnAxis: true, // grid start 지점 지정
		equalSpacing: true, // grid start 지점 지정
		parseDates: true, // x축 date-related에 의한 정의 줄임
		boldPeriodBeginning: false,
		minHorizontalGap: 50, // minimum cell width
		gridAlpha: 0,
		labelOffset: 0,
		tickPosition: "start" //colum 차트 tick 지정
		//tickLength: 5 // label line 길이
	},
	ValueAxis: { //y축
		//dashLength: 3 // line dash
	},
	ChartScrollbar: {
		dragIcon: "dragIconRoundBig", //드래그 아이콘 모양 변경 "dragIconRoundBig"//드래그 아이콘 모양 변경
		dragIconHeight: 26,
		dragIconWidth: 26,
		scrollbarHeight: 8,
		backgroundAlpha: 0.2,
		backgroundColor: "#000000",
		selectedBackgroundColor: "#43495f"
	},
	ChartCursor: {
		//cursorColor: "#000000",//마우스 오버시 세로 라인&selection 컬러
		color: "#FFFFFF",
		//cursorAlpha: 0.5, //세로 라인,
		categoryBalloonColor: "#9400D3",
		selectionAlpha: 0.1
	},
	AmBalloon: {
		borderThickness: 1.5,
		fillAlpha: 1,
		shadowAlpha: 0, // shadow 디폴트 값없애기
		//fontSize: 11,
		//horizontalPadding: 10,
		verticalPadding: 1	
	},
	AmLegend: {
		align: "center",
		autoMargins: false, 
		marginTop: -12,
		marginBottom:12,
		color: "#AAB3B3",
		markerSize: 10,
		markerType: "circle",
		markerDisabledColor: "#666666",
		spacing: 35,
		equalWidths: false,
		valueText: ""
		//valueAlign: "left",
		//switchColor:"#000000"
	},
	AmGraph: { //"graphs"속성 설정
		lineThickness: 1.2,  // line graph 두깨
		lineAlpha: 1,  // line graph 투명도
		type: "smoothedLine",
		columnWidth: 0.4 //%
	},
	AmPieChart: {
		colors: ["#12b3a5", "#f65177", "#7d7e7e"],
		radius: "30%",
		innerRadius: "70%",
		labelRadius: 15,
		labelTickColor: "#555555",
		color: "#808080",
		fontSize: 11,
		pullOutOnlyOne: true
	},
	AmAngularGauge: {
		adjustSize: false,
		gaugeY: 150,// 전체 div height사이즈 대비 y 위치 지정
		color: "#808080",
		marginTop: 20 //전체 div에서 gauge 사이즈 줄이기
	},
	GaugeArrow: {
		color: "#FFFFFF",
		borderAlpha: 0,
		nailRadius: 10,
		radius: "55%", //바늘 길이
		startWidth: 19
	},
	GaugeAxis: {
		axisAlpha: 0,
		endAngle: 90,
		endValue: 112,
		fontSize: 10,
		inside: false, //텍스트 원 밖으로
		labelOffset: 8,
		labelsEnabled: false, //텍스트 숨기기
		minorTickLength: 72, //원두깨
		startAngle: -90,
		startValue: 10, //시작값이 0이 아닐때 값 지정
		tickAlpha: 0,
		tickThickness: 0,
	},
	AmRectangularChart : {
		zoomOutButtonColor: "#000000",
		zoomOutButtonRollOverAlpha: 0.2,
		zoomOutButtonImage: "lensWhite",
		zoomOutButtonImageSize: 15
	},
	Label:{//기타 텍스트 정보를 삽입
		color: "#878AA1", //텍스트컬러
		size: 1
	}
};

/* -- theme_06 --*/
AmCharts.themes.theme_06 = {
	themeName: "theme_06",
	AmChart: {
		color: "#878AA1", // x,y축 텍스트컬러
		//backgroundAlpha: 1,
		//backgroundColor:"#2d344c"
	},
	AmCoordinateChart: {
		colors: ["#0087FA", "#9A35D1","#FEEA66","#F65177","#7D7E7E","#515A5A"] // graph color
	},
	AmSerialChart: {
		//plotAreaFillAlphas:0,
		//plotAreaFillColors:"#FFFFFF", // x,y안쪽 영역 배경컬러
		//plotAreaBorderAlpha: 1,
		//plotAreaBorderColor: "#43495f", // 그래프 영역 Border 컬러
		autoMargins:true,
		autoMarginOffset:20,
		marginTop: 10, //autoMargins:true 일때도 설정 가능
		marginRight: 35, //autoMargins:true 일때도 설정 가능
		//marginBottom: 35, //autoMargins:true 일때는 개별 설정 안됨
		//marginLeft: 50, //autoMargins:true 일때는 개별 설정 안됨
		startDuration: 0.2, //애니메이션 속도
		startEffect: "elastic" //애니메이션 스타일
		//sequencedAnimation: false //애니메이션 없음
	},
	AxisBase: { //x축, y축, grid style
		fontSize: 10,
		axisColor: "#43495f", // x,y축 line color
		axisAlpha: 0,
		gridColor: "#43495f", // line color
		gridAlpha: 0,
		tickLength: 0,// label line 길이
		labelOffset:4,
		titleBold: false,
		titleColor: "#878AA1",
		titleFontSize : 10
	},
	CategoryAxis: { //x축
		autoWrap: true,//텍스트 행처리 auto
		gridPosition: "start",
		startOnAxis: true, // grid start 지점 지정
		equalSpacing: true, // grid start 지점 지정
		parseDates: true, // x축 date-related에 의한 정의 줄임
		boldPeriodBeginning: false,
		minHorizontalGap: 50, // minimum cell width
		gridAlpha: 0,
		//labelOffset: 0,
		tickPosition: "start" //colum 차트 tick 지정
		//tickLength: 5 // label line 길이
	},
	ValueAxis: { //y축
		//dashLength: 3 // line dash
	},
	ChartScrollbar: {
		dragIcon: "dragIconRoundBig", //드래그 아이콘 모양 변경 "dragIconRoundBig"//드래그 아이콘 모양 변경
		dragIconHeight: 26,
		dragIconWidth: 26,
		scrollbarHeight: 8,
		backgroundAlpha: 0.2,
		backgroundColor: "#000000",
		selectedBackgroundColor: "#43495f"
	},
	ChartCursor: {
		//cursorColor: "#000000",//마우스 오버시 세로 라인&selection 컬러
		color: "#FFFFFF",
		//cursorAlpha: 0.5, //세로 라인,
		//categoryBalloonColor: "#9400D3",
		selectionAlpha: 0.1
	},
	AmBalloon: {
		borderThickness: 1.5,
		fillAlpha: 1,
		shadowAlpha: 0, // shadow 디폴트 값없애기
		//fontSize: 11,
		//horizontalPadding: 10,
		verticalPadding: 1	
	},
	AmLegend: {
		align: "right",
		position: "top",
		autoMargins: false, 
		marginBottom:-10,
		color: "#AAB3B3",
		markerSize: 10,
		markerType: "circle",
		markerDisabledColor: "#666666",
		spacing: 35,
		equalWidths: false,
		valueText: ""
		//valueAlign: "left",
		//switchColor:"#000000"
	},
	AmGraph: { //"graphs"속성 설정
		lineThickness: 1.2,  // line graph 두깨
		lineAlpha: 1,  // line graph 투명도
		type: "smoothedLine",
		columnWidth: 0.4 //%
	},
	AmPieChart: {
		colors: ["#12b3a5", "#f65177", "#7d7e7e"],
		radius: "30%",
		innerRadius: "70%",
		labelRadius: 15,
		labelTickColor: "#555555",
		color: "#808080",
		fontSize: 11,
		pullOutOnlyOne: true
	},
	AmAngularGauge: {
		adjustSize: false,
		gaugeY: 150,// 전체 div height사이즈 대비 y 위치 지정
		color: "#808080",
		marginTop: 20 //전체 div에서 gauge 사이즈 줄이기
	},
	GaugeArrow: {
		color: "#FFFFFF",
		borderAlpha: 0,
		nailRadius: 10,
		radius: "55%", //바늘 길이
		startWidth: 19
	},
	GaugeAxis: {
		axisAlpha: 0,
		endAngle: 90,
		endValue: 112,
		fontSize: 10,
		inside: false, //텍스트 원 밖으로
		labelOffset: 8,
		labelsEnabled: false, //텍스트 숨기기
		minorTickLength: 72, //원두깨
		startAngle: -90,
		startValue: 10, //시작값이 0이 아닐때 값 지정
		tickAlpha: 0,
		tickThickness: 0,
	},
	AmRectangularChart : {
		zoomOutButtonColor: "#000000",
		zoomOutButtonRollOverAlpha: 0.2,
		zoomOutButtonImage: "lensWhite",
		zoomOutButtonImageSize: 15
	},
	Label:{//기타 텍스트 정보를 삽입
		color: "#878AA1", //텍스트컬러
		size: 1
	}
};

/* -- theme_07 --*/
AmCharts.themes.theme_07 = {
	themeName: "theme_07",
	AmCoordinateChart: {
		colors: ["#fd625e","#50c14e","#feea66","#87d0f1","#7d7e7e","#515a5a"] // graph color
	},
	AmSerialChart: {
		autoMargins:true,
		autoMarginOffset:0,
		marginTop: 0, //autoMargins:true 일때도 설정 가능
		marginRight: 0 //autoMargins:true 일때도 설정 가능
	},
	AxisBase: { //x축, y축, grid style
		axisThickness: 0,
		gridAlpha: 0,
		tickLength: 0,
		labelsEnabled : false
	},
	ChartScrollbar: {
		enabled: true
	},
	ChartCursor: {
		enabled: true
	},
	AmBalloon: {
		enabled: true	
	},
	AmLegend: {
		enabled: true
	},
	AmGraph: { //"graphs"속성 설정
		lineThickness: 1.2,  // line graph 두깨
		lineAlpha: 1,  // line graph 투명도
		columnWidth: 0.4, //%
		showBalloon: false //말풍선 숨기기
	},
	AmPieChart: {
		colors: ["#fd625e","#50c14e","#feea66","#87d0f1","#7d7e7e","#515a5a"],
		balloonText: "",
		innerRadius: "55%",
		labelsEnabled: false,
		startDuration: 0,
		pullOutRadius: "0", //클릭 동작 없음
		marginBottom: 4,
		marginTop: 4
	}
};