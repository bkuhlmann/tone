# frozen_string_literal: true

RSpec::Matchers.define :have_color do |color, *expected|
  match do |actual|
    fail ArgumentError, "First argument must be a color instance." unless color.respond_to? :decode

    @decode = color.decode actual
    @decode == expected
  end

  failure_message do |actual|
    <<~MESSAGE
      expected #{actual.inspect} to have color decoded as:
      #{expected.map(&:inspect).join(",\n")}

      but actually is:
      #{@decode.map(&:inspect).join(",\n")}
    MESSAGE
  end
end
