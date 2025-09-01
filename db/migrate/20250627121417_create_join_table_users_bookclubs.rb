class CreateJoinTableUsersBookclubs < ActiveRecord::Migration[8.0]
  def change
    create_join_table :users, :bookclubs do |t|
      # t.index [:user_id, :bookclub_id]
      # t.index [:bookclub_id, :user_id]
    end
  end
end
