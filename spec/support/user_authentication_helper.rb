module UserAuthenticationHelper
    def confirm_and_login_user(user)
        jwt = JsonWebToken.encode({ user_id: user.user_id })
        request.headers.merge!('Authorization': "Bearer #{jwt}")
    end
  end