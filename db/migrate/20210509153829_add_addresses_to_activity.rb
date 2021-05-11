class AddAddressesToActivity < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :starting_street, :string
    add_column :activities, :starting_city, :string
    add_column :activities, :starting_country, :string
    add_column :activities, :end_street, :string
    add_column :activities, :end_city, :string
    add_column :activities, :end_country, :string
  end
end
