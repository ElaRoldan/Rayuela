class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :winner, default: 0
      t.timestamps
    end   
  end
end
