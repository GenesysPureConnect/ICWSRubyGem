require 'icws/messages/messagesubscriber'
require 'icws/messages/messagequeue'

class ICWS
    class Queues


        class Queue < ICWS::Messages::MessageSubscriber
            @addedHandler = nil
            @changedHandler = nil
            @removedHandler = nil

        #    @interactionMap = {}

            def initialize(connection, messageQueue )
                super(connection,messageQueue, "urn:inin.com:queues:queueContentsMessage")
            end

            def start_watching_workgroup_queue(queueName, attributes)
                watchData = {
                    :queueIds=> [
                        {
                            :queueType=>2,
                            :queueName=> queueName
                        }
                    ],
                    :attributeNames => attributes
                }

                @client.put "/messaging/subscriptions/queues/" + queueName, watchData
            end

            def event_received(message)
                if @addedHandler != nil
                    if(message["interactionsAdded"] != nil && message["interactionsAdded"].length >0 )
                        puts 'interactions added '
                        interactions = []
                        for interaction in message["interactionsAdded"]
                            addedInteraction =  ICWS::Interactions::Interaction.new interaction, @connection
                            interactions.push addedInteraction

                        #    @interactionMap[addedInteraction.id] = addedInteraction;
                        end

                        @addedHandler.call interactions
                    end

                end

                if @changedHandler != nil
                    if(message["interactionsChanged"] != nil && message["interactionsChanged"].length >0 )
                        interactions = []
                        for interaction in message["interactionsChanged"]
                            interactions.push ICWS::Interactions::Interaction.new interaction["interactionId"], @connection
                        end

                        @changedHandler.call interactions
                    end

                end

                if @removedHandler != nil
                    if(message["interactionsRemoved"] != nil && message["interactionsRemoved"].length >0 )
                        for interaction in message["interactionsRemoved"]
                            @interactionMap.delete interaction;
                        end

                        @removedHandler.call message["interactionsRemoved"]

                    end

                end
            end

            def on_interactions_added(&block)
                @addedHandler = block
            end

            def on_interactions_changed(&block)
                @changedHandler = block
            end

            def on_interactions_removed(&block)
                @removedHandler = block
            end
        end
    end
end
