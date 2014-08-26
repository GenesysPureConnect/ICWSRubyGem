require 'test_constants'
require 'minitest/autorun'

require 'rubygems'
require 'icws/connection'
require 'icws/configuration/roles'
require 'icws/configuration/workgroups'
require 'securerandom'

class RoleTest <  MiniTest::Unit::TestCase

    def test_get_all
        puts "envar"
        puts ENV['CI']

        skip ("Not running on integration server") if ENV['CI'] != nil

        connection = ICWS::Connection.new APPLICATIONNAME, SERVER
        connection.connect USERID, PASSWORD
        roleconfig = ICWS::Configuration::Roles.new connection
        assert roleconfig != nil

        allroles = roleconfig.get_all

        assert allroles != nil
        assert allroles.length > 0
        assert allroles[0]["configurationId"] != nil
    end

    def test_get_all_custom_attributes
        skip ("Not running on integration server") if ENV['CI'] == true

        connection = ICWS::Connection.new APPLICATIONNAME, SERVER
        connection.connect USERID, PASSWORD
        roleconfig = ICWS::Configuration::Roles.new connection
        assert roleconfig != nil

        allroles = roleconfig.get_all "configurationId,workgroups"

        assert allroles!= nil
        assert allroles.length > 0
        assert allroles[0]["configurationId"] != nil
        assert allroles[0].has_key? "workgroups" #workgroups must actually be configured for this role
        assert allroles[0].has_key?("foo") == false
    end

    def test_defaults
        skip ("Not running on integration server") if ENV['CI'] == true

        connection = ICWS::Connection.new APPLICATIONNAME, SERVER
        connection.connect USERID, PASSWORD
        roleconfig = ICWS::Configuration::Roles.new connection
        assert roleconfig != nil
        assert roleconfig.defaults != nil
    end

end
