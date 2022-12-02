defmodule Part2 do
  @moduledoc """
  Directions:

  For each module mass, calculate its fuel and add it to the total.
  Then, treat the fuel amount you just calculated as the input mass
  and repeat the process, continuing until a fuel requirement is zero
  or negative. For example:

  - A module of mass 14 requires 2 fuel. This fuel requires no further
    fuel (2 divided by 3 and rounded down is 0, which would call for a
    negative fuel), so the total fuel required is still just 2.

  - At first, a module of mass 1969 requires 654 fuel. Then, this fuel
    requires 216 more fuel (654 / 3 - 2). 216 then requires 70 more
    fuel, which requires 21 fuel, which requires 5 fuel, which
    requires no further fuel. So, the total fuel required for a module
    of mass 1969 is 654 + 216 + 70 + 21 + 5 = 966.

  - The fuel required by a module of mass 100756 and its fuel is:
    33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2 = 50346.

  See https://adventofcode.com/2019/day/1
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

  @doc """
      iex(9)> total_fuel_for_mass(14)
      2

      iex(10)> total_fuel_for_mass(1969)
      966

      iex(11)> total_fuel_for_mass(100756)
      50346
  """
  def total_fuel_for_mass(mass_or_fuel) do
    fuel = fuel_for_mass(mass_or_fuel)

    if fuel > 0 do
      fuel + total_fuel_for_mass(fuel)
    else
      0
    end
  end

  def total_fuel(input_file) do
    File.stream!(input_file)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.map(&total_fuel_for_mass/1)
    |> Enum.sum()
  end
end
