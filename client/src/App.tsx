import React from 'react';
import OrderBook from './components/OrderBook';
import Header from './components/Header';

export default function App() {
  return (
    <div>
      <Header />
      <div className="mx-auto max-w-3xl px-4 sm:px-6 lg:max-w-7xl lg:px-8">
        <div className="relative flex items-center justify-center py-5 lg:justify-between">
          <OrderBook />
        </div >
      </div>
    </div >
  )
};
