/*popup*/
// popup open
function openPopup(e) {
  $(e).addClass('on');
  popupPosition(e);
  noneScroll();
}
$(window).resize(function() {
  // popup
  var $on_popup = $('.popup.on');
  for (var i = 0; i < $on_popup.length; i++) {
    popupPosition($on_popup.eq(i));
  }
}); //$(window).resize(function()..


// popup set position
function popupPosition(e) {
  for (var i = 0; i < $(e).length; i++) {
    var $pop_wrap = $(e).find('.pop_wrap').eq(i);
    $pop_wrap.css({
      'top': Math.max(0, (($(window).height() - $pop_wrap.outerHeight()) / 2)) + "px",
      'left': Math.max(0, (($(window).width() - $pop_wrap.outerWidth()) / 2)) + "px"
    });
  }
}
// popup close
function closePopup(e) {
  $(e).parents('.popup').removeClass('on');
  noneScroll();
}
// popup close (target : exclude popup)
function closePopupOther(e) {
  var $popup = $('.popup');
  if ($popup.length) {
    $('body').on('click', function(e) {
      var $target = $(e.target);
      if ($target.hasClass('popup')) {
        $target.removeClass('on');
        noneScroll();
      }
    });
  }
}
// remove scroll (active popup)
function noneScroll() {
  if ($('.popup.on').length) {
    if ($('html').hasClass('ie8')) {
      $('html,body').scrollTop(0);
    }
    window.setTimeout(function() {
      $('body').addClass('oh')
    }, 50);
  } else {
    $('body').removeClass('oh');
  }
}