type pos = {file : string; line : int; column : int}
type region = {left : pos; right : pos}
type 'a phrase = {at : region; it : 'a}

let (@@) x region = {it = x; at = region}
let it phrase = phrase.it
let at phrase = phrase.at


(* Positions and regions *)

let no_pos = {file = ""; line = 0; column = 0}
let no_region = {left = no_pos; right = no_pos}
let all_region file =
  { left = {file; line = 0; column = 0};
    right = {file; line = Int.max_int; column = Int.max_int}
  }

let string_of_pos pos =
  if pos.line = -1 then
    Printf.sprintf "0x%x" pos.column
  else
    string_of_int pos.line ^ "." ^ string_of_int (pos.column + 1)

let string_of_region r =
  r.left.file ^ ":" ^ string_of_pos r.left ^
  (if r.right = r.left then "" else "-" ^ string_of_pos r.right)
