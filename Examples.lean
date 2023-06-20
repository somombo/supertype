import Supertype
set_option pp.notation false


-- section
-- end
#check {n // 5 + n < 17} -- Subtype (5 + · < 17)

#check {n \\ 5 + n < 17} -- Supertype (5 + · < 17)

open Notation.Override in 
  #check {n // 5 + n < 17}  -- Supertype (5 + · < 17)


----------
#check {// 5 + · < 17} -- does not require notation override

------------


example : Supertype (5 + · < 17) := ... 2

open Notation.Override in 
  example : Supertype (5 + · < 17) := ↑2

open Notation.Override in 
  example : Supertype (5 + · < 17)  :=  ⟨2⟩ 
  
------------------------------------------------------------------------------------------

---- ALT

example : {n : Nat \\ n < 5} :=  {val := 2} 
example : {n \\ n < 5} = Supertype ( · < 5) := rfl

example : {\\ 3 + · ≤ 11} = Supertype (3 + · ≤ 11) := rfl  #check {\\ 3 + · ≤ 11}
example : {\\ · < 5} := 2 ...
example : {\\ · < 5} := ... 2

example : {\\ · < 5} := 7 ... -- Error: fails to automatically prove value has the predicted property
example : {\\ · < 5} := ... 7 -- Error: fails to automatically prove value has the predicted property

-- OVERR
section override 
open Notation.Override 
example : {n : Nat // n < 5} :=  {val := 2} 
example : {n // n < 5} = Supertype ( · < 5) := rfl

example : {// 3 + · ≤ 11} = Supertype (3 + · ≤ 11) := rfl  #check {// 3 + · ≤ 11}

example : {// · < 5} :=  ↑2 
example : {// · < 5} :=  ⟨ 2 ⟩

example : {// · < 5} :=  ⟨ 2, by simp_arith ⟩

example : {// · < 5} :=  ↑7   -- Error: fails to automatically prove value has the predicted property
example : {// · < 5} :=  ⟨ 7 ⟩ -- Error: fails to automatically prove value has the predicted property
end override