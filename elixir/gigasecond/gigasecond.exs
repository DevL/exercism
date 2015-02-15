defmodule Gigasecond do
	@doc """
	Calculate a date one billion seconds after an input date.
	"""
	@spec from({pos_integer, pos_integer, pos_integer}) :: :calendar.date

	def from(date) do
    date
    |> date_to_seconds
    |> add_a_gigasecond
    |> seconds_to_date
	end

  defp date_to_seconds(date), do: date |> date_to_datetime |> datetime_to_seconds
  defp add_a_gigasecond(seconds), do: seconds + 1_000_000_000
  defp seconds_to_date(seconds), do: seconds |> seconds_to_datetime |> datetime_to_date
  defp date_to_datetime(date), do: {date, {0, 0, 0}}
  defp datetime_to_seconds(datetime), do: datetime |> :calendar.datetime_to_gregorian_seconds
  defp seconds_to_datetime(seconds), do: seconds |> :calendar.gregorian_seconds_to_datetime
  defp datetime_to_date({date, time}), do: date
end
