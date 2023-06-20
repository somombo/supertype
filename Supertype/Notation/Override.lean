import Lean
import Supertype.Core

namespace Notation.Override

scoped macro_rules
  | `({ $x : $type // $p }) => ``(Supertype (fun ($x:ident : $type) => $p))
  | `({ $x // $p })         => ``(Supertype (fun ($x:ident : _) => $p))

@[inherit_doc Supertype] 
syntax "{" " // " term " }" : term
macro_rules
  | `({ // $e}) =>  do `(Supertype $((←Lean.Elab.Term.expandCDot? e).getD e))

section

variable {p : α → Prop}
theorem dot : {// p .} = Supertype p := rfl
theorem alt : {// p} = Supertype p := rfl

end 

scoped macro_rules | `(↑$v) => `({val:=$v, property:=(by mk_subtype_tactic)})
scoped macro_rules | `(⟨$v⟩) => `({val:=$v, property:=(by mk_subtype_tactic)})
scoped macro_rules | `(⟨$v, $h⟩) => `({val:=$v, property:=$h})
