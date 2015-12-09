defmodule Expr.VM do
  alias Expr.Helpers
  alias Expr.Parser

  @spec compile(Expr.t) :: Expr.program
  def compile({:num, value}), do: [push: value]
  def compile({:var, value}), do: [fetch: value]
  def compile({:add, left, right}) do
    compile(left) ++ compile(right) ++ [{:add2}]
  end
  def compile({:mul, left, right}) do
    compile(left) ++ compile(right) ++ [{:mul2}]
  end

  @spec run(Expr.program, Expr.env) :: integer
  def run(program, env), do: run(program, env, [])

  @spec run(Expr.program, Expr.env, Expr.stack) :: integer
  def run([{:push, number} | continue], env, stack) do
    run(continue, env, [number | stack])
  end
  def run([{:fetch, key} | continue], env, stack) do
    run(continue, env, [Helpers.lookup(env, key) | stack])
  end
  def run([{:add2} | continue], env, [left, right | stack]) do
    run(continue, env, [left + right | stack])
  end
  def run([{:mul2} | continue], env, [left, right | stack]) do
    run(continue, env, [left * right | stack])
  end
  def run([], _env, [value]), do: value

  @spec eval(Expr.t, Expr.env) :: integer
  def eval({:num, value}, _env), do: value
  def eval({:var, key}, env), do: Helpers.lookup(env, key)
  def eval({:add, left, right}, env) do
    eval(left, env) + eval(right, env)
  end
  def eval({:mul, left, right}, env) do
    eval(left, env) * eval(right, env)
  end

  @spec interpret(String.t) :: integer
  def interpret(expression), do: interpret(expression, [])

  @spec interpret(String.t, Expr.env) :: integer
  def interpret(expression, env) do
    expression
    |> Parser.parse
    |> compile
    |> run(env)
  end
end
