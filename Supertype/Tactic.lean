/--
`mk_subtype_tactic_trivial` is an extensible tactic automatically called
by the notation `v ...` to prove any side conditions that arise when
constructing the term (e.g. the value of a subtype satifies its property).
The default behavior is to just try `trivial` and `simp_arith`
(for doing linear arithmetic).
-/
syntax "mk_subtype_tactic_trivial" : tactic

macro_rules | `(tactic| mk_subtype_tactic_trivial) => `(tactic| trivial)
macro_rules | `(tactic| mk_subtype_tactic_trivial) => `(tactic| simp (config := { arith := true }); done)

/--
`mk_subtype_tactic` is the tactic automatically called by the notation `v ...`
to prove any side conditions that arise when constructing the term
(e.g. the value of a subtype satifies its property). It just delegates to
`mk_subtype_tactic_trivial` and gives a diagnostic error message otherwise;
users are encouraged to extend `mk_subtype_tactic_trivial` instead of this tactic.
-/
macro "mk_subtype_tactic" : tactic =>
  `(tactic| first
    | mk_subtype_tactic_trivial
    | fail "failed to prove the value is valid, possible solutions:
  - Use `have`-expressions to prove the value valid
  - Use `{val:=v, proof:=h}` notation instead, where `h` is a proof that the value has the prescribed property"
   )
