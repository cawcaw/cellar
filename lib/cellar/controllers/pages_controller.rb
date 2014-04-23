module Cellar
  class Base
    get '/' do
      content = []
      if page = @site.pages_dataset.where(slug: 'index').first
        template = page.template || 'index'
        content = page.content.to_ary || []
      else
        template = 'index'
      end
      render_page template, content: content
    end

    get '/:page' do
      content = []
      if page = @site.pages_dataset.where(slug: params[:page]).first
        template = page.template
        content = page.content.to_ary
      elsif template_exist?(params[:page])
        template = params[:page]
      else
        status 404
        template = 'page_not_found'
      end
      if template_exist? template
        render_page template, content: content
      else
        status 500
        'template lost'
      end
    end
  end
end

