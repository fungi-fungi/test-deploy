def authorize(user)
  @token = Knock::AuthToken.new(payload: { sub: user[:id], email: user[:email], user_metadata: user[:user_metadata] }).token
  @request.env['HTTP_AUTHORIZATION'] = "Bearer #{@token}"
end

def generate_valid_user
  @user = {}
  @user[:id] = Faker::Number.number(5)
  @user[:email] = Faker::Internet.email
  @user[:name] = Faker::Name.name
  @user[:user_metadata] = {sf_id: Faker::Number.number(5)}
  @user
end