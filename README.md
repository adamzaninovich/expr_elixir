# Elixir Expression Processor
Tiny expression processing example in Elixir

## Examples

`Expr.Parser.parse` takes an expression as a string and turns it into a tree representation.

```
iex> Expr.Parser.parse("(123+(bananas*456))")
{:add, {:num, 123}, {:mul, {:var, :bananas}, {:num, 456}}}
```

You can then take that tree and pass it to `Expr.VM.compile` to get back a program compiled into a list of instructions.

```
iex> Expr.VM.compile({:add, {:num, 123}, {:mul, {:var, :bananas}, {:num, 456}}})
[{:push, 123}, {:fetch, :bananas}, {:push, 456}, {:mul2}, {:add2}]
```

That program can then be run with `Expr.VM.run/2` by providing the program and an environment with variable values.

```
iex> Expr.VM.run([{:push, 123}, {:fetch, :bananas}, {:push, 456}, {:mul2}, {:add2}], [bananas: 5])
2403
```

You can also just run `Expr.VM.interpret` like so:

```
iex> Expr.VM.interpret("(123+(bananas*456))", [bananas: 5])
2403
```
