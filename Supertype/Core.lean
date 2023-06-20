-- import Lean



/--
`mk_subtype_tactic_trivial` is an extensible tactic automatically called
by the notation `arr[i]` to prove any side conditions that arise when
constructing the term (e.g. the index is in bounds of the array).
The default behavior is to just try `trivial` (which handles the case
where `i < arr.size` is in the context) and `simp_arith`
(for doing linear arithmetic in the index).
-/
syntax "mk_subtype_tactic_trivial" : tactic

macro_rules | `(tactic| mk_subtype_tactic_trivial) => `(tactic| trivial)
macro_rules | `(tactic| mk_subtype_tactic_trivial) => `(tactic| simp (config := { arith := true }); done)

/--
`mk_subtype_tactic` is the tactic automatically called by the notation `v ...`
to prove any side conditions that arise when constructing the term
(e.g. the index is in bounds of the array). It just delegates to
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




/--
`Supertype p`, usually written as `{x : α // p x}`, is a type which
represents all the elements `x : α` for which `p x` is true. It is structurally
a pair-like type, so if you have `x : α` and `h : p x` then
`⟨x, h⟩ : {x // p x}`. An element `s : {x // p x}` will coerce to `α` but
you can also make it explicit using `s.2` or `s.val`.
-/
structure Supertype 
  {π : Sort u} 
  (p : π → Prop) 
extends Subtype p 
where
  -- /-- If `s : {x // p x}` then `s.val : α` is the underlying element in the base
  -- type. You can also write this as `s.2`, or simply as `s` when the type is
  -- known from context. -/
  -- val : π
  /-- If `s : {x // p x}` then `s.3` or `s.proof` is the assertion that
  `p s.2`, that is, that `s` is in fact an element for which `p` holds. -/
  proof : p val := by mk_subtype_tactic
  pred := p
  
  ---------
  private __ : (pred=p) ∧ (property=proof)  := by simp
  (property := proof)  


namespace Supertype
variable (s : Supertype p)

def prop := s.pred s.val
-- def property := s.proof
-- def toSubtype := {val := s.val, property := s.proof : Subtype p}
end Supertype

-- class MkSup 
--   (π : Type u) 
--   (p : outParam (π → Prop)) 
--   (S : outParam (Type w)) 
-- where
--   mkSup (x : π) (h : p x) : S -- Supertype p

-- export MkSup (mkSup)

----
section instances
instance {α : Sort u} {p : α → Prop} : CoeOut (Supertype p) α where
  coe v := v.val

instance {p : α → Prop} [Repr α] : Repr (Supertype p) where
  reprPrec s prec := reprPrec s.val prec

instance {α : Type u} {p : α → Prop} [ToString α] : ToString (Supertype p) := 
  ⟨fun s => toString s.val⟩

-- import Init.SizeOf
-- deriving instance SizeOf for Supertype
end instances
