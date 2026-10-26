require "spec_helper"

describe JsonSpec::Matchers::HaveJsonPath do
  it "matches hash keys" do
    %({"one":{"two":{"three":4}}}).should have_json_path("one/two/three")
  end

  it "doesn't match values" do
    %({"one":{"two":{"three":4}}}).should_not have_json_path("one/two/three/4")
  end

  it "matches array indexes" do
    %([1,[1,2,[1,2,3,4]]]).should have_json_path("1/2/3")
  end

  it "respects null array values" do
    %([null,[null,null,[null,null,null,null]]]).should have_json_path("1/2/3")
  end

  it "matches hash keys and array indexes" do
    %({"one":[1,2,{"three":4}]}).should have_json_path("one/2/three")
  end

  it "provides a description message" do
    matcher = have_json_path("json")
    matcher.matches?(%({"id":1,"json":"spec"}))
    matcher.description.should == %(have JSON path "json")
  end

  it_behaves_like "a composable matcher" do
    let(:matching) { have_json_path("bar") }
    let(:not_matching) { have_json_path("baz") }
  end
end
