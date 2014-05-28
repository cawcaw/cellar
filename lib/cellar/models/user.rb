module Cellar
  class User < Sequel::Model

    def password= (password)
      password_digest = bcrypt(password)
    end

    def admin?
      role == 'admin'
    end

    class << self
      def authenticate(login, password)
        user = self.first(login: login)
        user if user && user.password_digest == bcrypt(password)
      end

      def bcrypt(password)
        BCrypt::Engine.hash_secret(password, Cellar.config['secret_salt'])
      end
    end
  end
end

