module Palmade::Stepscreen
  class Utilities
    def self.prepare_headers
      username = Palmade::Stepscreen.username
      password = Palmade::Stepscreen.password

      if username.nil? || password.nil?
        raise "missing credentials"
      end
      headers = {}
      headers[:authorization] = "Basic #{Base64.encode64(username + ':' + password)}"
      {:headers => headers}
    end
  end
end
