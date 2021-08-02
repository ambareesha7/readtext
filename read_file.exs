defmodule ReadFiles do
	@output_file "output.txt"
	def read_file(args) do
		case File.read("source.txt") do
			{:ok, body} ->
				body
				|> ReadFiles.replace_variables(parse_args(args))
				|> ReadFiles.write_to_file()
			{:error, reason} ->
				IO.puts "Error reading file. Reason: #{inspect reason}"
		end
	end

	def replace_variables(body, vars) do
		body
		|> String.split("\n")
		|> Enum.map(&replace_line(&1, vars))
		|> Enum.join("\n")
	end

	def replace_line(line, vars) do
		String.split(line, " ")
		|> Enum.map(fn a ->
			replace_word(a, vars)
		end)
		|> Enum.join(" ")
	end

	defp replace_word(word, vars) do
		case String.match?(word, ~r/\[\w+\]/) do
			true ->
				[prefix, var_name, suffix] = String.split(word, ["[", "]"])
				replacement = Map.get(vars, var_name)
				Enum.join([prefix, replacement, suffix], "")
			false ->
				word
		end
	end

	def write_to_file(contents) do
		case File.write(@output_file, contents) do
			:ok ->
				IO.puts "Wrote file: #{@output_file}.\n"
			_ ->
				IO.puts "Failed to write file."
		end
	end

	defp parse_args(args) do
		args |> Enum.map(&String.split(&1, "="))
		|> Enum.reduce(%{}, fn [k|v], acc -> Map.put(acc, k, v) end)
	end
end

System.argv() |> ReadFiles.read_file()
