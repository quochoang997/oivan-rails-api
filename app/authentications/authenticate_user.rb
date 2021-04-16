class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    current_user = user
    if current_user
      time = Time.now + 24.hours.to_i
      { token: JwtService.encode(user_id: current_user.id), exp: time.strftime("%m-%d-%Y %H:%M"), email: current_user.email}
    end
  end

  private

  def user
    user = User.find_by!(email: @email)
    return user if user&.authenticate(@password)
    errors.add(:user_authentication, "Invalid Credentials")
  end
end
