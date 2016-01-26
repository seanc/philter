defmodule Philter do
    def main(args) do
        args |> parse_args |> process
    end
    
    def process([]) do
        IO.puts """
            Usage: philter --file [proxy file] --website [http://example.org] --timeout 100 --output working.txt
            
            Options:
              --help    Show this message
              --file    Set proxy file (proxies should be in format "host:port")
              --website Website you want to check the proxy against (recommended: http://google.com)
              --timeout How long should we wait for the proxy to connect before we deem it unusable
              --output  The output file to write the working proxies, make sure we can write to this file
            """
    end
    
    def process(options) do
        {exists, contents} = File.read options[:file]
        if exists === :ok do
            {status, file} = File.open options[:output], [:write]
            if status !== :ok do
              IO.puts "There was an error writing to the output file, please check permissions"
              File.close file
              System.exit(0)
            end
            lines = String.split contents, "\n"
            proxies = Enum.count(lines)
            IO.puts "Checking #{proxies} proxies"
            valid = Enum.filter(lines, fn(line) -> 
              Enum.count(String.split(line, ":")) === 2
            end)
            working = Enum.filter(valid, fn(proxy) ->
              valid_proxy(proxy, options[:website], options[:timeout])
            end)
            Enum.each(working, fn(proxy) ->
              IO.binwrite file, proxy <> "\n"
            end)
            working = Enum.count(working)
            IO.puts "Finished checking, #{working} reported working"
            File.close file
        else
            IO.puts "Couldn't find file: #{options[:file]}"
        end
    end
    
    def valid_proxy(proxy, website, timeout) do
        proxy = String.split proxy, ":"
        try do
            HTTPotion.get website, [
                ibrowse: [
                    proxy_host: to_char_list(Enum.at(proxy, 0)),
                    proxy_port: elem(Integer.parse(Enum.at(proxy, 1)), 0),
                    timeout: timeout
                ]
            ]
            true
        rescue
            HTTPotion.HTTPError -> false
        end
    end
    
    defp parse_args(args) do
        {options, _, _} = OptionParser.parse(args,
            switches: [
              file: :string, 
              website: :string, 
              timeout: :integer, 
              output: :string
            ]
        )
        options
    end
end
