# Supertype
An extension of lean's Subtypes with extra features and syntax

### Installation and Usage

Add the following line to your `lakefile.lean`.

```lean
require supertype from git "https://github.com/somombo/supertype" @ "main"
```

Then you can use the package in the following manner:

```lean
import Supertype
example : {// 5 + · < 17} := 2 ...
```

(See [`Examples.lean`](https://github.com/somombo/supertype/blob/main/Examples.lean) file for more examples of usage and syntax)