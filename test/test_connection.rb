require 'test_constants'
require 'minitest/autorun'

require 'rubygems'
require 'icws/connection'

class ConnectionTest < MiniTest::Unit::TestCase
  def test_connection
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    assert connection.cookie != nil
    assert connection.token != nil

  end

  def test_initialize
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    assert connection.application_name != nil
    assert connection.server != nil

  end

  def test_version
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    assert connection.version != nil
  end

  def test_features
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    features = connection.features
    assert features != nil
    assert features.length > 0
  end
end
