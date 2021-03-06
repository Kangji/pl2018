type formula = TRUE
             | FALSE
             | NOT of formula
             | ANDALSO of formula * formula
             | ORELSE of formula * formula
             | IMPLY of formula * formula
             | LESS of expr * expr
and expr = NUM of int
         | PLUS of expr * expr
         | MINUS of expr * expr

let rec eval : formula -> bool = fun form ->
  let rec calc : expr -> int = fun exp ->
    (
	 match exp with
     | NUM i1 -> i1
     | PLUS (i1, i2) -> (calc i1) + (calc i2)
     | MINUS (i1, i2) -> (calc i1) - (calc i2)
	)
  in
  match form with
  | TRUE -> true
  | FALSE -> false
  | NOT f1 -> not(eval f1)
  | ANDALSO (f1, f2) -> (eval f1) && (eval f2)
  | ORELSE (f1, f2) -> (eval f1) || (eval f2)
  | IMPLY (f1, f2) -> not (eval f1) || (eval f2)
  | LESS (e1, e2) -> (calc e1) < (calc e2)
