/*
 * openConfirmModal("Message", "Description", function() {console.log("ok");}, function() {console.log("cancel")}, "OK", "Cancel");
 */
function openConfirmModal(sTitle, sDescription, fnOK, fnCancel, sOK, sCancel, bModal) {
	if (sTitle == null) {
		sTitle = "";
	}
	if (sDescription == null) {
		sDescription = "";
	}
	if (sOK == null) {
		sOK = "Continue";
	}
	if (sCancel == null) {
		sCancel = "Go Back";
	}
	if (bModal == null) {
		bModal = true;
	}

	var sHtml = "";
	sHtml += "<section id=\"confirmModalDiv\" class=\"";
	if (!bModal) {
		sHtml += "open_popup ";
	}
	sHtml += "popup\">\n";
	sHtml += "	<div class=\"pop_wrap\">\n";
	sHtml += "		<div class=\"pop_head\">\n";
	sHtml += "			<h1>"+stringToHtml(sTitle)+"</h1>\n";
	sHtml += "			<button class=\"btn close ";
	if (bModal) {
		sHtml += "simplemodal-close";
	}
	sHtml += " \" type=\"button\" id=\"confirmModal_closeButton\"></button>\n";
	sHtml += "		</div>\n";
	sHtml += "		<div class=\"pop_cont\">\n";
	sHtml += "			<p class=\"text_cont\">\n";
	sHtml += "					"+stringToHtml(sDescription)+"\n";
	sHtml += "			</p>\n";
	sHtml += "		</div>\n";
	sHtml += "		<div class=\"btn_area\">\n";
	sHtml += "			<button type=\"button\" id=\"confirmModal_cancelButton\" class=\"btn type_01 ";
	if (bModal) {
		sHtml += "simplemodal-close";
	}
	sHtml += "\">"+sCancel+"</button>\n";
	sHtml += "			<button type=\"button\" id=\"confirmModal_okButton\" class=\"btn type_01 primary ";
	if (bModal) {
		sHtml += "simplemodal-close";
	}
	sHtml += "\">"+sOK+"</button>\n";
	sHtml += "		</div>\n";
	sHtml += "	</div>\n";
	sHtml += "</section>\n";
	$("body").append(sHtml);

	$("#confirmModal_okButton").click(function() {
		if (fnOK != null) {
			fnOK.call();
		}
	});

	$("#confirmModal_closeButton, #confirmModal_cancelButton").click(function() {
		if (fnCancel != null) {
			fnCancel.call();
		}
	});

	if (bModal) {
		openModal("#confirmModalDiv", {opacity:0, escClose:false, close:false, overlayClose:false, onShow: function (dialog) {
            	dialog.container.draggable({handle: ".pop_head", containment: "body"});
        	}
		});
	} else {
		openPopup("#confirmModalDiv");
	}
}

/*
 * openAlertModal("Message", "Description", function() {console.log("ok");}, "OK");
 */
function openAlertModal(sTitle, sDescription, fnOK, sOK) {
	if (sTitle == null) {
		sTitle = "";
	}
	if (sDescription == null) {
		sDescription = "";
	}
	if (sOK == null) {
		sOK = "OK";
	}
	console.log("popupUtil");

	//closeModal("#alertModalDiv");

	var sHtml = "";
	var className = "";
	if (sTitle.toLowerCase() == "success") {
		className = "noti ok";
	} else if (sTitle.toLowerCase() == "warning") {
		className = "noti warning";
	} else if (sTitle.toLowerCase() == "fail" || sTitle.toLowerCase() == "error") {
		className = "noti fail";
	}
	sHtml += "<section id=\"alertModalDiv\" class=\"popup\">\n";
	sHtml += "	<div class=\"pop_wrap\">\n";
	sHtml += "		<div class=\"alert\">\n";
	sHtml += "			<p class=\""+className+"\">"+sTitle.toUpperCase()+"</p>\n";
	sHtml += "			<div class=\"text_cont\">\n";
	sHtml += "				"+sDescription+"\n";
	sHtml += "			</div>\n";
	sHtml += "			<div class=\"btn_area\">\n";
	sHtml += "				<button type=\"button\" id=\"alertModal_okButton\" class=\"btn type_01 primary simplemodal-close\">"+sOK+"</button>\n";
	sHtml += "			</div>\n";
	sHtml += "		</div>\n";
	sHtml += "	</div>\n";
	sHtml += "</section>\n";
	$("body").append(sHtml);
/*
	$("#alertModal_okButton").click(function() {
		console.log("buttonEventOK");
		if (fnOK != null) {
			fnOK.call();
		}
		//closeModal("#alertModalDiv");
	});
*/
	$(document).on("click", "#alertModal_okButton", function(){
		if (fnOK != null) {
			fnOK.call();
		}
	});

	openModal("#alertModalDiv", {opacity:0, escClose:false, close:false, overlayClose:false, onShow: function (dialog) {
        	dialog.container.draggable({handle: ".pop_head", containment: "body"});
    	}
	});
}

function openAlertModal_old(sTitle, sDescription, fnOK, sOK, bModal) {
	if (sTitle == null) {
		sTitle = "";
	}
	if (sDescription == null) {
		sDescription = "";
	}
	if (sOK == null) {
		sOK = "OK";
	}
	if (bModal == null) {
		bModal = true;
	}

	$("#alertModalDiv").remove();
	if (bModal) {
		closeModal("#alertModalDiv");
	} else {
		closePopup("#alertModal_okButton");
	}

	var sHtml = "";
	var className = "";
	if (sTitle.toLowerCase() == "success") {
		className = "ok";
	} else if (sTitle.toLowerCase() == "warning") {
		className = "warning";
	} else if (sTitle.toLowerCase() == "fail" || sTitle.toLowerCase() == "error") {
		className = "fail";
	}
	sHtml += "<section id=\"alertModalDiv\" class=\"popup\">\n";
	sHtml += "	<div class=\"pop_wrap\">\n";
	sHtml += "		<div class=\"alert\">\n";
	sHtml += "			<p class=\"noti "+className+"\">"+sTitle.toUpperCase()+"</p>\n";
	sHtml += "			<div class=\"text_cont\">\n";
	sHtml += "				"+sDescription+"\n";
	sHtml += "			</div>\n";
	sHtml += "			<div class=\"btn_area\">\n";
	sHtml += "				<button type=\"button\" id=\"alertModal_okButton\" class=\"btn type_01 primary simplemodal-close\">"+sOK+"</button>\n";
	sHtml += "			</div>\n";
	sHtml += "		</div>\n";
	sHtml += "	</div>\n";
	sHtml += "</section>\n";
	$("body").append(sHtml);

	$("#alertModal_okButton").click(function() {
		if (fnOK != null) {
			fnOK.call();
		}
		if (bModal) {
			closeModal("#alertModalDiv");
		} else {
			closePopup("#alertModal_okButton");
		}
	});

	if (bModal) {
		openModal("#alertModalDiv", {opacity:0, escClose:false, close:false, overlayClose:false, onShow: function (dialog) {
			dialog.container.draggable({handle: ".pop_head", containment: "body"});
		}
		});
	} else {
		openPopup("#alertModalDiv");
	}
}

function openIframePopupDiv(sUrl, sName, param, nWidth, nHeight) {
	$("._iframePopupDiv").css("z-index", 1003);
	$("#_iframePopupDiv_"+sName+"").remove();
	$("#_soTempForm").remove();
	var sHtml = "";
	sHtml += "<div id=\"_iframePopupDiv_"+sName+"\" class=\"_iframePopupDiv\" style=\"display:none;width:"+nWidth+"px;height:"+nHeight+"px;\">\n";
	sHtml += "	<div class=\"popup pw\" style=\"width:100%;height:100%;max-height:none;\">\n";
	sHtml += "		<h2>PageTitle</h2>\n";
	sHtml += "		<a class=\"close\" href=\"javascript:closeIframePopupDiv('"+sName+"');\">&times;</a>\n";
	sHtml += "		<div class=\"pop_cont\" style=\"height:calc(100% - 50px);max-height:none;overflow:hidden;\">\n";
	sHtml += "			<iframe id=\""+sName+"\" name=\""+sName+"\" src=\"\" style=\"width:100%;height:100%;border:none;\"></iframe>\n";
	sHtml += "		</div>\n";
	sHtml += "	</div>\n";
	sHtml += "</div>\n";
	$("body").append(sHtml);

	var left = ($(window).width() - $("#_iframePopupDiv_"+sName+"").width()) / 2;
	var top = ($(window).height() - $("#_iframePopupDiv_"+sName+"").height()) / 2;
	$("#_iframePopupDiv_"+sName+"").css("z-index", 1004);
	$("#_iframePopupDiv_"+sName+"").css("left", left+"px");
	$("#_iframePopupDiv_"+sName+"").css("top", top+"px");
	$("#_iframePopupDiv_"+sName+"").css("position", "absolute");
	$("#_iframePopupDiv_"+sName+"").show();

	sHtml = "";
	sHtml += "<form id=\"_soTempForm\" action=\""+sUrl+"\" method=\"post\" target=\""+sName+"\">";
	if (param != null) {
		var keys = Object.keys(param);
		for (var i=0;i<keys.length;i++) {
			var key = keys[i];
			sHtml += "<input type=\"hidden\" name=\""+key+"\" value=\""+param[key]+"\"/>";
		}
	}
	sHtml += "</form>";
	$("body").append(sHtml);
	$("#_soTempForm").submit();

	$("#_iframePopupDiv_"+sName+"").draggable({
		"handler": "h2"
	});

	$("#_iframePopupDiv_"+sName+"").click(function() {
		$("._iframePopupDiv").css("z-index", 1003);
		$(this).css("z-index", 1004);
	});
}

function closeIframePopupDiv(sName) {
	$("#_iframePopupDiv_"+sName+"").remove();
}

function openPasswordModal(fnOkCallback, fnCancelCallback) {
	$("#passwordModalDiv").remove();
	var sHtml = "";
	sHtml += "<section id=\"passwordModalDiv\" class=\"popup s on\">\n";
	sHtml += "	<div class=\"pop_wrap\" style=\"top: 329.5px; left: 685px;\">\n";
	sHtml += "		<div class=\"pop_head\">\n";
	sHtml += "			<h1>Permission Check</h1>\n";
	sHtml += "			<button class=\"btn close\" type=\"button\" id=\"passwordModal_closeButton\"></button>\n";
	sHtml += "		</div>\n";
	sHtml += "		<div class=\"pop_cont\">\n";
	sHtml += "			<div class=\"cont\">\n";
	sHtml += "				<div class=\"text_cont\">\n";
	sHtml += "					Please input permission password for proceeding<br>\n";
	sHtml += "					<div class=\"input type_01 m\"><input type=\"password\" value=\"\" id=\"passwordModalDiv_password\"></div>\n";
	sHtml += "					<div class=\"error_text\"></div>\n";
	sHtml += "				</div>\n";
	sHtml += "			</div>\n";
	sHtml += "			<div class=\"btn_area\">\n";
	sHtml += "				<button type=\"button\" class=\"btn type_01\" id=\"passwordModal_cancelButton\">Cancel</button>\n";
	sHtml += "				<button type=\"button\" class=\"btn type_01 primary\" id=\"passwordModal_okButton\">OK</button>\n";
	sHtml += "			</div>\n";
	sHtml += "		</div>\n";
	sHtml += "	</div><!--// .pop_wrap -->\n";
	sHtml += "</section>\n";
	$("body").append(sHtml);

	$("#passwordModal_okButton").click(function() {
		var param = new Object();
		$.ajax({
	        url: "/management/login/makeDummy",
	        type: "POST",
	        data: param,
	        dataType: "json",
	        success: function(data) {
	        	var dummy = data;

	        	var rsa = new RSAKey();
	            rsa.setPublic(data.publicKeyModulus, data.publicKeyExponent);

	            // 사용자ID와 비밀번호를 RSA로 암호화한다.
	            var param = new Object();
	        	param.password = rsa.encrypt($("#passwordModalDiv_password").val());
	        	$.ajax({
			        url: "/management/login/checkPasswordAction",
			        type: "POST",
			        data: param,
			        dataType: "json",
			        success: function(data) {
			        	var result = data.result;
			        	if (result == "succ") {
			        		$("#passwordModalDiv").remove();
			        		if (fnOkCallback != null) {
			        			fnOkCallback.call();
			        		}
			        	} else {
			        		$("#passwordModalDiv .input.type_02").addClass("error");
			        		$("#passwordModalDiv .error_text").text(result);
			        	}
			        }
	        	});
	        }
		});
	});
	$("#passwordModal_closeButton, #passwordModal_cancelButton").click(function() {
		$("#passwordModalDiv").remove();
		if (fnCancelCallback != null) {
			fnCancelCallback.call();
		}
	});

	var left = ($(window).width() - $("#passwordModalDiv > div").width()) / 2;
	var top = ($(window).height() - $("#passwordModalDiv > div").height()) / 2;
	$("#passwordModalDiv > div").css("z-index", 1003);
	$("#passwordModalDiv > div").css("left", left+"px");
	$("#passwordModalDiv > div").css("top", top+"px");
	$("#passwordModalDiv > div").css("position", "absolute");
	$("#passwordModalDiv > div").show();
}

function openPasswordChangeModal(str) {
		$("#passwordChangeModalDiv").remove();
		var sHtml = "";
		sHtml += "<section id=\"passwordChangeModalDiv\" class=\"popup s\">\n";
		sHtml += "    <div class=\"pop_wrap\">\n";
		sHtml += "      <div class=\"pop_head\">\n";
		sHtml += "        <h1>Change Password</h1>\n";
		sHtml += "        <button class=\"btn close\"  id=\"passwordChangeModal_closeButton\" type=\"button\"></button>\n";
		sHtml += "      </div>\n";
		sHtml += "      <div class=\"pop_cont\">\n";
		sHtml += "        <div class=\"table type_13\">\n";
		sHtml += "          <table>\n";
		sHtml += "            <colgroup>\n";
		sHtml += "              <col style=\"width:*\">\n";
		sHtml += "              <col style=\"width:65%\">\n";
		sHtml += "            </colgroup>\n";
		sHtml += "            <tbody>\n";
		if(str == "passwdExpiration"){
			sHtml += "              <tr>\n";
			sHtml += "                <td colspan=\"2\" style=\"color:red;\"><span>Password expiration date has been exceeded. Reset your password.</span></td>\n";
			sHtml += "              </tr>\n";
		}
		sHtml += "              <tr>\n";
		sHtml += "              <tr>\n";
		sHtml += "                <th><span class=\"imp\">Current Password</span></th>\n";
		sHtml += "                <td>\n";
		sHtml += "                  <div class=\"input type_02\">\n";
		sHtml += "                    <input type=\"password\" id=\"passwordChangeModalDiv_currentPassword\">\n";
		sHtml += "                  </div>\n";
		sHtml += "                  <div class=\"error_text\" style=\"display:none\">\n";
		sHtml += "                  </div>\n";
		sHtml += "                </td>\n";
		sHtml += "              </tr>\n";
		sHtml += "              <tr>\n";
		sHtml += "                <th><span class=\"imp\">New Password</span></th>\n";
		sHtml += "                <td>\n";
		sHtml += "                  <div class=\"input type_02\">\n";
		sHtml += "                    <input type=\"password\" id=\"passwordChangeModalDiv_newPassword\">\n";
		sHtml += "                  </div>\n";
		sHtml += "                  <div class=\"value_text\" id=\"test02\">\n";
		sHtml += "                    A strong password should be between 6 and 20 characters long and should include a mix of upper and lower case letters, numbers, and symbols\n";
		sHtml += "                  </div>\n";
		sHtml += "                  <div class=\"error_text\" style=\"display:none\">\n";
		sHtml += "                  </div>\n";
		sHtml += "                </td>\n";
		sHtml += "              </tr>\n";
		sHtml += "              <tr>\n";
		sHtml += "                <th><span class=\"imp\">New Password Check</span></th>\n";
		sHtml += "                <td>\n";
		sHtml += "                  <div class=\"input type_02\">\n";
		sHtml += "                    <input type=\"password\" id=\"passwordChangeModalDiv_newConfirmPassword\">\n";
		sHtml += "                  </div>\n";
		sHtml += "                  <div class=\"error_text\">\n";
		/*sHtml += "                    “Password doesn’t match. Please try again”\n";*/
		sHtml += "                  </div>\n";
		sHtml += "                </td>\n";
		sHtml += "              </tr>\n";
		sHtml += "            </tbody>\n";
		sHtml += "          </table>\n";
		sHtml += "        </div>\n";
		sHtml += "        <div class=\"btn_area\">\n";
		sHtml += "          <button type=\"button\" class=\"btn type_01\"  id=\"passwordChangeModal_cancelButton\">Cancel</button>\n";
		sHtml += "          <button type=\"button\" class=\"btn type_02\" id=\"passwordChangeModal_okButton\">Save</button>\n";
		sHtml += "        </div>\n";
		sHtml += "      </div>\n";
		sHtml += "    </div>\n";
		sHtml += "  </section>\n";
		$("body").append(sHtml);
		openSOModal("#passwordChangeModalDiv");
		$("#passwordChangeModalDiv_currentPassword").focus();
		$("#passwordChangeModal_okButton").click(function() {
			console.log("!!!")
			var validFlag;
			if(isEmpty($("#passwordChangeModalDiv_currentPassword").val())){
				$("#passwordChangeModalDiv .error_text").eq(0).show();
				$("#passwordChangeModalDiv .error_text").eq(0).text("Please enter your current password");
				$("#passwordChangeModalDiv_currentPassword").parent().attr("class", "input type_02 error");
			}else{
				$("#passwordChangeModalDiv_currentPassword").parent().removeClass("error")
				$("#passwordChangeModalDiv .error_text").eq(0).hide();
			}


			if(isEmpty($("#passwordChangeModalDiv_newPassword").val())){
				$("#passwordChangeModalDiv .error_text").eq(1).show();
				$("#passwordChangeModalDiv .error_text").eq(1).text("Please enter your new password");
				$("#test02").css("color","#0077ed");//blue
				$("#passwordChangeModalDiv_newPassword").parent().attr("class", "input type_02 error");
			 }else if(($("#passwordChangeModalDiv_newPassword").val().length < 6) || ($("#passwordChangeModalDiv_newPassword").val().length > 20)){
				 //$("#passwordChangeModalDiv .error_text").eq(1).show();
				// $("#passwordChangeModalDiv .error_text").eq(1).text("Please enter Password within 6 to 20 characters");
				 $("#passwordChangeModalDiv_newPassword").parent().attr("class", "input type_02 error");
				 $("#passwordChangeModalDiv .error_text").eq(1).hide();
				 $("#test02").css("color","#ed2424");//red
				 validFlag = false;
			 }else if(!isValidPasswd($("#passwordChangeModalDiv_newPassword").val())) {
				//$("#passwordChangeModalDiv .error_text").eq(1).show();
				//$("#passwordChangeModalDiv .error_text").eq(1).text("The password containing valid special characters and numbers");
				$("#passwordChangeModalDiv .error_text").eq(1).hide();
				$("#passwordChangeModalDiv_newPassword").parent().attr("class", "input type_02 error");
				$("#test02").css("color","#ed2424");//red
				validFlag = false;
			}else{
				$("#passwordChangeModalDiv_newPassword").parent().removeClass("error")
				$("#passwordChangeModalDiv .error_text").eq(1).hide();
				$("#test02").css("color","#0077ed");//blue
			}
			if(isEmpty($("#passwordChangeModalDiv_newConfirmPassword").val())){
				$("#passwordChangeModalDiv .error_text").eq(2).show();
				$("#passwordChangeModalDiv .error_text").eq(2).text("Please enter your new password check");
				$("#passwordChangeModalDiv_newConfirmPassword").parent().attr("class", "input type_02 error");
			}else if($("#passwordChangeModalDiv_newConfirmPassword").val() != $("#passwordChangeModalDiv_newPassword").val()){
				$("#passwordChangeModalDiv .error_text").eq(2).show();
				$("#passwordChangeModalDiv .error_text").eq(2).text("The new password does not match");
				$("#passwordChangeModalDiv_newConfirmPassword").parent().attr("class", "input type_02 error");
			}else{
				$("#passwordChangeModalDiv_newConfirmPassword").parent().removeClass("error")
				$("#passwordChangeModalDiv .error_text").eq(2).hide();
			}
			console.log(validFlag);
			console.log($(".error_text:visible").length==0);
			if($(".error_text:visible").length==0 && validFlag != false){
				var param = new Object();
				$.ajax({
			        url: "/management/login/makeDummy",
			        type: "POST",
			        data: param,
			        dataType: "json",
			        success: function(data) {
			        	var dummy = data;

			        	var rsa = new RSAKey();
			            rsa.setPublic(data.publicKeyModulus, data.publicKeyExponent);

			            // 사용자ID와 비밀번호를 RSA로 암호화한다.
			            var param = new Object();
			        	param.current_password = rsa.encrypt($("#passwordChangeModalDiv_currentPassword").val());
			        	param.new_password = rsa.encrypt($("#passwordChangeModalDiv_newPassword").val());
			        	param.new_confirm_password = rsa.encrypt($("#passwordChangeModalDiv_newConfirmPassword").val());
			        	$.ajax({
					        url: "/management/login/changePasswordAction",
					        type: "POST",
					        data: param,
					        dataType: "json",
					        success: function(data) {
					        	var result = data.result;
					        	console.log(result);
					        	if (result == "succ") {
					        		closeSOModal();
					        		openAlertModal('Success','Password change successful',fnLogOutOk);
					        	} else {
					        		$("#passwordChangeModalDiv .error_text").eq(0).show();
					        		$("#passwordChangeModalDiv .error_text").eq(0).text(result);
					        		$("#passwordChangeModalDiv_currentPassword").parent().attr("class", "input type_02 error");
					        	}
					        }
			        	});
			        }
				});
			}
	    });
	 	$("#passwordChangeModal_closeButton, #passwordChangeModal_cancelButton").click(function() {
			//$("#passwordChangeModalDiv").remove();
			closeSOModal();
		});
		var left = ($(window).width() - $("#passwordChangeModalDiv > div").width()) / 2;
		var top = ($(window).height() - $("#passwordChangeModalDiv > div").height()) / 2;
		$("#passwordChangeModalDiv > div").css("z-index", 1003);
		$("#passwordChangeModalDiv > div").css("left", left+"px");
		$("#passwordChangeModalDiv > div").css("top", top+"px");
		$("#passwordChangeModalDiv > div").css("position", "absolute");
		$("#passwordChangeModalDiv > div").show();
}
