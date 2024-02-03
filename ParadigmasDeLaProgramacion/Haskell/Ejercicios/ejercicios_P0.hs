-- [PRACTICA 0] --


-- EJERCICIO 2 --
valorAbsoluto :: Float -> Float
valorAbsoluto x | x > 0 = x
                | otherwise = (-x)

bisiesto :: Int -> Bool
bisiesto x = mod x 4 == 0

factorial :: Int -> Int
factorial 0 = 1
factorial x = x * factorial(x - 1)


cantidadDivisores :: Int -> Int -> Int
cantidadDivisores x 1 = 1   
cantidadDivisores x y = cantidadDivisores x (y-1) + if (mod x y == 0) then 1 else 0

esPrimo :: Int -> Bool
esPrimo x = cantidadDivisores x x == 2 

cantidadDivisoresPrimos_aux :: Int -> Int -> Int
cantidadDivisoresPrimos_aux _ 1 = 0
cantidadDivisoresPrimos_aux x y = cantidadDivisoresPrimos_aux x (y-1) + if (mod x y == 0 && esPrimo(y)) then 1 else 0

cantidadDivisoresPrimos :: Int -> Int
cantidadDivisoresPrimos x = cantidadDivisoresPrimos_aux x x

-- EJERCICIO 3 --
-- El preludio cuenta con: 
-- data Maybe a = Nothing | Just a          <- This syntax reads as "Create a new type constructor called Maybe which accepts one type parameter. It has two value constructors: Just which takes a single argument of type a, or Nothing."
-- data Either a b = Left a | Right b

inverso :: Float -> Maybe Float -- dado un numero devuelve su inverso multiplicativo si esta definido, o Nothing en caso contrario.
inverso 0 = Nothing             -- Nothing permite expresar sin un error/excepcion la ausencia de un valor.
inverso x = Just (1.0/x)        -- Para deshacerse del printeo de just hay que wrapear print

aEntero :: Either Int Bool -> Int   -- <- aEntero (Left 3) = 3 y aEntero (Right False) = 0. Le tenes que pasar algo Either, no un Int o un Bool nomas.
aEntero (Left a) = a
aEntero (Right b) = if b then 1 else 0        

-- EJERCICIO 4 --

limpiar :: String -> String -> String 
limpiar xs [] = []
limpiar xs (y:ys) = if elem y xs then limpiar xs ys else y : limpiar xs ys

difPromedio :: [Float] -> [Float]
difPromedio xs = map (\x-> x - ((foldl (+) 0 xs ) / fromIntegral(length xs))) xs

todosIguales :: [Int] -> Bool
todosIguales [x] = True
todosIguales (x:xs) = x == head xs && todosIguales xs

-- EJERCICIO 5 -- 
data AB a = Nil | Bin (AB a) a (AB a)

vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB _ = False

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin izq e der) = Bin (negacionAB(izq)) (not e) (negacionAB(der))


productoAB :: AB Int -> Int
productoAB Nil = 1  
productoAB (Bin izq e der) = e * productoAB(izq) * productoAB(der)


-- Uso printAB para poder printear arboles y chequear que esten bien las funciones.

printAB :: AB a -> [ Maybe a]
printAB Nil = [Nothing]
printAB (Bin izq e der) = Just e : (printAB(izq) ++ printAB(der))



