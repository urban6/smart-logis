/*! select3 4.0.6-rc.1 | https://github.com/select3/select3/blob/master/LICENSE.md */

(function(){if(jQuery&&jQuery.fn&&jQuery.fn.select3&&jQuery.fn.select3.amd)var e=jQuery.fn.select3.amd;return e.define("select3/i18n/id",[],function(){return{errorLoading:function(){return"Data tidak boleh diambil."},inputTooLong:function(e){var t=e.input.length-e.maximum;return"Hapuskan "+t+" huruf"},inputTooShort:function(e){var t=e.minimum-e.input.length;return"Masukkan "+t+" huruf lagi"},loadingMore:function(){return"Mengambil data…"},maximumSelected:function(e){return"Anda hanya dapat memilih "+e.maximum+" pilihan"},noResults:function(){return"Tidak ada data yang sesuai"},searching:function(){return"Mencari…"}}}),{define:e.define,require:e.require}})();