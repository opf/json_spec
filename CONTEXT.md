# json_spec

RSpec matchers and Cucumber steps for asserting on JSON text in tests.

## Language

**Normalized JSON**:
JSON text with object keys sorted and pretty-generated, optionally with excluded keys dropped. Two JSON texts are equivalent when their normalized JSON is identical.
_Avoid_: Canonical form, scrubbed JSON

**Excluded keys**:
Object keys dropped during normalization, at any depth. Configured globally and adjusted per matcher.
_Avoid_: Ignored keys, filtered keys
