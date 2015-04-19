-module(afile_client).
-export([ls/1, get_file/2, append_to_tmp_file/2]).
ls(Server) ->
    Server ! {self(), list_dir},
    receive
        {Server, FileList} ->
            FileList
    end.
get_file(Server, File) ->
    Server ! {self(), {get_file, File}},
    receive
        {Server, Content} ->
            Content
    end.
append_to_tmp_file(Server, Content) ->
    Server ! {self(), {append_to_tmp_file, Content}},
    receive
        {Server, CurrentContent} ->
            CurrentContent
    end.
