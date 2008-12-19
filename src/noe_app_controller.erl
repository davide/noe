-module(noe_app_controller).
-export([hook/1]).
-include("noe.hrl").

hook(A) ->
    case erlyweb:get_initial_ewc({ewc, A}) of
		{page, "/"} -> start(A);
		{page, "/static" ++ _Static} = Ewc -> Ewc;
		{page, "/favicon.ico"} = Ewc2 -> Ewc2;
		_Ewc -> start(A)
    end.



start(A) ->
    Appmod = yaws_arg:appmoddata(A),	
    Appmod1 = 
		case Appmod of
			"/" ->
				"/main";
			_ ->
				Appmod
		end,
    A3 = yaws_arg:appmoddata(A, Appmod1),
	{phased, 
		{ewc, A3},
		fun(_Ewc, Data, PhasedVars) ->
			{ewc, html_container, [A3, Data, PhasedVars]}
		end
	}.
