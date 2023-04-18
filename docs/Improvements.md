## What can be improved?

Here are some of my thoughts on improvements that can be considered for the Exchange Order Book

## Backend

1. **Data persistence:** Adding data persistence using a database (e.g., PostgreSQL with Ecto) or other storage solutions will ensure that the order book data is not lost when the application restarts or encounters any crashes. This can be particularly important when dealing with financial data, where data integrity and consistency are crucial.

2. **Perfomance improvements:** Rather than using a simple map for the GenServer's state, leveraging Elixir's built-in ETS (Erlang Term Storage). ETS tables can provide more efficient and performant data storage and retrieval. ETS allows for fast in-memory storage. Espcially for shared state between processes.

The order book is I implemenented as a behavior to allow for swapping out the implementation. This can be useful for testing and benchmarking different data structures.

Note: there are also possibilities of optimizing the functions especially to fetch the top orderbook entries.

3. **Add test coverage reports:** This can be done using ExCoveralls. This will allow us to see the test coverage of the application. (Maybe I'll have it added by the time you are going through this)

## FrontEnd

1. **Tests**: Definately would be nice to have more tests. You can never have enough tests :)
