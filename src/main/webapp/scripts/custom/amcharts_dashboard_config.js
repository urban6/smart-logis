/* Total node chart config */
var totlaNodeConfig ={
	    "type": "serial",
	    "columnWidth": 1,
	    "autoMargins": false,
	    "marginBottom": 0,
	    "marginLeft": 0,
	    "marginRight": 0,
	    "marginTop": 0,
	    "minMarginBottom": 0,
	    "minMarginLeft": 0,
	    "minMarginRight": 0,
	    "minMarginTop": 0,
	    "startDuration": 0,
	    "startEffect": "easeOutSine",
	    "fontSize": 12,
	    "categoryAxis": {
	      "gridPosition": "start",
	      "axisAlpha": 0,
	      "gridAlpha": 0,
	      "tickLength": 0,
	      "labelsEnabled": false
	    },
	    "guides": [],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "stackType": "100%",
	        "axisAlpha": 0,
	        "gridAlpha": 0,
	        "labelsEnabled": false
	      }
	    ],
	    "allLabels": [],
	    "balloon": {
	      "fixedPosition": false,
	      "fillAlpha": 0.88,
	      "pointerWidth": 0,
	      "shadowAlpha": 0.2
	    }
	  };



/* dashboard chart config */
var totlaAlarmConfig ={
	    "type": "serial",
	    "categoryField": "alarm_group",
	    "columnWidth": 0.2,
	    "marginRight": 15,
	    "colors": [
	      "#dd1717",
	      "#f2690e",
	      "#f2b230",
	      "#7b6b98"
	    ],
	    "startDuration": 1,
	    "categoryAxis": {
	      /*"autoRotateAngle": 30,*/
	      /*"autoRotateCount": 1,*/
	      "autoWrap": true,
	      "gridPosition": "start",
	      "gridAlpha": 0,
	      "axisColor": "#d2d4d6",
	      "color": "#929aa6",
	      "tickLength": 0
	    },
	    "trendLines": [],
	    "graphs": [
	      {
	          "balloonText": "Critical<p style='font-size:14px'><b>[[value]]</b><p>",
	          "fillAlphas": 1,
	          "id": "AmGraph-1",
	          "title": "graph 1",
	          "type": "column",
	          "valueField": "critical"
	      },
	      {
	          "balloonText": "Major<p style='font-size:14px'><b>[[value]]</b><p>",
	          "fillAlphas": 1,
	          "id": "AmGraph-2",
	          "title": "graph 2",
	          "type": "column",
	          "valueField": "major"
	      },
	      {
	          "balloonText": "Minor<p style='font-size:14px'><b>[[value]]</b><p>",
	          "fillAlphas": 1,
	          "id": "AmGraph-3",
	          "title": "graph 3",
	          "type": "column",
	          "valueField": "minor"
	      },
	      {
	          "balloonText": "Fault<p style='font-size:14px'><b>[[value]]</b><p>",
	          "fillAlphas": 1,
	          "id": "AmGraph-4",
	          "title": "graph 4",
	          "type": "column",
	          "valueField": "fault"
	      }
	    ],
	    "guides": [],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "stackType": "regular",
	        "axisAlpha": 0,
	        "gridAlpha": 0,
	        "labelsEnabled": false
	      }
	    ],
	    "allLabels": [],
	    "balloon": {
	        "fillAlpha": 0.88,
	        "shadowAlpha": 0.2
	      },
	    "titles": []
	     
	  };




/* dashboard chart  config - Top5 resource */
var topResourceConfig = ['CPU','Memory','Disk','Tablespace'];

 /*CPU*/
 topResourceConfig[0] = {
	    "type": "serial",
	    "categoryField": "category",
	    "rotate": true,
	    "autoMargins": false,
	    "marginBottom": 7,
	    "marginLeft": -1,
	    "marginRight": 15,
	    "marginTop": 0,
	    "startDuration": 0.5,
	    "startEffect": "easeInSine",
	    //"precision": 2,
	    "addClassNames": true,
	    "fontSize": 12,
	    "categoryAxis": {
	      "axisAlpha": 0,
	      "color": "#828d99",
	      "gridAlpha": 0,
	      "tickLength": 0,
	      "labelsEnabled": false
	    },
	    "graphs": [
	      {
	        "color":"#787e87",
	        "balloonText": "<b>[[value]]</b>",
	        "colorField": "color",
	        "fillAlphas": 1,
	        "fixedColumnWidth": 6,
	        "fontSize": -16,
	        "gradientOrientation": "horizontal",
	        "id": "AmGraph-1",
	        "labelOffset": -2,
	        "labelPosition": "inside",
	        "labelText": "[[category]] ([[value]])",
	        "showAllValueLabels": true,
	        "lineColorField": "color",
	        "title": "graph 1",
	        "type": "column",
	        "valueField": "column-1",
	        "labelFunction": function(value){
	        	var category  = value.category;
	        	var value_obj = value.values.value;
                if(category == ""){
                	return ""  ;
	            }else{
	            	return category+" "+"("+value_obj+")";	
	            }
             }
	      }
	    ],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "axisAlpha": 0,
	        "gridAlpha": 0,
	        "labelsEnabled": false
	      }
	    ],
	    "balloon": {
	      "fillAlpha": 0.88,
	      "shadowAlpha": 0.2
	    }
	  };

 /*Memory*/
 topResourceConfig[1] = {
		    "type": "serial",
		    "categoryField": "category",
		    "rotate": true,
		    "autoMargins": false,
		    "marginBottom": 7,
		    "marginLeft": -1,
		    "marginRight": 15,
		    "marginTop": 0,
		    "startDuration": 0.5,
		    "startEffect": "easeInSine",
		    //"precision": 1,
		    "addClassNames": true,
		    "fontSize": 12,
		    "categoryAxis": {
		      "axisAlpha": 0,
		      "color": "#828d99",
		      "gridAlpha": 0,
		      "tickLength": 0,
		      "labelsEnabled": false
		    },
		    "graphs": [
		      {
		        "color":"#787e87",
		        "balloonText": "<b>[[value]]</b>",
		        "colorField": "color",
		        "fillAlphas": 1,
		        "fixedColumnWidth": 6,
		        "fontSize": -16,
		        "gradientOrientation": "horizontal",
		        "id": "AmGraph-1",
		        "labelOffset": -2,
		        "labelPosition": "inside",
		        "labelText": "[[category]] ([[value]])",
		        "showAllValueLabels": true,
		        "lineColorField": "color",
		        "title": "graph 1",
		        "type": "column",
		        "valueField": "column-1",
		        "labelFunction": function(value){
		        	var category  = value.category;
		        	var value_obj = value.values.value;
	                if(category == ""){
	                	return ""  ;
		            }else{
		            	return category+" "+"("+value_obj+")";	
		            }
                 }
		      }
		    ],
		    "valueAxes": [
		      {
		        "id": "ValueAxis-1",
		        "axisAlpha": 0,
		        "gridAlpha": 0,
		        "labelsEnabled": false
		      }
		    ],
		    "balloon": {
		      "fillAlpha": 0.88,
		      "shadowAlpha": 0.2
		    }
		  };
 /*Disk*/
 topResourceConfig[2] = {
		    "type": "serial",
		    "categoryField": "category",
		    "rotate": true,
		    "autoMargins": false,
		    "marginBottom": 7,
		    "marginLeft": -1,
		    "marginRight": 15,
		    "marginTop": 0,
		    "startDuration": 0.5,
		    "startEffect": "easeInSine",
		    "addClassNames": true,
		    "fontSize": 12,
		    "categoryAxis": {
		      "axisAlpha": 0,
		      "color": "#828d99",
		      "gridAlpha": 0,
		      "tickLength": 0,
		      "labelsEnabled": false
		    },
		    "graphs": [
		      {
		        "color":"#787e87",
		        "balloonText": "<b>[[value]]</b>",
		        "colorField": "color",
		        "fillAlphas": 1,
		        "fixedColumnWidth": 6,
		        "fontSize": -16,
		        "gradientOrientation": "horizontal",
		        "id": "AmGraph-1",
		        "labelOffset": -2,
		        "labelPosition": "inside",
		        "labelText": "[[category]] ([[value]])",
		        "showAllValueLabels": true,
		        "lineColorField": "color",
		        "title": "graph 1",
		        "type": "column",
		        "valueField": "column-1",
		        "labelFunction": function(value){
		        	var category  = value.category;
		        	var value_obj = value.values.value;
	                if(category == ""){
	                	return ""  ;
		            }else{
		            	return category+" "+"("+value_obj+")";	
		            }
                 }
		      }
		    ],
		    "valueAxes": [
		      {
		        "id": "ValueAxis-1",
		        "axisAlpha": 0,
		        "gridAlpha": 0,
		        "labelsEnabled": false
		      }
		    ],
		    "balloon": {
		      "fillAlpha": 0.88,
		      "shadowAlpha": 0.2
		    }
		  };
 /*Tablespace*/
 topResourceConfig[3] = {
		    "type": "serial",
		    "categoryField": "category",
		    "rotate": true,
		    "autoMargins": false,
		    "marginBottom": 7,
		    "marginLeft": -1,
		    "marginRight": 15,
		    "marginTop": 0,
		    "startDuration": 0.5,
		    "startEffect": "easeInSine",
		    "addClassNames": true,
		    "fontSize": 12,
		    "categoryAxis": {
		      "axisAlpha": 0,
		      "color": "#828d99",
		      "gridAlpha": 0,
		      "tickLength": 0,
		      "labelsEnabled": false
		    },
		    "graphs": [
		      {
		        "color":"#787e87",
		        "balloonText": "<b>[[value]]</b>",
		        "colorField": "color",
		        "fillAlphas": 1,
		        "fixedColumnWidth": 6,
		        "fontSize": -16,
		        "gradientOrientation": "horizontal",
		        "id": "AmGraph-1",
		        "labelOffset": -2,
		        "labelPosition": "inside",
		        "labelText": "[[category]] ([[value]])",
		        "showAllValueLabels": true,
		        "lineColorField": "color",
		        "title": "graph 1",
		        "type": "column",
		        "valueField": "column-1",
		        "labelFunction": function(value){
		        	var category  = value.category;
		        	var value_obj = value.values.value;
	                if(category == ""){
	                	return ""  ;
		            }else{
		            	return category+" "+"("+value_obj+")";	
		            }
                 }
		      }
		    ],
		    "valueAxes": [
		      {
		        "id": "ValueAxis-1",
		        "axisAlpha": 0,
		        "gridAlpha": 0,
		        "labelsEnabled": false
		      }
		    ],
		    "balloon": {
		      "fillAlpha": 0.88,
		      "shadowAlpha": 0.2
		    }
		  };