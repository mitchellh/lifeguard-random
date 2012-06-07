%% @doc This is a data source for Lifeguard that just returns pseudo-random
%% numbers. This can be useful for testing new checks or just as an example
%% of how to write a Lifeguard plugin.

-module(lifeguard_ds_random).
-behavior(gen_server).
-export([start_link/3]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%% @doc Start the data source in a supervision tree. The ServerRef is given
%% by Lifeguard and is the atom that we should register ourselves locally
%% under. The Name and Args are what are configured in the application
%% configuration.
start_link(ServerRef, _Name, _Args) ->
    gen_server:start_link({local, ServerRef}, ?MODULE, [], []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% gen_server callbacks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

init(_Args) ->
    lager:info("Started the random data source..."),
    {ok, no_state}.

handle_call({get, [Amount]}, _From, State) ->
    lager:debug("Get: ~p", [Amount]),
    {reply, {ok, get_numbers(Amount)}, State}.

handle_cast(_Request, State) -> {noreply, State}.

handle_info(_Request, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Internal methods
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

get_numbers(Amount) ->
    [random:uniform(50) || _ <- lists:seq(1, Amount)].

-ifdef(TEST).

handle_get_test() ->
    Result = get_numbers(5),
    ?assert(length(Result) =:= 5),

    Result2 = get_numbers(10),
    ?assert(length(Result2) =:= 10).

-endif.
