require 'rest_client'
require 'rubygems'
require 'json'

class ICWS
    # REST wrapper around the ICWS connection. This class handles setting the proper cookies and headers for
    # each request.

    class Client
        # Creates a new ICWS Client
        #
        # == Parameters:
        # connection::
        #   ICWS::Connection instance
        def initialize(connection)
            @connection = connection
            headers = {:Cookie => @connection.cookie,"ININ-ICWS-CSRF-Token" => @connection.token}
            @http_resource = RestClient::Resource.new(@connection.base_uri, :headers => headers)
        end

        # Makes a POST call to the server.
        #
        # == Parameters:
        # url::
        #   The Url to call the POST On
        #
        # headers::
        #   Optional additional headers to send
        #
        # == Returns:
        # The response from the server
        #
        def post(url, body, headers={})
            begin
                result = nil
                if body != nil
                    result =  @http_resource[url].post body.to_json, headers
                else
                    result = @http_resource[url].post "", headers
                end

                if(result != nil && result != '')
                    JSON.parse result
                else
                    return nil
                end
            rescue => e
                puts e.inspect
                throw e
            end
        end


        # Makes a GET call to the server.
        #
        # == Parameters:
        # url::
        #   The Url to call the GET On
        #
        # headers::
        #   Optional additional headers to send
        #
        # == Returns:
        # The response from the server
        #

        def get(url, headers={})
            JSON.parse @http_resource[url].get headers
        end

        # Makes a DELETE call to the server.
        #
        # == Parameters:
        # url::
        #   The Url to call the DELETE On
        #
        # headers::
        #   Optional additional headers to send
        #
        def delete(url, headers={})
            @http_resource[url].delete headers
        end

        # Makes a PUT call to the server.
        #
        # == Parameters:
        # url::
        #   The Url to call the PUT On
        #
        # headers::
        #   Optional additional headers to send
        #
        # == Returns:
        # The response from the server
        #
        def put(url, body, headers={})
            begin
                @http_resource[url].put body.to_json, headers
            rescue => e
                puts e.inspect
                throw e
            end

        end
    end
end
