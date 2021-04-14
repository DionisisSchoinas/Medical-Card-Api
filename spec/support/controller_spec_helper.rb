module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # generate QR token
  def qr_token_generator(patient_id)
    JsonWebToken.encode(patient_id: patient_id)
  end

  # generate expired QR token
  def expired_qr_token_generator(patient_id)
    JsonWebToken.encode({ patient_id: patient_id }, (Time.now - 20.minutes))
  end

  # return valid headers
  def valid_headers
    {
      "Authorization_Token" => token_generator(user.id),
      "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "Authorization_Token" => nil,
      "Content-Type" => "application/json"
    }
  end
end
