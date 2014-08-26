require 'test_constants'
require 'minitest/autorun'

require 'rubygems'
require 'icws/connection'
require 'icws/configuration/roles'
require 'icws/configuration/workgroups'
require 'securerandom'

class RoleTest <  MiniTest::Unit::TestCase
=begin

  def test_create_new_get_update_and_delete
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    roleconfig = ICWS::Configuration::Roles.new connection

    workgroupconfig = ICWS::Configuration::Workgroups.new connection
    workgroupid = SecureRandom.uuid;
    newworkgroup = {}

    workgroupconfig.create_new workgroupid, newworkgroup

    id = SecureRandom.uuid;

    newrole = {}
    newrole["workgroups"] = []

    roleworkgroup = {}
    roleworkgroup['id'] = workgroupid
    roleworkgroup['displayName'] = workgroupid

    newrole['workgroups'].push roleworkgroup

    roleconfig.create_new id, newrole

    role = roleconfig.get id, "configurationId,workgroups"
    assert_not_nil role

    assert role["workgroups"].length > 0

    assert role["workgroups"][0]['id'] == workgroupid

    roleconfig.delete id
    workgroupconfig.delete workgroupid

    assert_raise RestClient::ResourceNotFound do
      role = roleconfig.get id
    end

  end
=end
  def test_get_all
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
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    roleconfig = ICWS::Configuration::Roles.new connection
    assert roleconfig != nil
    assert roleconfig.defaults != nil
  end

end
