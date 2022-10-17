class CreateCurrencyList < ActiveRecord::Migration[7.0]
  def change
    create_table :currency_list do |t|
      t.json :list

      t.timestamps
    end
  end
end
