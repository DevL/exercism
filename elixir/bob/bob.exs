defmodule Teenager do
  def hey(remark) do
    cond do
      Remark.silent?(remark) ->
        "Fine. Be that way!"
      Remark.question?(remark) ->
        "Sure."
      Remark.shout?(remark) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
end

defmodule Remark do
  def silent?(remark) do
    StringUtils.blank?(remark)
  end

  def question?(remark) do
    String.ends_with?(remark, "?")
  end

  def shout?(remark) do
    StringUtils.lacks_lower_case?(remark) and StringUtils.contains_letters?(remark)
  end
end

defmodule StringUtils do
  def blank?(string) do
    String.strip(string) == ""
  end

  def contains_letters?(string) do
    String.upcase(string) != String.downcase(string)
  end

  def lacks_lower_case?(string) do
    String.upcase(string) == string
  end
end
