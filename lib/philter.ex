defmodule Philter do
    def main(args) do
        args |> parse_args |> process
    end
    
    def process([]) do
        IO.puts """
            Usage: philter --file [proxy file] --website [http://example.org]
            
            Options:
              --help    Show this message
              --file    Set proxy file (proxies should be in format "host:port")
              --website Website you want to check the proxy against (recommended: http://google.com)
            """
    end
    
    def process(options) do
        {exists, contents} = File.read options[:file]
        if exists === :ok do
            lines = String.split contents, "\n"
            working = Enum.map(lines, fn(line) -> 
                if valid_format(line) do
                    if(valid_proxy(line, options[:website])) do
                        IO.puts line
                    end
                end
            end)
        else
            IO.puts "Couldn't find file: #{options[:file]}"
        end
    end
    
    def valid_format(proxy) do
        split = String.split proxy, ":"
        case Enum.count(split) do
            2 -> true
            _ -> false
        end 
    end
    
    def valid_proxy(proxy, website) do
        proxy = String.split proxy, ":"
        try do
            HTTPotion.get website, [
                ibrowse: [
                    proxy_host: to_char_list(Enum.at(proxy, 0)),
                    proxy_port: elem(Integer.parse(Enum.at(proxy, 1)), 0)
                ]
            ]
            true
        rescue
            HTTPError -> false
        end
    end
    
    defp parse_args(args) do
        {options, _, _} = OptionParser.parse(args,
            switches: [file: :string, website: :string]
        )
        options
    end
end
