class CreatePortfolioApiTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_api_trades do |t|
      t.belongs_to :portfolio
      t.belongs_to :stock

      t.decimal :price
      t.integer :order_type
      t.integer :quantity

      t.timestamps
    end
  end
end
