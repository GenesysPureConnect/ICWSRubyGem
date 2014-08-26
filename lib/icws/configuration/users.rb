require 'icws/configuration/configurationitem'

class ICWS
    class Configuration
        # Represents the users configuration in CIC.  This class can perform operations to create/edit/delete users.
        class Users < ICWS::Configuration::ConfigurationItem
            def initialize(connection)
                super(connection,'users')
            end

            #sets the password on a user
            # @param user_id [String] Id user to change.
            # @param password [String] new password to change to.
            # @param force [bool] Forces the password change, false will fail if password does not meet password policies..
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
