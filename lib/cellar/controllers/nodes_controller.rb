module Cellar
  class Base
    get '/' do
      content = []
      if node = load_node('', 'index', 'page')
        template = node.template || 'index'
        content = node.data[:content] || []
      else
        template = 'index'
      end
      render_page template, content: content
    end

    get '/:node' do
      if node = load_node('', params[:node], 'page')
        template = node.template || node.type
        if node.data
          node = node.data.merge(node.to_hash)
        else
          node = node.to_hash
        end
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

    private

    def load_node(path, slug, type)
      parent = nil
      while !path.nil? && path != ""
        path = path.split('/').reject(&:blank?)
        pslg = path[0]
        path = path[1..-1].join("/")
        parent = @site.nodes_dataset.where(slug: pslg, parent_id: parent).first.id
      end
      if type
        @site.nodes_dataset.where(slug: slug, parent_id: parent, type: type).first
      else
        @site.nodes_dataset.where(slug: slug, parent_id: parent).first
      end
    end
  end
end

