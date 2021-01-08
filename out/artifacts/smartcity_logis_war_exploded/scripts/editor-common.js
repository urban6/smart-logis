(function() {

	function getUtf8ByteSize(string) {
	    var utf8length = 0;

	    for (var n = 0; n < string.length; n++) {
	        var c = string.charCodeAt(n);
	        if (c < 128) {
	        	utf8length++;
	        	if ( c == 10 ) {
	        		utf8length++;
	        	}
	        } else if((c > 127) && (c < 2048)) {
	        	utf8length = utf8length+2;
	        } else {
	        	utf8length = utf8length+3;
	        }
	    }

	    return utf8length;
	}
	
    // ######## ajax error options ########
    var ajaxErrorOptions = function(x, s, e) {
        if (x.status == 0) {
            alert('Error. : Please Check Your Network.');
        } else if (x.status == 404) {
            alert('Error. : Page not found.');
        } else if (x.status == 500) {
            alert('Error. : Internel Server Error.');
        } else if (e == 'timeout') {
            alert('Error. : Request Time out.');
        } else {
            alert('Unknow Error. : ' + x.responseText);
        }
    };
    
    // ######## Validate default options ########
    var validateDefaultOptions = {
        onkeyup: false,
        onclick: false,
        onfocusout: false,
        showErrors: function(errorMap, errorList) {
            if (this.numberOfInvalids()) {
                alert(errorList[0].message);
                var $elem = $(errorList[0].element);
                try {
                    var _idx = $elem.data('idx');
                    tinyMCE.editors[_idx].focus();
                } catch(e) {
                    $elem.focus();
                }
            }
        }
    };


    // ########## TinyMCE init options ########
    var tinymceInitOptions = function(languageCode ,selector , readonly) {
        var options = {
            selector: selector,
            theme: "modern",
            menubar: false,
            resize: "horizontal",
            //width: 1150,
            //height: 202,
            //br_in_pre: false,
            nowrap: false,
            forced_root_block: false, //IE에서 한글입력 문제 해결을 위해서
            relative_urls: false,
            statusbar: false,
            plugins: [
                "advlist autolink autoresize link image lists charmap print preview hr anchor pagebreak spellchecker",
                "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                "save table contextmenu directionality paste textcolor jbimages"
            ], // imagetools
            //toolbar: "fontselect fontsizeselect | bold italic forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | table link jbimages | preview "
            toolbar: "fontselect fontsizeselect | bold italic forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | table link | preview",
            init_instance_callback: function (editor) {
                editor.on('keyup', function (e) {
                	// 1000 byte 제한
                	var text = tinymce.get(this.id).getContent();                	
                	if(text.length > 0){
	                	var convText = byteCut(text,1000);
	                	if(getUtf8ByteSize(text) <= 1000){
	                		tinymce_updateCharCounter(this,tinymce_getContentLength());	
	                	}else{
	                		tinymce.get(this.id).setContent(convText);
	                	}
                	}else{
                		tinymce_updateCharCounter(this,0);	
                	}
                });
              }
        };

        if (languageCode != '10801100') {
            jQuery.extend(options, { language: 'ko_KR' });
        }
        
        if (readonly != '') {
            jQuery.extend(options, { readonly: 1 });
            jQuery.extend(options, { toolbar: false });
        }

        return options;
    };

    function tinymce_updateCharCounter(el, len) {
    	var text = tinymce.get(el.id).getContent();
    	var byteSize = getUtf8ByteSize(text);
        //$('#' + el.id).prev().find('.mce-wordcount').text('단어 : '+ byteSize + ' /1000 byte');
    	var contLen = text.split(' ');
    	
    	$('#' + el.id).prev().find('.mce-wordcount').text('단어 : '+ contLen.length);
    }
    
    function tinymce_getContentLength() {
        return tinymce.get(tinymce.activeEditor.id).contentDocument.body.innerText.length;
    }
    
    // ######## 바이트 단위로 문자열 자르기 ########
    var byteCut = function byteCut(s, len) {
        if (s == null || s.length == 0) {
            return 0;
        }
        var size = 0;
        var rIndex = s.length;
        for (var i = 0; i < s.length; i++) {
            size += getUtf8ByteSize(s.charAt(i));
            if (size == len) {
                rIndex = i + 1;
                break;
            } else if (size > len) {
                rIndex = i;
                break;
            }
        }
        return s.substring(0, rIndex);
    }
    
    var root = this;
    var version = '1.0';
    var editCommon;
    if (typeof exports !== 'undefined') {
    	editCommon = exports;
    } else {
    	editCommon = root.editCommon = {};
    }

    editCommon.getAjaxErrorOpts = ajaxErrorOptions;
    editCommon.validateDefaultOpts = validateDefaultOptions;
    editCommon.getTinymceInitOpts = tinymceInitOptions;

    editCommon.byteCut = byteCut;

}).call(this);
