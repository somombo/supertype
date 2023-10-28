import Supertype
set_option pp.notation false

------------------------------------------------------------

#check { (a, b) : Nat × Nat // 5 ≤ a + b} -- Subtype fun (⟨a,b⟩ : Nat × Nat) => 5 ≤ a + b
#check { (a, b) // 5 ≤ a + b} -- Subtype fun (a,b) => 5 ≤ a + b
example : { (a, b) // 5 ≤ a + b} := ... (4,3)
def x : { (a, b) : Nat×Nat // 5 ≤ a + b} := (4,3) ...
#reduce x --  ⟨(4,3), by simp_arith⟩

------------

structure Foo where  mk :: (p : Nat) (q : Bool) (r : String)
#check { ⟨a, b, c⟩ : Foo // s!"{a} {b} {c}".length > 4 } -- Subtype fun (⟨a, b, c⟩ : Foo) => s!"{a} {b} {c}".length > 4

---------------------------------------------------------------

#check {// 5 + · < 17} -- Subtype (5 + · < 17)
example : {// 5 + · < 17} := ... 2
def y : {// 5 + · < 17} := 2 ...
#reduce y -- ⟨2, by simp_arith⟩

------------------------------------------------------------------------------------------

example : {// · < 5} := 7 ... -- Error: fails to automatically prove value has the predicted property
example : {// · < 5} := ... 7 -- Error: fails to automatically prove value has the predicted property
