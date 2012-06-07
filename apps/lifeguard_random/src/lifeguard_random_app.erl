-module(lifeguard_random_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    lifeguard_random_sup:start_link().

stop(_State) ->
    ok.
