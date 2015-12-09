defmodule Expr.ParserTest do
  use ExUnit.Case, async: true
  import Expr.Parser

  @expr {:add, {:num, 123}, {:mul, {:var, :bananas}, {:num, 456}}}
  @form "(123+(bananas*456))"

  test "print" do
    assert print(@expr) == @form
  end

  test "parse" do
    assert parse(@form) == @expr
  end
end
