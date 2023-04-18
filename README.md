# Exchange Order Book

This project simulates a simplified model of an order book of a financial exchange and displays the data in a reusable React application. The backend is built with Elixir and Plug/Cowboy, while the frontend uses React.

## Table of Contents

- [Tech stack](#tech-stack)
- [Setup](#setup)
- [Running the Apps](#running-the-apps)
- [Architecture](#architecture)
- [Assumptions](#assumptions)
- [Improvements](#improvements)
- [Additional Information](#additional-information)


### Tech stack
* elixir 1.14.4
* erlang 25.3
* nodejs 18.14.2

## Installation

### Pre-requisites

This setup assumes you have already installed and set up the following:
- [Homebrew](https://brew.sh/) (macOS only)
- [asdf](https://asdf-vm.com/guide/getting-started.html)

Note: It is recommended to use _asdf_ instead of tool/language specific version managers.

Don't forget to clone the repo of course.

```sh
git clone https://github.com/njausteve/exchange.git
```
### Installing Elixir, Erlang, and Nodejs

Once you have asdf installed, run the commands below from any directory:

```sh
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add nodejs
asdf reshim
```

Install the necessary versions:

```sh
cd exchange
asdf install
```
### Backend
1. Run `mix deps.get` to fetch the dependencies.
2. Run `iex -S mix` to start the server in an iex shell.


I've gone an extra mile and add a iex.exs file to make it easy to seed the events given in the example and have them as `event_1` ... `event_7`.

At this point, you can choose to seed the events or come back to this later.

#### Seeding the events

To seed all the events, run while in your iex console run
```elixir
iex> Enum.each(events, fn event -> Exchange.send_instruction(Exchange, event) end)

```
Or you can choose to seed 1 at a time by running
```elixir
iex> Exchange.send_instruction(Exchange, event_1)
:ok

iex> Exchange.send_instruction(Exchange, event_2)
:ok
```
See the Iex.exs file for details and an explanation why we will not the pid.
### Frontend

1. After installing nodejs using asdf or any other method and optionally seeding some events.
2. Navigate to the `client` directory.
3. Run `npm install` to fetch the dependencies.
4. Run `npm start` to start the React development server.

This should start the React development server on port 3000.

## Running the Apps

1. Make sure both the backend and frontend servers are running as described in the [Setup](#setup) section.
2. Open your browser and visit `http://localhost:3000` to view the React app.

You should see the UI: (Not the best looking UI but 🤷🏽‍♂️)

![UI](/docs/reactUI.png)

## Architecture

##### Information flow

![Aritecture](/docs/architecture.png)

### Backend

- The backend is built using Elixir and Plug/Cowboy.
- An `Exchange` module simulates the order book of a financial exchange.
- The order book state is managed by a GenServer with a map data structure.
- The application exposes a REST API for the frontend to consume.
- The REST API provides endpoints for sending instructions and fetching order book data.

### Frontend

- The frontend is built using React, Typescript, Tailwindcss.
- A reusable `OrderBook` component displays the exchange data.
- The application fetches the latest exchange data when the user opens the website using react Query.
- The app enters a loading state when the user clicks the `Show latest` button.
- The app shows either the data response from the API or an error message in case the API request fails.

## Assumptions

While working on the implemention I made the following assumptions

1. That there was **no need to persist the data** since the primary focus(as it  seemed to me) was on data structures and algorithms and not on data persistence.
2. It was not too obvious what the **use of the price_level_index** is. How its calculated and who increments it. Since the events given as examples have the values already added.
3. **Security and authentication** was not a concern. I did not add any authentication or authorization.

## Improvements
Here are some of my thoughts on improvements that can be considered for the Exchange Order Book
## Backend

1. **Data persistence:** Adding data persistence using a database (e.g., PostgreSQL with Ecto) or other storage solutions will ensure that the order book data is not lost when the application restarts or encounters any crashes. This can be particularly important when dealing with financial data, where data integrity and consistency are crucial.

2. **Perfomance improvements:** Rather than using a simple map for the GenServer's state, leveraging Elixir's built-in ETS (Erlang Term Storage). ETS tables can provide more efficient and performant data storage and retrieval. ETS allows for fast in-memory storage. Espcially for shared state between processes.

The order book is I implemenented as a behavior to allow for swapping out the implementation. This can be useful for testing and benchmarking different data structures.

Note: there are also possibilities of optimizing the functions especially to fetch the top orderbook entries. to reduce time and space complexity.

3. **Add test coverage reports:** This can be done using ExCoveralls. This will allow us to see the test coverage of the application. (Maybe I'll have it added by the time you are going through this)

## FrontEnd
1. **Tests**: Definately would be nice to have more tests. You can never have enough tests :)

## overall
1. Maybe add a **dockerfile** to make it easier to run the app.
2. A one time executable script to install all the dependencies and run the app. We all want an easy life 😁
## Additional Information

This project serves as a simple example of a financial exchange order book simulation. It can be further extended and customized to meet specific requirements and use cases.
