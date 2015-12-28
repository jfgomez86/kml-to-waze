Sequel.migration do
  up do
    create_table :places do
      primary_key :id
      String :name, null: false
      String :coordinates, null: false
      String :waze_url, null: false
      String :google_maps_url, null: false
      String :permalink, null: false
      DateTime :created_at

      index :created_at
    end

  end

  down do
    drop_table(:places)
  end
end

