class SessionHandler

  def initialize(user)
    self.user = user
  end

  def authenticate(password, cookies)
    raise ActiveRecord::RecordNotFound unless user && user.authenticate(password)
    cookies.signed[:user_id] = user.id
    cookies.signed[:auth_token] = session_token
    return user
  end

  def session_destroy(session, cookies)
    session.destroy!
    cookies.delete(:user_id)
    cookies.delete(:auth_token)
  end

  private

  attr_accessor :user

  def session_token
    loop do
      token = SecureRandom.hex(12)
      return token unless Session.find_by(auth_token: token, deleted_at: nil)
    end
  end
end
