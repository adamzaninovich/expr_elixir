defmodule Expr do
  @type t :: {:num, integer}
          |  {:var, atom}
          |  {:add, t, t}
          |  {:mul, t, t}

  @type env :: [{atom, integer}]

  @type instr :: {:push, integer}
              |  {:fetch, atom}
              |  {:add2}
              |  {:mul2}

  @type program :: [instr]

  @type stack :: [integer]
end
