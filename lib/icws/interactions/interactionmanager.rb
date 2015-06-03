require 'icws/interactions/interaction'

class ICWS
    class Interactions
        class InteractionManager
            def initialize(connection)
                @client = ICWS::Client.new connection
            end

            def make_call (connection, number)

                makeCallParams = {
                    "__type" => "urn:inin.com:interactions:createCallParameters",
                    :target => number
                }

                result = @client.post "/interactions", makeCallParams

                return Interaction.new result, connection
            end
        end
    end
end
