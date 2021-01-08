

AmCharts.cloneObject = function (obj) {
    return JSON.parse(JSON.stringify(obj));
};

var configTemplate = {
		"type": "serial",
	      "categoryField": "category",
	      "columnWidth": 0.7,
	      "rotate": true,
	      "autoMargins": false,
	      "marginBottom": 7,
	      "marginLeft": 0,
	      "marginRight": 15,
	      "marginTop": 0,
	      "startDuration": 0.5,
	      "startEffect": "easeInSine",
	      "addClassNames": true,
	      "fontFamily": "Segoe UI",
	      "fontSize": 12,
	      "categoryAxis": {
	        "axisAlpha": 0,
	        "color": "#828d99",
	        "gridAlpha": 0,
	        "tickLength": 0,
	        "labelsEnabled": false
	      },
	      "trendLines": [],
	      "graphs": [
	        {
	          "balloonText": "[[category]] : <b>[[value]]</b>",
	          "colorField": "color",
	          "fillAlphas": 1,
	          "id": "AmGraph-1",
	          "lineColorField": "color",
	          "title": "graph 1",
	          "type": "column",
	          "valueField": "column-1"
	        }
	      ],
	      "guides": [],
	      "valueAxes": [
	        {
	          "id": "ValueAxis-1",
	          "axisAlpha": 0,
	          "gridAlpha": 0,
	          "gridColor": "#FF0000",
	          "labelsEnabled": false
	        }
	      ],
	      "allLabels": [],
	      "balloon": {
	        "borderThickness": 2,
	        "fontSize": 13,
	        "cornerRadius": 3,
	        "maxWidth": 170,
	        "fillAlpha": 1,
	        "pointerWidth": 10,
	        "shadowAlpha": 0,
	        "horizontalPadding": 7,
	        "verticalPadding": 4,
	        "textAlign": "left"
	      },
	      "titles": [],
};
