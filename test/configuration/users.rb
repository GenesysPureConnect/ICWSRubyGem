require 'test_constants'
require 'test/unit'

require 'rubygems'
require 'icws/connection'
require 'icws/configuration/users'
require 'securerandom'

class UserTest < Test::Unit::TestCase

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

  def test_get_all
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    userconfig = ICWS::Configuration::Users.new connection
    assert_not_nil userconfig
    
    allusers = userconfig.get_all
    
    assert_not_nil allusers
    assert allusers.length > 0
    assert_not_nil allusers[0]["configurationId"]
  end
  
  def test_get_all_custom_attributes
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    userconfig = ICWS::Configuration::Users.new connection
    assert_not_nil userconfig
    
    allusers = userconfig.get_all "configurationId,extension"
    
    assert_not_nil allusers
    assert allusers.length > 0
    assert_not_nil allusers[0]["configurationId"]
    assert allusers[0].has_key? "extension"
    assert allusers[0].has_key?("foo") == false
  end
  
  def test_defaults
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    userconfig = ICWS::Configuration::Users.new connection
    assert_not_nil userconfig
    assert_not_nil userconfig.defaults
  end

end
