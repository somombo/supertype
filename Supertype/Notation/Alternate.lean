import Lean
import Supertype.Core

@[inherit_doc Supertype] 
syntax "{ " withoutPosition(ident (" : " term)? " \\\\ " term) " }" : term

macro_rules
  | `({ $x : $type \\ $p }) => ``(Supertype (fun ($x:ident : $type) => $p))
  | `({ $x \\ $p })         => ``(Supertype (fun ($x:ident : _) => $p))

@[inherit_doc Supertype] 
syntax "{" " \\\\ " term " }" : term
macro_rules
  | `({ \\ $e}) =>  do `(Supertype $((←Lean.Elab.Term.expandCDot? e).getD e))

section

variable {p : α → Prop}
theorem dot : {\\ p .} = Supertype p := rfl
theorem alt : {\\ p} = Supertype p := rfl

end 

@[inherit_doc Supertype]
syntax:max term /- noWs -/ "..."  : term
macro_rules | `($v...) => `({val:=$v, property:=(by mk_subtype_tactic)})


@[inherit_doc Supertype]
syntax:max "..." /- noWs -/ term  : term
macro_rules | `(...$v) => `({val:=$v, property:=(by mk_subtype_tactic)})
