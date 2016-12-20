class CreateUserRounds < ActiveRecord::Migration
  def change
    create_table :user_rounds do |t|
      t.belongs_to :user, index: true
      t.belongs_to :round, index: true
      t.integer :score, default: 0
      t.timestamps
    end   
  end
end
