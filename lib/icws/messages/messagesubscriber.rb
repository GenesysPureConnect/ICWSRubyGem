class ICWS
    #Base class to listen for events from the server.
    class MessageSubscriber
        def initialize(connection, message_queue, messageId)
            message_queue.register(messageId) {|e| event_received(e)}
            @application_name = connection.application_name
            @client = ICWS::Client.new connection

        end

        def event_received(message)

        end
    end
end
