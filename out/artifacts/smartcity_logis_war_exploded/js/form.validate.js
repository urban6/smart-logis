$(function () {
    $("form.valid_form").validate({
        submitHandler: function(form) {
            form.submit();
        },
        errorPlacement: function(label, element) {
            $('<div class="errorContainer"><div class="arrow"></div></div>').insertAfter(element).find('.arrow').append(label)

            if(element.hasClass("wfull")) {
                element.next('.errorContainer').addClass("d_block")
            }
            element.next('.errorContainer').css("width", element.width())
            element.prependTo(element.next('.errorContainer'))
        }
    });
    $.extend($.validator.messages, {
        required: "필수 항목입니다.",
        url: "유효한 URL 형식이 아닙니다."
    });
});
