require 'securerandom'

class RegisterUser
    prepend SimpleCommand
  
    def initialize(email, password)
      @email = email
      @password = password
    end
  
    def call
      user
    end
  
    private
  
    attr_accessor :email, :password
  
    def user
      user = User.find_by_email(email)
      return errors.add :user_registration, 'user already exists' if user
  
      User.create(user_id: SecureRandom.uuid, email: email, password: password)
    end
end