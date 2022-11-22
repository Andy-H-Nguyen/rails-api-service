class CreatePortfolioApiTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_api_trades do |t|
      t.belongs_to :portfolio, foreign_key: { to_table: :portfolio_api_portfolios }
      t.belongs_to :stock, foreign_key: { to_table: :portfolio_api_stocks }

      t.decimal :price, null: false
      t.integer :order_type, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
