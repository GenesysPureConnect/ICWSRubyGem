require 'test_constants'
require 'test/unit'

require 'rubygems'
require 'icws/connection'

class ConnectionTest < Test::Unit::TestCase
  def test_connection
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    assert_not_nil connection.cookie                                       
    assert_not_nil connection.token
      
  end
  
  def test_initialize
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    assert_not_nil connection.application_name                                       
    assert_not_nil connection.server
      
  end

  def test_version
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    assert_not_nil connection.version
  end
  
  def test_features
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    features = connection.features
    assert_not_nil features
    assert features.length > 0
  end
end
