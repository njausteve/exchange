import React from 'react';
import * as Highcharts from 'highcharts';
import HighchartsReact from 'highcharts-react-official';
import { options } from './chartConfig';
import { getSeries } from './orderBookUtils';
import OrderBookItem from "../types/orderBook";

interface DepthChartProps {
  data: OrderBookItem[];
}

const DepthChart: React.FC<DepthChartProps> = ({ data }) => {
  return (
    <HighchartsReact
      highcharts={Highcharts}
      options={{ ...options, series: getSeries(data) }}
    />
  );
};

export default DepthChart;
