var ctx, scatterChart;

// Rendering osnovnih html elemenata
$(document).ready(function(){
	ctx = $("#chartUI");
	renderScatterChart(scatterChartConfig);
});

// Funkcionalnost isctavanja grafika
var renderScatterChart = function(scf) {
	scatterChart = new Chart(ctx, scf);
}

var addScatterData = function(data) { //Podrazumeva se da su podaci xy
	scatterChart.data.datasets = data;
	scatterChart.update();
}

var removeScatterData = function() {
	scatterChart.data.datasets = [];
	scatterChart.update();
}

// Povezivanje sa instancom Shiny servera
Shiny.addCustomMessageHandler("jsondata",
	function(jsonmessage) {
		var pcadataset = [];
		addScatterData(composeScatterData(_.groupBy(jsonmessage, 'team')));
	}
)

// Uskladjivanje formata podataka R/Grafik
var composeScatterData = function(gdata) {
	var composed = [];
	console.log(gdata);
	_.each(gdata, function(val, key) {
		var dataset = {
			label: key,
			borderColor: _.first(val).auxcolor,
			backgroundColor: _.first(val).color,
			pointBorderColor: _.first(val).auxcolor,
			pointBackgroundColor: _.first(val).color,
			pointRadius: 5,
			data: val
		};
		composed.push(dataset);
	});
	return composed;
}
