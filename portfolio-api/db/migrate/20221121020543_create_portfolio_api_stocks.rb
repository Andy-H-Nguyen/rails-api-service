class CreatePortfolioApiStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_api_stocks do |t|
      t.string :ticker, null: false
      t.string :name, null: false
      t.decimal :current_price, null: false

      t.timestamps
    end
  end
end
