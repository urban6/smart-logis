/* Alarm Statistics chart config */
var alarmStatisticsConfig ={
 	    "type": "serial",
 	    "categoryField": "PRC_DATE",
 	    "colors": [
 	              "#29b4cc",
 	              "#fd625e",
 	              "#404f52",
 	              "#f2c318",
 	              "#c252cc",
 	              "#bd7b4b",
 	              "#3272d9",
 	              "#f21835",
 	              "#32c253",
 	              "#ef8ede",
 	              "#3e7f82"
 	            ],
 	            "plotAreaFillAlphas": 1,
 	            "plotAreaFillColors": "#f8fafa",
 	            "autoMarginOffset": 35,
 	            "marginRight": 354,
 	            "marginTop": 35,
 	            "fontFamily": "Segoe UI",
 	            "fontSize": 12,
 	            "categoryAxis": {
 	              "equalSpacing": true,
 	              "minPeriod": "mm",
 	              "parseDates": true,
 	              "startOnAxis": true,
 	              "gridAlpha": 0,
 	              "labelOffset": -3,
 	              "color": "#3e3e3e",
 	              "axisColor": "#3e3e3e",
 	              "boldPeriodBeginning": false,
 	              "centerLabelOnFullPeriod": false,
 	              "tickLength": 5
 	            },
 	        		"chartCursor": {
 	        			"enabled": true,
 	        			"categoryBalloonDateFormat": "JJ:NN",
 	              "cursorPosition": "middle",
 	              "cursorColor": "#2a3139",
 	              "graphBulletSize": 9,
 	              "selectionAlpha": 0.15
 	        		},
 	        		"chartScrollbar": {
 	        			"enabled": true,
 	              "backgroundColor": "#e1e1e1",
 	              "dragIcon": "dragIconRectBig",
 	              "dragIconHeight": 32,
 	              "scrollbarHeight": 10
 	        		},
 	        		"trendLines": [],
 	        		"allLabels": [],
 	            "balloon": {
 	              /*"adjustBorderColor": false,*/
 	              /*"borderAlpha": 0,*/
 	              /*"color": "#FFFFFF",*/
 	              "borderThickness": 1,
 	              "fontSize": 10,
 	              "cornerRadius": 2,
 	              "fillAlpha": 1,
 	              "pointerWidth": 10,
 	              "shadowAlpha": 0,
 	              "horizontalPadding": 6,
 	              "verticalPadding": 3,
 	              "textAlign": "left"
 	            },
 	            "legend": {
 	              "enabled": true,
 	              "autoMargins": false,
 	              "backgroundAlpha": 1,
 	              "backgroundColor": "#FFF",
 	              "color": "#808080",
 	              "fontSize": 12,
 	              "horizontalGap": 24,
 	              "labelWidth": 200,
 	              "marginLeft": 20,
 	              "marginRight": 20,
 	              "markerLabelGap": 12,
 	              "markerSize": 12,
 	              "markerType": "circle",
 	              "maxColumns": 0,
 	              "position": "absolute",
 	              "verticalGap": 12,
 	              "right": 0,
 	              "width": 284,
 	              "valueText": ""
 	            },
 	        		"titles": [],
 	    	    "export": {
 	    	        "enabled": true,
 	              "libs"  : {
 	                "path": "/scripts/amcharts_3.19.4/amcharts/plugins/export/libs/"
 	              }, 
 	              "menu": []
 	    	    }	
 			};

/* Resource Statistics chart config */
var resourceStatisticsConfig ={
 	    "type": "serial",
 	    "categoryField": "PRC_DATE",
 	    "colors": [
 	              "#29b4cc",
 	              "#fd625e",
 	              "#404f52",
 	              "#f2c318",
 	              "#c252cc",
 	              "#bd7b4b",
 	              "#3272d9",
 	              "#f21835",
 	              "#32c253",
 	              "#ef8ede",
 	              "#3e7f82"
 	            ],
 	            "plotAreaFillAlphas": 1,
 	            "plotAreaFillColors": "#f8fafa",
 	            "autoMarginOffset": 35,
 	            "marginRight": 354,
 	            "marginTop": 35,
 	            "fontFamily": "Segoe UI",
 	            "fontSize": 12,
 	            "categoryAxis": {
 	              "equalSpacing": true,
 	              "minPeriod": "mm",
 	              "parseDates": true,
 	              "startOnAxis": true,
 	              "gridAlpha": 0,
 	              "labelOffset": -3,
 	              "color": "#3e3e3e",
 	              "axisColor": "#3e3e3e",
 	              "boldPeriodBeginning": false,
 	              "centerLabelOnFullPeriod": false,
 	              "tickLength": 5
 	            },
 	        		"chartCursor": {
 	        			"enabled": true,
 	        			"categoryBalloonDateFormat": "JJ:NN",
 	              "cursorPosition": "middle",
 	              "cursorColor": "#2a3139",
 	              "graphBulletSize": 9,
 	              "selectionAlpha": 0.15
 	        		},
 	        		"chartScrollbar": {
 	        			"enabled": true,
 	              "backgroundColor": "#e1e1e1",
 	              "dragIcon": "dragIconRectBig",
 	              "dragIconHeight": 32,
 	              "scrollbarHeight": 10
 	        		},
 	        		"trendLines": [],
 	        		"allLabels": [],
 	            "balloon": {
 	              /*"adjustBorderColor": false,*/
 	              /*"borderAlpha": 0,*/
 	              /*"color": "#FFFFFF",*/
 	              "borderThickness": 1,
 	              "fontSize": 10,
 	              "cornerRadius": 2,
 	              "fillAlpha": 1,
 	              "pointerWidth": 10,
 	              "shadowAlpha": 0,
 	              "horizontalPadding": 6,
 	              "verticalPadding": 3,
 	              "textAlign": "left"
 	            },
 	            "legend": {
 	              "enabled": true,
 	              "autoMargins": false,
 	              "backgroundAlpha": 1,
 	              "backgroundColor": "#FFF",
 	              "color": "#808080",
 	              "fontSize": 12,
 	              "horizontalGap": 24,
 	              "labelWidth": 200,
 	              "marginLeft": 20,
 	              "marginRight": 20,
 	              "markerLabelGap": 12,
 	              "markerSize": 12,
 	              "markerType": "circle",
 	              "maxColumns": 0,
 	              "position": "absolute",
 	              "verticalGap": 12,
 	              "right": 0,
 	              "width": 284,
 	              "valueText": ""
 	            },
 	        		"titles": [],
 	    	    "export": {
 	    	        "enabled": true,
 	              "libs"  : {
 	                "path": "/scripts/amcharts_3.19.4/amcharts/plugins/export/libs/"
 	              }, 
 	              "menu": []
 	    	    }	
 			};

/* Performance Statistics chart config */
var performanceStatisticsConfig ={
 	    "type": "serial",
 	    "categoryField": "PRC_DATE",
 	    "colors": [
 	              "#29b4cc",
 	              "#fd625e",
 	              "#404f52",
 	              "#f2c318",
 	              "#c252cc",
 	              "#bd7b4b",
 	              "#3272d9",
 	              "#f21835",
 	              "#32c253",
 	              "#ef8ede",
 	              "#3e7f82"
 	            ],
 	            "plotAreaFillAlphas": 1,
 	            "plotAreaFillColors": "#f8fafa",
 	            "autoMarginOffset": 35,
 	            "marginRight": 354,
 	            "marginTop": 35,
 	            "fontFamily": "Segoe UI",
 	            "fontSize": 12,
 	            "categoryAxis": {
 	              "equalSpacing": true,
 	              "minPeriod": "mm",
 	              "parseDates": true,
 	              "startOnAxis": true,
 	              "gridAlpha": 0,
 	              "labelOffset": -3,
 	              "color": "#3e3e3e",
 	              "axisColor": "#3e3e3e",
 	              "boldPeriodBeginning": false,
 	              "centerLabelOnFullPeriod": false,
 	              "tickLength": 5
 	            },
 	        		"chartCursor": {
 	        			"enabled": true,
 	        			"categoryBalloonDateFormat": "JJ:NN",
 	              "cursorPosition": "middle",
 	              "cursorColor": "#2a3139",
 	              "graphBulletSize": 9,
 	              "selectionAlpha": 0.15
 	        		},
 	        		"chartScrollbar": {
 	        			"enabled": true,
 	              "backgroundColor": "#e1e1e1",
 	              "dragIcon": "dragIconRectBig",
 	              "dragIconHeight": 32,
 	              "scrollbarHeight": 10
 	        		},
 	        		"trendLines": [],
 	        		"allLabels": [],
 	            "balloon": {
 	              /*"adjustBorderColor": false,*/
 	              /*"borderAlpha": 0,*/
 	              /*"color": "#FFFFFF",*/
 	              "borderThickness": 1,
 	              "fontSize": 10,
 	              "cornerRadius": 2,
 	              "fillAlpha": 1,
 	              "pointerWidth": 10,
 	              "shadowAlpha": 0,
 	              "horizontalPadding": 6,
 	              "verticalPadding": 3,
 	              "textAlign": "left"
 	            },
 	            "legend": {
 	              "enabled": true,
 	              "autoMargins": false,
 	              "backgroundAlpha": 1,
 	              "backgroundColor": "#FFF",
 	              "color": "#808080",
 	              "fontSize": 12,
 	              "horizontalGap": 24,
 	              "labelWidth": 200,
 	              "marginLeft": 20,
 	              "marginRight": 20,
 	              "markerLabelGap": 12,
 	              "markerSize": 12,
 	              "markerType": "circle",
 	              "maxColumns": 0,
 	              "position": "absolute",
 	              "verticalGap": 12,
 	              "right": 0,
 	              "width": 284,
 	              "valueText": ""
 	            },
 	        		"titles": [],
 	    	    "export": {
 	    	        "enabled": true,
 	              "libs"  : {
 	                "path": "/scripts/amcharts_3.19.4/amcharts/plugins/export/libs/"
 	              }, 
 	              "menu": []
 	    	    }	
 			};
