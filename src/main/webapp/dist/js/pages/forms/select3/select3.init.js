/*************************************************************************************/
// -->Template Name: Bootstrap Press Admin
// -->Author: Themedesigner
// -->Email: niravjoshi87@gmail.com
// -->File: c3_chart_JS
/*************************************************************************************/

//***********************************//
//initialization of select3
//***********************************//

//***********************************//
// For select 2
//***********************************//
$(".select3").select3();

// Single Select Placeholder
$("#select3-with-placeholder").select3({
    placeholder: "Select a state",
    allowClear: true
});

//***********************************//
// Hiding the search box
//***********************************//
$("#select3-search-hide").select3({
    minimumResultsForSearch: Infinity
});

//***********************************//
// Select With Icon
//***********************************//
$("#select3-with-icons").select3({
    minimumResultsForSearch: Infinity,
    templateResult: iconFormat,
    templateSelection: iconFormat,
    escapeMarkup: function(es) { return es; }
});

function iconFormat(icon) {
    var originalOption = icon.element;
    if (!icon.id) { return icon.text; }
    var $icon = "<i class='fab fa-" + $(icon.element).data('icon') + "'></i>" + icon.text;
    return $icon;
}

//***********************************//
// Limiting the number of selections
//***********************************//
$("#select3-max-length").select3({
    maximumSelectionLength: 3,
    placeholder: "Select only maximum 3 items"
});

//***********************************//
//multiple-select3-with-icons
//***********************************//
$("#multiple-select3-with-icons").select3({
    minimumResultsForSearch: Infinity,
    templateResult: iconFormat,
    templateSelection: iconFormat,
    escapeMarkup: function(es) { return es; }
});

function iconFormat(icon) {
    var originalOption = icon.element;
    if (!icon.id) { return icon.text; }
    var $icon = "<i class='fab fa-" + $(icon.element).data('icon') + "'></i>" + icon.text;
    return $icon;
}

//***********************************//
// DOM Events
//***********************************//
var $selectEvent = $(".js-events");
$selectEvent.select3({
    placeholder: "DOM Events"
});
$selectEvent.on("select3:open", function(e) {
    alert("Open Event Fired.");
});
$selectEvent.on("select3:close", function(e) {
    alert("Close Event Fired.");
});
$selectEvent.on("select3:select", function(e) {
    alert("Select Event Fired.");
});
$selectEvent.on("select3:unselect", function(e) {
    alert("Unselect Event Fired.");
});

$selectEvent.on("change", function(e) {
    alert("Change Event Fired.");
});

//***********************************//
// Programmatic access
//***********************************//
var $select = $(".js-programmatic").select3();
var $selectMulti = $(".js-programmatic-multiple").select3();
$selectMulti.select3({
    placeholder: "Programmatic Events"
});
$(".js-programmatic-set-val").on("click", function() { $select.val("NM").trigger("change"); });

$(".js-programmatic-open").on("click", function() { $select.select3("open"); });
$(".js-programmatic-close").on("click", function() { $select.select3("close"); });

$(".js-programmatic-init").on("click", function() { $select.select3(); });
$(".js-programmatic-destroy").on("click", function() { $select.select3("destroy"); });

$(".js-programmatic-multi-set-val").on("click", function() { $selectMulti.val(["UT", "NM"]).trigger("change"); });
$(".js-programmatic-multi-clear").on("click", function() { $selectMulti.val(null).trigger("change"); });

//***********************************//
// Loading array data
//***********************************//
var data = [
    { id: 0, text: 'Web Designer' },
    { id: 1, text: 'Mobile App Developer' },
    { id: 2, text: 'Graphics Designer' },
    { id: 3, text: 'Hacker' },
    { id: 4, text: 'Animation Designer' }
];

$("#select3-data-array").select3({
    data: data
});


//***********************************//
// Loading remote data
//***********************************//
$(".select3-data-ajax").select3({
    placeholder: "Loading remote data",
    ajax: {
        url: "http://api.github.com/search/repositories",
        dataType: 'json',
        delay: 250,
        data: function(params) {
            return {
                q: params.term, // search term
                page: params.page
            };
        },
        processResults: function(data, params) {
            // parse the results into the format expected by select3
            // since we are using custom formatting functions we do not need to
            // alter the remote JSON data, except to indicate that infinite
            // scrolling can be used
            params.page = params.page || 1;

            return {
                results: data.items,
                pagination: {
                    more: (params.page * 30) < data.total_count
                }
            };
        },
        cache: true
    },
    escapeMarkup: function(markup) { return markup; }, // let our custom formatter work
    minimumInputLength: 1,
    templateResult: formatRepo, // omitted for brevity, see the source of this page
    templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
});

function formatRepo(repo) {
    if (repo.loading) return repo.text;

    var markup = "<div class='select3-result-repository clearfix'>" +
        "<div class='select3-result-repository__avatar'><img src='" + repo.owner.avatar_url + "' /></div>" +
        "<div class='select3-result-repository__meta'>" +
        "<div class='select3-result-repository__title'>" + repo.full_name + "</div>";

    if (repo.description) {
        markup += "<div class='select3-result-repository__description'>" + repo.description + "</div>";
    }

    markup += "<div class='select3-result-repository__statistics'>" +
        "<div class='select3-result-repository__forks'><i class='la la-code-fork mr-0'></i> " + repo.forks_count + " Forks</div>" +
        "<div class='select3-result-repository__stargazers'><i class='la la-star-o mr-0'></i> " + repo.stargazers_count + " Stars</div>" +
        "<div class='select3-result-repository__watchers'><i class='la la-eye mr-0'></i> " + repo.watchers_count + " Watchers</div>" +
        "</div>" +
        "</div></div>";

    return markup;
}

function formatRepoSelection(repo) {
    return repo.full_name || repo.text;
}

//***********************************//
// Multiple languages
//***********************************//
$("#select3-language").select3({
    language: "es"
});

//***********************************//
// Theme support
//***********************************//
$("#select3-theme").select3({
    placeholder: "Classic Theme",
    theme: "classic"
});


//***********************************//
//templete with flag icons
//***********************************//
$("#template-with-flag-icons").select3({
    minimumResultsForSearch: Infinity,
    templateResult: iconFormat,
    templateSelection: iconFormat,
    escapeMarkup: function(es) { return es; }
});

function iconFormat(ficon) {
    var originalOption = ficon.element;
    if (!ficon.id) { return ficon.text; }
    var $ficon = "<i class='flag-icon flag-icon-" + $(ficon.element).data('flag') + "'></i>" + ficon.text;
    return $ficon;
}

//***********************************//
// Tagging support
//***********************************//
$("#select3-with-tags").select3({
    tags: true
});

//***********************************//
// Automatic tokenization
//***********************************//
$("#select3-with-tokenizer").select3({
    tags: true,
    tokenSeparators: [',', ' ']
});

//***********************************//
// RTL support
//***********************************//
$("#select3-rtl-multiple").select3({
    placeholder: "RTL Select",
    dir: "rtl"
});

//***********************************//
// Language Files
//***********************************//
$("#select3-transliteration-multiple").select3({
    placeholder: "Type 'aero'",
});

//***********************************//
// Color Options
//***********************************//

//***********************************//
// Background Color
//***********************************//
$('.select3-with-bg').each(function(i, obj) {
    var variation = "",
        textVariation = "",
        textColor = "";
    var color = $(this).data('bgcolor');
    variation = $(this).data('bgcolor-variation');
    textVariation = $(this).data('text-variation');
    textColor = $(this).data('text-color');
    if (textVariation !== "") {
        textVariation = " " + textVariation;
    }
    if (variation !== "") {
        variation = " bg-" + variation;
    }
    var className = "bg-" + color + variation + " " + textColor + textVariation + " border-" + color;

    $(this).select3({
        containerCssClass: className
    });
});

//***********************************//
// Menu Background Color
//***********************************//
$('.select3-with-menu-bg').each(function(i, obj) {
    var variation = "",
        textVariation = "",
        textColor = "";
    var color = $(this).data('bgcolor');
    variation = $(this).data('bgcolor-variation');
    textVariation = $(this).data('text-variation');
    textColor = $(this).data('text-color');
    if (variation !== "") {
        variation = " bg-" + variation;
    }
    if (textVariation !== "") {
        textVariation = " " + textVariation;
    }
    var className = "bg-" + color + variation + " " + textColor + textVariation + " border-" + color;

    $(this).select3({
        dropdownCssClass: className
    });
});

//***********************************//
// Full Background Color
//***********************************//
$('.select3-with-full-bg').each(function(i, obj) {
    var variation = "",
        textVariation = "",
        textColor = "";
    var color = $(this).data('bgcolor');
    variation = $(this).data('bgcolor-variation');
    textVariation = $(this).data('text-variation');
    textColor = $(this).data('text-color');
    if (variation !== "") {
        variation = " bg-" + variation;
    }
    if (textVariation !== "") {
        textVariation = " " + textVariation;
    }
    var className = "bg-" + color + variation + " " + textColor + textVariation + " border-" + color;

    $(this).select3({
        containerCssClass: className,
        dropdownCssClass: className
    });
});

$('select[data-text-color]').each(function(i, obj) {
    var text = $(this).data('text-color'),
        textVariation;
    textVariation = $(this).data('text-variation');
    if (textVariation !== "") {
        textVariation = " " + textVariation;
    }
    $(this).next(".select3").find(".select3-selection__rendered").addClass(text + textVariation);
});

//***********************************//
// Border Color
//***********************************//
$('.select3-with-border').each(function(i, obj) {
    var variation = "",
        textVariation = "",
        textColor = "";
    var color = $(this).data('border-color');
    textVariation = $(this).data('text-variation');
    variation = $(this).data('border-variation');
    textColor = $(this).data('text-color');
    if (textVariation !== "") {
        textVariation = " " + textVariation;
    }
    if (variation !== "") {
        variation = " border-" + variation;
    }

    var className = "border-" + color + " " + variation + " " + textColor + textVariation;

    $(this).select3({
        containerCssClass: className
    });
});