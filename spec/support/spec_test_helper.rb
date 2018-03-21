module SpecTestHelper

  def create_user_and_login
    user = create(:user)
    login(user)
  end

  def create_admin_user_and_login
    user = create(:user, is_admin: true)
    login(user)
  end

  def login(user)
    request.session[:user_id] = user.id
  end

  def current_user()
    User.find(request.session[:user_id])
  end

end