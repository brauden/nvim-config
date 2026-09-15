; extends

; A decorator with no definition after it yet (the state right after typing
; `@staticmethod` and pressing `o`) parses as an ERROR node, and upstream's
; `(ERROR "try" . ":")` pattern wrongly captures that ERROR as @indent.begin.
; Cancel that extra level so the next line lines up with the decorator.
((ERROR
  (decorator)) @indent.dedent)
