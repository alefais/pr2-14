(* author: Alessandra Fais*)

#use "pr2InterpreteDinam.ml";;

(*Test sul corretto funzionamento di Applyfun con scoping dinamico*)

(* let x = 5
in let func = fun y -> x + y
in let x = 8
in apply(func, x) 

In scoping statico, il risultato è Dint 13
In scoping dinamico, il risultato è Dint 16*)

let fun1 = 
	Let("x", ValInt(5), Let("func", ValFun("y", Plus(ValIde("x"), ValIde("y"))), Let("x", ValInt(8), Applyfun(ValIde("func"), ValIde("x")))))
in let res = semden(fun1, emptyenv Unbound)
in if res = Dint(16) then print_endline "APPLYFUN ok"
	else failwith "APPLYFUN error";;


(*Test sul corretto funzionamento di Map*)

(*
	let x = 5
	in let plusfive = fun formalparam -> x + formalparam
	in let x = 8
	in let lis = [1; 2; 3]
	in map(plusfive, lis)

	Scoping statico: [6; 7; 8]
	Scoping dinamico: [9; 10; 11]

*)

let map1 = Let(
			   "x", 
			   ValInt(5), 
			   Let(
			   	   "plusfive", 
			   	   ValFun(
			   	   	      "formalparam", 
			   	   		  Plus(
			   	   		  	   ValIde("x"), 
			   	   		  	   ValIde("formalparam")
			   	   		  )
			   	   ),
			   	   Let(
			   	   	   "x",
			   	   	   ValInt(8),
			   	   	   Let(
			   	   	   	   "lis",
			   	   	   	   ValIntlist(Cons(1, Cons(2, Cons(3, Nil)))),
			   	   	   	   Map(
			   	   	   	   		ValIde("plusfive"),
			   	   	   	   		ValIde("lis")
			   	   	   	   )
			   	   	   )
			   	   )
			   )
		   )
in let res = semden(map1, emptyenv Unbound)
in if res = Dintlist(Cons(9, Cons(10, Cons(11, Nil)))) then print_endline "MAP ok"
	else failwith "MAP error";;