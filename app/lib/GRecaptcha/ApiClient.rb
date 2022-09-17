module GRecaptcha
  class ApiClient
    VERIFY_URL = 'https://www.google.com/recaptcha/api/siteverify'.freeze

    def self.verify_response(response)
      conn = Faraday.new do |f|
        f.request :url_encoded
        f.response :json
      end
      res = conn.post(VERIFY_URL, { secret: Rails.application.credentials.recaptcha.secret_key, response: response })
      puts res.body.to_s
      res['hostname'] == ENV['APPLICATION_HOSTNAME'] && res['success']
    end
  end
end
