/*! select3 4.0.6-rc.1 | https://github.com/select3/select3/blob/master/LICENSE.md */

(function(){if(jQuery&&jQuery.fn&&jQuery.fn.select3&&jQuery.fn.select3.amd)var e=jQuery.fn.select3.amd;return e.define("select3/i18n/pl",[],function(){var e=["znak","znaki","znaków"],t=["element","elementy","elementów"],n=function(t,n){if(t===1)return n[0];if(t>1&&t<=4)return n[1];if(t>=5)return n[2]};return{errorLoading:function(){return"Nie można załadować wyników."},inputTooLong:function(t){var r=t.input.length-t.maximum;return"Usuń "+r+" "+n(r,e)},inputTooShort:function(t){var r=t.minimum-t.input.length;return"Podaj przynajmniej "+r+" "+n(r,e)},loadingMore:function(){return"Trwa ładowanie…"},maximumSelected:function(e){return"Możesz zaznaczyć tylko "+e.maximum+" "+n(e.maximum,t)},noResults:function(){return"Brak wyników"},searching:function(){return"Trwa wyszukiwanie…"}}}),{define:e.define,require:e.require}})();