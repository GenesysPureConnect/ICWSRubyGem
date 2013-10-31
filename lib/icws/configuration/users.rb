require 'icws/configuration/configurationitem'

class ICWS
  class Configuration
    class Users < ICWS::Configuration::ConfigurationItem
      def initialize(connection)
        super(connection,'users')
      end
      
      def set_password(user_id, password, force)
         icws_uri = @uri + '/' + user_id + '/password'
         puts 'setting password to ' + password
         puts 'to: ' + icws_uri
         @client.put icws_uri, 
                    { :password => password,
                      :force => force}
      end
    end
  end
end