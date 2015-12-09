defmodule Expr.Parser do
  alias Expr.Helpers

  @spec print(Expr.t) :: String.t
  def print({:num, value}), do: Integer.to_string(value)
  def print({:var, value}), do: Atom.to_string(value)
  def print({:add, left, right}), do: "(#{print(left)}+#{print(right)})"
  def print({:mul, left, right}), do: "(#{print(left)}*#{print(right)})"

  @spec parse(String.t) :: Expr.t
  def parse(expression) do
    expression
    |> String.to_char_list
    |> recursive_parse
    |> elem(0)
  end

  @spec recursive_parse(char_list) :: {Expr.t, char_list}
  def recursive_parse([?( | rest]) do
    {left, rest}  = recursive_parse(rest)
    [op | rest]   = rest
    {right, rest} = recursive_parse(rest)
    [?)|rest]     = rest
    {express_operator(op, left, right), rest}
  end
  def recursive_parse([ch | rest]) when ?0 <= ch and ch <= ?9 do
    {succeeds, remainder} = Helpers.get_while(rest, &Helpers.num?/1)
    {{:num, :erlang.list_to_integer([ch | succeeds])}, remainder}
  end
  def recursive_parse([ch | rest]) when ?a <= ch and ch <= ?z do
    {succeeds, remainder} = Helpers.get_while(rest, &Helpers.alpha?/1)
    {{:var, :erlang.list_to_atom([ch | succeeds])}, remainder}
  end

  defp express_operator(?+, left, right), do: {:add, left, right}
  defp express_operator(?*, left, right), do: {:mul, left, right}
end
