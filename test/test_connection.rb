require 'test_constants'
require 'test/unit'

 require 'rubygems'
  #gem 'icws', '~> 0.0.1'
require 'icws'

class RakeTest < Test::Unit::TestCase
  def test_connection
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    
  end

  def test_version
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    assert_not_nil connection.version
  end

  def test_spanish_hello
    assert_equal "hola mundo",
      Hola.hi("spanish")
  end
end
