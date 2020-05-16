class CreateTableUsers < Sequel::Migration
  def up
    create_table :users do
      primary_key :id
      String :name, unique: true
      String :group
    end
  end

  def down
    drop_table :users
  end
end
