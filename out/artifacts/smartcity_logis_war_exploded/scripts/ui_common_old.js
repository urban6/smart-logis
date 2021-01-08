$(function() {
  browserCheck();
  var $tab_area = $('.tab_area');
  for (var i = 0; i < $tab_area.length; i++) {
    tabEvent($tab_area.eq(i));
  }
  // var $test_target = $('.table').find('th,td')
  // $test_target.on('click',function(){
  //   console.log($(this).text());
  // }); 
  commonLoad();
  var $tree_table = $('.treeTable');
  for (var i = 0; i < $tree_table.length; i++) {
    $tree_table.eq(i).treeTable({
      indent: 37
    });
  };
  toggleLayer();
  dropdown();
}); //$(function()..
$(window).resize(function() {
  // table
  var $scroll = $('.x_scroll,.y_scroll');
  for (var i = 0; i < $scroll.length; i++) {
    if (!$scroll.eq(i).parents().hasClass('popup')) {
      scrollTable($scroll.eq(i));
    }
  }
  // form
  var $datetimeActive = $('.datetime.active,.date.active,.time.active');
  datetimePosition($datetimeActive);
}); //$(window).resize(function()..

function commonLoad() {
  // table
  var $scroll = $('.x_scroll,.y_scroll');
  for (var i = 0; i < $scroll.length; i++) {
    if ($scroll.eq(i).parents().hasClass('popup')) {
      scrollTable($scroll.eq(i));
    }else{
      $(function(index){
        return scrollTimer = setTimeout(function() {
          scrollTable($scroll.eq(index));
        }, 50);
      }(i));
    }
  }
  // scrollTable();
  // linkTable();
  tooltip();
  // form
  var $selectTarget = $('.select');
  // selectCustom($selectTarget); //가상아이디 생성
  var $label = $('.radio label,.checkbox label,.switch label');
  // matchLabel($label); // input id 와 label for 맞춤
  // matchName(); // radio name 맞춤
  checkboxAll(); // checkbox 일괄 선택 해제
  datetimeLoad(); //input datetime
  // inputFile(); // input file
}

//browser check
function browserCheck() {
  var $html = $('html'),
    $userAgent = navigator.userAgent.toUpperCase(),
    $documentMode = document.documentMode,
    $is_ie = navigator.appName.match('Microsoft Internet Explorer'),
    $is_ie6 = $userAgent.indexOf('MSIE 6') > -1 && $userAgent.indexOf('TRIDENT') == -1,
    $is_ie7 = $userAgent.indexOf('MSIE 7') > -1 && $userAgent.indexOf('TRIDENT') == -1,
    $is_ie8 = $userAgent.indexOf('MSIE 8') > -1,
    $is_ie9 = $userAgent.indexOf('MSIE 9') > -1,
    $is_ie10 = $userAgent.indexOf('MSIE 10') > -1,
    $is_ie11 = $userAgent.match(/(TRIDENT\/7.0)(?:.*RV:11.0)/),
    $is_ie_competView = $userAgent.indexOf('MSIE 7') > -1 && $userAgent.indexOf('TRIDENT') > -1, //호환성보기
    $is_ie_quirksMode = $documentMode == 5, //호환성보기
    $old_browser = '<div class="lt_ie8_info"> <span class="logo"><span class="hidden">올에듀넷</span></span> <i class="icon error"></i> 안녕하세요. 올에듀넷입니다. <br><br> 현재 사용 중이신 브라우저는 오래된 버전의 브라우저로 <em>보안 및 성능에 문제</em>가 있어<br> 지원하지 않습니다. <br> <a href="http://browsehappy.com/" target="_blank" title="브라우저 업그레이드" class="link">브라우저를 업그레이드</a> 하시면 보다 빠르고 안전하게 올에듀넷 서비스를<br> 이용하실 수 있습니다. 감사합니다. <a href="http://browsehappy.com/" target="_blank" title="브라우저 업그레이드" class="btn typ_14"> 브라우저 업그레이드 <i class="before"></i> </a> </div>';

  function addAgent(e) { $html.addClass(e); }
  // console.log($userAgent);
  if ($is_ie7 || $is_ie6 || $html.hasClass('lt-ie8')) { $('body').html($old_browser); }
  if ($is_ie7 || $is_ie6) { addAgent('ie7'); } else if ($is_ie8) { addAgent('ie8'); } else if ($is_ie9) { addAgent('ie9'); } else if ($is_ie10) { addAgent('ie10'); } else if ($is_ie11) { addAgent('ie11'); } else if (!$is_ie) {
    var $vendor = navigator.vendor.toUpperCase(),
      $is_op = $vendor.indexOf('OPERA') > -1,
      $is_ch = $userAgent.indexOf('CHROME') > -1,
      $is_sf = $userAgent.indexOf('APPLE') > -1,
      $is_ff = $userAgent.indexOf('FIREFOX') > -1;
    if ($is_op) { addAgent('op'); } else if ($is_ch) { addAgent('ch'); } else if ($is_sf) { addAgent('sf'); } else if ($is_ff) { addAgent('ff'); }
  }
  if ($is_ie_quirksMode) { addAgent('ie_qm'); }
  if ($is_ie_competView) { addAgent('ie_cv'); }
};
/*form*/
//select custom 가상 아이디 생성
function selectCustom(e) {
  for (var i = 0; i < e.length; i++) {
    var $value = e.eq(i).find('option:selected').text();
    var $selectId = e.eq(i).find('select').attr('id');
    if (!$selectId == true) {
      e.eq(i).find('select').attr('id', 'select_temp_id_' + i);
      $selectId = 'select_temp_id_' + i
    }
    var $label = '<label for="' + $selectId + '">' + $value + '</label>';
    e.eq(i).find('label').remove();
    e.eq(i).append($label);
    e.eq(i).find('select').on('change', function() {
      var $select_name = $(this).find('option:selected').text();
      $(this).siblings('label').text($select_name);
    });
  }
}
// matching id (form element & lable) 
function matchLabel(e) {
  for (var i = 0; i < e.length; i++) {
    // set label input matching
    if (!e.eq(i).prev('input').attr('id')) {
      e.eq(i).prev('input').attr('id', 'temp_id_' + (i + 1));
    }
    e.eq(i).attr('for', e.eq(i).prev('input').attr('id'));
  }
}
// matching name (input radio) 
function matchName() {
  // set radio name
  var $radioName = $('.radio_name');
  for (var i = 0; i < $radioName.length; i++) {
    $radio = $radioName.eq(i).find('.radio input');
    for (var j = 0; j < $radio.length; j++) {
      if (!$radio.eq(j).attr('name')) {
        $radio.attr('name', 'temp_name_' + (i + 1));
      }
    }
  };
}
// checkbox all toggle
function checkboxAll() {
  // console.log($('body').find('input[type=checkbox]').length);
  $('body').on('click', function(e) {
    var $target = $(e.target);
    var $nodeName = e.target.nodeName;
    if ($target.parent().hasClass('checkbox') && $nodeName == 'INPUT') {
      if ($target.hasClass('all')) {
        var $checkbox = $target.parents('.checkbox_all').find('.checkbox').find('input').not('all');
        if ($target.is(':checked')) {
          $checkbox.prop('checked', true);
        } else {
          $checkbox.prop('checked', false);
        }
      } else {
        var $checkbox_all = $target.parents('.checkbox_all').find('.checkbox').find('input.all');
        if (!$target.is(':checked')) {
          $checkbox_all.prop('checked', false);
        }
      }
    }
  });
}
// inputFile
// function inputFile() {
//   var $input_file = $('.input.file');
//   for (var i = 0; i < $input_file.length; i++) {
//     var $input_file_file = $input_file.eq(i).find('input');
//     if (!$input_file.eq(i).find('.file_value').length) {
//       $input_file.eq(i).append('<input type="text" class="file_value" value="선택된 파일이 없습니다." readonly>');
//       $input_file_file.addClass('file_hide');
//     }
//     $input_file_file.on('change', function() {
//       var $value = $(this).val();
//       var $file_value = $(this).parents('.input.file').find('.file_value');
//       $file_value.val($value);
//     });
//   }
// }

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
      showTodayButton: true,/*추가*/
      //showClear: true,/*추가*/
      showClose: true,/*추가*/
      toolbarPlacement: 'bottom',/*추가*/
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
      showTodayButton: true,/*추가*/
      //showClear: true,/*추가*/
      showClose: true,/*추가*/
      toolbarPlacement: 'bottom',/*추가*/
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
      showTodayButton: true,/*추가*/
      //showClear: true,/*추가*/
      showClose: true,/*추가*/
      toolbarPlacement: 'bottom',/*추가*/
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
      showTodayButton: true,/*추가*/
      //showClear: true,/*추가*/
      showClose: true,/*추가*/
      toolbarPlacement: 'bottom',/*추가*/
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
      showTodayButton: true,/*추가*/
      //showClear: true,/*추가*/
      showClose: true,/*추가*/
      toolbarPlacement: 'bottom',/*추가*/
      ignoreReadonly: true,
      // focusOnShow: false,
      widgetParent: 'body'
    });
  }
  // popup:z-index, Delete selected year(period)
  $dateclock.on('dp.show', function() {
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
/*tab*/
// tab event common
var tabEvent = function(container) {
    var $tab_area = container;
    var $tab_menu = $tab_area.find('.tab_menu').eq(0).children('li').children();
    var $tab_cont = $tab_area.find('.tab_cont').eq(0).children('.cont');

    if ($tab_menu.parent('li').hasClass('active')) { //활성 tab을 지정했을 경우
      var j = $tab_menu.parent('.active').index();
      $tab_cont.eq(j).addClass('active').siblings().removeClass('active');
    } else { // 활성 tab을 지정하지 않았을 경우 첫번째 tab 노출
      $tab_menu.parent('li').eq(0).addClass('active');
      $tab_cont.eq(0).addClass('active');
    }

    for (var i = 0; i < $tab_menu.length; i++) {
      $tab_menu.eq(i).on('click', (function(index) {
        return function(event) {
          $tab_menu.eq(index).parent('li').addClass('active').siblings().removeClass('active');
          $tab_cont.eq(index).addClass('active').siblings().removeClass('active');
          event.preventDefault();
        }
      })(i));
    }
  }
  /*table*/
  // scroll Table
// function scrollTable(e) {
//   if (e == undefined) {
//     var $scroll = $('.table.x_scroll,.table.y_scroll');
//   } else {
//     var $scroll = e;
//   }
//   for (var i = 0; i < $scroll.length; i++) {
//     var $table_width;
//     var $td_array = new Array;
//     var $colgroup = $scroll.eq(i).find('colgroup').eq(0);
//     var $col = $colgroup.find('col');
//     // set table layout auto
//     $scroll.eq(i).addClass('load');
//     // reset table
//     if ($scroll.eq(i).find('.thead,.tbody,.tfoot').length > 0) {
//       var $thead = $scroll.eq(i).find('.thead').find('table').find('thead');
//       var $tbody = $scroll.eq(i).find('.tbody').find('table').find('tbody');
//       var $tfoot = $scroll.eq(i).find('.tfoot').find('table').find('tfoot');
//       $thead.unwrap('table').unwrap('.thead');
//       $tbody.unwrap('table').unwrap('.tbody');
//       $tfoot.unwrap('table').unwrap('.tfoot');
//       $thead.next('colgroup').remove();
//       $tbody.next('colgroup').remove();
//       $tfoot.next('colgroup').remove();
//       $scroll.eq(i).wrapInner('<table></table>')
//       // return false; break;
//     } else {
//       // fix col width
//       if ($scroll.eq(i).hasClass('x_scroll')) {
//         for (var j = 0; j < $col.length; j++) {
//           if (parseInt($col.eq(j).width()) > 0) {
//             $col.eq(j).addClass('fix');
//           } else {
//             $col.eq(j).removeAttr('width');
//             $col.eq(j).removeAttr('style');
//           }
//         }
//       }
//     }
//     var $table = $scroll.eq(i).find('table');

//     // set col width before wrap
//     if ($scroll.eq(i).hasClass('x_scroll')) {

//       for (var j = 0; j < $col.length; j++) {
//         var $td_width;
//         if ($col.eq(j).hasClass('fix')) {
//           $td_width = $col.eq(j).css('width');
//         } else {
//           var $tr = $scroll.eq(i).find('table').find('tr');
//           var $td;
//           for (var k = 0; k < $tr.length; k++) {
//             $td = $tr.eq(k).children().eq(j);
//             if ($tr.eq(k).children().length == $col.length) {
//               if ($td.attr('colspan') > 0) {
//                 k++;
//               } else {
//                 break;
//               }
//             }
//           }
//           $td_width = Math.ceil($td.outerWidth()) + 'px';
//         }
//         $col.eq(j).removeAttr('width');
//         if (j == $col.length - 1) {
//           $col.eq(j).css('width', parseInt($td_width) - 7 + 'px');
//         } else {
//           $col.eq(j).css('width', $td_width);
//         }
//         // get width
//         $td_array[j] = parseInt($td_width);
//       }
//     }
//     if (!$scroll.eq(i).find('.thead,.tbody,.tfoot').length > 0) {
//       var $thead = $scroll.eq(i).find('thead');
//       var $tbody = $scroll.eq(i).find('tbody');
//       var $tfoot = $scroll.eq(i).find('tfoot');

//       newSet($thead);
//       newSet($tbody);
//       newSet($tfoot);

//       function newSet(e) {
//         if (e.length) {
//           $scroll.eq(i).append(e);
//           e.wrap('<div class="' + e[0].tagName.toLowerCase() + '"><table></table></div>');
//           e.before($colgroup.clone());
//         }
//       }

//       $scroll.eq(i).children('table').remove();
//     }
//     // get width
//     $table_width = $td_array.reduce(function(a, b) {
//       return a + b;
//     }, 0);
//     // set width
//     if ($scroll.eq(i).hasClass('x_scroll')) {
//       if ($scroll.eq(i).outerWidth() >= $table_width) {
//         $scroll.eq(i).find('.thead,.tbody,.tfoot').css('width', '100%');
//       } else {
//         $scroll.eq(i).find('.thead,.tbody,.tfoot').css('width', $table_width);
//       }
//     }
//     // set table fixed
//     $scroll.eq(i).removeClass('load');
//   }
// }
// table td:active
// function linkTable() {
//   var $link_table = $('.table.link').find('tbody');
//   $link_table.mousedown(function(e) {
//     var $target = $(e.target);
//     var $nodeName = e.target.nodeName;
//     if ($nodeName == 'TD') {
//       $target.parent('tr').addClass('active');
//     }
//   }).mouseup(function(e) {
//     var $target = $(e.target);
//     var $nodeName = e.target.nodeName;
//     if ($nodeName == 'TD') {
//       $target.parent('tr').removeClass('active');
//     }
//   });
// }
/*toggle ui*/
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
  $btn.on('click', function() {
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
    $dropdown_btn.eq(i).on('click', (function(index) {
      return function() {
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
    $(window).scroll(function() {
      if ($dropdown_box.hasClass('active')) {
        removeActive();
      }
    });
    $(window).resize(function() {
      if ($dropdown_box.hasClass('active')) {
        removeActive();
      }
    });
    $('body').on('click', function(e) {
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
    $tooltip_label.eq(i).mouseenter(function(index) {
      // console.log('mouseenter');
      return function() {
        $tooltip_box.remove();
        var $this_box = $tooltipArray[index];
        $('body').append($this_box);
        $this_box.addClass('active');
        $tooltip_label.removeClass('active');
        $(this).addClass('active');
        var $scroll_top = (document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop;
        var $top = $(this).offset().top - $scroll_top;
        var $bottom = (window.innerHeight - $top - $(this).outerHeight());
        var $left = $(this).offset().left + $(this).outerWidth();
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
    }(i)).mouseleave(function() {
      removeActive();
      // console.log('mouseleave');
    });


    function removeActive() {
      $tooltip_box.removeClass('active');
      $tooltip_label.removeClass('active');
      $tooltip_box.remove();
    }
    $(window).scroll(function() {
      if ($tooltip_box.hasClass('active')) {
        removeActive();
      }
    });
    $(window).resize(function() {
      if ($tooltip_box.hasClass('active')) {
        removeActive();
      }
    });
    $('body').on('click', function(e) {
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

//input file onchange function : set title to value
function setValue(e){
  e.parentNode.setAttribute('title', e.value.replace(/^.*[\\/]/, ''))
}