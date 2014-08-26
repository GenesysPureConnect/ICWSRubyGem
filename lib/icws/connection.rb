require 'rest_client'
require 'rubygems'
require 'json'
require 'icws/feature'

class ICWS
    #Representation of a connectio nto a CIC server.
    class Connection
        # Creates a new connection
        # @param application_name [String] the name of the application
        # @param server [String] the server to connect to
        def initialize(application_name, server)
            @application_name = application_name
            @server = server
        end

        # Connects to the server
        # @param user [String] the name of the user to connect with
        # @param password [String] the password for the user
        def connect(user, password)
            connectResponse = RestClient.post @server +'/icws/connection',
            { :applicationName => @application_name,
                :userID => user,
                :password => password}.to_json,
                :content_type => :json,
                :accept => :json,
                'Accept-Language' => 'en-us'

                response = JSON.parse(connectResponse);
                @cookie = connectResponse.headers[:set_cookie][0]
                @csrf_token = response['csrfToken']
                @session_id = response['sessionId']

            end

            # Gets the name of the application.
            # @return [String] Application name.
            def application_name
                @application_name
            end

            # Gets the connection token.
            # @return [String] connection token
            def token
                @csrf_token
            end

            # Gets the connection cookie.
            # @return [String] connection cookie
            def cookie
                @cookie
            end

            # Gets the url of the server
            # @return [String] the url of the server
            def server
                @server
            end

            # Gets the version of the server.
            # @return the version of the server.
            def version
                JSON.parse RestClient.get @server+'/icws/connection/version'
            end

            # Gets the features of the server.
            # @return [Array[ICWS::Connection::Features]] the features of the server
            def features
                data = JSON.parse RestClient.get @server+'/icws/connection/features'
                features = data["featureInfoList"].map { |rd| ICWS::Connection::Feature.new(rd["featureId"], rd["version"]) }
            end

            # Generates a full uri given the resource path.
            # @param path [String] The path to the ReST resource.
            # @return [String] The full url.
            def generate_uri(path)
                base_uri + path
            end

            # Returns the base uri to the server, including the session id
            # @return [String] The base url with session id.
            def base_uri
                @server+'/icws/' + @session_id +'/'
            end
        end
    end
