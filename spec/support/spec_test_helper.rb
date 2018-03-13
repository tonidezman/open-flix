module SpecTestHelper

  def login(user)
    request.session[:user_id] = user.id
  end

  def logged_user()
    User.find(request.session[:user_id])
  end

end