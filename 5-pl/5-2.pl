#! /usr/bin/env swipl
:- initialization(main, main).

main() :-
	open("input.txt", read, Str),
	read_section(Str, Seed),
	read_section(Str, Soil),
	read_section(Str, Fertilizer),
	read_section(Str, Water),
	read_section(Str, Light),
	read_section(Str, Temperature),
	read_section(Str, Humidity),
	read_section(Str, Location),
	close(Str),
	split_string(Seed, " \n", " \n", [_|S]),
	maplist(number_string, Seeds, S),
	split_string(Soil, "\n", "", [_|Soils]),
	add_soils(Soils),
	split_string(Fertilizer, "\n", "", [_|Fertilizers]),
	add_fertilizers(Fertilizers),
	split_string(Water, "\n", "", [_|Waters]),
	add_waters(Waters),
	split_string(Light, "\n", "", [_|Lights]),
	add_lights(Lights),
	split_string(Temperature, "\n", "", [_|Temperatures]),
	add_temperatures(Temperatures),
	split_string(Humidity, "\n", "", [_|Humiditys]),
	add_humiditys(Humiditys),
	split_string(Location, "\n", "", [_|Locations]),
	add_locations(Locations),
	seeds_to_locations(Seeds, Locs),
	list_min(Locs, Y),
	write(Y).

list_min([L|Ls], Min) :-
	list_min(Ls, L, Min).

list_min([], Min, Min).
list_min([L|Ls], Min0, Min) :-
	Min1 is min(L, Min0),
	list_min(Ls, Min1, Min).

seeds_to_locations([], []) :- !.
seeds_to_locations([Seed|Seeds], [Location|Locations]) :- 
	write('Seed: '),write(Seed),nl,
	get_soil(Seed, Soil),
	write('Soil: '),write(Soil),nl,
	get_fertilizer(Soil, Fertilizer),
	write('Fertilizer: '),write(Fertilizer),nl,
	get_water(Fertilizer, Water),
	write('Water: '),write(Water),nl,
	get_light(Water, Light),
	write('Light: '),write(Light),nl,
	get_temperature(Light, Temperature),
	write('Temperature: '),write(Temperature),nl,
	get_humidity(Temperature, Humidity),
	write('Humidity: '),write(Humidity),nl,
	get_location(Humidity, Location),
	write('Location: '),write(Location),nl,
	write('------------'),nl,
	seeds_to_locations(Seeds, Locations).

range(Start, Range, Out) :- 
	End is (Start + Range) - 1,
	between(Start, End, Out).

/* For each entry, X is previous entry and Y is the value
e.g. soil(79, 81) means soil 81 maps to seed 79 */

get_soil(X, Y) :-
	soil(StartY, StartX, Range),
	X < StartX + Range,
	X >= StartX,
	Y is StartY + (X - StartX). 
get_soil(X,Y) :-
	Y is X.
:- dynamic soil/3.
add_soils([""]) :- !.
add_soils([S1|S2]) :-
	split_string(S1, " ", "", S),
	maplist(number_string, [StartY|[StartX|[Range]]], S),
	asserta(soil(StartY, StartX, Range)),
	add_soils(S2).

get_fertilizer(X, Y) :-
	fertilizer(StartY, StartX, Range),
	X < StartX + Range,
	X >= StartX,
	Y is StartY + (X - StartX). 
get_fertilizer(X,Y) :-
	Y is X.
:- dynamic fertilizer/3.
add_fertilizers([""]) :- !.
add_fertilizers([S1|S2]) :-
	split_string(S1, " ", "", S),
	maplist(number_string, [StartY|[StartX|[Range]]], S),
	asserta(fertilizer(StartY, StartX, Range)),
	add_fertilizers(S2).

get_water(X, Y) :-
	water(StartY, StartX, Range),
	X < StartX + Range,
	X >= StartX,
	Y is StartY + (X - StartX). 
get_water(X,Y) :-
	Y is X.
:- dynamic water/3.
add_waters([""]) :- !.
add_waters([S1|S2]) :-
	split_string(S1, " ", "", S),
	maplist(number_string, [StartY|[StartX|[Range]]], S),
	asserta(water(StartY, StartX, Range)),
	add_waters(S2).

get_light(X, Y) :-
	light(StartY, StartX, Range),
	X < StartX + Range,
	X >= StartX,
	Y is StartY + (X - StartX). 
get_light(X,Y) :-
	Y is X.
:- dynamic light/3.
add_lights([""]) :- !.
add_lights([S1|S2]) :-
	split_string(S1, " ", "", S),
	maplist(number_string, [StartY|[StartX|[Range]]], S),
	asserta(light(StartY, StartX, Range)),
	add_lights(S2).

get_temperature(X, Y) :-
	temperature(StartY, StartX, Range),
	X < StartX + Range,
	X >= StartX,
	Y is StartY + (X - StartX). 
get_temperature(X,Y) :-
	Y is X.
:- dynamic temperature/3.
add_temperatures([""]) :- !.
add_temperatures([S1|S2]) :-
	split_string(S1, " ", "", S),
	maplist(number_string, [StartY|[StartX|[Range]]], S),
	asserta(temperature(StartY, StartX, Range)),
	add_temperatures(S2).

get_humidity(X, Y) :-
	humidity(StartY, StartX, Range),
	X < StartX + Range,
	X >= StartX,
	Y is StartY + (X - StartX). 
get_humidity(X,Y) :-
	Y is X.
:- dynamic humidity/3.
add_humiditys([""]) :- !.
add_humiditys([S1|S2]) :-
	split_string(S1, " ", "", S),
	maplist(number_string, [StartY|[StartX|[Range]]], S),
	asserta(humidity(StartY, StartX, Range)),
	add_humiditys(S2).

get_location(X, Y) :-
	location(StartY, StartX, Range),
	X < StartX + Range,
	X >= StartX,
	Y is StartY + (X - StartX). 
get_location(X,Y) :-
	Y is X.
:- dynamic location/3.
add_locations([""]) :- !.
add_locations([S1|S2]) :-
	split_string(S1, " ", "", S),
	maplist(number_string, [StartY|[StartX|[Range]]], S),
	asserta(location(StartY, StartX, Range)),
	add_locations(S2).
	
read_section(InStream,W) :-
        get0(InStream,Char),
        checkCharAndReadRest(Char,Chars,InStream),
        atom_chars(W,Chars).
 
checkCharAndReadRest(-1,[],_) :- !.  % End of Stream
checkCharAndReadRest(end_of_file,[],_) :- !.
checkCharAndReadRest(10,[10|Chars],InStream) :-
        get0(InStream,NextChar),
	checkEndline(NextChar, Chars,InStream).
checkCharAndReadRest(Char,[Char|Chars],InStream) :-
        get0(InStream,NextChar),
        checkCharAndReadRest(NextChar,Chars,InStream).
checkEndline(-1,[],_) :- !.
checkEndline(end_of_file,[],_) :- !.
checkEndline(10,[],_) :- !.
checkEndline(Char,[Char|Chars],InStream) :-
        get0(InStream,NextChar),
        checkCharAndReadRest(NextChar,Chars,InStream).
