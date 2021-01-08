$(function() {
  //a link
  var $side_a = $('.sidebar dd a');
  for (var i = 0; i < $side_a.length; i++) {
    // none href
    var $a_href = $side_a.eq(i).attr("href"),
      $a = $side_a.eq(i);
    if (!$a_href) {
      $a.attr("href", "#none");
    } else if ($a_href) {
      //mainFrame link
      $a.attr('target', 'mainFrame');
      $a.on('click', function() {
        var $url = $(this).attr("href");
        parent.mainFrame.location.href = $url;
        $side_a.removeClass("on");
        $(this).addClass("on");
      });
      //add title
      if ($a.parents('li').length) {
        var $a_split = $a.attr("href").split("/"),
          $a_split_last = ($a_split.length) - 1,
          $a_new = $a.clone().attr({ target: "_blank", tabIndex: "-1" }).html("<span>NEW</span>").addClass('new_open');
        $a.after($a_new);
        $a.prepend("<span>[" + $a_split[$a_split_last].toUpperCase() + "]</span> ");
      }
    }
  }
  //tab
  var $dt = $('.sidebar dl').find('dt'),
    $dd = $('.sidebar dl').find('dd');
  $dt.find('a').prepend('<i class="bl"></i>');
  for (var i = 0; i < $dt.length; i++) {
    $dt.eq(i).find('a').on('click', function() {
      if ($(this).parent('dt').hasClass('on')) {
        $(this).parent('dt').removeClass('on');
        $(this).parent('dt').next('dd').removeClass('on');
      } else {
        $(this).parent('dt').addClass("on").siblings('dt').removeClass('on');
        $(this).parent('dt').next('dd').addClass('on').siblings('dd').removeClass('on');
      }
    });
  };
  if ($dt.hasClass('on')) {
    $('dt.on').next('dd').addClass('on');
  } else {
    $dt.eq(0).addClass("on").next('dd').addClass("on");
  }
});
