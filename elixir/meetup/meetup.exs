defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @day_of_the_week [monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7]

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    relevant_dates(year, month, schedule)
    |> find_first(weekday)
  end

  @spec find_first(list(:calendar.date), weekday) :: :calendar.date
  defp find_first(dates, weekday) do
    dates
    |> Enum.find &matching_day_of_the_week?(&1, weekday)
  end

  @spec matching_day_of_the_week?(:calendar.date, weekday) :: boolean
  defp matching_day_of_the_week?(date, weekday) do
    :calendar.day_of_the_week(date) == @day_of_the_week[weekday]
  end

  @spec relevant_dates(pos_integer, pos_integer, schedule) :: list(:calendar.date)
  defp relevant_dates(year, month, schedule), do: dates(year, month, search_range(year, month, schedule))

  @spec search_range(pos_integer, pos_integer, schedule) :: 1..31
  defp search_range(_, _, :first), do: 1..7
  defp search_range(_, _, :second), do: 8..14
  defp search_range(_, _, :third), do: 15..21
  defp search_range(_, _, :fourth), do: 22..28
  defp search_range(_, _, :teenth), do: 13..19
  defp search_range(year, month, :last), do: last_seven_days_ending_with :calendar.last_day_of_the_month(year, month)

  @spec dates(pos_integer, pos_integer, 1..31) :: list(:calendar.date)
  defp dates(year, month, days) do
    Enum.map days, fn(day) -> {year, month, day} end
  end

  @spec last_seven_days_ending_with(pos_integer) :: 22..31
  defp last_seven_days_ending_with(day) do
    (day - 6)..day
  end
end
