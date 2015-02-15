defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(Dict.t, String.t, pos_integer) :: Dict.t
  def add(db, name, grade) do
    Dict.merge(db, new_grade(grade, name), &merge_grades/3)
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(Dict.t, pos_integer) :: [String]
  def grade(db, grade) do
    Dict.get(db, grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(Dict) :: Dict.t
  def sort(db) do
    Enum.into(db, %{}, &sort_names/1)
  end

  defp merge_grades(_grade, old, new) do
    old ++ new
  end

  defp new_grade(grade, name) do
    Dict.put(%{}, grade, [name]) # can be changed to %{grade => [name]} in Elixir 1.1/Erlang R18
  end

  defp sort_names({grade, names}) do
    {grade, Enum.sort(names)}
  end
end
