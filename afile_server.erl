-module(afile_server).
-export([start/1, loop/1]).

start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
    receive
        {Client, list_dir} ->
            Client ! {self(), file:list_dir(Dir)};
        {Client, {get_file, File}} ->
            Full = filename:join(Dir, File),
            Client ! {self(), file:read_file(Full)};
        {Client, {append_to_tmp_file, Content}} ->
            Full = filename:join(Dir, "blah.tmp"),
            Client ! {self(), file:write_file(Full, Content, [append])}
    end,
    loop(Dir).

