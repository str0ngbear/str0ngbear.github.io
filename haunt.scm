(use-modules (haunt asset)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
             (haunt reader commonmark)
             (haunt site))

(site #:title "Built with Guile"
      #:domain "str0ngbear.org"
      #:default-metadata
      '((author . "Matt")
        (email  . "matt@strongbear.org"))
      #:readers (list commonmark-reader)
      #:build-directory "docs"
      #:builders (list (blog)
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (static-directory "images")))
