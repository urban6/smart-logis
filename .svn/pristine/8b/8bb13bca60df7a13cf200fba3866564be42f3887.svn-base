/*  Amchart 실행, 종류  설정  - html실행 id는 임시 아이디 생성하여 실행 됨   */

$(function() {

	/* --  .chart.theme_01.line_01  -- */
	// set temp_id
	var $chartType_line01 = $('.chart.theme_01.line_01');
	var $chartType_line01_array = [];
	for (var i = 0; i < $chartType_line01.length; i++) {
		$id = 'chartTempID_line1_' + (i + 1);
		$chartType_line01.eq(i).attr('id', $id);
		$chartType_line01_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_line01_array.length; i++) {
		AmCharts.makeChart($chartType_line01_array[i], {
			"type": "serial",
			"theme": "theme_01",
			"categoryField": "date", //date 챠트로 지정
			"colors": [
				"#90d18a",
				"#8a77c9",
				"#f17178",
				"#ffc168",
				"#66b7e0",
				"#6b7f9c"
			],
			"titles": [
				{
					"id": "Title-2",
					"text": "Title Name",
					"color": "#555555",
					"size": 11
				}
			],
			"color": "#777C80",
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"categoryAxis": {//x축
				"minPeriod": "mm", // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
				"gridThickness": 0,
				"labelOffset": -5
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1",
					"title": "byte",
					"dashLength": 5,
					"titleBold": false
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "JJ:NN", //x축 balloon 정보포맷 
				"categoryBalloonEnabled": false //x축 balloon 지우기
				//"zoomable": false //확대,축소 기능 삭제
			},
			"chartScrollbar": { //스크롤바 유,무
				"enabled": true
			},
			"allLabels": [//기타 텍스트 정보 삽입
				{
					"color": "#AAB3B3",
					"id": "unit",
					"size": 1,
					"text": "(%)", // 단위 같은 것을 기입
					"x": 14,
					"y": 20
				}
			],
			"legend": { //범례 유,무
				"horizontalGap": 10,
				//"maxColumns": 1,
				"position": "right",
				//"useGraphSettings": true,
				"markerSize": 10,
				"color": "#818181",
				"borderColor":"#000000",
				"markerType": "square"
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]:[[value]]", //풍선말 텍스트 정보
					"id": "AmGraph-1",
					"title": "SNMP",
					"valueField": "column-1",
					"lineThickness": 2
				}, 
				{
					"balloonText": "[[title]]:[[value]]",
					"id": "AmGraph-2",
					"title": "Interface Port",
					"valueField": "column-2",
					"lineThickness": 2
				}, 
				{
					"balloonText": "[[title]]:[[value]]",
					"id": "AmGraph-3",
					"title": "Traffic",
					"valueField": "column-3",
					"lineThickness": 2
				}, 
				{
					"balloonText": "[[title]]:[[value]]",
					"id": "AmGraph-4",
					"title": "CPU",
					"valueField": "column-4",
					"lineThickness": 2
				}, 
				{
					"balloonText": "[[title]]:[[value]]",
					"id": "AmGraph-5",
					"title": "Memory",
					"valueField": "column-5",
					"lineThickness": 2
				}, 
				{
					"balloonText": "[[title]]:[[value]]",
					"id": "AmGraph-6",
					"title": "Disk",
					"valueField": "column-6",
					"lineThickness": 2
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 28,
					"column-2": 25,
					"column-3": 23,
					"column-4": 33,
					"column-5": 20,
					"column-6": 20,
					"date": "07:51"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 42,
					"column-5": 70,
					"column-6": 50,
					"date": "07:52"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 27,
					"column-5": 30,
					"column-6": 20,
					"date": "07:53"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 47,
					"column-5": 40,
					"column-6": 30,
					"date": "07:54"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 45,
					"column-5": 20,
					"column-6": 50,
					"date": "07:55"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 45,
					"column-5": 30,
					"column-6": 20,
					"date": "07:56"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 14,
					"column-5": 70,
					"column-6": 50,
					"date": "07:57"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 17,
					"column-5": 30,
					"column-6": 20,
					"date": "07:58"
				}
			]
		});
	}

	/* --  .chart.theme_01.pie_01  -- */
	// set temp_id
	var $chartType_pie01 = $('.chart.theme_01.pie_01');
	var $chartType_pie01_array = [];
	for (var i = 0; i < $chartType_pie01.length; i++) {
		$id = 'chartTempID_pie1_' + (i + 1);
		$chartType_pie01.eq(i).attr('id', $id);
		$chartType_pie01_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_pie01_array.length; i++) {
		AmCharts.makeChart($chartType_pie01_array[i], {
			"type": "pie",
			"theme": "theme_01",
			"balloonText": "[[title]]<br><b>[[value]]</b><br>([[percents]]%)",
			"labelText": "[[title]]<br>[[percents]]%",
			"innerRadius": "80%",
			"marginTop": -10,
			"titleField": "category",
			"valueField": "column-1",
			"colors": [
				"#90d18a",
				"#8a77c9",
				"#f17178",
				"#ffc168",
				"#66b7e0",
				"#6b7f9c"
			],
			"color": "#777C80",
			"titles": [
				{
					"id": "Title-2",
					"text": "Title Name",
					"color": "#555555",
					"size": 11
				}
			],
			"dataProvider": [
				{
					"category": "Normal",
					"column-1": 356.9
				},
				{
					"category": "Error",
					"column-1": 131.1
				},
				{
					"category": "Unknown",
					"column-1": 115.8
				}
			]
		});
	}
	
	/* --  .chart.theme_01.gauge_01  -- */
	// set temp_id
	var $chartType_gauge01 = $('.chart.theme_01.gauge_01');
	var $chartType_gauge01_array = [];
	for (var i = 0; i < $chartType_gauge01.length; i++) {
		$id = 'chartTempID_gauge1_' + (i + 1);
		$chartType_gauge01.eq(i).attr('id', $id);
		$chartType_gauge01_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_gauge01_array.length; i++) {
		AmCharts.makeChart($chartType_gauge01_array[i], {
			"type": "gauge",
			"theme": "theme_01",
			"fontSize": 12,
			"arrows": [
				{
					"id": "GaugeArrow-1",
					"value": 49.5
				}
			],
			"axes": [
				{
					"id": "GaugeAxis-1",
					"bands": [
						{
							"color": "#28a9ff",
							"endValue": 28,
							"id": "GaugeBand-1",
							"startValue": 10
						},
						{
							"color": "#00CC00",
							"endValue": 56,
							"id": "GaugeBand-2",
							"startValue": 28
						},
						{
							"color": "#FFAC29",
							"endValue": 84,
							"id": "GaugeBand-3",
							"startValue": 56
						},
						{
							"color": "#EA3838",
							"endValue": 112,
							"id": "GaugeBand-4",
							"startValue": 84
						}
					]
				}
			]
		});
	}


	/* --  .chart.theme_02.line_02  -- */
	// set temp_id
	var $chartType_line02 = $('.chart.theme_02.line_02');
	var $chartType_line02_array = [];
	for (var i = 0; i < $chartType_line02.length; i++) {
		$id = 'chartTempID_line2_' + (i + 1);
		$chartType_line02.eq(i).attr('id', $id);
		$chartType_line02_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_line02_array.length; i++) {
		AmCharts.makeChart($chartType_line02_array[i], {
			"type": "serial",
			"theme": "theme_02",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"categoryAxis": {//x축
				"minPeriod": "mm" // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "JJ:NN", //x축 balloon 정보포맷 
				"categoryBalloonEnabled": false //x축 balloon 지우기
				//"zoomable": false //확대,축소 기능 삭제
			},
			"chartScrollbar": { //스크롤바 유,무
				"enabled": true
			},
			"allLabels": [//기타 텍스트 정보 삽입
				{
					"color": "#AAB3B3",
					"id": "unit",
					"size": 1,
					"text": "(%)", // 단위 같은 것을 기입
					"x": 14,
					"y": 20
				}
			],
			"legend": { //범례 유,무
				"enabled": false
				//"reversedOrder": true, //순서 반대로
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]:[[value]]%", //풍선말 텍스트 정보
					"id": "AmGraph-1",
					"title": "Memory",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-2",
					"title": "Storage",
					"valueField": "column-2"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-3",
					"title": "CPU",
					"valueField": "column-3"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-4",
					"title": "CPU data",
					"valueField": "column-4"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-5",
					"title": "CPU data",
					"valueField": "column-5"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-6",
					"title": "CPU data",
					"valueField": "column-6"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 28,
					"column-2": 25,
					"column-3": 23,
					"column-4": 33,
					"column-5": 20,
					"column-6": 20,
					"date": "2014-03-01 07:51"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 42,
					"column-5": 70,
					"column-6": 50,
					"date": "2014-03-01 07:52"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 27,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 07:53"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 47,
					"column-5": 40,
					"column-6": 30,
					"date": "2014-03-01 07:54"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 45,
					"column-5": 20,
					"column-6": 50,
					"date": "2014-03-01 07:55"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 45,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 07:56"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 14,
					"column-5": 70,
					"column-6": 50,
					"date": "2014-03-01 07:57"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 17,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 07:58"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 57,
					"column-5": 40,
					"column-6": 30,
					"date": "2014-03-01 07:59"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 45,
					"column-5": 20,
					"column-6": 50,
					"date": "2014-03-01 08:00"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 54,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 08:01"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 84,
					"column-5": 70,
					"column-6": 50,
					"date": "2014-03-01 08:02"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 34,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 08:03"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 67,
					"column-5": 40,
					"column-6": 30,
					"date": "2014-03-01 08:04"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 67,
					"column-5": 20,
					"column-6": 50,
					"date": "2014-03-01 08:05"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 78,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 08:06"
				}
			]
		});
	}

	/* --  .chart.theme_02.area_03  -- */
	// set temp_id
	var $chartType_area03 = $('.chart.theme_02.area_03');
	var $chartType_area03_array = [];
	for (var i = 0; i < $chartType_area03.length; i++) {
		$id = 'chartTempID_area3_' + (i + 1);
		$chartType_area03.eq(i).attr('id', $id);
		$chartType_area03_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_area03_array.length; i++) {
		AmCharts.makeChart($chartType_area03_array[i], {
			"type": "serial",
			"theme": "theme_02",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"startDuration": 0.4, //애니메이션 속도
			"startEffect": "easeOutSine", //애니메이션 스타일
			"categoryAxis": {//x축
				"minPeriod": "ss" // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "JJ:NN:SS" //x축 balloon 정보포맷 
			},
			"chartScrollbar": { //스크롤바 유,무
				"enabled": true
			},
			"legend": { //범례 유,무
				"enabled": true
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]:[[value]]%", //풍선말 텍스트 정보
					"id": "AmGraph-1",
					"fillAlphas": 0.45,
					"title": "Memory",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-2",
					"fillAlphas": 0.45,
					"title": "CPU data",
					"valueField": "column-2"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 8,
					"column-2": 5,
					"date": "2014-03-01 07:57:40"
				}, 
				{
					"column-1": 6,
					"column-2": 7,
					"date": "2014-03-01 07:57:41"
				}, 
				{
					"column-1": 2,
					"column-2": 3,
					"date": "2014-03-01 07:57:42"
				}, 
				{
					"column-1": 1,
					"column-2": 3,
					"date": "2014-03-01 07:57:43"
				}, 
				{
					"column-1": 2,
					"column-2": 1,
					"date": "2014-03-01 07:57:44"
				}, 
				{
					"column-1": 3,
					"column-2": 2,
					"date": "2014-03-01 07:57:45"
				}, 
				{
					"column-1": 6,
					"column-2": 8,
					"date": "2014-03-01 07:57:46"
				}
			]
		});
	}

	/* --  .chart.theme_02.column_02  -- */
	// set temp_id
	var $chartType_column02 = $('.chart.theme_02.column_02');
	var $chartType_column02_array = [];
	for (var i = 0; i < $chartType_column02.length; i++) {
		$id = 'chartTempID_column2_' + (i + 1);
		$chartType_column02.eq(i).attr('id', $id);
		$chartType_column02_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_column02_array.length; i++) {
		AmCharts.makeChart($chartType_column02_array[i], {
			"type": "serial",
			"theme": "theme_02",
			"categoryField": "category",
			"categoryAxis": {//x축
				"startOnAxis": false, // grid start 지점 지정
				"parseDates": false, // x축 date-related에 의한 정의 줄임
				"labelOffset": 1
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"legend": { //범례 유,무
				"enabled": true,
				"markerType": "square"
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[category]]<br><b>[[value]]</b>", //풍선말 텍스트 정보
					//"fixedColumnWidth": 10, //data개수가 N개일 경우에는 적용 제한
					"fillAlphas": 1,
					"id": "AmGraph-1",
					"title": "Memory",
					"type": "column",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[category]]<br><b>[[value]]</b>",
					//"fixedColumnWidth": 10, //data개수가 N개일 경우에는 적용 제한
					"fillAlphas": 1,
					"id": "AmGraph-2",
					"title": "Storage",
					"type": "column",
					"valueField": "column-2"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "category 1",
					"column-1": 28,
					"column-2": 25
				}, 
				{
					"category": "category 2 - Name Text Length Test",
					"column-1": 71,
					"column-2": 14
				}, 
				{
					"category": "category 3",
					"column-1": 22,
					"column-2": 31
				}, 
				{
					"category": "category 4",
					"column-1": 32,
					"column-2": 45
				}, 
				{
					"category": "category 5",
					"column-1": 52,
					"column-2": 23
				}, 
				{
					"category": "category 6",
					"column-1": 22,
					"column-2": 31
				}, 
				{
					"category": "category 7",
					"column-1": 56,
					"column-2": 71
				}, 
				{
					"category": "category 8",
					"column-1": 22,
					"column-2": 31
				}
			]
		});
	}

	/* --  .chart.theme_02.bar_02  -- */
	// set temp_id
	var $chartType_bar02 = $('.chart.theme_02.bar_02');
	var $chartType_bar02_array = [];
	for (var i = 0; i < $chartType_bar02.length; i++) {
		$id = 'chartTempID_bar2_' + (i + 1);
		$chartType_bar02.eq(i).attr('id', $id);
		$chartType_bar02_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_bar02_array.length; i++) {
		AmCharts.makeChart($chartType_bar02_array[i], {
			"type": "serial",
			"theme": "theme_02",
			"categoryField": "category",
			//"rotate": true, // bar 또는  column 유형 변경값 
			"colors": [ // theme컬러 사용 안할때 
				"#5093e1"
			],
			"categoryAxis": {//x축
				"startOnAxis": false, // grid start 지점 지정
				"parseDates": false, // x축 date-related에 의한 정의 줄임
				"tickPosition": "middle", //colum 차트 tick 지정
				"tickLength": 0, // label line 길이
				"labelOffset": 1,
				"labelFunction": function(valueText, serialDataItem, categoryAxis) {//텍스트 수가 많을때 생략 
					if (valueText.length > 20)
						return valueText.substring(0, 20) + '..';
					else
						return valueText;
				}
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[category]]<br><b>[[value]]</b>", //풍선말 텍스트 정보
					"fixedColumnWidth": 17,
					"fillAlphas": 1,
					//"fillColors": "#12b3a5", //컬러 별도 지정 가능
					//"lineColor": "#12b3a5", //컬러 별도 지정 가능
					"id": "AmGraph-1",
					"title": "Memory",
					"type": "column",
					"valueField": "column-1"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "Ranking 01",
					"column-1": 28,
					"column-2": 25
				}, 
				{
					"category": "Ranking 02-Name Text Length Test ",
					"column-1": 71,
					"column-2": 14
				}, 
				{
					"category": "Ranking 03",
					"column-1": 22,
					"column-2": 31
				}, 
				{
					"category": "Ranking 04",
					"column-1": 32,
					"column-2": 45
				}, 
				{
					"category": "Ranking 05",
					"column-1": 52,
					"column-2": 23
				}
			]
		});
	}

	/* --  .chart.theme_02.value_02(bar+line) */
	// set temp_id
	var $chartType_value02 = $('.chart.theme_02.value_02');
	var $chartType_value02_array = [];
	for (var i = 0; i < $chartType_value02.length; i++) {
		$id = 'chartTempID_value2_' + (i + 1);
		$chartType_value02.eq(i).attr('id', $id);
		$chartType_value02_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_value02_array.length; i++) {
		AmCharts.makeChart($chartType_value02_array[i], {
			"type": "serial",
			"theme": "theme_02",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN", //date format 지정
			"categoryAxis": { // X축
				"minPeriod": "mm", // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
				"startOnAxis": false // grid start 지점 지정
			},
			"valueAxes": [// Y축
				{
					"id": "ValueAxis-1",
					"stackType": "regular", // 막대유형
					"title": "Packets"
				}, 
				{
					"id": "ValueAxis-2",
					"position": "right",
					"gridAlpha": 0,
					"fillAlpha":0,
					"title": "BPS"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "YYYY-MM-DD JJ:NN" //x축 balloon 정보포맷 
			},
			"chartScrollbar": { //스크롤바 유,무
				"enabled": true
			},
			"legend": { //범례 유,무
				"enabled": true,
				"align": "center",
				"markerType": "square",
				"useGraphSettings": true
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"fillAlphas": 1,
					"id": "AmGraph-1",
					"title": "Input Packets",
					"type": "column",
					"valueAxis": "ValueAxis-1",
					"valueField": "column-1"
				},
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"fillAlphas": 1,
					"id": "AmGraph-2",
					"title": "Output Packets",
					"type": "column",
					"valueAxis": "ValueAxis-1",
					"valueField": "column-2"
				},
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"bullet": "round",
					"bulletSize": 7,
					"id": "AmGraph-3",
					"title": "Input BPS",
					"valueAxis": "ValueAxis-2",
					"valueField": "column-3"
				},
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"bullet": "round",
					"bulletSize": 7,
					"id": "AmGraph-4",
					"title": "Output BPS",
					"valueAxis": "ValueAxis-2",
					"valueField": "column-4"
				}

			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 2000,
					"column-2": 4000,
					"column-3": 35000,
					"column-4": 25000,
					"date": "2016-11-30 07:40"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 30000,
					"date": "2016-11-30 07:45"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 07:50"
				},
				{
					"column-1": 8000,
					"column-2": 5000,
					"column-3": 50000,
					"column-4": 40000,
					"date": "2016-11-30 07:55"
				},
				{
					"column-1": 6000,
					"column-2": 7000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 08:00"
				},
				{
					"column-1": 2000,
					"column-2": 3000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 08:05"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 08:10"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 08:15"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 08:20"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 08:25"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 08:30"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 08:35"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 08:40"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 08:45"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 500,
					"column-4": 1000,
					"date": "2016-11-30 08:50"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"date": "2016-11-30 08:55"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 09:00"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 09:05"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 09:10"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 09:15"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 09:20"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 30000,
					"date": "2016-11-30 09:25"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 09:30"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 09:35"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 500,
					"column-4": 1000,
					"date": "2016-11-30 09:40"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 09:45"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 09:50"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 09:55"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 10:00"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 10:05"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 10:10"
				},
				{
					"column-1": 5000,
					"column-2": 7000,
					"column-3": 50000,
					"column-4": 45000,
					"date": "2016-11-30 10:15"
				}
			],
		});
	}


	/* --  .chart.theme_03.line_03  -- */
	// set temp_id
	var $chartType_line03 = $('.chart.theme_03.line_03');
	var $chartType_line03_array = [];
	for (var i = 0; i < $chartType_line03.length; i++) {
		$id = 'chartTempID_line3_' + (i + 1);
		$chartType_line03.eq(i).attr('id', $id);
		$chartType_line03_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_line03_array.length; i++) {
		AmCharts.makeChart($chartType_line03_array[i], {
			"type": "serial",
			"theme": "theme_03",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"categoryAxis": {//x축
				"minPeriod": "mm" // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "JJ:NN", //x축 balloon 정보포맷 
				"categoryBalloonEnabled": false //x축 balloon 지우기
				//"zoomable": false //확대,축소 기능 삭제
			},
			"legend": { //범례 유,무
				"enabled": false
				//"reversedOrder": true, //순서 반대로
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]:[[value]]%", //풍선말 텍스트 정보
					"id": "AmGraph-1",
					"title": "Memory",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-2",
					"title": "Storage",
					"valueField": "column-2"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-3",
					"title": "CPU",
					"valueField": "column-3"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-4",
					"title": "CPU data",
					"valueField": "column-4"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-5",
					"title": "CPU data",
					"valueField": "column-5"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-6",
					"title": "CPU data",
					"valueField": "column-6"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 28,
					"column-2": 25,
					"column-3": 23,
					"column-4": 33,
					"column-5": 20,
					"column-6": 20,
					"date": "2014-03-01 07:51"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 42,
					"column-5": 70,
					"column-6": 50,
					"date": "2014-03-01 07:52"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 27,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 07:53"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 47,
					"column-5": 40,
					"column-6": 30,
					"date": "2014-03-01 07:54"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 45,
					"column-5": 20,
					"column-6": 50,
					"date": "2014-03-01 07:55"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 45,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 07:56"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 14,
					"column-5": 70,
					"column-6": 50,
					"date": "2014-03-01 07:57"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 17,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 07:58"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 57,
					"column-5": 40,
					"column-6": 30,
					"date": "2014-03-01 07:59"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 45,
					"column-5": 20,
					"column-6": 50,
					"date": "2014-03-01 08:00"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 54,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 08:01"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 84,
					"column-5": 70,
					"column-6": 50,
					"date": "2014-03-01 08:02"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 34,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 08:03"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 67,
					"column-5": 40,
					"column-6": 30,
					"date": "2014-03-01 08:04"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 67,
					"column-5": 20,
					"column-6": 50,
					"date": "2014-03-01 08:05"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 78,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 08:06"
				}
			]
		});
	}

	/* --  .chart.theme_03.area_04  -- */
	// set temp_id
	var $chartType_area04 = $('.chart.theme_03.area_04');
	var $chartType_area04_array = [];
	for (var i = 0; i < $chartType_area04.length; i++) {
		$id = 'chartTempID_area4_' + (i + 1);
		$chartType_area04.eq(i).attr('id', $id);
		$chartType_area04_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_area04_array.length; i++) {
		AmCharts.makeChart($chartType_area04_array[i], {
			"type": "serial",
			"theme": "theme_03",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"startDuration": 0.4, //애니메이션 속도
			"startEffect": "easeOutSine", //애니메이션 스타일
			"categoryAxis": {//x축
				"minPeriod": "ss" // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "JJ:NN:SS" //x축 balloon 정보포맷 
			},
			"legend": { //범례 유,무
				"enabled": true
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]:[[value]]%", //풍선말 텍스트 정보
					"id": "AmGraph-1",
					"fillAlphas": 0.45,
					"title": "Memory",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-2",
					"fillAlphas": 0.45,
					"title": "CPU data",
					"valueField": "column-2"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 8,
					"column-2": 5,
					"date": "2014-03-01 07:57:40"
				}, 
				{
					"column-1": 6,
					"column-2": 7,
					"date": "2014-03-01 07:57:41"
				}, 
				{
					"column-1": 2,
					"column-2": 3,
					"date": "2014-03-01 07:57:42"
				}, 
				{
					"column-1": 1,
					"column-2": 3,
					"date": "2014-03-01 07:57:43"
				}, 
				{
					"column-1": 2,
					"column-2": 1,
					"date": "2014-03-01 07:57:44"
				}, 
				{
					"column-1": 3,
					"column-2": 2,
					"date": "2014-03-01 07:57:45"
				}, 
				{
					"column-1": 6,
					"column-2": 8,
					"date": "2014-03-01 07:57:46"
				}
			]
		});
	}

	/* --  .chart.theme_03.column_03  -- */
	// set temp_id
	var $chartType_column03 = $('.chart.theme_03.column_03');
	var $chartType_column03_array = [];
	for (var i = 0; i < $chartType_column03.length; i++) {
		$id = 'chartTempID_column3_' + (i + 1);
		$chartType_column03.eq(i).attr('id', $id);
		$chartType_column03_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_column03_array.length; i++) {
		AmCharts.makeChart($chartType_column03_array[i], {
			"type": "serial",
			"theme": "theme_03",
			"categoryField": "category",
			"categoryAxis": {//x축
				"startOnAxis": false, // grid start 지점 지정
				"parseDates": false, // x축 date-related에 의한 정의 줄임
				"labelOffset": 1
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"legend": { //범례 유,무
				"enabled": true,
				"markerType": "square"
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[category]]<br><b>[[value]]</b>", //풍선말 텍스트 정보
					//"fixedColumnWidth": 10, //data개수가 N개일 경우에는 적용 제한
					"fillAlphas": 1,
					"id": "AmGraph-1",
					"title": "Memory",
					"type": "column",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[category]]<br><b>[[value]]</b>",
					//"fixedColumnWidth": 10, //data개수가 N개일 경우에는 적용 제한
					"fillAlphas": 1,
					"id": "AmGraph-2",
					"title": "Storage",
					"type": "column",
					"valueField": "column-2"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "category 1",
					"column-1": 28,
					"column-2": 25
				}, 
				{
					"category": "category 2 - Name Text Length Test",
					"column-1": 71,
					"column-2": 14
				}, 
				{
					"category": "category 3",
					"column-1": 22,
					"column-2": 31
				}, 
				{
					"category": "category 4",
					"column-1": 32,
					"column-2": 45
				}, 
				{
					"category": "category 5",
					"column-1": 52,
					"column-2": 23
				}, 
				{
					"category": "category 6",
					"column-1": 22,
					"column-2": 31
				}, 
				{
					"category": "category 7",
					"column-1": 56,
					"column-2": 71
				}, 
				{
					"category": "category 8",
					"column-1": 22,
					"column-2": 31
				}
			]
		});
	}

	/* --  .chart.theme_03.bar_03  -- */
	// set temp_id
	var $chartType_bar03 = $('.chart.theme_03.bar_03');
	var $chartType_bar03_array = [];
	for (var i = 0; i < $chartType_bar03.length; i++) {
		$id = 'chartTempID_bar3_' + (i + 1);
		$chartType_bar03.eq(i).attr('id', $id);
		$chartType_bar03_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_bar03_array.length; i++) {
		AmCharts.makeChart($chartType_bar03_array[i], {
			"type": "serial",
			"theme": "theme_03",
			"categoryField": "category",
			//"rotate": true, // bar 또는  column 유형 변경값 
			"colors": [ // theme컬러 사용 안할때 
				"#5093e1"
			],
			"categoryAxis": {//x축
				"startOnAxis": false, // grid start 지점 지정
				"parseDates": false, // x축 date-related에 의한 정의 줄임
				"tickPosition": "middle", //colum 차트 tick 지정
				"tickLength": 0, // label line 길이
				"labelOffset": 1,
				"labelFunction": function(valueText, serialDataItem, categoryAxis) {//텍스트 수가 많을때 생략 
					if (valueText.length > 20)
						return valueText.substring(0, 20) + '..';
					else
						return valueText;
				}
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[category]]<br><b>[[value]]</b>", //풍선말 텍스트 정보
					"fixedColumnWidth": 17,
					"fillAlphas": 1,
					//"fillColors": "#12b3a5", //컬러 별도 지정 가능
					//"lineColor": "#12b3a5", //컬러 별도 지정 가능
					"id": "AmGraph-1",
					"title": "Memory",
					"type": "column",
					"valueField": "column-1"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "Ranking 01",
					"column-1": 28,
					"column-2": 25
				}, 
				{
					"category": "Ranking 02-Name Text Length Test ",
					"column-1": 71,
					"column-2": 14
				}, 
				{
					"category": "Ranking 03",
					"column-1": 22,
					"column-2": 31
				}, 
				{
					"category": "Ranking 04",
					"column-1": 32,
					"column-2": 45
				}, 
				{
					"category": "Ranking 05",
					"column-1": 52,
					"column-2": 23
				}
			]
		});
	}

	/* --  .chart.theme_03.value_03(bar+line) */
	// set temp_id
	var $chartType_value03 = $('.chart.theme_03.value_03');
	var $chartType_value03_array = [];
	for (var i = 0; i < $chartType_value03.length; i++) {
		$id = 'chartTempID_value3_' + (i + 1);
		$chartType_value03.eq(i).attr('id', $id);
		$chartType_value03_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_value03_array.length; i++) {
		AmCharts.makeChart($chartType_value03_array[i], {
			"type": "serial",
			"theme": "theme_03",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN", //date format 지정
			"categoryAxis": { // X축
				"minPeriod": "mm", // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
				"startOnAxis": false // grid start 지점 지정
			},
			"valueAxes": [// Y축
				{
					"id": "ValueAxis-1",
					"stackType": "regular", // 막대유형
					"title": "Packets"
				}, 
				{
					"id": "ValueAxis-2",
					"position": "right",
					"title": "BPS"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "YYYY-MM-DD JJ:NN" //x축 balloon 정보포맷 
			},
			"legend": { //범례 유,무
				"enabled": true,
				"align": "center",
				"markerType": "square",
				"useGraphSettings": true
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"fillAlphas": 1,
					"id": "AmGraph-1",
					"title": "Input Packets",
					"type": "column",
					"valueAxis": "ValueAxis-1",
					"valueField": "column-1"
				},
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"fillAlphas": 1,
					"id": "AmGraph-2",
					"title": "Output Packets",
					"type": "column",
					"valueAxis": "ValueAxis-1",
					"valueField": "column-2"
				},
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"bullet": "round",
					"bulletSize": 7,
					"id": "AmGraph-3",
					"title": "Input BPS",
					"valueAxis": "ValueAxis-2",
					"valueField": "column-3"
				},
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"bullet": "round",
					"bulletSize": 7,
					"id": "AmGraph-4",
					"title": "Output BPS",
					"valueAxis": "ValueAxis-2",
					"valueField": "column-4"
				}

			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 2000,
					"column-2": 4000,
					"column-3": 35000,
					"column-4": 25000,
					"date": "2016-11-30 07:40"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 30000,
					"date": "2016-11-30 07:45"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 07:50"
				},
				{
					"column-1": 8000,
					"column-2": 5000,
					"column-3": 50000,
					"column-4": 40000,
					"date": "2016-11-30 07:55"
				},
				{
					"column-1": 6000,
					"column-2": 7000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 08:00"
				},
				{
					"column-1": 2000,
					"column-2": 3000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 08:05"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 08:10"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 08:15"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 08:20"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 08:25"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 08:30"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 08:35"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 08:40"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 08:45"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 500,
					"column-4": 1000,
					"date": "2016-11-30 08:50"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"date": "2016-11-30 08:55"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 09:00"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 09:05"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 09:10"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 09:15"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 09:20"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 30000,
					"date": "2016-11-30 09:25"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 09:30"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 09:35"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 500,
					"column-4": 1000,
					"date": "2016-11-30 09:40"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 09:45"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 09:50"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 09:55"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 10:00"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 10:05"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 10:10"
				},
				{
					"column-1": 5000,
					"column-2": 7000,
					"column-3": 50000,
					"column-4": 45000,
					"date": "2016-11-30 10:15"
				}
			],
		});
	}

	/* --  .chart.theme_04.area_05  -- */
	// set temp_id
	var $chartType_area05 = $('.chart.theme_04.area_05');
	var $chartType_area05_array = [];
	for (var i = 0; i < $chartType_area05.length; i++) {
		$id = 'chartTempID_area5_' + (i + 1);
		$chartType_area05.eq(i).attr('id', $id);
		$chartType_area05_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_area05_array.length; i++) {
		AmCharts.makeChart($chartType_area05_array[i], {
			"type": "serial",
			"theme": "theme_04",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"categoryAxis": {//x축
				"minPeriod": "ss" // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[category]]<br><b>[[value]]</b>", //풍선말 텍스트 정보
					"id": "AmGraph-1",
					"fillAlphas":0.3,
					"title": "RX",
					"valueField": "column-1"
				}
			],
			"dataProvider": [
				{
					"column-1": 120,
					"date": "2016-11-30 07:57:56"
				},
				{
					"column-1": 150,
					"date": "2016-11-30 07:57:57"
				},
				{
					"column-1": 100,
					"date": "2016-11-30 07:57:58"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:57:59"
				},
				{
					"column-1": 150,
					"date": "2016-11-30 07:58:00"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:58:01"
				},
				{
					"column-1": 190,
					"date": "2016-11-30 07:58:02"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:03"
				},
				{
					"column-1": 130,
					"date": "2016-11-30 07:58:04"
				},
				{
					"column-1": 180,
					"date": "2016-11-30 07:58:05"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:58:06"
				},
				{
					"column-1": 200,
					"date": "2016-11-30 07:58:07"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:08"
				},
				{
					"column-1": 192,
					"date": "2016-11-30 07:58:09"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:58:10"
				},
				{
					"column-1": 175,
					"date": "2016-11-30 07:58:11"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:12"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:13"
				},
				{
					"column-1": 130,
					"date": "2016-11-30 07:58:14"
				},
				{
					"column-1": 180,
					"date": "2016-11-30 07:58:15"
				},
				{
					"column-1": 220,
					"date": "2016-11-30 07:58:16"
				},
				{
					"column-1": 180,
					"date": "2016-11-30 07:58:17"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:18"
				},
				{
					"column-1": 192,
					"date": "2016-11-30 07:58:19"
				},
				{
					"column-1": 220,
					"date": "2016-11-30 07:58:20"
				},
				{
					"column-1": 175,
					"date": "2016-11-30 07:58:21"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:22"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:23"
				},
				{
					"column-1": 130,
					"date": "2016-11-30 07:58:24"
				},
				{
					"column-1": 180,
					"date": "2016-11-30 07:58:25"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:58:26"
				},
				{
					"column-1": 140,
					"date": "2016-11-30 07:58:27"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:28"
				},
				{
					"column-1": 192,
					"date": "2016-11-30 07:58:29"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:58:30"
				},
				{
					"column-1": 175,
					"date": "2016-11-30 07:58:31"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:32"
				},
				{
					"column-1": 190,
					"date": "2016-11-30 07:58:33"
				},
				{
					"column-1": 130,
					"date": "2016-11-30 07:58:34"
				},
				{
					"column-1": 190,
					"date": "2016-11-30 07:58:35"
				},
				{
					"column-1": 220,
					"date": "2016-11-30 07:58:36"
				},
				{
					"column-1": 140,
					"date": "2016-11-30 07:58:37"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:38"
				},
				{
					"column-1": 192,
					"date": "2016-11-30 07:58:39"
				},
				{
					"column-1": 220,
					"date": "2016-11-30 07:58:40"
				},
				{
					"column-1": 175,
					"date": "2016-11-30 07:58:41"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:42"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:43"
				},
				{
					"column-1": 130,
					"date": "2016-11-30 07:58:44"
				},
				{
					"column-1": 180,
					"date": "2016-11-30 07:58:45"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:58:46"
				},
				{
					"column-1": 180,
					"date": "2016-11-30 07:58:47"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:48"
				},
				{
					"column-1": 192,
					"date": "2016-11-30 07:58:49"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:58:50"
				},
				{
					"column-1": 175,
					"date": "2016-11-30 07:58:51"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:52"
				},
				{
					"column-1": 175,
					"date": "2016-11-30 07:58:53"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:54"
				},
				{
					"column-1": 180,
					"date": "2016-11-30 07:58:55"
				},
				{
					"column-1": 220,
					"date": "2016-11-30 07:58:56"
				},
				{
					"column-1": 225,
					"date": "2016-11-30 07:58:57"
				},
				{
					"column-1": 200,
					"date": "2016-11-30 07:58:58"
				},
				{
					"column-1": 210,
					"date": "2016-11-30 07:58:59"
				},
				{
					"column-1": 170,
					"date": "2016-11-30 07:59:00"
				},
				{
					"column-1": 210,
					"date": "2016-11-30 07:59:01"
				},
				{
					"column-1": 220,
					"date": "2016-11-30 07:59:02"
				},
				{
					"column-1": 225,
					"date": "2016-11-30 07:59:03"
				},
				{
					"column-1": 170,
					"date": "2016-11-30 07:59:04"
				},
				{
					"column-1": 210,
					"date": "2016-11-30 07:59:05"
				},
				{
					"column-1": 220,
					"date": "2016-11-30 07:59:06"
				},
				{
					"column-1": 165,
					"date": "2016-11-30 07:59:07"
				},
				{
					"column-1": 190,
					"date": "2016-11-30 07:59:08"
				},
				{
					"column-1": 225,
					"date": "2016-11-30 07:59:09"
				},
				{
					"column-1": 200,
					"date": "2016-11-30 07:59:10"
				},
				{
					"column-1": 155,
					"date": "2016-11-30 07:59:11"
				},
				{
					"column-1": 200,
					"date": "2016-11-30 07:59:12"
				},
				{
					"column-1": 190,
					"date": "2016-11-30 07:59:13"
				},
				{
					"column-1": 220,
					"date": "2016-11-30 07:59:14"
				},
				{
					"column-1": 225,
					"date": "2016-11-30 07:59:15"
				},
				{
					"column-1": 170,
					"date": "2016-11-30 07:59:16"
				},
				{
					"column-1": 215,
					"date": "2016-11-30 07:59:17"
				},
				{
					"column-1": 170,
					"date": "2016-11-30 07:59:18"
				},
				{
					"column-1": 225,
					"date": "2016-11-30 07:59:19"
				},
				{
					"column-1": 220,
					"date": "2016-11-30 07:59:20"
				},
				{
					"column-1": 195,
					"date": "2016-11-30 07:59:21"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:59:22"
				}
			]
		});
	}


	/* --  .chart.theme_05.line_04  -- */
	// set temp_id
	var $chartType_line04 = $('.chart.theme_05.line_04');
	var $chartType_line04_array = [];
	for (var i = 0; i < $chartType_line04.length; i++) {
		$id = 'chartTempID_line4_' + (i + 1);
		$chartType_line04.eq(i).attr('id', $id);
		$chartType_line04_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_line04_array.length; i++) {
		AmCharts.makeChart($chartType_line04_array[i], {
			"type": "serial",
			"theme": "theme_05",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"categoryAxis": {//x축
				"minPeriod": "mm" // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "JJ:NN", //x축 balloon 정보포맷 
				"categoryBalloonEnabled": false //x축 balloon 지우기
				//"zoomable": false //확대,축소 기능 삭제
			},
			"chartScrollbar": { //스크롤바 유,무
				"enabled": true
			},
			"allLabels": [//기타 텍스트 정보 삽입
				{
					"id": "unit",
					"size": 1,
					"text": "(%)", // 단위 같은 것을 기입
					"x": 20,
					"y": 20
				}
			],
			"legend": { //범례 유,무
				"enabled": false
				//"reversedOrder": true, //순서 반대로
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]:[[value]]%", //풍선말 텍스트 정보
					"id": "AmGraph-1",
					"title": "Memory",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-2",
					"title": "Storage",
					"valueField": "column-2"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-3",
					"title": "CPU",
					"valueField": "column-3"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-4",
					"title": "CPU data",
					"valueField": "column-4"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-5",
					"title": "CPU data",
					"valueField": "column-5"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-6",
					"title": "CPU data",
					"valueField": "column-6"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 28,
					"column-2": 25,
					"column-3": 23,
					"column-4": 33,
					"column-5": 20,
					"column-6": 20,
					"date": "2014-03-01 07:51"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 42,
					"column-5": 70,
					"column-6": 50,
					"date": "2014-03-01 07:52"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 27,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 07:53"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 47,
					"column-5": 40,
					"column-6": 30,
					"date": "2014-03-01 07:54"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 45,
					"column-5": 20,
					"column-6": 50,
					"date": "2014-03-01 07:55"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 45,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 07:56"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 14,
					"column-5": 70,
					"column-6": 50,
					"date": "2014-03-01 07:57"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 17,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 07:58"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 57,
					"column-5": 40,
					"column-6": 30,
					"date": "2014-03-01 07:59"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 45,
					"column-5": 20,
					"column-6": 50,
					"date": "2014-03-01 08:00"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 54,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 08:01"
				}, 
				{
					"column-1": 56,
					"column-2": 71,
					"column-3": 14,
					"column-4": 84,
					"column-5": 70,
					"column-6": 50,
					"date": "2014-03-01 08:02"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 87,
					"column-4": 34,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 08:03"
				}, 
				{
					"column-1": 32,
					"column-2": 45,
					"column-3": 67,
					"column-4": 67,
					"column-5": 40,
					"column-6": 30,
					"date": "2014-03-01 08:04"
				}, 
				{
					"column-1": 52,
					"column-2": 23,
					"column-3": 45,
					"column-4": 67,
					"column-5": 20,
					"column-6": 50,
					"date": "2014-03-01 08:05"
				}, 
				{
					"column-1": 22,
					"column-2": 31,
					"column-3": 15,
					"column-4": 78,
					"column-5": 30,
					"column-6": 20,
					"date": "2014-03-01 08:06"
				}
			]
		});
	}

	/* --  .chart.theme_05.area_06  -- */
	// set temp_id
	var $chartType_area06 = $('.chart.theme_05.area_06');
	var $chartType_area06_array = [];
	for (var i = 0; i < $chartType_area06.length; i++) {
		$id = 'chartTempID_area6_' + (i + 1);
		$chartType_area06.eq(i).attr('id', $id);
		$chartType_area06_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_area06_array.length; i++) {
		AmCharts.makeChart($chartType_area06_array[i], {
			"type": "serial",
			"theme": "theme_05",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"startDuration": 0.4, //애니메이션 속도
			"startEffect": "easeOutSine", //애니메이션 스타일
			"categoryAxis": {//x축
				"minPeriod": "ss" // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "JJ:NN:SS" //x축 balloon 정보포맷 
			},
			"chartScrollbar": { //스크롤바 유,무
				"enabled": false
			},
			"legend": { //범례 유,무
				"enabled": true
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]:[[value]]%", //풍선말 텍스트 정보
					"id": "AmGraph-1",
					"fillAlphas": 0.45,
					"title": "Memory",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[title]]:[[value]]%",
					"id": "AmGraph-2",
					"fillAlphas": 0.45,
					"title": "CPU data",
					"valueField": "column-2"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 8,
					"column-2": 5,
					"date": "2014-03-01 07:57:40"
				}, 
				{
					"column-1": 6,
					"column-2": 7,
					"date": "2014-03-01 07:57:41"
				}, 
				{
					"column-1": 2,
					"column-2": 3,
					"date": "2014-03-01 07:57:42"
				}, 
				{
					"column-1": 1,
					"column-2": 3,
					"date": "2014-03-01 07:57:43"
				}, 
				{
					"column-1": 2,
					"column-2": 1,
					"date": "2014-03-01 07:57:44"
				}, 
				{
					"column-1": 3,
					"column-2": 2,
					"date": "2014-03-01 07:57:45"
				}, 
				{
					"column-1": 6,
					"column-2": 8,
					"date": "2014-03-01 07:57:46"
				}
			]
		});
	}

	/* --  .chart.theme_05.area_07  -- */
	// set temp_id
	var $chartType_area07 = $('.chart.theme_05.area_07');
	var $chartType_area07_array = [];
	for (var i = 0; i < $chartType_area07.length; i++) {
		$id = 'chartTempID_area7_' + (i + 1);
		$chartType_area07.eq(i).attr('id', $id);
		$chartType_area07_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_area07_array.length; i++) {
		AmCharts.makeChart($chartType_area07_array[i], {
			"dataProvider": chartData,
			"type": "serial",
			"theme": "theme_05",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"startDuration": 0.4, //애니메이션 속도
			"startEffect": "easeOutSine", //애니메이션 스타일
			"colors": [ //컬러 변경
				"#fee566"
			],
			"categoryAxis": {//x축
				"minPeriod": "mm" // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "JJ:NN" //x축 balloon 정보포맷 
			},
			"chartScrollbar": { //스크롤바 유,무
				"enabled": true
			},
			"allLabels": [//기타 정보를 삽입하는데 유용
				{ 
					"id": "unit",
					"size": 1,
					"text": "(MB)", // 단위 같은 것을 기입
					"x": 16,
					"y": 20
				}
			],
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]:[[value]]MB", //풍선말 텍스트 정보
					"id": "AmGraph-1",
					"fillAlphas": 1,
					"title": "RX",
					"valueField": "value_no"
				}
			],
			"export": {
				"enabled": true,
				"dateFormat": "YYYY-MM-DD HH:NN:SS"
			}
		});
	}

	/* --  .chart.theme_05.column_04  -- */
	// set temp_id
	var $chartType_column04 = $('.chart.theme_05.column_04');
	var $chartType_column04_array = [];
	for (var i = 0; i < $chartType_column04.length; i++) {
		$id = 'chartTempID_column4_' + (i + 1);
		$chartType_column04.eq(i).attr('id', $id);
		$chartType_column04_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_column04_array.length; i++) {
		AmCharts.makeChart($chartType_column04_array[i], {
			"type": "serial",
			"theme": "theme_05",
			"categoryField": "category",
			"categoryAxis": {//x축
				"startOnAxis": false, // grid start 지점 지정
				"parseDates": false, // x축 date-related에 의한 정의 줄임
				"labelOffset": 1
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"cursorAlpha": 0.1, 
				"fullWidth": true,
				"categoryBalloonEnabled": false //x축 balloon 지우기
			},
			"chartScrollbar": { //스크롤바 유,무
				"enabled": true
			},
			"legend": { //범례 유,무
				"enabled": true,
				"markerType": "square"
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[category]]:<br><b>[[value]]</b>", //풍선말 텍스트 정보
					//"fixedColumnWidth": 10, //data개수가 N개일 경우에는 적용 제한
					"fillAlphas": 1,
					"id": "AmGraph-1",
					"title": "Memory",
					"type": "column",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[category]]:<br><b>[[value]]</b>",
					//"fixedColumnWidth": 10, //data개수가 N개일 경우에는 적용 제한
					"fillAlphas": 1,
					"id": "AmGraph-2",
					"title": "Storage",
					"type": "column",
					"valueField": "column-2"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "category 1",
					"column-1": 28,
					"column-2": 25
				}, 
				{
					"category": "category 2 - Name Text Length Test",
					"column-1": 71,
					"column-2": 14
				}, 
				{
					"category": "category 3",
					"column-1": 22,
					"column-2": 31
				}, 
				{
					"category": "category 4",
					"column-1": 32,
					"column-2": 45
				}, 
				{
					"category": "category 5",
					"column-1": 52,
					"column-2": 23
				}, 
				{
					"category": "category 6",
					"column-1": 22,
					"column-2": 31
				}, 
				{
					"category": "category 7",
					"column-1": 56,
					"column-2": 71
				}, 
				{
					"category": "category 8",
					"column-1": 22,
					"column-2": 31
				}
			]
		});
	}

	/* --  .chart.theme_05.bar_04  -- */
	// set temp_id
	var $chartType_bar04 = $('.chart.theme_05.bar_04');
	var $chartType_bar04_array = [];
	for (var i = 0; i < $chartType_bar04.length; i++) {
		$id = 'chartTempID_bar4_' + (i + 1);
		$chartType_bar04.eq(i).attr('id', $id);
		$chartType_bar04_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_bar04_array.length; i++) {
		AmCharts.makeChart($chartType_bar04_array[i], {
			"type": "serial",
			"theme": "theme_05",
			"categoryField": "category",
			"rotate": true, // bar 또는  column 유형 변경값 
			"colors": [ // theme컬러 사용 안할때 
				"#12b3a5", 
				"#f65177", 
				"#7d7e7e"
			],
			"categoryAxis": {//x축
				"startOnAxis": false, // grid start 지점 지정
				"parseDates": false, // x축 date-related에 의한 정의 줄임
				"tickPosition": "middle", //colum 차트 tick 지정
				"tickLength": 0, // label line 길이
				"labelOffset": 1,
				"labelFunction": function(valueText, serialDataItem, categoryAxis) {//텍스트 수가 많을때 생략 
					if (valueText.length > 20)
						return valueText.substring(0, 20) + '..';
					else
						return valueText;
				}
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[category]]<br><b>[[value]]</b>", //풍선말 텍스트 정보
					"fixedColumnWidth": 10,
					"fillAlphas": 1,
					//"fillColors": "#12b3a5", //컬러 별도 지정 가능
					//"lineColor": "#12b3a5", //컬러 별도 지정 가능
					"id": "AmGraph-1",
					"title": "Memory",
					"type": "column",
					"valueField": "column-1"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "Ranking 01",
					"column-1": 28,
					"column-2": 25
				}, 
				{
					"category": "Ranking 02-Name Text Length Test ",
					"column-1": 71,
					"column-2": 14
				}, 
				{
					"category": "Ranking 03",
					"column-1": 22,
					"column-2": 31
				}, 
				{
					"category": "Ranking 04",
					"column-1": 32,
					"column-2": 45
				}, 
				{
					"category": "Ranking 05",
					"column-1": 52,
					"column-2": 23
				}
			]
		});
	}

	/* --  .chart.theme_05.value_04(bar+line) */
	// set temp_id
	var $chartType_value04 = $('.chart.theme_05.value_04');
	var $chartType_value04_array = [];
	for (var i = 0; i < $chartType_value04.length; i++) {
		$id = 'chartTempID_value4_' + (i + 1);
		$chartType_value04.eq(i).attr('id', $id);
		$chartType_value04_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_value04_array.length; i++) {
		AmCharts.makeChart($chartType_value04_array[i], {
			"type": "serial",
			"theme": "theme_05",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN", //date format 지정
			"categoryAxis": { // X축
				"minPeriod": "mm", // date-related에 의한 정의 x축 값 형식 노출(ex. 3mm 6mm)
				"startOnAxis": false // grid start 지점 지정
			},
			"valueAxes": [// Y축
				{
					"id": "ValueAxis-1",
					"stackType": "regular", // 막대유형
					"title": "Packets"
				}, 
				{
					"id": "ValueAxis-2",
					"position": "right",
					"gridAlpha": 0,
					"title": "BPS"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"categoryBalloonDateFormat": "YYYY-MM-DD JJ:NN" //x축 balloon 정보포맷 
			},
			"chartScrollbar": { //스크롤바 유,무
				"enabled": true
			},
			"legend": { //범례 유,무
				"enabled": true,
				"align": "center",
				"markerType": "square",
				"useGraphSettings": true
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"fillAlphas": 1,
					"id": "AmGraph-1",
					"title": "Input Packets",
					"type": "column",
					"valueAxis": "ValueAxis-1",
					"valueField": "column-1"
				},
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"fillAlphas": 1,
					"id": "AmGraph-2",
					"title": "Output Packets",
					"type": "column",
					"valueAxis": "ValueAxis-1",
					"valueField": "column-2"
				},
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"bullet": "round",
					"bulletSize": 7,
					"id": "AmGraph-3",
					"title": "Input BPS",
					"valueAxis": "ValueAxis-2",
					"valueField": "column-3"
				},
				{
					"balloonText": "[[title]]: <b>[[value]]</b>",
					"bullet": "round",
					"bulletSize": 7,
					"id": "AmGraph-4",
					"title": "Output BPS",
					"valueAxis": "ValueAxis-2",
					"valueField": "column-4"
				}

			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 2000,
					"column-2": 4000,
					"column-3": 35000,
					"column-4": 25000,
					"date": "2016-11-30 07:40"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 30000,
					"date": "2016-11-30 07:45"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 07:50"
				},
				{
					"column-1": 8000,
					"column-2": 5000,
					"column-3": 50000,
					"column-4": 40000,
					"date": "2016-11-30 07:55"
				},
				{
					"column-1": 6000,
					"column-2": 7000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 08:00"
				},
				{
					"column-1": 2000,
					"column-2": 3000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 08:05"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 08:10"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 08:15"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 08:20"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 08:25"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 08:30"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 08:35"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 08:40"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 08:45"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 500,
					"column-4": 1000,
					"date": "2016-11-30 08:50"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"date": "2016-11-30 08:55"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 09:00"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 09:05"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 09:10"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 09:15"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 09:20"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 30000,
					"date": "2016-11-30 09:25"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 09:30"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 09:35"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 500,
					"column-4": 1000,
					"date": "2016-11-30 09:40"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 09:45"
				},
				{
					"column-1": 1000,
					"column-2": 3000,
					"column-3": 40000,
					"column-4": 35000,
					"date": "2016-11-30 09:50"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 12000,
					"date": "2016-11-30 09:55"
				},
				{
					"column-1": 3000,
					"column-2": 2000,
					"column-3": 30000,
					"column-4": 25000,
					"date": "2016-11-30 10:00"
				},
				{
					"column-1": 2000,
					"column-2": 1000,
					"column-3": 15000,
					"column-4": 10000,
					"date": "2016-11-30 10:05"
				},
				{
					"column-1": 6000,
					"column-2": 8000,
					"column-3": 70000,
					"column-4": 60000,
					"date": "2016-11-30 10:10"
				},
				{
					"column-1": 5000,
					"column-2": 7000,
					"column-3": 50000,
					"column-4": 45000,
					"date": "2016-11-30 10:15"
				}
			],
		});
	}

	/* --  .chart.theme_05.pie_04  -- */
	// set temp_id
	var $chartType_pie04 = $('.chart.theme_05.pie_04');
	var $chartType_pie04_array = [];
	for (var i = 0; i < $chartType_pie04.length; i++) {
		$id = 'chartTempID_pie4_' + (i + 1);
		$chartType_pie04.eq(i).attr('id', $id);
		$chartType_pie04_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_pie04_array.length; i++) {
		AmCharts.makeChart($chartType_pie04_array[i], {
			"type": "pie",
			"theme": "theme_05",
			"balloonText": "[[title]]<br><b>[[value]]</b><br>([[percents]]%)",
			"labelText": "[[title]]<br>[[percents]]%",
			"titleField": "category",
			"valueField": "column-1",
			"legend": {//범례 유,무
				"enabled": true,
				"align": "center"
			},
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "Normal",
					"column-1": 356.9
				},
				{
					"category": "Error",
					"column-1": 131.1
				},
				{
					"category": "Unknown",
					"column-1": 115.8
				}
			]
		});
	}

	/* --  .chart.theme_05.gauge_04  -- */
	// set temp_id
	var $chartType_gauge04 = $('.chart.theme_05.gauge_04');
	var $chartType_gauge04_array = [];
	for (var i = 0; i < $chartType_gauge04.length; i++) {
		$id = 'chartTempID_gauge4_' + (i + 1);
		$chartType_gauge04.eq(i).attr('id', $id);
		$chartType_gauge04_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_gauge04_array.length; i++) {
		AmCharts.makeChart($chartType_gauge04_array[i], {
			"type": "gauge",
			"theme": "theme_05",
			"fontSize": 12,
			"arrows": [
				{
					"id": "GaugeArrow-1",
					"value": 49.5
				}
			],
			"axes": [
				{
					"id": "GaugeAxis-1",
					"bands": [
						{
							"color": "#28a9ff",
							"endValue": 28,
							"id": "GaugeBand-1",
							"startValue": 10
						},
						{
							"color": "#00CC00",
							"endValue": 56,
							"id": "GaugeBand-2",
							"startValue": 28
						},
						{
							"color": "#FFAC29",
							"endValue": 84,
							"id": "GaugeBand-3",
							"startValue": 56
						},
						{
							"color": "#EA3838",
							"endValue": 112,
							"id": "GaugeBand-4",
							"startValue": 84
						}
					]
				}
			]
		});
	}


	/* --  .chart.theme_06.column_05  -- */
	// set temp_id
	var $chartType_column05 = $('.chart.theme_06.column_05');
	var $chartType_column05_array = [];
	for (var i = 0; i < $chartType_column05.length; i++) {
		$id = 'chartTempID_column5_' + (i + 1);
		$chartType_column05.eq(i).attr('id', $id);
		$chartType_column05_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_column05_array.length; i++) {
		AmCharts.makeChart($chartType_column05_array[i], {
			"type": "serial",
			"theme": "theme_06",
			"categoryField": "category",
			"categoryAxis": {//x축
				"startOnAxis": false, // grid start 지점 지정
				"parseDates": false, // x축 date-related에 의한 정의 줄임
				"labelOffset": 1
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1",
					"stackType": "regular" // 막대유형
				}
			],
			"legend": { //범례 유,무
				"enabled": true
			},
			"balloon": {
				"borderThickness": 0	
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[category]]:[[value]]", //풍선말 텍스트 정보
					"fixedColumnWidth": 2, //data개수가 N개일 경우에는 적용 제한
					"fillAlphas": 1,
					"id": "AmGraph-1",
					"title": "Memory",
					"type": "column",
					"valueField": "column-1"
				}, 
				{
					"balloonText": "[[category]]:[[value]]",
					"fixedColumnWidth": 2, //data개수가 N개일 경우에는 적용 제한
					"fillAlphas": 1,
					"id": "AmGraph-2",
					"title": "Storage",
					"type": "column",
					"valueField": "column-2"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "1",
					"column-1": 3223,
					"column-2": 3004
				},
				{
					"category": "2",
					"column-1": 2424,
					"column-2": 2535
				},
				{
					"category": "3",
					"column-1": 4654,
					"column-2": 3634
				},
				{
					"category": "4",
					"column-1": 2345,
					"column-2": 5657
				},
				{
					"category": "5",
					"column-1": 3454,
					"column-2": 3453
				},
				{
					"category": "6",
					"column-1": 2323,
					"column-2": 2323
				},
				{
					"category": "7",
					"column-1": 2343,
					"column-2": 3423
				},
				{
					"category": "8",
					"column-1": 2343,
					"column-2": 2353
				},
				{
					"category": "9",
					"column-1": 3423,
					"column-2": 2342
				},
				{
					"category": "10",
					"column-1": 4342,
					"column-2": 3443
				},
				{
					"category": "11",
					"column-1": 5454,
					"column-2": 4545
				},
				{
					"category": "12",
					"column-1": 5656,
					"column-2": 3445
				},
				{
					"category": "13",
					"column-1": 2342,
					"column-2": 4234
				},
				{
					"category": "14",
					"column-1": 3434,
					"column-2": 3434
				},
				{
					"category": "15",
					"column-1": 3423,
					"column-2": 3432
				},
				{
					"category": "16",
					"column-1": 2342,
					"column-2": 3223
				},
				{
					"category": "17",
					"column-1": 2234,
					"column-2": 3432
				},
				{
					"category": "18",
					"column-1": 2342,
					"column-2": 2342
				},
				{
					"category": "19",
					"column-1": 3434,
					"column-2": 3434
				},
				{
					"category": "20",
					"column-1": 4343,
					"column-2": 3434
				},
				{
					"category": "21",
					"column-1": 3434,
					"column-2": 3433
				},
				{
					"category": "22",
					"column-1": 2334,
					"column-2": 2323
				},
				{
					"category": "23",
					"column-1": 3434,
					"column-2": 3434
				},
				{
					"category": "24",
					"column-1": 3434,
					"column-2": 2424
				},
				{
					"category": "25",
					"column-1": 2343,
					"column-2": 3232
				},
				{
					"category": "26",
					"column-1": 3434,
					"column-2": 3434
				},
				{
					"category": "27",
					"column-1": 3435,
					"column-2": 5343
				},
				{
					"category": "28",
					"column-1": 3432,
					"column-2": 4234
				},
				{
					"category": "29",
					"column-1": 3234,
					"column-2": 3433
				},
				{
					"category": "30",
					"column-1": 2343,
					"column-2": 2343
				},
				{
					"category": "31",
					"column-1": 2342,
					"column-2": 2342
				}
			]
		});
	}

	/* --  .chart.theme_06.bar_05  -- */
	// set temp_id
	var $chartType_bar05 = $('.chart.theme_06.bar_05');
	var $chartType_bar05_array = [];
	for (var i = 0; i < $chartType_bar05.length; i++) {
		$id = 'chartTempID_bar5_' + (i + 1);
		$chartType_bar05.eq(i).attr('id', $id);
		$chartType_bar05_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_bar05_array.length; i++) {
		AmCharts.makeChart($chartType_bar05_array[i], {
			"type": "serial",
			"theme": "theme_06",
			"marginTop": 23, // legend가 top에 위치하고 숨기는 차트에서  값 개별 설정 
			"categoryField": "category",
			"categoryAxis": {//x축
				"startOnAxis": false, // grid start 지점 지정
				"parseDates": false, // x축 date-related에 의한 정의 줄임
				"tickPosition": "middle", //colum 차트 tick 지정
				"tickLength": 0, // label line 길이
				"labelOffset": 1
			},
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			"chartCursor": {// balloon 유,무
				"enabled": true,
				"zoomable": false //확대,축소 기능 삭제
			},
			"balloon": {
				"borderThickness": 0	
			},
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"balloonText": "[[value]]", //풍선말 텍스트 정보
					"columnWidth": 0.3,
					"cornerRadiusTop": 17,
					"fillAlphas": 1,
					"fillColors": "#5E54E4", //컬러 별도 지정 가능
					//"lineColor": "#5E54E4", //컬러 별도 지정 가능
					"lineThickness": 0,
					"id": "AmGraph-1",
					"title": "Memory",
					"type": "column",
					"valueField": "column-1"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "MON",
					"column-1": 2.67
				},
				{
					"category": "TUE",
					"column-1": 2.45
				},
				{
					"category": "WED",
					"column-1": 2.35
				},
				{
					"category": "THU",
					"column-1": 2.27
				},
				{
					"category": "FRI",
					"column-1": 2.18
				},
				{
					"category": "SAT",
					"column-1": 2.18
				},
				{
					"category": "SUN",
					"column-1": 2.1
				}
			]
		});
	}


	/* --  .chart.theme_07.line_05  -- */
	// set temp_id
	var $chartType_line05 = $('.chart.theme_07.line_05');
	var $chartType_line05_array = [];
	for (var i = 0; i < $chartType_line05.length; i++) {
		$id = 'chartTempID_line5_' + (i + 1);
		$chartType_line05.eq(i).attr('id', $id);
		$chartType_line05_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_line05_array.length; i++) {
		AmCharts.makeChart($chartType_line05_array[i], {
			"type": "serial",
			"theme": "theme_07",
			"categoryField": "date", //date 챠트로 지정
			"dataDateFormat": "YYYY-MM-DD HH:NN:SS", //date format 지정
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"id": "AmGraph-1",
					"title": "Memory",
					"valueField": "column-1"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 28,
					"date": "2014-03-01 07:51"
				}, 
				{
					"column-1": 46,
					"date": "2014-03-01 07:52"
				}, 
				{
					"column-1": 22,
					"date": "2014-03-01 07:53"
				}, 
				{
					"column-1": 49,
					"date": "2014-03-01 07:54"
				}, 
				{
					"column-1": 40,
					"date": "2014-03-01 07:55"
				}, 
				{
					"column-1": 22,
					"date": "2014-03-01 07:56"
				}, 
				{
					"column-1": 45,
					"date": "2014-03-01 07:57"
				}, 
				{
					"column-1": 22,
					"date": "2014-03-01 07:58"
				}, 
				{
					"column-1": 32,
					"date": "2014-03-01 07:59"
				}, 
				{
					"column-1": 52,
					"date": "2014-03-01 08:00"
				}, 
				{
					"column-1": 22,
					"date": "2014-03-01 08:01"
				}, 
				{
					"column-1": 42,
					"date": "2014-03-01 08:02"
				}, 
				{
					"column-1": 22,
					"date": "2014-03-01 08:03"
				}, 
				{
					"column-1": 32,
					"date": "2014-03-01 08:04"
				}, 
				{
					"column-1": 49,
					"date": "2014-03-01 08:05"
				}, 
				{
					"column-1": 25,
					"date": "2014-03-01 08:06"
				},
				{
					"column-1": 40,
					"date": "2014-03-01 08:07"
				}
			]
		});
	}

	/* --  .chart.theme_07.bar_06  -- */
	// set temp_id
	var $chartType_bar06 = $('.chart.theme_07.bar_06');
	var $chartType_bar06_array = [];
	for (var i = 0; i < $chartType_bar06.length; i++) {
		$id = 'chartTempID_bar6_' + (i + 1);
		$chartType_bar06.eq(i).attr('id', $id);
		$chartType_bar06_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_bar06_array.length; i++) {
		AmCharts.makeChart($chartType_bar06_array[i], {
			"type": "serial",
			"theme": "theme_07",
			"categoryField": "category",
			"valueAxes": [//y축
				{
					"id": "ValueAxis-1"
				}
			],
			///////////////////////////   GRAPHS   ////////////////
			"graphs": [
				{
					"fixedColumnWidth": 3,
					"fillAlphas": 1,
					"id": "AmGraph-1",
					"title": "Memory",
					"type": "column",
					"valueField": "column-1"
				}
			],
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"column-1": 100,
					"date": "2016-11-30 07:57:57"
				},
				{
					"column-1": 180,
					"date": "2016-11-30 07:57:58"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:57:59"
				},
				{
					"column-1": 150,
					"date": "2016-11-30 07:58:00"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:58:01"
				},
				{
					"column-1": 190,
					"date": "2016-11-30 07:58:02"
				},
				{
					"column-1": 160,
					"date": "2016-11-30 07:58:03"
				},
				{
					"column-1": 130,
					"date": "2016-11-30 07:58:04"
				},
				{
					"column-1": 180,
					"date": "2016-11-30 07:58:05"
				},
				{
					"column-1": 120,
					"date": "2016-11-30 07:58:06"
				}
			]
		});
	}

	/* --  .chart.theme_07.pie_05  -- */
	// set temp_id
	var $chartType_pie05 = $('.chart.theme_07.pie_05');
	var $chartType_pie05_array = [];
	for (var i = 0; i < $chartType_pie05.length; i++) {
		$id = 'chartTempID_pie5_' + (i + 1);
		$chartType_pie05.eq(i).attr('id', $id);
		$chartType_pie05_array[i] = $id;
	}
	// run chart
	for (var i = 0; i < $chartType_pie05_array.length; i++) {
		AmCharts.makeChart($chartType_pie05_array[i], {
			"type": "pie",
			"theme": "theme_07",
			"titleField": "category",
			"valueField": "column-1",
			///////////////////////////   DATA   //////////////////
			"dataProvider": [
				{
					"category": "TCP",
					"column-1": 70
				},
				{
					"category": "UDP",
					"column-1": 40
				},
				{
					"category": "UDP",
					"column-1": 20
				},
				{
					"category": "ICMP",
					"column-1": 10
				}
			]
		});
	}



//////////chart end//////////
});

///////////// Temp data // generate some random data, quite different range
var chartData = new function generateChartData() {
	var chartData = [];
	// current date
	var firstDate = new Date();
	// now set 500 minutes back
	firstDate.setMinutes(firstDate.getDate() - 1000);

	// and generate 500 data items
	for (var i = 0; i < 500; i++) {
		var newDate = new Date(firstDate);
		// each time we add one minute
		newDate.setMinutes(newDate.getMinutes() + i);
		// some random number
		var value_no = Math.round(Math.random() * 40 + 10 + i + Math.random() * i / 5);
		// add data item to the array
		chartData.push({
			date: newDate,
			value_no: value_no
		});
	}
	return chartData;
}

