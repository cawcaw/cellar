Sequel.migration do
  change do
    create_table(:nodes) do
      primary_key :id
      foreign_key :site_id, :sites
      foreign_key :parent_id, :nodes
      String      :type, default: 'page'
      String      :slug
      DateTime    :created_at
      DateTime    :updated_at
      String      :template, default: 'page'
      String      :childs
      column      :data, "json"
    end
  end
end

