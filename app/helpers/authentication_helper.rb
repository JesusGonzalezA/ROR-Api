require 'singleton'

require 'json'

module AuthenticationHelper
    
    class Auth
        @@secret = ".ASDHmnmsad,hakKH"
        @instance = new
    
        private_class_method :new
    
        def self .instance
            @instance
        end

        def checkPassword( body )
            params   = JSON.parse( body.read )
            emailParams    = params["email"]
            passwordParams =  params["password"]

            @user = User.find_by(email: emailParams)

            if (@user!=nil)
                passwordUser = @user.password
                
                if ( passwordParams == passwordUser )
                  return true
                else 
                  return false
                end
            else
                return false
            end
        end

        # PRE : password is correct
        def generateJWT( email )
            return ({:token => (email + @@secret)}.to_json)
        end

        def getEmailFromJWT( request )
            pattern = /^Bearer /
            header  = request.headers['Authorization']
            token   = header.gsub(pattern, '') if header && header.match(pattern)

            email   = token.chomp(@@secret)
            return email
        end
        
    end

end
