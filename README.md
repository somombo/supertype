# Supertype
Supertype is an extension of lean's `Subtype` that provides addional conveniences, features and syntax.

### Installation

To get started, add the following line to your `lakefile.lean`.

```lean
require supertype from git "https://github.com/somombo/supertype" @ "main"
```

### Usage
At the top of every lean file where you want to use Supertypes, add:

```lean
import Supertype
```

Then you can use the package in the following manner:

```lean
def x : { // 5 + · < 17 } := 2 ...
def y : { (a, b) // 5 ≤ a + b } := ... (4,3)
```

(For more examples of usage and syntax,
See [`Examples.lean`](https://github.com/somombo/supertype/blob/main/Examples.lean) file)