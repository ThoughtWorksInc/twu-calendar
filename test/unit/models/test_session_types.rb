require 'test_helper'

class TestSessionTypes < Test::Unit::TestCase

  def test_find_by_session_types
    session_types = SessionTypes.find_by_session_types(["TWU", "Session"])
    assert_equal "TWU", session_types[0].name
    assert_equal "Session", session_types[1].name
    assert_equal 2, session_types.size
  end

  def test_by_type
    session_type = SessionTypes.by_type("TWU")
    assert_equal "TWU", session_type.name
  end

  def test_validate
    invalid_sessions = SessionTypes.validate(["TWU", "invalid"])
    assert_equal "invalid", invalid_sessions.first
  end

end

 
