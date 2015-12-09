defmodule Expr.HelpersTest do
  use ExUnit.Case, async: true
  import Expr.Helpers

  test "lookup" do
    env = [apples: 5, bananas: 7]
    assert lookup(env, :bananas) == 7
  end

  test "num? when input is a number" do
    assert num?(?5) == true
  end
  test "num? when input is not a number" do
    assert num?(?a) == false
  end

  test "alpha? when input is a letter" do
    assert alpha?(?a) == true
  end
  test "alpha? when input is not a letter" do
    assert alpha?(?5) == false
  end

  test "get_while" do
    assert get_while('abc123', &alpha?/1) == {'abc', '123'}
  end
  test "get_while when there is nothing to get" do
    assert get_while('', &(&1)) == {[],[]}
  end
end
