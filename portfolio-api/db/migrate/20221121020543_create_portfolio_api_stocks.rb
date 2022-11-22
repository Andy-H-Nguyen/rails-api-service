class CreatePortfolioApiStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_api_stocks do |t|
      t.string :ticker
      t.string :name
      t.decimal :current_price

      t.timestamps
    end
  end
end
