defmodule InverseCaptcha do
  @moduledoc """
  Solves Part 2 of the Inverse Captcha problem.
  http://adventofcode.com/2017/day/1

  (Run new captcha's with a doctest for now)
  """

  @doc """
  Solves the given captcha string by summing all the digits that have
  a matching digit halfway around the circular list.

  ## Examples

      iex> solve_captcha("1212")
      6

      iex> solve_captcha("1221")
      0

      iex> solve_captcha("123425")
      4

      iex> solve_captcha("123123")
      12

      iex> solve_captcha("12131415")
      4
  """
  def solve_captcha(string) do
    half_length = div(String.length(string), 2)
    {_left, right} = String.split_at(string, half_length)

    left_stream = string_to_digit_stream(string)

    right_stream =
      right
      |> string_to_digit_stream
      |> Stream.concat(Stream.take(left_stream, half_length))

    Stream.zip(left_stream, right_stream)
    |> Stream.filter(fn {x, y} -> x == y end)
    |> Stream.map(fn {x, _} -> x end)
    |> Enum.sum()
  end

  defp string_to_digit_stream(string) do
    string
    |> String.splitter("", trim: true)
    |> Stream.map(&String.to_integer(&1))
  end
end
