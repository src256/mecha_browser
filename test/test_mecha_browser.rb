# frozen_string_literal: true

require "test_helper"

class TestMechaBrowser < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MechaBrowser::VERSION
  end

  def test_command_class_exists
    assert MechaBrowser::Command
  end

  def test_browser_base_class_exists
    assert MechaBrowser::Browser::BaseBrowser
  end

  def test_ruby_browser_exists
    assert MechaBrowser::Browser::RubyBrowser
  end
end
