module Cellar
  class Base
    get '/' do
      content = []
      if page = @site.pages_dataset.where(slug: 'index').first
        template = page.template || 'index'
        content = page.content || []
      else
        template = 'index'
      end
      render_page template, content.to_ary
    end

    get '/:page' do
      content = []
      if page = @site.pages_dataset.where(slug: params[:page]).first
        template = page.template
        content = page.content
      elsif template_exist?(params[:page])
        template = params[:page]
      else
        status 404
        template = 'page_not_found'
      end
      if template_exist? template
        render_page template, content.to_ary
      else
        status 500
        'template lost'
      end
    end
  end
end

