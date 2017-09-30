(* author: Alessandra Fais*)

(*Ambiente*)
type 'a env = (string * 'a) list

let emptyenv (el:'a) = [("", el)]
let rec lookup ((e:'a env), (ide:string)) =
	match e with
	| [] -> failwith("Wrong env")
	| ("", el)::[] -> el
	| (i1, e1)::es -> if(i1=ide) then e1 else lookup(es, ide)
let bind ((e:'a env), (ide:string), (el:'a)) = (ide, el)::e
let rec bindlist ((e:'a env), (idelist:string list), (ellist:'a list)) =
	match (idelist, ellist) with
	| ([], []) -> e
	| (i::is, el::els) -> bindlist(bind(e, i, el), is, els)
	| _ -> failwith("Wrong bindlist")


(*Sintassi astratta*)

(*Identificatori*)
type ide = string

(*Interi*)
type intlist =
	| Nil
	| Cons of int * intlist

(*Espressioni*)

(*Si è scelto di non implementare i valori come tipo separato per
  evitare di rendere l'input troppo verboso
  (es. ValInt(5) invece di Val(Int (5)))*)

type expr =
	| ValIde of ide
	| ValInt of int
	| ValBool of bool
	| ValIntlist of intlist
	| ValFun of ide * expr
	| And of expr * expr
	| Or of expr * expr
	| Not of expr
	| Plus of expr * expr
	| Diff of expr * expr
	| Prod of expr * expr
	| Eq of expr * expr
	| Leq of expr * expr
	| Subseq of expr * expr
	| Eqlist of expr * expr
	| Isempty of expr
	| Append of expr * expr
	| Ifthenelse of expr * expr * expr
	| Let of ide * expr * expr
	| Applyfun of expr * expr
	| Map of expr * expr


(*Domini semantici*)

(*Valori esprimibili*)
type eval =
	| Eint of int
	| Ebool of bool
	| Eintlist of intlist
	| Unknown

(*Valori denotabili*)
type dval =
	| Dint of int
	| Dbool of bool
	| Dintlist of intlist
	| Dfun of ide * expr * dval env
	| Unbound

(*Casting*)
let dvaltoeval (d:dval) =
	match d with
	| Dint(n) -> Eint(n)
	| Dbool(b) -> Ebool(b)
	| Dintlist(l) -> Eintlist(l)
	| Dfun(_, _, _) -> failwith("Not an expressible value")
	| Unbound -> Unknown

let evaltodval (e:eval) =
	match e with
	| Eint(n) -> Dint(n)
	| Ebool(b) -> Dbool(b)
	| Eintlist(l) -> Dintlist(l)
	| Unknown -> Unbound


(*Interprete*)

(*Funzioni ausiliarie*)

let et ((e1:eval), (e2:eval)) =
	match (e1, e2) with
	| (Ebool(a), Ebool(b)) -> Ebool(a && b)
	| (_, _) -> failwith("Type error")

let vel ((e1:eval), (e2:eval)) =
	match (e1, e2) with
	| (Ebool(a), Ebool(b)) -> Ebool(a || b)
	| (_, _) -> failwith("Type error")

let non (e:eval) =
	match e with
	| Ebool(b) -> Ebool(not b)
	| _ -> failwith("Type error")

let sum ((e1:eval), (e2:eval)) =
	match (e1, e2) with
	| (Eint(a), Eint(b)) -> Eint(a + b)
	| (_, _) -> failwith("Type error")

let dif ((e1:eval), (e2:eval)) =
	match (e1, e2) with
	| (Eint(a), Eint(b)) -> Eint(a - b)
	| (_, _) -> failwith("Type error")

let per ((e1:eval), (e2:eval)) =
	match (e1, e2) with
	| (Eint(a), Eint(b)) -> Eint(a * b)
	| (_, _) -> failwith("Type error")

let ug ((e1:eval), (e2:eval)) =
	match (e1, e2) with
	| (Eint(a), Eint(b)) -> Ebool(a = b)
	| (_, _) -> failwith("Type error")

let minug ((e1:eval), (e2:eval)) =
	match (e1, e2) with
	| (Eint(a), Eint(b)) -> Ebool(a <= b)
	| (_, _) -> failwith("Type error")

let rec sublist ((e1:eval), (e2:eval)) =
	match (e1, e2) with
	| (Eintlist(a), Eintlist(b)) ->
		begin match (a, b) with
		| (Nil, _) -> Ebool(true)
		| (a, Nil) -> Ebool(false)
		| (Cons(x, xs), Cons(y, ys)) -> if(x=y) then sublist(Eintlist(xs), Eintlist(ys)) else Ebool(false)
		end
	| (_, _) -> failwith("Type error")

let rec eqlst ((e1:eval), (e2:eval)) =
	match (e1, e2) with
	| (Eintlist(a), Eintlist(b)) ->
		begin match (a, b) with
		| (Nil, Nil) -> Ebool(true)
		| (a, Nil) -> Ebool(false)
		| (Nil, b) -> Ebool(false)
		| (Cons(x, xs), Cons(y, ys)) -> if(x=y) then eqlst(Eintlist(xs), Eintlist(ys)) else Ebool(false)
		end
	| (_, _) -> failwith("Type error")

let emptylst (e1:eval) =
	match e1 with
	| Eintlist(Nil) -> Ebool(true)
	| Eintlist(_) -> Ebool(false)
	| _ -> failwith("Type error")

let app ((e1:eval), (e2:eval)) =
	let rec app1 ((l1:intlist), (l2:intlist)) =
		begin match (l1, l2) with
		| (l1, Nil) -> l1
		| (Nil, l2) -> l2
		| (Cons(x, xs), Cons(y, ys)) -> Cons(x, (app1(xs, l2)))
		end
	in begin match (e1, e2) with
	| (Eintlist(a), Eintlist(b)) -> Eintlist(app1(a, b))
	| (_, _) -> failwith("Type error")
	end

let rec sem ((e:expr), (env:dval env)) =
	match e with
	| ValIde(i) -> dvaltoeval(lookup(env, i))
	| ValInt(n) -> Eint(n)
	| ValBool(b) -> Ebool(b)
	| ValIntlist(l) -> Eintlist(l)
	| And(e1, e2) -> et(sem(e1, env), sem(e2, env))
	| Or(e1, e2) -> vel(sem(e1,env), sem(e2, env))
	| Not(e1) -> non(sem(e1, env))
	| Plus(e1, e2) -> sum(sem(e1, env), sem(e2, env))
	| Diff(e1, e2) -> dif(sem(e1, env), sem(e2, env))
	| Prod(e1, e2) -> per(sem(e1, env), sem(e2, env))
	| Eq(e1, e2) -> ug(sem(e1, env), sem(e2, env))
	| Leq(e1, e2) -> minug(sem(e1, env), sem(e2, env))
	| Subseq(e1, e2) -> sublist(sem(e1, env), sem(e2, env))
	| Eqlist(e1, e2) -> eqlst(sem(e1, env), sem(e2, env))
	| Isempty(e1) -> emptylst(sem(e1, env))
	| Append(e1, e2) -> app(sem(e1, env), sem(e2, env))
	| Ifthenelse(b, e1, e2) ->
		begin match sem(b, env) with
		| Ebool(true) -> sem(e1, env)
		| Ebool(false) -> sem(e2, env)
		| _ -> failwith("Non boolean guard")
		end
	| Let(i, e1, e2) ->
		let v1 = semden(e1, env)
		in let env1 = bind(env, i, v1)
		in sem(e2, env1)
	| Applyfun(e1, e2) -> 
		begin match semden(e1, env) with
		| Dfun(param, body, env1) ->
			let env2 = bind(env1, param, evaltodval(sem(e2, env)))
			in sem(body, env2) 
		| _ -> failwith("Not a function")
		end
	| Map(e1, e2) ->
		begin match semden(e1, env) with
		| Dfun(param, body, env1) ->
			begin match sem(e2, env) with
			| Eintlist(l) ->
				let rec mapl (lis:intlist) =
					begin match lis with
					| Nil -> Nil
					| Cons(x, xs) ->
						let env2 = bind(env1, param, Dint(x))
						in let v2 = sem(body, env2)
						in begin match v2 with
						| Eint(n) -> Cons(n, mapl(xs))
						| _ -> failwith("Type error")
						end
					end
				in Eintlist(mapl(l))
			| _ -> failwith("Type error")
			end
		| _ -> failwith("Not a function")
		end
	| _ -> failwith("Not a valid expression")

and semden ((e:expr), (env:dval env)) =
	match e with
	| ValIde(i) -> lookup(env, i)
	| ValFun(i, e1) -> Dfun(i, e1, env)
	| _ -> evaltodval(sem(e, env))