defmodule Expr.Helpers do
  @spec lookup(Expr.env, atom) :: integer
  def lookup([{key, value}|_], key), do: value
  def lookup([_|env], key), do: lookup(env, key)

  @spec num?(integer) :: boolean
  def num?(char), do: ?0 <= char and char <= ?9

  @spec alpha?(integer) :: boolean
  def alpha?(char), do: ?a <= char and char <= ?z

  @spec get_while([any], (any -> boolean)) :: {[any], [any]}
  def get_while([char|rest], predicate) do
    case predicate.(char) do
      true ->
        {succeeds, remainder} = get_while(rest, predicate)
        {[char|succeeds], remainder}
      false ->
        {[], [char|rest]}
    end
  end
  def get_while([],_), do: {[],[]}
end
