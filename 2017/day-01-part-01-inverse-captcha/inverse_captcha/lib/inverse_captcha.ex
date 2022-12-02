defmodule InverseCaptcha do
  @moduledoc """
  Solves Part 1 of the Inverse Captcha problem.
  http://adventofcode.com/2017/day/1

  Run with:

      mix
      ./inverse_captcha 1122
  """

  @doc """
  Solves the given captcha string by summing all the digits that match
  their immediately next digit. The given string is assumed to be
  circular so that "1122" is treated as "11221..." and so on.

  ## Examples

      iex> solve_captcha("1122")
      3

      iex> solve_captcha("1111")
      4

      iex> solve_captcha("1234")
      0

      iex> solve_captcha("91212129")
      9
  """
  def solve_captcha(string) do
    digit_stream =
      string                                        # "1122"
      |> String.splitter("", trim: true)            # ["1", "1", "2", "2"]
      |> Stream.map(& String.to_integer(&1))        # [1, 1, 2, 2]

    digit_stream
    |> Stream.chunk_every(2, 1, Enum.take(digit_stream, 1)) # [[1, 1], [1, 2], [2, 2], [2, 1]]
    |> Stream.filter(fn [x, y] -> x == y end)               # [[1, 1], [2, 2]]
    |> Stream.map(fn [x, _] -> x end)                       # [1, 2]
    |> Enum.sum                                             # 3
  end
end

defmodule InverseCaptcha.CLI do
  def main(args) do
    string = hd(args)
    IO.puts InverseCaptcha.solve_captcha(string)
  end
end
