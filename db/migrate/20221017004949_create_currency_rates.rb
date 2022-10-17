class CreateCurrencyRates < ActiveRecord::Migration[7.0]
  def change
    create_table :currency_rates do |t|
      t.string :currency_from
      t.string :currency_to
      t.float :rate

      t.timestamps
    end
  end
end
