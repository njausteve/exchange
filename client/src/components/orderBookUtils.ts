import OrderBookItem from "../types/orderBook";

interface Accumulator {
  asks: number[][];
  bids: number[][];
}

export const getSeries = (data: OrderBookItem[]) => {
  const dataSimplified = data.reduce<Accumulator>(
    (acc, { ask_price, ask_quantity, bid_price, bid_quantity }) => {
      if (ask_price + ask_quantity + bid_price + bid_quantity === 0) return acc;
      acc.asks.push([ask_price, ask_quantity]);
      acc.bids.push([bid_quantity, bid_price]);
      return acc;
    },
    { asks: [], bids: [] })


  return [
    {
      type: 'area',
      name: 'Asks',
      data: dataSimplified.asks,
      color: '#fc5857'
    }, {
      type: 'area',
      name: 'Bids',
      data: dataSimplified.bids,
      color: '#03a7a8'
    }]
};
