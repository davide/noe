all: code

code: clean
	erl -noshell -eval 'filelib:ensure_dir("./ebin/"), filelib:ensure_dir("./ebin/noe/"), make:all().' -pa ebin -s erlang halt

run:	code
	erl -noshell -eval 'filelib:ensure_dir("./log/").' -pa ebin -s erlang halt
	erl -yaws debug -run yaws --conf yaws.conf -yaws id noe.webserver

clean:
	rm -fv ebin/*.beam ebin/noe/*.beam log/* noe.rel noe.script noe.boot erl_crash.dump *.log *.access
	rm -fv  *.Emakefile

