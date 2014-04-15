module Cellar
  class Site < Sequel::Model
    set_primary_key :domain
  end
end

