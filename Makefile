APP = lifeguard_random

all: deps compile

compile:
	./rebar compile

clean:
	./rebar clean

deps:
	./rebar get-deps

devrel: rel
	rm -rf rel/$(APP)/lib/$(APP)-*/ebin
	ln -sf $(abspath ./apps/$(APP)/ebin) rel/$(APP)/lib/$(APP)-*
	rm -rf rel/$(APP)/lib/$(APP)-*/priv
	ln -sf $(abspath ./apps/$(APP)/priv) rel/$(APP)/lib/$(APP)-*
	echo -s sync | tee -a rel/$(APP)/releases/*/vm.args

rel: compile
	./rebar generate -f

test: compile
	./rebar eunit apps=$(APP)

.PHONY: all compile clean deps
