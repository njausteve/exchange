import axios from "axios";
import OrderBookItem from "../types/orderBook";

const fetchOrders = async (): Promise<OrderBookItem[]> => {
  const response = await axios.get('http://localhost:4050/orders');
  return response.data;
};

export default fetchOrders;
