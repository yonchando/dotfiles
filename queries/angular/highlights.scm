; extends

; Highlight control flow blocks (@if, @for, @switch, @defer, ...) as keywords
((control_keyword) @keyword
  (#set! priority 105))

("@" @keyword
  (#set! priority 105))
