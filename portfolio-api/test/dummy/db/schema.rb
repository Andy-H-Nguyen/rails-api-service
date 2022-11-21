# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_21_020543) do
  create_table "portfolio_api_portfolios", force: :cascade do |t|
    t.integer "portfolio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["portfolio_id"], name: "index_portfolio_api_portfolios_on_portfolio_id"
  end

  create_table "portfolio_api_stocks", force: :cascade do |t|
    t.string "ticker"
    t.string "name"
    t.integer "trade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["trade_id"], name: "index_portfolio_api_stocks_on_trade_id"
  end

  create_table "portfolio_api_trades", force: :cascade do |t|
    t.integer "portfolio_id"
    t.decimal "price"
    t.integer "order_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["portfolio_id"], name: "index_portfolio_api_trades_on_portfolio_id"
  end

end
