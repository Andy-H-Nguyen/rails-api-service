[![Build Status](https://travis-ci.org/kodokon/w-wars.svg?branch=master)](https://travis-ci.org/kodokon/w-wars)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)

Live demo [Here](https://portfolio-api-andy.herokuapp.com/)

### Getting Started

Install the latest Rails 7.0.4, using ruby 3.0.0-p0 is highly recommended.

`git clone https://github.com/Andy-H-Nguyen/rails-api-service.git`

`cd rails-api-service`

`rails s`

Make any requests to `http://127.0.0.1:3000`

Run tests using 

`rails test`

### Assumptions
- There is only one portfolio. Multiple portfolios is not supported.
- No duplicate tickers, there can be companies with the same name as some companies decide to do business under a generic name.
- The date that the trade model is created is the trade date.
- The formula used for average of all buys is `average_of_all_buys = total_purchase_price/total_shares`. No sell orders were included. This means that we have `RELIANCE: 150 @ 875` instead of `RELIANCE: 150 @ 875.5`

### Design
- To keep code modular, this app is an API host. Each individual API can be mounted as an rails engine. There is only one engine here `portfolio-api` we could add more in the future.
- Internally we represent data using three models: portfolio, trade and stock.
- For simplicity, I kept this as vanilla and in-the-box as possible using stock rails features.

### Tests
- Tests are under the `portfolio-api/test` folder.

### Features

`/portfolio/`
 
`/portfolio/holdings`

`/portfolio/returns`

`/portfolio/addTrade`

`/portfolio/updateTrade/:id`

`/portfolio/removeTrade/:id`

### Tech Debt + Implementation wishlist
- code quality tools like codecov, packwerk, rubocop
- use GraphQL instead of REST, for QOL features like introspection queries, and stronger schemas
- multiple portfolios

