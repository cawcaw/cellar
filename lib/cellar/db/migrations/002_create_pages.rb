Sequel.migration do
  change do
    create_table(:pages) do
      primary_key :id
      foreign_key :site_id, :sites
      String      :slug
      String      :title
      Text        :description
      Text        :reywords
      DateTime    :created_at
      DateTime    :updated_at
      String      :template
      column      :content, 'text[]'
    end
  end
end
