defmodule CorruptionChecksum do
  @moduledoc """
  Generates the required checksum from the given spreadsheet.

  To run:

      elixir day-02-part-01-corruption-checksum.exs FILENAME
  """

  def checksum(file) do
    File.stream!(file)
    |> Stream.map(&line_to_min_max_difference/1)
    |> Enum.sum
  end

  # Reduces "1 2 3 4" => 3
  defp line_to_min_max_difference(line) do
    {min, max} =
      line
      |> String.split
      |> Stream.map(&String.to_integer/1)
      |> Enum.min_max

    max - min
  end
end

[file] = System.argv
IO.inspect CorruptionChecksum.checksum(file)
