class JsonWebToken
  @@JWT_SECRET = Rails.application.secrets.secret_key_base
  
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode payload, @@JWT_SECRET
  end

  def self.decode(token)
    begin
      JWT.decode token, @@JWT_SECRET
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError, JWT::VerificationError => e
      false
    end
  end
end