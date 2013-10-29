require 'icws/configuration/configurationitem'

class ICWS
  class Configuration
    class Users < ICWS::Configuration::ConfigurationItem
      def initialize(connection)
        super(connection,'users')
      end
      
      def set_password(user_id, password, force=false)
        
         @client.put @uri + '/' + id + '/password', 
                                        { :password => password,
                                          :force => force}
      end
    end
  end
end