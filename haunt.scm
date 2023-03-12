(use-modules (haunt asset)
             (haunt post)
             (haunt page)
             (haunt html)
             (haunt utils)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
             (haunt reader)
             (haunt reader commonmark)
             (haunt reader skribe)
             (haunt site)
             (web uri))

(define (stylesheet name)
  `(link (@ (rel "stylesheet")
            (href ,(string-append "/css/" name ".css")))))


(define (anchor content uri)
  `(a (@ (href ,uri)) ,content))

(define str0ngbear-theme
  (theme #:name "str0ngbear"
         #:layout
        (lambda (site title body)
         `((doctype "html")
           (head
            (meta (@ (charset "utf-8")))
            (title ,(string-append title " — " (site-title site)))
            ,(stylesheet "main"))
             (body
              (header (@ (class "navbar"))
                      (div (@ (class "container"))
                           (ul
                            (li ,(anchor "str0ngbear.org" "/")))))
              (div (@ (class "container"))
                   ,body
                   (footer (@ (class "text-center"))
                    (p (small "This site was built with " (a (@ (href "https://dthompson.us/projects/haunt.html")) "Haunt."))))
                    ))))

         #:post-template
         (lambda (post)
           `((h2 ,(post-ref post 'title))
             (h3 "by " ,(post-ref post 'author)
                 " — " ,(date->string* (post-date post)))
             (div ,(post-sxml post))))))

(define %collections
  `(("Home" "index.html" ,posts/reverse-chronological)))

(site #:title "blog.strongbear.org"
      #:domain "str0ngbear.org"
      #:default-metadata
      '((author . "Matt")
        (email  . "matt@strongbear.org"))
      #:build-directory "docs"
      #:readers (list commonmark-reader sxml-reader skribe-reader)
      #:builders (list (blog #:theme str0ngbear-theme #:collections %collections)
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (static-directory "images")
                       (static-directory "css")))

