var radarChartConfig = {
  type: 'radar',
  data: {
      labels: ['1', '2', '3', '4', '5'],
      datasets: [{
          label: "PC1",
          data: [],
          backgroundColor: nbaRedTransparent,
          borderColor: nbaRed,
          pointBackgroundColor: nbaRedTransparent,
          pointBorderColor: nbaRed
      },
      {
          label: "PC2",
          data: [],
          backgroundColor: nbaBlueTransparent,
          borderColor: nbaBlue,
          pointBackgroundColor: nbaBlueTransparent,
          pointBorderColor: nbaBlue
      }]
  },
  options: {
    scale: {
      pointLabels: {
        fontColor: '#df691a',
        fontSize: 12
      },
      gridLines: {
        color: chartGridColor
      },
      angleLines: {
        color: chartZeroColor
      },
      ticks: {
        backdropColor: 'rgba(0, 0, 0, 0.2)',
        fontColor: chartFontColor,
        backdropPaddingY: 1,
        fontSize: 11,
        max: 1,
        min: -1
      }
    },
    title: {
      display: true,
      text: 'Doprinos promenljivih na komponentama',
      fontColor: chartFontColor,
      fontSize: 12,
    },
    legend: {
      labels: {
        fontColor: chartFontColor
      }
    }
  }
}
