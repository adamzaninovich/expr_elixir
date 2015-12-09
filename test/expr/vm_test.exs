defmodule Expr.VMTest do
  use ExUnit.Case, async: true
  import Expr.VM

  @form   "(123+(bananas*456))"
  @env    [bananas: 789]
  @expr   {:add, {:num, 123}, {:mul, {:var, :bananas}, {:num, 456}}}
  @prog   [{:push, 123}, {:fetch, :bananas}, {:push, 456}, {:mul2}, {:add2}]
  @result 359907

  test "compile" do
    assert compile(@expr) == @prog
  end

  test "run" do
    assert run(@prog, @env) == @result
  end

  test "eval" do
    assert eval(@expr, @env) == @result
  end

  test "interpret" do
    assert interpret(@form, @env) == @result
  end
  test "interpret with no environment" do
    assert interpret("(1+2)") == 3
  end
end
