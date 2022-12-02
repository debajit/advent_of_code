defmodule CorruptionChecksum do
  @moduledoc """
  Generates the required checksum from the given spreadsheet. The
  checksum is calculated as the sum of the quotients of the only
  evenly divisible values in each row.

  To run:

      elixir day-02-part-02-corruption-checksum.exs FILENAME
  """

  def checksum(file) do
    File.stream!(file)
    |> Stream.map(&line_to_whole_quotient/1)
    |> Enum.sum
  end

  # "5 2 9 8" => 8/2 => 4
  defp line_to_whole_quotient(line) do
    list = string_to_list(line)

    for i <- list, j <- list, i != j, rem(i, j) == 0 do
      div(i, j)
    end |> hd
  end

  # "1 2 3 4" => [1, 2, 3, 4]
  defp string_to_list(string) do
    string
    |> String.split
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list
  end
end

[file] = System.argv
IO.inspect CorruptionChecksum.checksum(file)
