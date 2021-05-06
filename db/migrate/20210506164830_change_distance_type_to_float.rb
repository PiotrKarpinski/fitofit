class ChangeDistanceTypeToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :activities, :distance, :decimal, precision: 10, scale: 2
  end
end
