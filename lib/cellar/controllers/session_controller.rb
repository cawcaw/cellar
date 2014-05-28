module Cellar
  class Base

    post '/login' do
      env['warden'].authenticate!
      if session[:return_to].nil? || session[:return_to] == "/login"
        redirect '/'
      else
        redirect session[:return_to]
      end
    end

    get '/logout' do
      env['warden'].logout
      redirect '/'
    end

    post '/unauthenticated' do
      session[:return_to] = env['warden.options'][:attempted_path]
      redirect to '/login'
    end
  end
end
