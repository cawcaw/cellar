Sequel.migration do
  change do
    create_table(:node_types) do
      primary_key :id
      foreign_key :site_id, :sites
      String      :name
      DateTime    :created_at
      DateTime    :updated_at
      column      :auto_load, :integer
      column      :fields, "json"
    end
  end
end

