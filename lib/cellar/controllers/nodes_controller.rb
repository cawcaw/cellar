module Cellar
  class Base
    get '/' do
      content = []
      if node = @site.nodes_dataset.where(slug: 'index', type: 'page').first
        template = node.template || 'index'
        content = node.data[:content] || []
      else
        template = 'index'
      end
      render_page template, content: content
    end

    get '/:node' do
      if node = @site.nodes_dataset.where(slug: params[:node], type: 'page').first
        template = node.template
        node = node.data.merge(node.to_hash)
        node.delete :data
      elsif template_exist?(params[:node])
        template = params[:node]
      else
        status 404
        template = 'page_not_found'
      end
      node ||= {content: [], slug: params[:page]}
      if template_exist? template
        render_page template, node
      else
        status 500
        'template lost'
      end
    end

    post '/pages' do
      if @user.admin?
        page = @site.pages_dataset.where(slug: params[:slug]).first
        if page
          page.content[params[:index].to_i] = params[:content]
          page.save
        end
      end
    end
  end
end

