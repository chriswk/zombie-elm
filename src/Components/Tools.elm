module Components.Tools where

import List
import Random


partition2 : Int -> List a -> List (List a)
partition2 n list =
  let
    part = (List.take n list)
  in
    if n == (List.length part) then
      [part] ++ (partition2 n (List.drop n list))
    else
      [part]
