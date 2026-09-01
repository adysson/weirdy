require 'test_helper'

module Weirdy
  class WexceptionOccurrenceTest < ActiveSupport::TestCase
    test "dummy app runs with the Rails 7.1 nil default column serializer" do
      assert_nil ActiveRecord::Base.default_column_serializer
    end

    test "backtrace and data round-trip through explicit YAML coders" do
      occurrence = Weirdy::WexceptionOccurrence.new(
        message: "boom",
        backtrace: ["app/models/file.rb:3:in `index'"],
        data: { "group_id" => 42, "nested" => { "a" => [1, 2] } },
      )
      occurrence.save!

      reloaded = Weirdy::WexceptionOccurrence.find(occurrence.id)
      assert_equal ["app/models/file.rb:3:in `index'"], reloaded.backtrace
      assert_equal({ "group_id" => 42, "nested" => { "a" => [1, 2] } }, reloaded.data)
    end

    test "wcreate captures ActionController::Parameters into the YAML data column" do
      raise ArgumentError, "boom" rescue exception = $!
      wexception = Weirdy::Wexception.wcreate(exception, "Params" => ActionController::Parameters.new(a: "b"))

      occurrence = wexception.reload.occurrences.first
      assert_kind_of ActionController::Parameters, occurrence.data["Params"]
      assert_equal({ "a" => "b" }, occurrence.data["Params"].to_unsafe_h)
    end
  end
end
