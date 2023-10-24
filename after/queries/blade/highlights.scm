(directive) @directive
(directive_start) @directive
(directive_end) @directive
(comment) @comment
((parameter) @include (#set! "priority" 110)) 
((php_only) @include (#set! "priority" 110)) 
((bracket_start) @directive (#set! "priority" 120)) 
((bracket_end) @directive (#set! "priority" 120)) 
(keyword) @directive
