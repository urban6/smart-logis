/*! select3 4.0.6-rc.1 | https://github.com/select3/select3/blob/master/LICENSE.md */

(function(){if(jQuery&&jQuery.fn&&jQuery.fn.select3&&jQuery.fn.select3.amd)var e=jQuery.fn.select3.amd;return e.define("select3/i18n/ro",[],function(){return{errorLoading:function(){return"Rezultatele nu au putut fi incărcate."},inputTooLong:function(e){var t=e.input.length-e.maximum,n="Vă rugăm să ștergeți"+t+" caracter";return t!==1&&(n+="e"),n},inputTooShort:function(e){var t=e.minimum-e.input.length,n="Vă rugăm să introduceți "+t+" sau mai multe caractere";return n},loadingMore:function(){return"Se încarcă mai multe rezultate…"},maximumSelected:function(e){var t="Aveți voie să selectați cel mult "+e.maximum;return t+=" element",e.maximum!==1&&(t+="e"),t},noResults:function(){return"Nu au fost găsite rezultate"},searching:function(){return"Căutare…"}}}),{define:e.define,require:e.require}})();