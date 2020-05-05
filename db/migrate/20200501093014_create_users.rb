# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table(:users) do
      primary_key :id
      string :name
      integer :age
      boolean :has_car, default: false
    end
  end
end
