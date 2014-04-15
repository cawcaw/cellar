Sequel.migration do
  change do
    create_table(:pages) do
      primary_key :id
      foreign_key :site_id, :sites
      String      :slug
      String      :template
      column      :content, 'text[]'
    end
  end
end
