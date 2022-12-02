defmodule Part1 do
  @moduledoc """
  Directions:

  To find the fuel required for a module, take its mass, divide by
  three, round down, and subtract 2.

  The Fuel Counter-Upper needs to know the total fuel requirement. To
  find it, individually calculate the fuel needed for the mass of each
  module (your puzzle input), then add together all the fuel values.
  """

  @doc """
      iex> fuel_for_mass(12)
      2

      iex> fuel_for_mass(14)
      2

      iex> fuel_for_mass(1969)
      654

      iex> fuel_for_mass(100756)
      33583
  """
  def fuel_for_mass(mass) do
    div(mass, 3) - 2
  end

  def total_fuel(input_file) do
    File.stream!(input_file)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.map(&fuel_for_mass/1)
    |> Enum.sum()
  end
end
