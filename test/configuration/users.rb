require 'test_constants'
require 'minitest/autorun'

require 'rubygems'
require 'icws/connection'
require 'icws/configuration/users'
require 'securerandom'

class UserTest <  MiniTest::Unit::TestCase

=begin

  def test_create_new_get_update_and_delete
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    userconfig = ICWS::Configuration::Users.new connection

    id = SecureRandom.uuid;
    ext = Random.new.rand(20000..90000)

    newuser = {}
    newuser["extension"] = ext
    newuser['homeSite'] = 1

    userconfig.create_new id, newuser

    user = userconfig.get id, "configurationId,extension"
    assert_not_nil user

    assert user["extension"].to_i == ext

    ext = ext + 1
    user["extension"] = ext
    userconfig.update(id,user)

    user = userconfig.get id, "configurationId,extension"
    assert user["extension"].to_i == ext

    userconfig.delete id
    assert_raise RestClient::ResourceNotFound do
      user = userconfig.get id
    end

  end
=end
  def test_get_all
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    userconfig = ICWS::Configuration::Users.new connection
    assert userconfig != nil

    allusers = userconfig.get_all

    assert allusers != nil
    assert allusers.length > 0
    assert allusers[0]["configurationId"] != nil
  end

  def test_get_all_custom_attributes
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    userconfig = ICWS::Configuration::Users.new connection
    assert userconfig != nil

    allusers = userconfig.get_all "configurationId,extension"

    assert allusers != nil
    assert allusers.length > 0
    assert allusers[0]["configurationId"] != nil
    assert allusers[0].has_key? "extension"
    assert allusers[0].has_key?("foo") == false
  end

  def test_defaults
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    userconfig = ICWS::Configuration::Users.new connection
    assert userconfig != nil
    assert userconfig.defaults != nil
  end

end
