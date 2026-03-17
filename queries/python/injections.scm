; extends

; language=sql comment followed by a string assignment
((comment) @_comment
  .
  (assignment
    right: (string
      (string_content) @injection.content))
  (#lua-match? @_comment "language=sql")
  (#set! injection.language "sql"))

; language=sql comment followed by a concatenated string assignment
((comment) @_comment
  .
  (assignment
    right: (concatenated_string
      (string
        (string_content) @injection.content)))
  (#lua-match? @_comment "language=sql")
  (#set! injection.language "sql"))
