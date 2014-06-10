module Cellar
  class Node < Sequel::Model
    one_to_many :nodes, key: :parent_id

    def page?
      type == 'page'
    end
  end
end

