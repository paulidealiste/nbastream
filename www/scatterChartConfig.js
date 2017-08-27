var chartFontColor = 'rgba(255, 255, 255, 0.9)';
var chartGridColor = 'rgba(255, 255, 255, 0.4)';
var chartZeroColor = 'rgba(255, 255, 255, 0.6)';

var emptyData = {
  label: "Trenutno nema podataka",
  data: []
}

var scatterChartConfig = {
  type: 'scatter',
  data: {
    datasets: []
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    showLines: false,
    scales: {
      xAxes: [{
        type: 'linear',
        position: 'bottom',
        gridLines: {
          color: chartGridColor,
          zeroLineColor: chartZeroColor
        },
        ticks: {
          fontColor: chartFontColor
        },
        scaleLabel: {
          display: true,
          labelString: 'PC1 (%)',
          fontColor: chartFontColor
        }
      }],
      yAxes: [{
        gridLines: {
          color: chartGridColor,
          zeroLineColor: chartZeroColor
        },
        ticks: {
          fontColor: chartFontColor
        },
        scaleLabel: {
          display: true,
          labelString: 'PC2 (%)',
          fontColor: chartFontColor
        }
      }],
    },
    title: {
      display: true,
      text: 'PCA napad/odbrana sezona 2016/17',
      fontColor: chartFontColor,
      fontSize: 14,
    },
    legend: {
      display: true,
      labels: {
        fontColor: chartFontColor
      }
    },
    tooltips: {
      backgroundColor: 'rgba(0, 0, 0, 0.5)',
      callbacks: {
      label: function(tooltipItem, data) {
         var label = data.datasets[tooltipItem.datasetIndex].label;
         return label + ': (' + tooltipItem.xLabel + ', ' + tooltipItem.yLabel + ')';
       }
     }
    },
    animation: {
      easing: 'easeInCubic'
    }
  }
}
