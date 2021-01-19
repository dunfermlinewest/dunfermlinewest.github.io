/**
 * ---------------------------------------
 * For more information visit:
 * https://www.amcharts.com/
 *
 * Documentation is available at:
 * https://www.amcharts.com/docs/v4/
 * ---------------------------------------
 */

// Create map instance
var chart = am4core.create("chartdiv", am4maps.MapChart);

// Set map definition
chart.geodata = am4geodata_worldLow;

// Set projection
chart.projection = new am4maps.projections.Miller();

// Create map polygon series
var polygonSeries = chart.series.push(new am4maps.MapPolygonSeries());

// Make map load polygon (like country names) data from GeoJSON
polygonSeries.useGeodata = true;

// Configure series
var polygonTemplate = polygonSeries.mapPolygons.template;
polygonTemplate.tooltipText = "{name} - {id}";
polygonTemplate.fill = am4core.color("#767676");

// Create hover state and set alternative fill color
var hs = polygonTemplate.states.create("hover");
hs.properties.fill = am4core.color("#626262");


// Remove Antarctica
polygonSeries.exclude = ["AQ"];
var countries = countries.split(',');

defaultSeries = [];
$.each(countries, function(index, value) {
    defaultSeries.push({
        "id": value,
        "value": 100,
        "fill": am4core.color("#f77f71")
    });
});

polygonSeries.data = defaultSeries;
// Bind "fill" property to "fill" key in data
polygonTemplate.propertyFields.fill = "fill";


function highlightCty(ref) {
    var ref = ref.split(',');
    highlightSeries = [];
    $.each(ref, function(index, value) {
        highlightSeries.push({
            "id": value,
            "value": 100,
            "fill": am4core.color("#7eafee")
        });
    });
    polygonSeries.data = highlightSeries;
}

function resetCty() {
    polygonSeries.data = defaultSeries;
}

$( document ).ready(function() {
    $(".maphover").bind('mouseenter touchstart', function(){ 
        highlightCty($(this).attr('ref'));
    });
    $(".maphover").bind('mouseleave touchend', function(){ 
        resetCty();
    });
});



// include series data on Page