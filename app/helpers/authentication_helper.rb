class AuthenticationHelper
  def self.logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    @teacher = Teacher.find(session[:user_id])
  end
end