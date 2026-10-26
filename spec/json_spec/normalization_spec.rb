require "spec_helper"

describe JsonSpec::Normalization do
  def normalize(ruby, **options)
    described_class.normalize(ruby, **options)
  end

  it "sorts object keys" do
    normalized = <<-JSON
{
  "a": 2,
  "b": 1
}
    JSON
    normalize({"b" => 1, "a" => 2}).should eq normalized.chomp
  end

  it "sorts object keys at any depth" do
    normalize([{"b" => {"d" => 1, "c" => 2}, "a" => 3}]).should eq normalize([{"a" => 3, "b" => {"c" => 2, "d" => 1}}])
  end

  it "keeps array order" do
    normalize([2, 1]).should_not eq normalize([1, 2])
  end

  it "excludes no keys by default" do
    normalize({"id" => 1}).should_not eq normalize({})
  end

  it "drops excluded keys at any depth" do
    ruby = {"id" => 1, "json" => [{"id" => 2, "spec" => true}]}
    normalize(ruby, excluded_keys: %w(id)).should eq normalize({"json" => [{"spec" => true}]})
  end

  it "normalizes values" do
    normalize("json_spec").should eq %("json_spec")
    normalize(10.0).should eq %(10.0)
    normalize(nil).should eq %(null)
  end

  it "normalizes non-finite floats" do
    normalize(Float::INFINITY).should_not eq normalize(-Float::INFINITY)
    normalize([Float::INFINITY]).should_not eq normalize([1])
  end
end
