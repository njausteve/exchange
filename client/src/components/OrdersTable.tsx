import React from "react";
import OrderBookItem from "../types/orderBook";

interface OrdersTableProps {
  data: OrderBookItem[];
}

const OrdersTable: React.FC<OrdersTableProps> = ({ data }) => {
  return (
    <div className="relative overflow-x-auto shadow-md sm:rounded-lg">
      <div className="py-4">Buy Orders & Sell orders</div>
      <table className="table-auto w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead className="text-xs text-gray-700 uppercase dark:text-gray-400 border border-slate-300">
          <tr>
            <th colSpan={2} className="border border-slate-300 px-10 py-3 bg-gray-50">Buy Orders</th>
            <th colSpan={2} className="border border-slate-300 px-10 py-3 bg-gray-50">Sell Orders</th>
          </tr>
        </thead>
        <thead className="text-xs text-gray-700 uppercase dark:text-gray-400">
          <tr>
            <th className="border border-slate-300 px-10 py-3 bg-gray-50">Size</th>
            <th className="border border-slate-300 px-10 py-3 bg-gray-50">Bid</th>
            <th className="border border-slate-300 px-10 py-3 bg-gray-50">Ask</th>
            <th className="border border-slate-300 px-10 py-3 bg-gray-50">size</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr key={index} className="border-b border-gray-200 dark:border-gray-700">
              <td className="px-10 py-4">{item.bid_quantity}</td>
              <td className="border border-slate-300 px-10 py-4 bg-gray-50 dark:bg-gray-800">
                $ {item.bid_price}
              </td>
              <td className="border border-slate-300 px-10 py-4 bg-gray-50 dark:bg-gray-800">
                $ {item.ask_price}
              </td>
              <td className="px-10 py-4">{item.ask_quantity}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default OrdersTable;
