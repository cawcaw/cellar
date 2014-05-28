Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      foreign_key :site_id, :sites
      String      :login
      String      :password_digest
      String      :email
      String      :token
      String      :role
      DateTime    :created_at
      DateTime    :updated_at
      DateTime    :last_login_at
    end
  end
end
