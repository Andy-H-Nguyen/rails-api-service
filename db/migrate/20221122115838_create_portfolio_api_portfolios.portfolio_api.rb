# This migration comes from portfolio_api (originally 20221121020519)
class CreatePortfolioApiPortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_api_portfolios do |t|
      t.timestamps
    end
  end
end
