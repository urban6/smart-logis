$(function(){
	SyntaxHighlighter.defaults['gutter'] = false;
	SyntaxHighlighter.defaults['toolbar'] = false;
	SyntaxHighlighter.defaults['quick-code'] = false;

	var $syntax_area = $('.syntax_area');

	for (var i = 0; i < $syntax_area.length; i++) {
		var $syntax_view = $syntax_area.eq(i).find('.syntax_view').eq(0).find('.view');
		var $syntax_code = $syntax_area.eq(i).find('.syntax_code');
		if($syntax_area.eq(i).find('.syntax_code.tab_area').length){
			$syntax_code.find('.tab_cont').find('.cont').eq(0).html('<xmp class="brush:html code"></xmp>');
			$syntax_code.find('.tab_cont').find('.cont').append('<button type="button" class="btn syntax_copy">copy</button>');
		}else{
			$syntax_code.html('<xmp class="brush:html code"></xmp><button type="button" class="btn syntax_copy">copy</button>');
		}
		$syntax_code.find('.code').html($syntax_view.html());
		$syntax_view.prepend('<button type="button" class="syntax_btn btn toggle"><i class="on" title="Source View">Source View</i><i class="off" title="Source Hide">Source Hide</i></button>');
	}

	var $btn_syntax_copy = $('.btn.syntax_copy');
	$val = [];
	for (var i = 0; i < $btn_syntax_copy.length; i++) {
		$val[i] = $btn_syntax_copy.eq(i).parent().find('xmp').text();
		$btn_syntax_copy.eq(i).on('click',(function(index){
			return function(){
				$(this).after('<textarea class="hidden">' + $val[index] + '</textarea>'); 
				$(this).next('textarea').select();
				document.execCommand("copy");
				$(this).next('textarea').remove();
			}
		})(i)); 
	}
	
});
