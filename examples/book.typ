// Option: prose: "book" (first-line indent + tight paragraphs). Same body as content.typ.
#import "../src/lib.typ": *
#show: scholia.with(prose: "book")
#include "body.typ"
