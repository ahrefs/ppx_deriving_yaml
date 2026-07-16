type var = Hello | World of string [@@deriving yamlx]
type poly_var = [ `Hello | `World of string ] [@@deriving yamlx]
type a = { x : [ `Simple | `Example ] } [@@deriving yamlx]
type t = { name : string; age : int option } [@@deriving yamlx]
type u = { name : string [@default "Una"] } [@@deriving to_yamlx]
type v = { age : int [@key "AGE"] [@default 10] } [@@deriving of_yamlx]

type w = {
  age : int;
      [@to_yamlx fun i -> YAMLx.Float (YAMLx.zero_loc, float_of_int (i - 10))]
}
[@@deriving yamlx]

type x = {
  age : int;
      [@of_yamlx
        function
        | YAMLx.Float (_, f) -> Ok (int_of_float (f +. 10.))
        | _ -> Error (`Msg "Expected a YAMLx.Float")]
}
[@@deriving yamlx]
