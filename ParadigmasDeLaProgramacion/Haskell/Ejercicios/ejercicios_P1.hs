max2 (x, y) | x >= y = x
            | otherwise = y

substract = flip (-)

evaluarEnCero = \f -> f 0 

dosVeces = \f -> f.f

flipAll = map flip

-- LISTAS POR COMPRENSION -- 
-- EJERCICIO 4 --

pitagoricas :: [(Int, Int, Int)]
pitagoricas = [(a,b,c) | a <- [1..], b <- [1..a], c <- [1..(a+b)], (a*a)+(b*b) == (c*c) ] 

-- EJERCICIO 5 --

cantidadDivisores :: Int -> Int -> Int
cantidadDivisores x 1 = 1   
cantidadDivisores x y = cantidadDivisores x (y-1) + if (mod x y == 0) then 1 else 0

esPrimo :: Int -> Bool
esPrimo x = cantidadDivisores x x == 2 

siguientePrimo :: Int -> Int
siguientePrimo x | esPrimo (x+1) = x+1
                 | otherwise = siguientePrimo (x+1)

iesimoPrimo :: Int -> Int
iesimoPrimo 1 = 2
iesimoPrimo x = siguientePrimo (iesimoPrimo (x-1))

primeros_mil_primos = [iesimoPrimo x | x <- [1..1000]]

-- EJERCICIO 6 --

partir :: [a] -> [([a],[a])]
partir [] = []
partir xs = [(take i xs, drop i xs ) | i <- [0..length xs]]

-- EJERCICIO 7 -- 

listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n = [(x:xs) | x <- [1..n], xs <- listasQueSuman (n-x)]

-- EJERCICIO 8 --

listasEnteros = [listasQueSuman x | x <- [1..]]

-- ESQUEMAS DE RECURSION --              <- recursion estructural (fold) ; recursion primitiva (recr)   <- Para definir esquemas de recursion nuevos, usamos la recursion explicita.
-- EJERCICIO 9 -- 

sum_fr :: [Int] -> Int
sum_fr xs = foldr (+) 0 xs -- head(xs) + sum_fr(tail(xs)) ;; CB: foldr (+) z [] = z

elem_fr :: Eq a => a -> [a] -> Bool
elem_fr e xs = foldr (\x rec_tail -> if (x == e) then True else rec_tail) False xs

-- La funcion que le paso tiene que tomar a la cabeza de la lista y la recursion sobre la cola de la lista. Esto se traduce a: 
-- (\x rec_tail -> if (x == e) then True else rec_tail) head(xs) (foldr (\...) False tail(xs))
--    --> if head(xs) == e then True else foldr(\...) False tail(xs)

append_fr :: [a] -> [a] -> [a]
append_fr xs ys = foldr (\h r_t -> r_t ++ [h]) xs (reverse ys)

filter_fr :: (a -> Bool) -> [a] -> [a]
filter_fr f xs = foldr (\h rt -> if (f h) then h:rt else rt) [] xs
-- Disclaimer: Esta definicion es equivalente pero devuelve una funcion ([a]->[a]); filter_fr f = foldr (\h rt -> if (f h) then h:rt else rt) []. 


map_fr :: (a -> b) -> [a] -> [b]
map_fr f xs = foldr (\h rt -> ((f h):rt)) [] xs 

-- b)
-- foldr1 toma como caso base al ultimo elemento de la lista.
 
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f xs = foldr1 (\h rt -> if (f h rt) then h else rt) xs

sumasParciales_fr :: Num a => [a] -> [a]
sumasParciales_fr (x:xs) = foldl (\rt h  -> rt ++ [h + last(rt)]) [x] xs    

sumaAlt :: Num a => [a] -> a
sumaAlt xs = foldr (\h rec_tail -> h - rec_tail) 0 xs


sumaAltInv :: Num a => [a] -> a
sumaAltInv xs = foldl (\rec_tail h -> h - rec_tail) 0 xs


-- falta permutaciones, doble foldr?


-- EJERCICIO 10

partes :: [a] -> [[a]]               
partes xs = foldr (\h rect -> rect ++ map ([h]++) rect) [[]] xs

prefijos :: [a] -> [[a]]
prefijos xs = foldr (\h rect -> [[]] ++ (map ([h]++) rect) )  [[]] xs


sublistas :: [a] -> [[a]]
sublistas xs = drop 1 (prefijos(xs) ++ foldl (\rect h -> [[]] ++ (map (++[h]) rect) )  [[]] (tail(xs)))    -- PREGUNTAR

--sublistas :: [a] -> [[a]]
--sublistas [] = [[]]
--sublistas (x:xs) =  ++ sublistas(xs)


-- EJERCICIO 11 

--elementosEnPosicionesPares :: [a] -> [a]
--elementosEnPosicionesPares [] = []
--elementosEnPosicionesPares (x:xs) = if null xs then [x] else x:elementosEnPosicionesPares (tail xs)           NO SE AJUSTA AL ESQUEMA DE RECURSION ESTRUCTURAL

--elementosEnPosicionesPares :: [a] -> [a]
--elementosEnPosicionesPares = foldr (\h rect -> \xs -> if null(tail(xs)) then [head(xs)] else (head(xs)):(rect (tail xs))) [] <- h y rect ya soon parte del xs esperado, esto no funca.

entrelazar :: [a] -> [a] -> [a]
entrelazar xs = foldr (\h rect -> \ys -> if null ys then h:(rect []) else h:(head ys):(rect(tail ys))) id xs

-- EJERCICIO 12
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x:xs) = f x xs (recr f z xs) 

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e xs = recr (\h ls rect -> if (h == e) then ls else h:rect) [] xs

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e xs = recr (\h hs rect -> if h >= e then (e:h:hs) else h:rect) [e] xs


--listasQueSuman_rec :: Int -> [[Int]]
--listasQueSuman_rec = recr (\h hs rect -> \n -> [(x:xs) | x <- [1..n], xs <- rect (n-x)]) [[]] 

-- EJERCICIO 13
 
type DivideConquer a b = (a -> Bool)   -- determina si es o no el caso trivial             <- a y b son variables de tipo!
                         -> (a -> b)   -- resuelve el caso trivial
                         -> (a -> [a]) -- parte el problema en subproblemas
                         -> ([b] -> b) -- combina resultados 
                         -> a          -- estructura de entrada
                         -> b          -- resultado

dc :: DivideConquer a b
dc trivial solve split combine x = if (trivial x) then solve x else combine (map (dc trivial solve split combine) (split x))    




singleton_or_null :: [a] -> Bool
singleton_or_null xs = (length xs == 1) || null xs        -- si es solo singleton se rompe si llamas mergeSort [] y si es solo null, los singletons se splitean indefinidamente.

split_mergeSort :: [a] -> [[a]]
split_mergeSort xs =  [take ( div (length xs) 2) xs , drop (div (length xs) 2) xs]

--merge :: Ord a => [a] -> [a] -> [a]        -- como hacer sin recursion explicita?
--merge xs [] = xs
--merge [] ys = ys
--merge (x:xs) (y:ys) = if x <= y then x:(merge xs (y:ys)) else y:(merge (x:xs) (ys))

--merge :: Ord a => [a] -> [a] -> [a]
--merge [] = (\ys -> ys)
--merge (x:xs) = (\ys -> (fst (break (>x) ys)) ++ x:(merge2 xs (drop (length(fst (break (>x) ys))) ys))) 


merge :: Ord a => [a] -> [a] -> [a]
merge xs = foldr (\h rect -> \ys -> (fst (span (<h) ys)) ++ h:(rect (dropWhile (<h) ys))) id xs 

combine_mergeSort :: Ord b => [[b]] -> [b]   -- acá a va a ser una lista. [[a]] -> [a] , tiene que mergear dos listas
combine_mergeSort xs = merge (head xs) (last xs)

mergeSort :: Ord a => [a] -> [a]
mergeSort xs = dc singleton_or_null id split_mergeSort combine_mergeSort xs        

split_dc :: [a] -> [[a]]
split_dc xs = init (foldr (\h rect -> [h]:rect) [[]] xs)

map_dc :: (a -> b) -> [a] -> [b]
map_dc f xs = dc singleton_or_null (\[x] -> [f x] ) split_dc concat xs

filter_dc :: (a -> Bool) -> [a] -> [a]
filter_dc p xs = dc singleton_or_null (\[x] -> if p x then [x] else []) split_dc concat xs

-- EJERCICIO 14

--composicion :: a -> (a -> a) -> Integer -> a
--composicion e f n = 

--genLista :: a -> (a -> a) -> Integer -> [a]
--genLista e f n = []
 
-- EJERCICIO 15

mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f xs = foldr (\h rect -> (uncurry f h) : rect) [] xs     -- Si la funcion es (\h rect -> rect ++ [(uncurry f h)]) entonces evalua rect primero infinitamente. 


armarPares :: [a] -> [a] -> [(a,a)] 
armarPares xs = foldr (\h rect -> \ys -> if null ys then [] else [(h,head(ys))] ++ (rect (tail ys))) (\_ -> []) xs -- <- si pongo rect primero no funca
-- hay que hacer recursion sobre ambas estructuras a la vez, para eso tomo un parametro. Si tuviera que ir haciendo recursion de forma intercalada no podria hacer esto
-- puedo hacer esto solo si estoy si o si haciendo recursion sobre una de las estructuras constantemente (xs), en este caso hago recursion con las dos a la vez (xs y ys) (armarPares)

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs = foldr (\h rect -> \ys -> [f h (head ys)] ++ (rect (tail ys))) (\_ -> []) xs

--  EJERCICIO 16

sumaMat ::[[Int]] -> [[Int]] -> [[Int]]
sumaMat xs = foldr (\h rect -> \ys -> (mapDoble (+) h (head ys)):(rect (tail ys))) (\_ -> [[]]) xs



-- EJERCICIO 17

generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []

generateFrom :: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom stop next xs | stop xs = init xs
                          | otherwise = generateFrom stop next (xs ++ [next xs])

generateBase :: ([a] -> Bool) -> a -> (a -> a) -> [a]
generateBase stop base next_last = generateFrom stop (\xs -> next_last (last xs)) [base] 

factoriales :: Int -> [Int]
factoriales n = generate (\xs -> length xs == (n + 1)) (\xs -> if null xs then 1 else last(xs) * (length xs + 1))

iterateN :: Int -> (a -> a) -> a -> [a]
iterateN n f x = generateBase (\xs -> length xs == n + 1) x f

--generateFrom_2 :: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
--generateFrom_2 stop next xs = xs ++ (takeWhile (stop) (iterate (next) (last xs)))

-- OTRAS ESTRUCTURAS DE DATOS --

-- EJERCICIO 18

-- la idea del foldNat esq generalice el siguiente esquema:
-- g 0 = z
-- g n = f (g n-1) -----_> foldNat z f 

foldNat :: (Integer -> Integer) -> Integer -> Integer-> Integer
foldNat f z 0 = z
foldNat f z n = f (foldNat f z (n-1)) 

potencia :: Integer -> Integer -> Integer
potencia b e = foldNat (*b) 1 (e)


-- EJERCICIO 19

data Polinomio a = X
                 | Cte a
                 | Suma (Polinomio a) (Polinomio a)
                 | Prod (Polinomio a) (Polinomio a)

-- defino el esquema de recursion estructural i.e fold sobre polinomios
 
--          |funcion a aplicar por cada forma del polinomio posible (todas devuelven el tipo del resultado| polinomio entrada -> resultado
foldPoli :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b 
foldPoli casoX casoCte casoSuma casoProd p = case p of X -> casoX                 -- si p = X -> foldPoli p = casoBase
                                                       Cte c ->  casoCte c        -- si p = Cte c -> foldPoli p = f c donde f = casoCte
                                                       Suma r s -> casoSuma (foldPoli casoX casoCte casoSuma casoProd r) (foldPoli casoX casoCte casoSuma casoProd s) -- p = r + s --> foldPoli p = f (fold r) (fold s) donde f es casoSUma
                                                       Prod r s -> casoProd (foldPoli casoX casoCte casoSuma casoProd r) (foldPoli casoX casoCte casoSuma casoProd s)

-- el fold de listas tiene el tipo de la misma forma: (a -> b -> b) -> b -> a -> b
--                                     |funcion para el caso (x:xs)| -> |funcion para el caso base (lista vacia)| -> lista -> resultado

evaluar :: Num a => a -> Polinomio a -> a
evaluar x p = foldPoli (x) (id) (+) (*) p

-- EJERCICIO 20

type Conj a = (a -> Bool)   -- c e devuelve True sii e pertenece a c

vacio :: Conj a
vacio = (\_ -> False)

agregar :: Eq a => a -> Conj a -> Conj a
agregar a c = (\e -> (a == e) || c e )

interseccion :: Conj a -> Conj a -> Conj a
interseccion a b = (\e -> a e && b e)

union :: Conj a -> Conj a -> Conj a
union a b = (\e -> a e || b e)

cero_pto_fijo :: Conj (Integer -> Integer)
cero_pto_fijo = (\f -> f 0 == 0)

-- EJERCICIO 22

data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB casoNil casoBin ab = case ab of Nil -> casoNil
                                       Bin izq raiz der -> casoBin (foldAB casoNil casoBin izq) raiz (foldAB casoNil casoBin der)

esNil :: AB a -> Bool
esNil ab = foldAB (True) (\_ _ _-> False) ab

cantNodos :: AB a -> Integer
cantNodos ab = foldAB (0) (\fi r fd -> fi + fd +1) ab

mejorSegunAB :: Num a => (a -> a -> Bool) -> AB a -> a  -- f a b = True sii a es mejor que b ; pedi que a sea Num, sino no se como definir el minimo para los Nil para cualquier tipo 
mejorSegunAB f ab = foldAB (0) (\fi r fd -> if (f r fi) && (f r fd) then r else (if (f r fi) then fd else (if (f r fd) then fi else (if (f fi fd) then fi else fd)))) ab
-- PREGUNTAR

--esABB_aux :: Ord a => AB a -> (Bool,a)
--esABB_aux ab = foldAB ((False,0)) (\fi r fd -> (fi && fd && (snd fi) < r && (snd fd) < r , r)) ab