$(function () {
  commonLoad();
  var $tab_area = $('.tab_area');
  for (var i = 0; i < $tab_area.length; i++) {
    tabEvent($tab_area.eq(i));
  }
  toggleLayer();
  dropdown();
}); //$(function()..

function commonLoad() {
  tooltip();
  checkboxAll(); // checkbox 일괄 선택 해제
  datetimeLoad(); //input datetime
  gnbViewAll();
  toggleContent();
  if ($('.choose').length) tableChoose();
  if ($('.check_list').length) listSelector();
  if ($('.charge_progress').length) progressBtn();
  //if ($('.rank_list').length)  rankBoard();
  progressBtnDepth();
  

  if( $('.depth2').is(':visible') ) $('.charge_progress > ol').css({marginTop: '-50px'});
}

// checkbox all toggle
function checkboxAll() {
  // console.log($('body').find('input[type=checkbox]').length);
  $('body').on('click', function (e) {
    var $target = $(e.target);
    var $nodeName = e.target.nodeName;
    if ($target.parents().hasClass('checkbox') && $nodeName == 'INPUT') {
      if ($target.hasClass('all')) {
        var $checkbox = $target.parents('.checkbox_all').find('.checkbox').find('input').not('all');
        if ($target.is(':checked')) {
          $checkbox.prop('checked', true);
        } else {
          $checkbox.prop('checked', false);
          $('#checkAll').prop('checked', false);
        }
      } else {
        var $checkbox_all = $target.parents('.checkbox_all').find('.checkbox').find('input.all');
        if (!$target.is(':checked')) {
          $checkbox_all.prop('checked', false);
          $('#checkAll').prop('checked', false);
        }
      }
    }
  });
}

// datetime picker load
function datetimeLoad() {
  // datetime insert button icon
  var $dateclock = $('.input.datetime,.input.datetime_s,.input.date,.input.time,.input.time_s');
  for (var i = 0; i < $dateclock.length; i++) {
    if ($dateclock.eq(i).find('.btn').length == 0) {
      $dateclock.eq(i).append('<span class="btn"></span>')
    }
  }
  //Date+Time(HH:MM) picker load
  if ($('.input.datetime').length > 0) {
    $('.input.datetime').datetimepicker({
      useCurrent: true,
      // locale: 'ko',
      format: 'YYYY-MM-DD HH:mm',
      defaultDate: new Date(),
      allowInputToggle: true,
      sideBySide: true,
      showTodayButton: true,
      /*추가*/
      //showClear: true,/*추가*/
      showClose: true,
      /*추가*/
      toolbarPlacement: 'bottom',
      /*추가*/
      ignoreReadonly: true,
      // focusOnShow: false,
      widgetParent: 'body'
    });
  }
  //Date+Time(HH:MM:SS) picker load
  if ($('.input.datetime_s').length > 0) {
    $('.input.datetime_s').datetimepicker({
      useCurrent: true,
      // locale: 'ko',
      format: 'YYYY-MM-DD HH:mm:ss',
      defaultDate: new Date(),
      allowInputToggle: true,
      sideBySide: true,
      showTodayButton: true,
      /*추가*/
      //showClear: true,/*추가*/
      showClose: true,
      /*추가*/
      toolbarPlacement: 'bottom',
      /*추가*/
      ignoreReadonly: true,
      // focusOnShow: false,
      widgetParent: 'body'
    });
  }
  if ($('.input.date').length > 0) {
    $('.input.date').datetimepicker({
      useCurrent: true,
      // locale: 'ko',
      format: 'YYYY-MM-DD',
      defaultDate: new Date(),
      allowInputToggle: true,
      sideBySide: true,
      showTodayButton: true,
      /*추가*/
      //showClear: true,/*추가*/
      showClose: true,
      /*추가*/
      toolbarPlacement: 'bottom',
      /*추가*/
      ignoreReadonly: true,
      // focusOnShow: false,
      widgetParent: 'body'
    });
  }
  if ($('.input.time').length > 0) {
    $('.input.time').datetimepicker({
      useCurrent: true,
      // locale: 'ko',
      format: 'HH:mm',
      defaultDate: new Date(),
      allowInputToggle: true,
      sideBySide: true,
      showTodayButton: true,
      /*추가*/
      //showClear: true,/*추가*/
      showClose: true,
      /*추가*/
      toolbarPlacement: 'bottom',
      /*추가*/
      ignoreReadonly: true,
      // focusOnShow: false,
      widgetParent: 'body'
    });
  }
  if ($('.input.time_s').length > 0) {
    $('.input.time_s').datetimepicker({
      useCurrent: true,
      // locale: 'ko',
      format: 'HH:mm:ss',
      defaultDate: new Date(),
      allowInputToggle: true,
      sideBySide: true,
      showTodayButton: true,
      /*추가*/
      //showClear: true,/*추가*/
      showClose: true,
      /*추가*/
      toolbarPlacement: 'bottom',
      /*추가*/
      ignoreReadonly: true,
      // focusOnShow: false,
      widgetParent: 'body'
    });
  }
  // popup:z-index, Delete selected year(period)
  $dateclock.on('dp.show', function () {
    var $datetime = $('.datetime,.datetime_s,.date,.time,.time_s');
    $datetime.removeClass('active');
    $(this).addClass('active');
    if ($(this).parents().hasClass('popup')) {
      var $datepicker = $('.bootstrap-datetimepicker-widget');
      $datepicker.css({
        zIndex: '1002'
      });
    }
    $(".datepicker-years .table-condensed thead tr th:eq(1)").removeAttr("data-action");
    $(".datepicker-years .table-condensed thead tr th:eq(1)").css("cursor", "default");
  });
}

// tab event common
var tabEvent = function (container) {
  var $tab_area = container;
  var $tab_menu = $tab_area.find('.tab_menu').eq(0).children('li').children('a');
  var $tab_cont = $tab_area.find('.tab_cont').eq(0).children('.cont');

  if ($tab_menu.parent('li').hasClass('active')) { //활성 tab을 지정했을 경우
    var j = $tab_menu.parent('.active').index();
    $tab_cont.eq(j).addClass('active').siblings().removeClass('active');
  } else { // 활성 tab을 지정하지 않았을 경우 첫번째 tab 노출
    $tab_menu.parent('li').eq(0).addClass('active');
    $tab_cont.eq(0).addClass('active');
  }

  for (var i = 0; i < $tab_menu.length; i++) {
    $tab_menu.eq(i).on('click', (function (index) {
      return function (event) {
        $tab_menu.eq(index).parent('li').addClass('active').siblings().removeClass('active');
        $tab_cont.eq(index).addClass('active').siblings().removeClass('active');
        event.preventDefault();
        scrollTable(); //tab 내부 테이블 스크롤 처리
      }
    })(i));
  }
}

// toggleLayer
function toggleLayer() {
  var $wrap = $('.toggle_layer');

  function btnLoad() {
    for (var i = 0; i < $wrap.length; i++) {
      var $layer = $wrap.eq(i).find('.layer').not('.sum_area');
      var $btn_toggle = $wrap.eq(i).find('.btn.toggle');
      if ($layer.hasClass('active')) {
        $btn_toggle.find('i.on').hide();
        $btn_toggle.find('i.off').show();
      } else {
        $btn_toggle.find('i.off').hide();
        $btn_toggle.find('i.on').show();
      }
    }
  }
  btnLoad();
  var $btn = $wrap.find('.btn');
  $btn.on('click', function () {
    var $wrap = $(this).parents('.toggle_layer').eq(0);
    if ($(this).hasClass('toggle')) {
      $layer = $wrap.find('.layer');
      for (var i = 0; i < $layer.length; i++) {
        $layer.eq(i).toggleClass('active');
      }
      btnLoad();
    } else if ($(this).hasClass('close')) {
      $wrap.find('.layer').removeClass('active');
      $wrap.find('.active').removeClass('active');
      btnLoad();
    }
  });
}

// dropdown
function dropdown() {
  var $dropdown = $('.dropdown');
  var $dropdown_btn = $dropdown.find('.dropdown_btn');
  var $dropdown_box = $dropdown.find('.dropdown_box');
  var $input = $dropdown_box.find('.input');
  var $dropdownArray = [];
  for (var i = 0; i < $dropdown.length; i++) {
    // console.log($dropdown_box);
    $input.eq(i).addClass('skip_remove');
    $dropdownArray[i] = $dropdown_box.eq(i);
    $dropdown_box.eq(i).remove();
    // console.log($dropdownArray);
    $dropdown_btn.eq(i).on('click', (function (index) {
      return function () {
        // $('body').append($this_box);
        $dropdown_box.remove();
        var $this_box = $dropdownArray[index];
        $('body').append($this_box);
        if (!$(this).hasClass('active')) {
          $this_box.addClass('active');
          $dropdown_btn.removeClass('active');
          $(this).addClass('active');
          var $scroll_top = (document.documentElement && document.documentElement.scrollTop) ||
            document.body.scrollTop;
          // var $top = $(this).offset().top - $('body').scrollTop() + $(this).outerHeight(); 
          var $top = $(this).offset().top - $scroll_top + $(this).outerHeight();
          var $bottom = (window.innerHeight - $top + $(this).outerHeight());
          var $left = $(this).offset().left + ($(this).outerWidth() / 2) - ($this_box.outerWidth() / 2);
          // console.log('/top:' + $top +'/bottom:' + $bottom + '/left:'+$left);
          if ($bottom < $top) {
            // console.log('if');
            $this_box.removeClass('top').addClass('bottom');
            $this_box.css({
              top: "inherit",
              bottom: $bottom,
              left: $left
            });
          } else {
            // console.log('else');
            $this_box.removeClass('bottom').addClass('top');
            $this_box.css({
              top: $top,
              bottom: "inherit",
              left: $left
            });
          }
          return false;
        } else {
          removeActive();
        }
      }
    })(i));

    function removeActive() {
      $dropdown_box.removeClass('active');
      $dropdown_btn.removeClass('active');
      $dropdown_box.remove();
    }
    $(window).scroll(function () {
      if ($dropdown_box.hasClass('active')) {
        removeActive();
      }
    });
    $(window).resize(function () {
      if ($dropdown_box.hasClass('active')) {
        removeActive();
      }
    });
    $('body').on('click', function (e) {
      var $target = $(e.target);
      if (!$target.hasClass('skip_remove')) {
        if (!$target.parent().hasClass('skip_remove')) {
          if (!$target.parents().hasClass('skip_remove')) {
            removeActive();
            // console.log('true');
          }
        }
      }
    });
  }
}

// tooltip
function tooltip() {
  var $tooltip = $('.tooltip');
  var $tooltip_label = $tooltip.find('.tooltip_label');
  var $tooltip_box = $tooltip.find('.tooltip_box');
  var $input = $tooltip_box.find('.input');
  var $tooltipArray = [];
  for (var i = 0; i < $tooltip.length; i++) {
    // console.log($tooltip_box);
    $input.eq(i).addClass('skip_remove');
    $tooltipArray[i] = $tooltip_box.eq(i);
    $tooltip_box.eq(i).remove();
    // console.log($tooltipArray);
    $tooltip_label.eq(i).mouseenter(function (index) {
      // console.log('mouseenter');
      return function () {
        $tooltip_box.remove();
        var $this_box = $tooltipArray[index];
        $('body').append($this_box);
        $this_box.addClass('active');
        $tooltip_label.removeClass('active');
        $(this).addClass('active');
        var $scroll_top = (document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop;
        var bn_h = $(this).outerHeight() + 30;
        var bn_h2 = $(this).outerHeight() + 60;
        var bn_w = $(this).outerWidth() / 2;
        var box_w = $('.tooltip_box').outerWidth() - (bn_w*2 + 50);
        var $top = $(this).offset().top - $scroll_top + bn_h;
        var $bottom = (window.innerHeight - $top + bn_h2);
        var $left = $(this).offset().left - box_w;
        var $left_diff = $(this).offset().left - 50;

        if($tooltip.hasClass('diff')){
          if ($bottom < $top) {
            $this_box.removeClass('top').addClass('bottom');
            $this_box.css({
              top: "inherit",
              bottom: $bottom,
              left: $left_diff
            });
          } else {
            $this_box.removeClass('bottom').addClass('top');
            $this_box.css({
              top: $top,
              bottom: "inherit",
              left: $left_diff
            });
          }
        }else{
          if ($bottom < $top) {
            $this_box.removeClass('top').addClass('bottom');
            $this_box.css({
              top: "inherit",
              bottom: $bottom,
              left: $left
            });
          } else {
            $this_box.removeClass('bottom').addClass('top');
            $this_box.css({
              top: $top,
              bottom: "inherit",
              left: $left
            });
          }
        }


      }
    }(i)).mouseleave(function () {
      removeActive();
      // console.log('mouseleave');
    });


    function removeActive() {
      $tooltip_box.removeClass('active');
      $tooltip_label.removeClass('active');
      $tooltip_box.remove();
    }
    $(window).scroll(function () {
      if ($tooltip_box.hasClass('active')) {
        removeActive();
      }
    });
    $(window).resize(function () {
      if ($tooltip_box.hasClass('active')) {
        removeActive();
      }
    });
    $('body').on('click', function (e) {
      var $target = $(e.target);
      if (!$target.hasClass('skip_remove')) {
        if (!$target.parent().hasClass('skip_remove')) {
          if (!$target.parents().hasClass('skip_remove')) {
            removeActive();
          }
        }
      }
    });
  }
}

// gnb - view all menus
function gnbViewAll() {
  var $body = $('body');
  var $btn_view_all = $('.header .view_all a');
  var $btn_close_all = $('.header .btn.close_all');
  $btn_close_all.on('click', function () {
    $body.removeClass('gnb_view_all')
  });
  $btn_view_all.on('click', function () {
    $body.addClass('gnb_view_all')
  });
}

//toggle section
function toggleContent(){
  var s = 300;
  var txt1 = '펼치기';
  var txt2 = '접기';
  var bang_len = 0;
  //2018-10-02 add
  $('.view_all').addClass('ov').children('span').text(txt1);
  $('.cont_step .inner').css({display:'none'});
  $('.cont_step .tit_head').addClass('bang');
  $('.section_sort').addClass('close');

  //2018-10-02 add
  $(document).on('click', '.bn_toggle', function () {
    var $header = $('.head');
    var $head = $(this).closest('.head');
    var $target = $head.next('div.table, div.inner');
    var $btnAll = $('.view_all');
    var head_len = $header.length;     
    $head.toggleClass('bang');
    $target.slideToggle(s);
    if( $('.view_all').length ){
      var $bang = $('.head.bang');
      bang_len = $bang.length;
      if(bang_len === head_len) $btnAll.addClass('ov').children('span').text(txt1);
      else $btnAll.removeClass('ov').children('span').text(txt2);
    }
  });

  $(document).on('click', '.view_all', function(){
    var $this = $(this);
    var $txt = $this.children('span');
    var $head = $('.head');
    var $target = $head.next('.inner'); 
    $this.toggleClass('ov');
    if( $this.hasClass('ov') ){
      $txt.text(txt1);
      for(var i=0; i<$target.length; i++){
        if( $target.eq(i).is(':visible') ){
          $target.slideUp(s);
          $head.addClass('bang');
        }
      }
    }else{
      $txt.text(txt2);
      for(var i=0; i<$target.length; i++){
        if( !$target.eq(i).is(':visible') ){
          $target.slideDown(s);
          $head.removeClass('bang');
        }
      }
    }
  });

}

//choose
function tableChoose() {
  $('.choose').find('td').click(function () {
    $('.choose').find('tr').removeClass();
    $(this).closest('tr').addClass('active');
  });
}
//select list
function listSelector() {
  var $target = $('.check_list ul > li');
  $target.on('click', function () {
    var $this = $(this);
    if ($this.hasClass('active')) return;
    $this.siblings('li').removeClass('active');
    $this.addClass('active');
  });
}

//레이어 팝업위에 띄우는 팝업
function secondLayer(selector) {
  var $body = $('body');
  var $selector = $('.' + selector);
  if ($selector.attr('href')) {
    var $id = $selector.attr('href');
    var $layer = $($id);
  } else {
    var $id = $selector.data('href');
    var $layer = $($id);
  }
  if ($selector.data('bg')) var $bg = $selector.data('bg');
  var layer_w = $layer.outerWidth();
  var layer_h = $layer.outerHeight();
  var mg_w = -parseInt(layer_w / 2);
  var mg_h = -parseInt(layer_h / 2);
  var mg = mg_h + 'px 0px 0px ' + mg_w + 'px';
  var overlay = '<span class="overlay"></span>';

  $selector.on('click', function () {
    $layer.css({
      display: 'block',
      position: 'fixed',
      top: '50%',
      left: '50%',
      margin: mg,
      zIndex: 99999
    });

    if ($(this).data('bg')) {
      $body.append(overlay);
      $('.overlay').css({
        display: 'block',
        zIndex: '99998'
      }).addClass(selector);
    }
    return false;
  });
  $layer.find('.btn.close, .close_npop').on('click', function () {
    $(this).closest('.popup').css({
      display: 'none',
      zIndex: '-99999'
    });
    if ($('.overlay.' + selector).length) $('.overlay.' + selector).css({
      display: 'none'
    }).remove();
  });
}

function progressBtn() {
  $('.charge_progress > ol > li.complete > button.btn').on('click', function () {
    $('.depth2 > li > button.btn').removeClass('ov');
    $(this).parent().siblings('li').find('button').removeClass('ov');
    // $(this).toggleClass('ov');
  });  
}

function progressBtnDepth() {
  $('.depth2 > li.complete > button.btn').on('click', function () {
    $('.charge_progress > ol > li.complete > button.btn').removeClass('ov');
    $(this).parent().siblings('li').find('button').removeClass('ov');
    // $(this).toggleClass('ov');
  });  
}

function rankBoard(){
  
  var $table = $('.rank_list tbody');
  var $tbody = $('.rank_list').parent();
  var $tr = $table.children('tr');
  var $bnNext = $('.bn_rank_next');
  var $bnPrev = $('.bn_rank_prev');
  var h = 420;
  var tr_h = $tr.outerHeight();
  var tr_len = $tr.length;
  
  
  $bnNext.on('click', function(){
    var $active = $table.children('tr.active');
    if($active.length == 0) return; 
    // var pos = $active.position().top;
    var $next = $active.next();
    var idx = $active.index() + 1;
    if(idx == tr_len) $active.prependTo($table);
    else  $active.insertAfter($next);
    // var scroll_h = tr_h*(idx - 9);
    // if(idx == tr_len) $tbody.animate({scrollTop:0}, 300);
    // else if(pos > h)  $tbody.animate({scrollTop:scroll_h}, 300);
    // else if(scroll_h > 0) return;
  });
  
  $bnPrev.on('click', function(){
    var $active = $table.children('tr.active');
    if($active.length == 0) return;
    // var pos = $active.position().top;
    var $prev = $active.prev();
    var idx = $active.index();
    if(idx == 0) $active.appendTo($table);
    else  $active.insertBefore($prev);
    //var scroll_h = tr_h*(idx - 1);    
    // console.log(pos, idx, h, scroll_h);
    // if(idx == 0) $tbody.animate({scrollTop:h}, 300);
    // else if(pos <= 86) $tbody.animate({scrollTop:scroll_h}, 300);

  });
}

function rankBoardSort(){
  var $table = $('.rank_list tbody');
  var $tbody = $('.rank_list').parent();
  var $tr = $table.children('tr');
  var $bnNext = $('.bn_rank_next');
  var $bnPrev = $('.bn_rank_prev');
  var tr_h = $tr.outerHeight();
  var tr_len = $tr.length;
  
  function toLetters(num) {
    var mod = num % 26;
    var pow = num / 26 | 0;
    var out = mod ? String.fromCharCode(64 + mod) : (pow--, 'Z');
    return pow ? toLetters(pow) + out : out;
  }
  
  $bnNext.on('click', function(){
    var $active = $table.children('tr.active');
    if($active.length == 0) return;
    var $next = $active.next();
    var idx = $active.index() + 1;
    $active.insertAfter($next);
    // if(idx == tr_len) $active.prependTo($table);
    // else  $active.insertAfter($next);
    sortingAlphabet();
  });
  
  $bnPrev.on('click', function(){
    var $active = $table.children('tr.active');
    if($active.length == 0) return;
    var $prev = $active.prev();
    var idx = $active.index();
    $active.insertBefore($prev);
    // if(idx == 0) $active.appendTo($table);
    // else  $active.insertBefore($prev);
    sortingAlphabet();
  });
  function sortingAlphabet(){
    var $tr = $table.children('tr');
    var tr_len = $tr.length;
    for(var i=0; i<tr_len; i++){
      $tr.eq(i).children('td').eq(1).text( toLetters(i+1) );
    }
  }
}



