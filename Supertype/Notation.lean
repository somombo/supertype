import Lean
import Supertype.Tactic

@[inherit_doc Subtype]
syntax (priority := high) "{ " withoutPosition((term (" : " term)?)?  " // " term) " }" : term

macro_rules
  | `({ $x : $type // $p }) => ``(Subtype (fun ($x:term : $type) => $p))
  | `({ $x // $p })         => ``(Subtype (fun ($x:term : _) => $p))
  | `({ // $p}) =>  do ``(Subtype $((←Lean.Elab.Term.expandCDot? p).getD p))

section

variable {α : Type u } {β : Type v } {p : α → β → Prop}
#reduce { (a, b) // p a b }
-- theorem destruct_eq' :  { (a, b) // p a b } = @Subtype (α×β) fun ((a,b): α×β) =>  p a b  := rfl
theorem destruct_eq : { (a, b) : α×β // p a b } = @Subtype (α×β) fun ((a,b): α×β) =>  p a b := rfl
end

section

variable {p : α → Prop}
theorem dot : {// p .} = Subtype p := rfl
theorem alt : {// p} = Subtype p := rfl

end

@[inherit_doc Subtype]
syntax:max term /- noWs -/ "..."  : term
macro_rules | `($v...) => `({val:=$v, property:=(by mk_subtype_tactic)})

@[inherit_doc Subtype]
syntax:max "..." /- noWs -/ term  : term
macro_rules | `(...$v) => `({val:=$v, property:=(by mk_subtype_tactic)})
