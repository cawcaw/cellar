module Cellar
  class Base
    before do
      @site = Site[domain: request.host]
    end
  end
end

Dir.glob(Cellar.path('controllers/*.rb'), &method(:require))

