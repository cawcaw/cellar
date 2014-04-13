module Cellar
  class Base
    get '/' do
      html 'sdf'
      css 'sdf'
      
      page = Page['index']
      template = page.template || 'index'
      content = page.content || []
      render_page template, content.to_ary
    end

    get '/:page' do
      content = []
      if page = Page[params[:page]]
        template = page.templat
        content = page.content
      elsif template_exist?(params[:page])
        template = params[:page]
      else
        template = 'page_not_found'
      end
      render_page template, content.to_ary
    end
  end
end
