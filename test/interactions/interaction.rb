require 'test_constants'
require 'minitest/autorun'

require 'rubygems'
require 'icws/interactions/interaction'
require 'icws/interactions/interactionmanager'

class InteractionTest <  MiniTest::Unit::TestCase

    def test_place_call
        skip ("Not running on integration server") if ENV['CI'] != nil

        connection = ICWS::Connection.new APPLICATIONNAME, SERVER
        connection.connect USERID, PASSWORD

        interactionManager = ICWS::Interactions::InteractionManager.new connection

        interaction = interactionManager.make_call connection, '2222222'

        assert interaction.id != nil
        assert interaction.id != ''

        assert interaction != nil

        attrs = ['Eic_State', 'Eic_RemoteName']
        attrValues = interaction.get_attributes attrs

        assert attrValues != nil
        assert attrValues.length == 2


        attrName = "TestAttrName"
        attrValue = "TestAttrValue"

        interaction.set_attribute attrName, attrValue

        testAttr = interaction.get_attribute attrName
        assert testAttr != nil
        assert testAttr == attrValue

        interaction.disconnect
    end

    def test_attributes

        id = "12345234"
        state = "FOO"

        newCallDetails = {
            :interactionId=> id,
            :attributes =>
            {
                "state"=> state
            }
        }
        interaction = ICWS::Interactions::Interaction.new newCallDetails, nil

        assert interaction.id == id
        assert interaction.get_attribute('state') == state


        newState = 'BAR'
        updatedCallAttributes =
        {
            "state"=> newState
        }

        interaction.update_attributes updatedCallAttributes

        assert interaction.id == id
        assert interaction.get_attribute('state') == newState
    end

    def test_is_connected
        state = "C"

        newCallDetails = {
            :interactionId=> "1234",
            :attributes =>
            {
                'Eic_State'=> state
            }
        }

        interaction = ICWS::Interactions::Interaction.new newCallDetails, nil

        assert interaction.is_connected?
    end

    def test_is_disconnected
        state = "E"

        newCallDetails = {
            :interactionId=> "1234",
            :attributes =>
            {
                'Eic_State'=> state
            }
        }

        interaction = ICWS::Interactions::Interaction.new newCallDetails, nil

        assert interaction.is_disconnected?
    end

end
