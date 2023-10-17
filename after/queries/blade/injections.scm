((php_only) @injection.content
    (#set! injection.combined)
    (#set! injection.language php))

((php) @injection.content
       (#set! injection.combined)
       (#set! injection.language html))
