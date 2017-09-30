(* author: Alessandra Fais*)

#use "pr2Interprete.ml";;

(*Test sul corretto funzionamento di And*)
let and1 = And(ValBool(true), ValBool(true))
in let res = semden(and1, emptyenv Unbound)
in if res = Dbool(true) then print_endline "AND1 ok"
	else failwith "AND1 error";;

let and2 = And(ValBool(false), ValBool(false))
in let res = semden(and2, emptyenv Unbound)
in if res = Dbool(false) then print_endline "AND2 ok"
	else failwith "AND2 error";;

let and3 = And(ValBool(false), ValBool(true))
in let res = semden(and3, emptyenv Unbound)
in if res = Dbool(false) then print_endline "AND3 ok"
	else failwith "AND3 error";;

(*Test eccezioni di And*)
let anderr1 = And(ValBool(true), ValInt(2))
in try
	ignore(semden(anderr1, emptyenv Unbound));
	failwith "anderr"
with
| Failure f -> if f = "Type error" then print_endline "ANDerr1 ok"
				else failwith "ANDerr1 error"
| _ -> failwith "ANDerr1 error";;


(*Test sul corretto funzionamento di Or*)
let or1 = Or(ValBool(true), ValBool(true))
in let res = semden(or1, emptyenv Unbound)
in if res = Dbool(true) then print_endline "OR1 ok"
	else failwith "OR1 error";;

let or2 = Or(ValBool(false), ValBool(false))
in let res = semden(or2, emptyenv Unbound)
in if res = Dbool(false) then print_endline "OR2 ok"
	else failwith "OR2 error";;

let or3 = Or(ValBool(false), ValBool(true))
in let res = semden(or3, emptyenv Unbound)
in if res = Dbool(true) then print_endline "OR3 ok"
	else failwith "OR3 error";;

(*Test eccezioni di Or*)
let orerr1 = Or(ValInt(2), ValBool(false))
in try
	ignore(semden(orerr1, emptyenv Unbound));
	failwith "orerr"
with
| Failure f -> if f = "Type error" then print_endline "ORerr1 ok"
				else failwith "ORerr1 error"
| _ -> failwith "ORerr1 error";;


(*Test sul corretto funzionamento di Not*)
let not1 = Not(ValBool(true))
in let res = semden(not1, emptyenv Unbound)
in if res = Dbool(false) then print_endline "NOT1 ok"
	else failwith "NOT1 error";;

let not2 = Not(ValBool(false))
in let res = semden(not2, emptyenv Unbound)
in if res = Dbool(true) then print_endline "NOT2 ok"
	else failwith "NOT2 error";;

(*Test eccezioni di Not*)
let noterr1 = Not(ValIntlist(Nil))
in try
	ignore(semden(noterr1, emptyenv Unbound));
	failwith "noterr"
with
| Failure f -> if f = "Type error" then print_endline "NOTerr1 ok"
				else failwith "NOTerr1 error"
| _ -> failwith "NOTerr1 error";;


(*Test sul corretto funzionamento di Plus*)
let plus1 = Plus(ValInt(5), ValInt(3))
in let res = semden(plus1, emptyenv Unbound)
in if res = Dint(8) then print_endline "PLUS1 ok"
	else failwith "PLUS1 error";;

(*Test eccezioni di Plus*)
let pluserr1 = Plus(ValInt(7), ValBool(true))
in try
	ignore(semden(pluserr1, emptyenv Unbound));
	failwith "pluserr"
with
| Failure f -> if f = "Type error" then print_endline "PLUSerr1 ok"
				else failwith "PLUSerr1 error"
| _ -> failwith "PLUSerr1 error";;


(*Test sul corretto funzionamento di Diff*)
let diff1 = Diff(ValInt(5), ValInt(3))
in let res = semden(diff1, emptyenv Unbound)
in if res = Dint(2) then print_endline "DIFF1 ok"
	else failwith "DIFF1 error";;

(*Test eccezioni di Diff*)
let differr1 = Diff(ValInt(7), ValBool(true))
in try
	ignore(semden(differr1, emptyenv Unbound));
	failwith "differr"
with
| Failure f -> if f = "Type error" then print_endline "DIFFerr1 ok"
				else failwith "DIFFerr1 error"
| _ -> failwith "DIFFerr1 error";;


(*Test sul corretto funzionamento di Prod*)
let prod1 = Prod(ValInt(5), ValInt(3))
in let res = semden(prod1, emptyenv Unbound)
in if res = Dint(15) then print_endline "PROD1 ok"
	else failwith "PROD1 error";;

(*Test eccezioni di Prod*)
let proderr1 = Prod(ValInt(7), ValBool(true))
in try
	ignore(semden(proderr1, emptyenv Unbound));
	failwith "proderr"
with
| Failure f -> if f = "Type error" then print_endline "PRODerr1 ok"
				else failwith "PRODerr1 error"
| _ -> failwith "PRODerr1 error";;


(*Test sul corretto funzionamento di Eq*)
let eq1 = Eq(ValInt(5), ValInt(3))
in let res = semden(eq1, emptyenv Unbound)
in if res = Dbool(false) then print_endline "EQ1 ok"
	else failwith "EQ1 error";;

let eq2 = Eq(ValInt(12), ValInt(12))
in let res = semden(eq2, emptyenv Unbound)
in if res = Dbool(true) then print_endline "EQ2 ok"
	else failwith "EQ2 error";;

(*Test eccezioni di Eq*)
let eqerr1 = Eq(ValInt(7), ValBool(true))
in try
	ignore(semden(eqerr1, emptyenv Unbound));
	failwith "eqerr"
with
| Failure f -> if f = "Type error" then print_endline "EQerr1 ok"
				else failwith "EQerr1 error"
| _ -> failwith "EQerr1 error";;


(*Test sul corretto funzionamento di Leq*)
let leq1 = Leq(ValInt(5), ValInt(3))
in let res = semden(leq1, emptyenv Unbound)
in if res = Dbool(false) then print_endline "LEQ1 ok"
	else failwith "LEQ1 error";;

let leq2 = Leq(ValInt(12), ValInt(12))
in let res = semden(leq2, emptyenv Unbound)
in if res = Dbool(true) then print_endline "LEQ2 ok"
	else failwith "LEQ2 error";;

let leq3 = Leq(ValInt(9), ValInt(12))
in let res = semden(leq3, emptyenv Unbound)
in if res = Dbool(true) then print_endline "LEQ3 ok"
	else failwith "LEQ3 error";;

(*Test eccezioni di Leq*)
let leqerr1 = Eq(ValInt(7), ValBool(true))
in try
	ignore(semden(leqerr1, emptyenv Unbound));
	failwith "leqerr"
with
| Failure f -> if f = "Type error" then print_endline "LEQerr1 ok"
				else failwith "LEQerr1 error"
| _ -> failwith "LEQerr1 error";;


(*Test sul corretto funzionamento di Subseq*)
let l1 = ValIntlist(Nil);;	(* [] *)
let l2 = ValIntlist(Cons(1, Cons(2, Cons(3, Nil))));;	(* [1; 2; 3] *)
let l3 = ValIntlist(Cons(1, Cons(2, Cons(3, Cons(4, Cons(5, Nil))))));;	(* [1; 2; 3; 4; 5] *)
let l4 = ValIntlist(Cons(1, Cons(2, Cons(7, Cons(3, Nil)))));;	(* [1; 2; 7; 3] *)

let subseq1 = Subseq(l1, l2)	(* [] sottolista di [1; 2; 3] : true *)
in let res = semden(subseq1, emptyenv Unbound)
in if res = Dbool(true) then print_endline "SUBSEQ1 ok"
	else failwith "SUBSEQ1 error";;

let subseq2 = Subseq(l2, l1)	(* [1; 2; 3] sottolista di [] : false *)
in let res = semden(subseq2, emptyenv Unbound)
in if res = Dbool(false) then print_endline "SUBSEQ2 ok"
	else failwith "SUBSEQ2 error";;

let subseq3 = Subseq(l2, l3)	(* [1; 2; 3] sottolista [1; 2; 3; 4; 5] : true *)
in let res = semden(subseq3, emptyenv Unbound)
in if res = Dbool(true) then print_endline "SUBSEQ3 ok"
	else failwith "SUBSEQ3 error";;

let subseq4 = Subseq(l2, l4)	(* [1; 2; 3] sottolista [1; 2; 7; 3] : false *)
in let res = semden(subseq4, emptyenv Unbound)
in if res = Dbool(false) then print_endline "SUBSEQ4 ok"
	else failwith "SUBSEQ4 error";;

(*Test eccezioni di Subseq*)
let subseqerr1 = Subseq(l2, ValInt(9))
in try
	ignore(semden(subseqerr1, emptyenv Unbound));
	failwith "subseqerr"
with
| Failure f -> if f = "Type error" then print_endline "SUBSEQerr1 ok"
				else failwith "SUBSEQerr1 err"
| _ -> failwith "SUBSEQerr1 err";;


(*Test sul corretto funzionamento di Eqlist*)
let l5 = ValIntlist(Cons(1, Cons(2, Cons(3, Nil))));;	(* [1; 2; 3] *)

let eqlist1 = Eqlist(l2, l5)	(* [1; 2; 3] uguale a [1; 2; 3] : true *)
in let res = semden(eqlist1, emptyenv Unbound)
in if res = Dbool(true) then print_endline "EQLIST1 ok"
	else failwith "EQLIST1 error";;

let eqlist2 = Eqlist(l1, l5)	(* [] uguale a [1; 2; 3] : false *)
in let res = semden(eqlist2, emptyenv Unbound)
in if res = Dbool(false) then print_endline "EQLIST2 ok"
	else failwith "EQLIST2 error";;

(*Test eccezioni di Eqlist*)
let eqlisterr1 = Eqlist(ValBool(true), l5)
in try
	ignore(semden(eqlisterr1, emptyenv Unbound));
	failwith "eqlisterr"
with
| Failure f -> if f = "Type error" then print_endline "EQLISTerr1 ok"
				else failwith "EQLISTerr1 error"
| _ -> failwith "EQLISTerr1 error";;


(*Test sul corretto funzionamento di Isempty*)
let isempty1 = Isempty(l1)	(* [] vuota : true *)
in let res = semden(isempty1, emptyenv Unbound)
in if res = Dbool(true) then print_endline "ISEMPTY1 ok"
	else failwith "ISEMPTY1 error";;

let isempty2 = Isempty(l2)	(* [1; 2; 3] vuota : false *)
in let res = semden(isempty2, emptyenv Unbound)
in if res = Dbool(false) then print_endline "ISEMPTY2 ok"
	else failwith "ISEMPTY2 error";;

(*Test eccezioni di Isempty*)
let isemptyerr1 = Isempty(ValInt(11))
in try
	ignore(semden(isemptyerr1, emptyenv Unbound));
	failwith "isemptyerr"
with
| Failure f -> if f = "Type error" then print_endline "ISEMPTYerr1 ok"
				else failwith "ISEMPTYerr1 error"
| _ -> failwith "ISEMPTYerr1 error";;


(*Test sul corretto funzionamento di Append*)
let l11 = Cons(1, Cons(2, Cons(3, Nil)));;	(* [1; 2; 3] *)
let l12 = Cons(1, Cons(2, Cons(3, Cons(1, Cons(2, Cons(3, Nil))))));;	(* [1; 2; 3; 1; 2; 3] *)

let append1 = Append(l1, l2)	(* [] @ [1; 2; 3] : [1; 2; 3] *)
in let res = semden(append1, emptyenv Unbound)
in if res = Dintlist(l11) then print_endline "APPEND1 ok"
	else failwith "APPEND1 error";;

let append2 = Append(l2, l1)	(* [1; 2; 3] @ [] : [1; 2; 3] *)
in let res = semden(append2, emptyenv Unbound)
in if res = Dintlist(l11) then print_endline "APPEND2 ok"
	else failwith "APPEND2 error";;

let append3 = Append(l2, l5)	(* [1; 2; 3] @ [1; 2; 3] : [1; 2; 3; 1; 2; 3] *)
in let res = semden(append3, emptyenv Unbound)
in if res = Dintlist(l12) then print_endline "APPEND3 ok"
	else failwith "APPEND3 error";;

(*Test eccezioni di Append*)
let appenderr1 = Append(ValInt(13), l5)
in try
	ignore(semden(appenderr1, emptyenv Unbound));
	failwith "appenderr"
with
| Failure f -> if f = "Type error" then print_endline "APPENDerr1 ok"
				else failwith "APPENDerr1 error"
| _ -> failwith "APPENDerr1 error";;


(*Test sul corretto funzionamento di Ifthenelse*)
let if1 = Ifthenelse(ValBool(true), l1, l2)
in let res = semden(if1, emptyenv Unbound)
in if res = Dintlist(Nil) then print_endline "IFTHENELSE1 ok"
	else failwith "IFTHENELSE1 error";;

let if2 = Ifthenelse(ValBool(false), ValInt(3), ValBool(true))
in let res = semden(if2, emptyenv Unbound)
in if res = Dbool(true) then print_endline "IFTHENELSE2 ok"
	else failwith "IFTHENELSE2 error";;

(*Test eccezioni di Ifthenelse*)
let iferr1 = Ifthenelse(ValInt(1), ValInt(2), ValInt(2))
in try
	ignore(semden(iferr1, emptyenv Unbound));
	failwith "iferr"
with
| Failure f -> if f = "Non boolean guard" then print_endline ("IFTHENELSEerr1 ok")
				else failwith "IFTHENELSEerr1 error"
| _ -> failwith "IFTHENELSEerr1 error";;


(*Test sul corretto funzionamento di Let*)
let let1 = Let("a", ValInt(5), Plus(ValIde("a"), ValInt(2)))
in let res = semden(let1, emptyenv Unbound)
in if res = Dint(7) then print_endline "LET1 ok"
	else failwith "LET1 error";;


(*Test sul corretto funzionamento di Applyfun con scoping statico*)

(* let x = 5
in let func = fun y -> x + y
in let x = 8
in apply(func, x) 

In scoping statico, il risultato è Dint 13
In scoping dinamico, il risultato è Dint 16*)

let fun1 = 
	Let("x", ValInt(5), Let("func", ValFun("y", Plus(ValIde("x"), ValIde("y"))), Let("x", ValInt(8), Applyfun(ValIde("func"), ValIde("x")))))
in let res = semden(fun1, emptyenv Unbound)
in if res = Dint(13) then print_endline "APPLYFUN1 ok"
	else failwith "APPLYFUN1 error";;

(*Test eccezioni di Applyfun*)
let applyerr1 = Applyfun(ValInt(4), ValInt(5))
in try
	ignore(semden(applyerr1, emptyenv Unbound));
	failwith "applyerr"
with
| Failure f -> if f = "Not a function" then print_endline "APPLYFUNerr1 ok"
				else failwith "APPLYFUNerr1 error"
| _ -> failwith "APPLYFUNerr1 error";;


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
in if res = Dintlist(Cons(6, Cons(7, Cons(8, Nil)))) then print_endline "MAP1 ok"
	else failwith "MAP1 error";;

(*Test eccezioni di Map*)
let maperr1 = Map(ValInt(5), l2)
in try
	ignore(semden(maperr1, emptyenv Unbound));
	failwith "maperr"
with
| Failure f -> if f = "Not a function" then print_endline "MAPerr1 ok"
				else failwith "MAPerr1 error"
| _ -> failwith "MAPerr1 error";;

let maperr2 = Map(double, ValInt(2))
in try
	ignore(semden(maperr2, emptyenv Unbound));
	failwith "maperr"
with
| Failure f -> if f = "Type error" then print_endline "MAPerr2 ok"
				else failwith "MAPerr2 error"
| _ -> failwith "MAPerr2 error";;

let bfun = ValFun("formalparam", ValBool(true));;

let maperr3 = Map(bfun, l2)
in try
	ignore(semden(maperr3, emptyenv Unbound));
	failwith "maperr"
with
| Failure f -> if f = "Type error" then print_endline "MAPerr3 ok"
				else failwith "MAPerr3 error"
| _ -> failwith "MAPerr3 error";;
