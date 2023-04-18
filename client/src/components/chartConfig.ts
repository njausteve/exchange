import { Options } from 'highcharts';

export const options: Options = {
  title: {
    text: 'Orderbook Market Depth'
  },
  credits: {
    enabled: false
  },
  xAxis: {
    minPadding: 0,
    maxPadding: 0,
    plotLines: [{
      color: '#888',
      width: 1,
      label: {
        text: '',
        rotation: 90
      }
    }],
    title: {
      text: 'Price'
    }
  },
  yAxis: [{
    lineWidth: 1,
    gridLineWidth: .1,
    tickWidth: 1,
    tickLength: 5,
    tickPosition: 'inside',
    labels: {
      align: 'left',
      x: 8
    }
  }, {
    opposite: true,
    linkedTo: 0,
    lineWidth: 0.1,
    gridLineWidth: 0,
    tickWidth: 1,
    tickLength: 5,
    tickPosition: 'inside',
    labels: {
      align: 'center',
      x: -8
    }
  }],
  legend: {
    enabled: false
  },
  plotOptions: {
    area: {
      fillOpacity: 0.2,
      lineWidth: 0.1,
      step: 'center'
    }
  },
  tooltip: {
    headerFormat: '<span style="font-size=10px;">Price: {point.key}</span><br/>',
    valueDecimals: 2
  },
  series: []
};
