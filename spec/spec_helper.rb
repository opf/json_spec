if ENV["CODECLIMATE_REPO_TOKEN"]
  require "simplecov"
  SimpleCov.start
end

require "json_spec"

RSpec.configure do |config|
  config.before do
    JsonSpec.reset
  end

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

RSpec.shared_examples "a composable matcher" do
  let(:json) { '{"foo":1,"bar":[2,3]}' }

  def fail_matching(message = nil)
    raise_error(RSpec::Expectations::ExpectationNotMetError, message)
  end

  it "works inside include" do
    expect([json]).to include(matching)
    expect([json]).not_to include(not_matching)
  end

  it "works inside match" do
    expect([json]).to match([matching])
    expect([json]).not_to match([not_matching])
  end

  it "combines using and" do
    expect(json).to matching.and(matching)
    expect { expect(json).to matching.and(not_matching) }.to fail_matching
    expect { expect(json).to not_matching.and(matching) }.to fail_matching
  end

  it "combines using or" do
    expect(json).to not_matching.or(matching)
    expect(json).to matching.or(not_matching)
    expect { expect(json).to not_matching.or(not_matching) }.to fail_matching
  end

  it "uses its description in composed failure message" do
    expect { expect([json]).not_to include(matching) }.to fail_matching(include(matching.description))
    expect { expect([json]).to include(not_matching) }.to fail_matching(include(not_matching.description))
  end
end

def files_path
  File.expand_path("../support/files", __FILE__)
end
