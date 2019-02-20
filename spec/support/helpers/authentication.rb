module Helpers
  module Authentication
    def login_as(user)
       visit logout_path
       visit login_path
       fill_in :email, with: user.email
       fill_in :password, with: user.password
       click_button 'Sign In'
    end
  end
end
