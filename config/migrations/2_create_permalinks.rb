Sequel.migration do
  up do
    create_table :permalinks do
      primary_key :id
      String :permalink, unique: true, null: false
      DateTime :created_at

      index :created_at
    end

  end

  down do
    drop_table(:permalinks)
  end
end

