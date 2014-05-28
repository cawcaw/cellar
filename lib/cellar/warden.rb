module Cellar
  class Base
    Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
    end

    Warden::Strategies.add(:password) do
      def valid?
        params['login'] && params['password']
      end

      def authenticate!
        user = User.authenticate(params['login'],
                                 params['password'])
        if user.nil?
          fail!('Could not log in')
        else
          success!(user, 'Successfully logged in')
        end
      end
    end

    use Warden::Manager do |config|
      config.serialize_into_session{|user| user.id }
      config.serialize_from_session{|id| User[id] }
      config.scope_defaults :default,
        strategies: [:password],
        action: '/unauthenticated'
      config.failure_app = self
    end
  end
end
