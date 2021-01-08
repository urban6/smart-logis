$(function () {
    $("form.valid_form").validate({
        ignore: [],
        debug: false,
        rules: {
            editor1:{
                required: function(textarea) {
                    CKEDITOR.instances[textarea.id].updateElement();
                    var editorcontent = textarea.value.replace(/<[^>]*>/gi, '');
                    return editorcontent.length === 0;
                }
            }
        },
        messages: {
            editor1:{
                required: "필수 항목입니다."
            }
        },
        submitHandler: function(form) {
            form.submit();
        },
        errorPlacement: function(label, element) {
            label.appendTo(element.prev());
            $('<div class="errorContainer"><div class="arrow"></div></div>').insertAfter(element).find('.arrow').append(label)
            if(element.hasClass("wfull")) {
                element.next('.errorContainer').addClass("d_block")
            }

            var $parent = element.closest("td")
            var $errCon = element.next('.errorContainer')
            if (element.siblings("#cke_editor1")) {
                $errCon.appendTo($parent)
            } else {
                $errCon.css("width", element.Width())
            }
            element.prependTo($errCon)
        }
    });
    $.extend($.validator.messages, {
        required: "필수 항목입니다."
    });
});
