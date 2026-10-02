## Version 2.0.0

- Support Ruby 4
- Drop RSpec 2 support, including the `failure_message_for_should` and `failure_message_for_should_not` matcher aliases
- Parse with the standard library's JSON instead of multi_json; invalid JSON now raises `JSON::ParserError` rather than `MultiJson::DecodeError` [#110](https://github.com/collectiveidea/json_spec/pull/110)
- Stop mutating string literals when building failure messages
- `normalize_json` and `generate_normalized_json` now sort object keys, matching what `be_json_eql` compares
- `include_json` now compares normalized JSON like `be_json_eql`: an integer no longer matches an equal float (`10` vs `10.0`), and a non-string expected value against a JSON string fails instead of raising `TypeError`
- Remove `JsonSpec::Exclusion.exclude_keys` and `exclude_key?`; `JsonSpec::Exclusion` no longer extends itself

## Version 1.1.5

- Added Changelog
- Fix RSpec warnings for uninitialized instance variables on matchers [#78](https://github.com/collectiveidea/json_spec/pull/78)

## Version 1.1.4

- Raise error when checking a size of a json ruby value of nil [#82](https://github.com/collectiveidea/json_spec/pull/82)
