require 'icws/icwsclient'

class ICWS
    class Messages
        #The message queue manages callbacks for different objects that are receiving messages from CIC.
        class MessageQueue
            class EventHandlerArray < Array
                def add_handler(&block)
                    push(block)
                end
                def add
                    raise "error"
                end
                def remove_handler(code)
                    delete(code)
                end
                def fire(e)
                    reverse_each { |handler|
                        begin
                            handler.call(e)
                        rescue => e
                            puts e.inspect
                        end
                    }
                end
            end

            def initialize(connection)
                @message_handlers = {}
                @client = ICWS::Client.new connection

                @pollingThread = Thread.new() {
                    poll_loop
                }
            end

            #register for a new message type.
            # @param messageType [String] The type of messages to receive notifications for.
            # @param block [&block] Block to call when a message of that type is received.
            def register(messageType, &block)
                if(@message_handlers[messageType] == nil)
                    @message_handlers[messageType] = EventHandlerArray.new
                end
                callback = block
                @message_handlers[messageType].add_handler {|e| callback.call(e)}
            end

            def deregister(messageType, code)
                if(@message_handlers[messageType] == nil)
                    return
                end

                @message_handlers[messageType].remove_handler(code)
            end

            private
            def poll_loop
                while true
                    messages = @client.get '/messaging/messages'
                    for message in messages
                        #puts message
                        type = message['__type']
                        if @message_handlers[type]
                            @message_handlers[type].fire(message)
                        end
                    end
                    sleep 1
                end
            end
        end
    end
end
