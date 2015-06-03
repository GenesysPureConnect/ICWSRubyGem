

class ICWS
    class Interactions
        class Interaction
            attr_reader :id

            @attributes = {}

            def initialize(interactionDetails, connection)
                if( connection != nil)
                    @client = ICWS::Client.new connection
                end

                @id = interactionDetails["interactionId"]
                @attributes = interactionDetails["attributes"]
            end

            def update_attributes(newAttributes)
                @attributes.merge! newAttributes
            end

            def get_attributes(attributeArray)
                attrs = attributeArray.join (",")
                attributes = @client.get "/interactions/#@id?select=" + attrs
                return attributes["attributes"]
            end

            def get_attribute(attributeName)

                if @attributes.key? attributeName
                    return @attributes[attributeName]
                end

                uri = "/interactions/#@id?select=" + attributeName

                attributeResult = @client.get uri

                return attributeResult["attributes"][attributeName]
            end

            def set_attributes(attributes)
                body = {"attributes" => attributes}
                @client.post "/interactions/#@id", body

            end

            def set_attribute(name, value)
                attrs = {}
                attrs[name] = value
                return set_attributes attrs
            end

            def is_connected?
                state = get_attribute("Eic_State")
                return state == 'C'
            end

            def is_disconnected?
                state = get_attribute("Eic_State")
                return state == 'E' || state == "I"
            end

            def disconnect
                @client.post "/interactions/#@id/disconnect", nil
            end

        end
    end
end
