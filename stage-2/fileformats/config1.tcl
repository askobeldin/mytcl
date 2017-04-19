# First, I describe some books in which you can find good design patterns
# and programming idioms.  Each book, website or other source of patterns
# is specified with the 'Source' keyword, followed by a unique tag and some
# additional information.

Source GOF {
  Design patterns
  Elements of reusable object-oriented software
  Gamm, Helm, Johnson, Vlissides
  Addison-Wesley, 1995
  0 201 63361 2
}

Source SYST {
  A system of patterns
  Pattern-oriented software architecture
  Buschmann, Meunier, Rohnert, Sommerlad, Stal
  Wiley, 1996
  0 471 95869 7
}

# Next, I describe some categories.  I want to group patterns
# in categories so I can find them back more easily.  Each category
# has a name (such as "Access control") and a short description.

Category "Access control" {
   How to let one object control the access to one or more
   other objects.
}

Category "Distributed systems" {
   Distributing computation over multiple processes, managing
   communication between them.
}

Category "Resource handling" {
   Preventing memory leaks, managing resources.
}

Category "Structural decomposition" {
   To break monoliths down into indpendent components.
}

# Finally, I describe the patterns themselves.  Each of them has a name,
# belongs to one or more categories, and occurs in one or more of the
# pattern sources listed above.  Each pattern has a level, which can
# be 'arch' (for architectural patterns), 'design' for smaller-scale
# design patterns, or 'idiom' for language-specific patterns.

Pattern "Broker" {
  Categories {"Distributed systems"}
  Level arch 
  Sources {SYST:99}   ; # This means that this pattern is described in
                        # the book with tag 'SYST' on page 99.
  Info {
    Remote service invocations.
  }
}

Pattern "Proxy" {
  # This pattern fits in two categories:
  Categories {"Access control" "Structural decomposition::object"}
  Level design
  # Both these books talk about the Proxy pattern:
  Sources {SYST:263 GOF:207}
  Info {
    Communicate with a representative rather than with the
    actual object.
  }
}

Pattern "Facade" {
  Categories {"Access control" "Structural decomposition::object"}
  Sources {GOF:185}
  Level design
  Info {
    Group sub-interfaces into a single interface.
  }
}

Pattern "Counted Pointer" {
  Categories {"Resource handling"}
  Level idiom
  Sources {SYST:353}
  Info {
    Reference counting prevents memory leaks.
  }
}
