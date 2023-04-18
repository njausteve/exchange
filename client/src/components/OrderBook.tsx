import React from "react";

import OrderBookItem from "../types/orderBook";
import fetchOrders from "../api/orders";

import LoadingIndicator from "./LoadingIndicator";
import OrdersTable from "./OrdersTable";
import DepthChart from "./DepthChart";
import Button from "./Button";

import { useQuery } from "@tanstack/react-query";

const OrderBook: React.FC = () => {
  const { error, data, isFetching, refetch } = useQuery<OrderBookItem[], Error>({
    queryKey: ['orders'],
    queryFn: fetchOrders,
  });

  const handleClick = () => {
    refetch()
  };

  return (
    <div className="w-full">
      <div className="flex justify-end">
        <Button isFetching={isFetching} onClick={handleClick} />
      </div>
      <div className="mt-6 relative">
        {isFetching && <LoadingIndicator />}

        {!isFetching && error &&
          <div className="flex items-center justify-center gap-4 mt-20 lg:mt-40">
            <div className="px-3 py-1 text-2xl leading-none text-center text-red-500 font-light">Oops! We encountered an issue while fetching data.</div>
          </div>
        }

        <div className={`flex flex-col lg:flex-row justify-evenly gap-4 #{isFetching && 'blur-xl'}`}>
          {data && !error && < DepthChart data={data} />}
          {data && !error && <OrdersTable data={data} />}
        </div>
      </div>
    </div >)
}

export default OrderBook;
