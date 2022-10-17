class AddNotNullConstraints < ActiveRecord::Migration[7.0]
  def change

    change_column :currency_list, :list, :json, null: false
    change_column :currency_rates, :currency_from, :string, null: false
    change_column :currency_rates, :currency_to, :string, null: false
    change_column :currency_rates, :rate, :float, null: false
  end
end
