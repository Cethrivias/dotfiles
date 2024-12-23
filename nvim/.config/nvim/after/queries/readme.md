# How to add spellcheck to variable names

Create a file `./{language}/highlights.scm`

```
; inherits: {language} // inherit from the default query file

(identifier) @spell // Enable spell for identifiers
```

This functionality is custom and configured in [treesitter.lua](../../lua/plugins/treesitter.lua)

## Example:

`./lua/highlights.scm`

```
; inherits: lua

(identifier) @spell

```
