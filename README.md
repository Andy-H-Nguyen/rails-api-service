# rails-api-service

## Portfolio API
A portfolio tracking API which allows adding/deleting/updating trades and can do basic return calculations etc.
For simplicity assume that there will be only one portfolio and one user.
The portfolio is essentially a collection of stocks, each stock having multiple trades (buy/sell). Each trade can have only one stock, a quantity and a date.

### Example portfolio:
RELIANCE:
BUY 100@900 10/04/2015
SELL 50@1000 10/05/2015 BUY 100@850 10/06/2015
HDFCBANK:
BUY 200@1000 11/05/2015
SELL 100 @800 12/07/2015
Holdings:
RELIANCE: 150 @ 875.5 (Avg of all buys) HDFCBANK: 100 @ 1000

### API
### Models
- Stock - just an alphanumeric id. Just pick any random strings for now, you do not need to
create the whole stock collection. Use yahoo/google finance if you’re feeling
adventurous
- Trade - Should capture a date, price, type (buy/sell)
- Portfolio - an aggregation over stocks and trades
Functionality
- Retrieve the portfolio
- Add/delete/modify trades
- Get the average buying price, cumulative return
Calculate the average buying price as the average of all buys disregarding sells.
The cumulative return requires the initial and current price. The initial price should be on the trade and you can get the current price using third party APIs like google or yahoo finance.

![CI](https://github.com/Andy-H-Nguyen/rails-api-service/actions/workflows/ci.yml/badge.svg)

[Live demo here](https://rails-api-service.herokuapp.com/)

[Postman collection](https://www.getpostman.com/collections/f64c49e71e7c5b0eab96) 

### Getting Started

Install Rails 7.0.4, using ruby 3.1-2 is highly recommended.

`git clone https://github.com/Andy-H-Nguyen/rails-api-service.git`

`cd rails-api-service`

Copy migrations from the rails engine.

`rake portfolio_api:install:migrations`

`rails db:create db:migrate`

Preload the test dataset using `rake db:fixtures:load RAILS_ENV=development FIXTURES_PATH='portfolio-api/test/fixtures'`

`rails s`

Make any requests to `http://127.0.0.1:3000`

Run tests using 

`cd portfolio-api`

`rails test`

### Assumptions
- There is only one portfolio. Multiple portfolios is not supported.
- No duplicate tickers, or stock names are allowed.
- The date that the trade model is created is the trade date.
- The formula used for average of all buys is `average_of_all_buys = total_purchase_price/total_shares`. No sell orders were included. This means that we have `RELIANCE: 150 @ 875` instead of `RELIANCE: 150 @ 875.5`

### Design
- To keep code modular, this app is an API host. Each individual API can be mounted as an rails engine. At the moment there is only one engine here `portfolio-api`. We could add more in the future.
- Internally we represent data using three models: portfolio, trade and stock. No other models for holdings or returns are created.
- For simplicity, I kept this as vanilla and in-the-box as possible using stock rails features.

### Tests
- Tests are under the `portfolio-api/test` folder.

### Features

`GET /portfolio/`
 
 Sample response

```
{
    success: true,
    data:
    {"GOOGLE"=>
        [{"id"=>33,
            "portfolio_id"=>11,
            "stock_id"=>22,
            "price"=>"12.24",
            "order_type"=>"buy",
            "quantity"=>1,
            "created_at"=>"1970-01-01T00:00:01.000Z",
            "updated_at"=>"1970-01-01T00:00:01.000Z"}],
        "RELIANCE"=>
        [{"id"=>111,
            "portfolio_id"=>11,
            "stock_id"=>333,
            "price"=>"900.0",
            "order_type"=>"buy",
            "quantity"=>100,
            "created_at"=>"2015-10-04T00:00:00.000Z",
            "updated_at"=>"2015-10-04T00:00:00.000Z"},
        {"id"=>222,
            "portfolio_id"=>11,
            "stock_id"=>333,
            "price"=>"1000.0",
            "order_type"=>"sell",
            "quantity"=>50,
            "created_at"=>"2015-10-05T00:00:00.000Z",
            "updated_at"=>"2015-10-05T00:00:00.000Z"},
        {"id"=>333,
            "portfolio_id"=>11,
            "stock_id"=>333,
            "price"=>"850.0",
            "order_type"=>"buy",
            "quantity"=>100,
            "created_at"=>"2015-10-06T00:00:00.000Z",
            "updated_at"=>"2015-10-06T00:00:00.000Z"}],
        "HDFCBANK"=>
        [{"id"=>4444,
            "portfolio_id"=>11,
            "stock_id"=>444,
            "price"=>"1000.0",
            "order_type"=>"buy",
            "quantity"=>200,
            "created_at"=>"2015-11-05T00:00:00.000Z",
            "updated_at"=>"2015-11-05T00:00:00.000Z"},
        {"id"=>5555,
            "portfolio_id"=>11,
            "stock_id"=>444,
            "price"=>"800.0",
            "order_type"=>"sell",
            "quantity"=>100,
            "created_at"=>"2015-12-07T00:00:00.000Z",
            "updated_at"=>"2015-12-07T00:00:00.000Z"}]}, 
            response.parsed_body["data"])
}
```
 
`GET /portfolio/holdings`

Sample response

```
{
    success: true,
    data:
    {
        "GOOGLE"=>{
            "total_shares"=>1, 
            "average_of_all_buys"=>"12.24"
        }, 
        "RELIANCE"=>{
            "total_shares"=>200, 
            "average_of_all_buys"=>"875.0"
        }, 
        "HDFCBANK"=>{
            "total_shares"=>200, 
            "average_of_all_buys"=>"1000.0"
        }
    }
}
```

`GET /portfolio/returns`

Sample response

```
{
    success: true,
    data:
    {
        "GOOGLE"=>{"culmulative_return"=>"4.0"}, 
        "RELIANCE"=>{"culmulative_return"=>"0.5"}, 
        "HDFCBANK"=>{"culmulative_return"=>"2.0"}
    }
}
```

`POST /portfolio/addTrade`

Sample params

```
{ trade: { stock_ticker: "ABC", price: 7.77, quantity: 100 order_type: 'buy'} }
```

Sample response

 ```
{
    "success"=>true,
    "data"=>{
        "id"=>5556,
        "portfolio_id"=>11,
        "stock_id"=>22,
        "price"=>"7.77",
        "order_type"=>"buy",
        "quantity"=>"100",
        "created_at"=>"2022-11-22T15:00:42.078Z",
        "updated_at"=>"2022-11-22T15:00:42.078Z"}
    }
}
 ```

`POST /portfolio/updateTrade/:id`

Sample params

```
{ trade: { stock_ticker: "RELI", price: 7.89, quantity: 1, order_type: 'sell'} }
```

Sample response

```
{
    "success"=>true,
    "data"=>
    {
        "portfolio_id"=>11,
        "stock_id"=>333,
        "price"=>"7.89",
        "order_type"=>"sell",
        "id"=>33,
        "quantity"=>1,
        "created_at"=>"1970-01-01T00:00:01.000Z",
        "updated_at"=>"2022-11-22T15:03:21.430Z"
    }
}
 ```

`POST /portfolio/removeTrade/:id`

Sample response

 ```
 {
    "success"=>true,
    "data"=>
    {
        "id"=>33,
        "portfolio_id"=>11,
        "stock_id"=>22,
        "price"=>"12.24",
        "order_type"=>"buy",
        "quantity"=>1,
        "created_at"=>"1970-01-01T00:00:01.000Z",
        "updated_at"=>"1970-01-01T00:00:01.000Z"
    }
}
 ```

### Tech Debt + Implementation wishlist
- code quality tools like codecov, packwerk, rubocop
- use GraphQL instead of REST, for QOL features like introspection queries, and stronger schemas
- multiple portfolio support
- seeding database with real stocks from an API provider
- ci/cd
