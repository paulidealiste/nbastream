var ctx, ctr, scatterChart, radarChart;

// Rendering osnovnih html elemenata
$(document).ready(function(){
	ctx = $("#chartUI");
	ctr = $("#radarUI");
	renderScatterChart(scatterChartConfig);
	renderRadarChart(radarChartConfig);
});

// Funkcionalnost isctavanja grafika rasprsivanja i dijagrama doprinosa
var renderScatterChart = function(scf) {
	scatterChart = new Chart(ctx, scf);
}

var renderRadarChart = function(rcf) {
	console.log(rcf.options);
	radarChart = new Chart(ctr, rcf);
}

// Upravljanje podacima grafika rasprsivanja
var addScatterData = function(data) { //Podrazumeva se da su podaci xy
	scatterChart.data.datasets = data;
	scatterChart.update();
}

var removeScatterData = function() {
	scatterChart.data.datasets = [];
	scatterChart.update();
}

// Upravljanje podacima grafika doprinosa

var addRadarData = function(data) {
	radarChart.data.labels = data.varnames;
	radarChart.data.datasets[0].label = "PC1";
	radarChart.data.datasets[0].data = _.map(data.pcc, 'PC1');
	radarChart.data.datasets[1].label = "PC2";
	radarChart.data.datasets[1].data = _.map(data.pcc, 'PC2');
	radarChart.update();
}

var removeRadarData = function() {
	radarChart.data.labels = ['1', '2', '3', '4', '5'];
	_.forEach(radarChart.data.datasets, function(ds) {
		ds.data = [];
	});
	radarChart.update();
}

// Povezivanje sa instancom Shiny servera
Shiny.addCustomMessageHandler("jsondata",
	function(jsondata) {
		var pcadataset = [];
		addScatterData(composeScatterData(_.groupBy(jsondata, 'team')));
	}
)

Shiny.addCustomMessageHandler("jsoninfo",
	function(jsoninfo) {
		fillInPCAinfo(jsoninfo);
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

// Popunjavanje osnovnih informacija o izvrsenoj PCA analizi
var fillInPCAinfo = function(ginfo) {
	_.first(scatterChart.options.scales.xAxes).scaleLabel.labelString = ginfo.pcaNames[0] + ' (' + ginfo.pcva[0] + '%)';
	_.first(scatterChart.options.scales.yAxes).scaleLabel.labelString = ginfo.pcaNames[1] + ' (' + ginfo.pcva[1] + '%)';
	scatterChart.update();
	addRadarData(ginfo);
}
