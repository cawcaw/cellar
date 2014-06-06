Sequel.migration do
  change do
    create_table(:pages) do
      primary_key :id
      foreign_key :site_id, :sites
      foreign_key :parent_id, :pages
      String      :slug
      String      :title
      Text        :description
      Text        :keywords
      DateTime    :created_at
      DateTime    :updated_at
      String      :template, default: 'page'
      column      :content, 'text[]'
    end
  end
end
