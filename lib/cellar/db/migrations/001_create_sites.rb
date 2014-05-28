Sequel.migration do
  change do
    create_table(:sites) do
      primary_key :id
      String      :name,   unique: true, null: false
      String      :domain, unique: true
      Text        :robots
      Text        :description
      Text        :reywords
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end

