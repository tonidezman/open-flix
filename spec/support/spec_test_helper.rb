module SpecTestHelper

  def create_user_and_login
    user = create(:user)
    login(user)
  end

  def login(user)
    request.session[:user_id] = user.id
  end

  def logged_user()
    User.find(request.session[:user_id])
  end

end