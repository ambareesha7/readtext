defmodule ReadText do
  def replace_text(sample_data) when is_map(sample_data) do
    File.read!("source.txt")
    |> replace(sample_data)
  end

  defp replace(source, sample_data) do
    replace(source, sample_data, [])
  end

  defp replace("", _sample_data, acc) do
    acc
    |> Enum.reverse()
    |> IO.iodata_to_binary()
  end

  defp replace(<<"[name]", rest::binary>>, sample_data, acc) do
    name = sample_data.name
    replace(rest, sample_data, [name | acc])
  end

  defp replace(<<"[company]", rest::binary>>, sample_data, acc) do
    company = sample_data.company
    replace(rest, sample_data, [company | acc])
  end

  defp replace(<<"[time]", rest::binary>>, sample_data, acc) do
    time = sample_data.time
    replace(rest, sample_data, [time | acc])
  end

  defp replace(<<"[salesguy]", rest::binary>>, sample_data, acc) do
    salesguy = sample_data.salesguy
    replace(rest, sample_data, [salesguy | acc])
  end

  defp replace(<<head, rest::binary>>, sample_data, acc) do
    replace(rest, sample_data, [head | acc])
  end
end
