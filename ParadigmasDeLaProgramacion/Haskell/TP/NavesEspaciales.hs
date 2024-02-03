module NavesEspaciales (Componente(Contenedor, Motor, Escudo, Cañón), NaveEspacial(Módulo, Base), Dirección(Babor, Estribor), TipoPeligro(Pequeño, Grande, Torpedo), Peligro, foldNave, capacidad, poderDeAtaque, puedeVolar, mismoPotencial, mayorCapacidad, transformar, impactar, maniobrar, pruebaDeFuego, componentesPorNivel, dimensiones) where

data Componente = Contenedor | Motor | Escudo | Cañón deriving (Eq, Show)

data NaveEspacial = Módulo Componente NaveEspacial NaveEspacial | Base Componente deriving Eq

data Dirección = Babor | Estribor deriving Eq

data TipoPeligro = Pequeño | Grande | Torpedo deriving Eq

type Peligro = (Dirección, Int, TipoPeligro)

instance Show NaveEspacial where
  show = ("\n" ++) . (padNave 0 0 False)
  
padNave nivel acum doPad (Base c) = (if doPad then pad (4*nivel + acum) else "") ++ show c
padNave nivel acum doPad (Módulo x i d) = (if doPad then pad (4*nivel + acum) else "") ++ show x ++ 
                          pad 4 ++ padNave (nivel+1) (acum+l) False i ++ "\n" ++
                          padNave (nivel+1) (acum+l) True d where l = length $ show x

pad :: Int -> String
pad i = replicate i ' '

-- Naves para testear
contenedorSolo = Base Contenedor
nave1 = Base Motor
nave2 = Módulo Cañón (Base Escudo) (Base Motor)
nave3 = Módulo Motor (Base Escudo) (Base Cañón)
nave4 = Módulo Contenedor nave2 nave3
nave5 = Módulo Contenedor nave3 nave2
nave6 = Módulo Contenedor nave4 nave1
nave7 = Módulo Contenedor nave1 nave5
nave8 = Módulo Contenedor nave1 nave6
nave9 = Módulo Escudo 
        (Módulo Escudo (Módulo Escudo (Base Escudo) (Base Cañón)) (Módulo Motor (Base Contenedor) (Base Motor))) 
        (Módulo Escudo (Módulo Contenedor (Base Motor) (Base Contenedor)) (Módulo Escudo (Base Cañón) (Base Escudo)))

nave10 = Módulo Escudo 
        (Módulo Escudo (Módulo Escudo (Base Escudo) (Base Cañón)) (Módulo Motor (Base Contenedor) (Base Motor))) 
        (Módulo Escudo (Módulo Contenedor (Base Motor) (Base Contenedor)) (Módulo Escudo (Base Cañón) (Módulo Escudo (Base Cañón) (Base Contenedor))))

soloUnMotor = Base Motor
puroContenedor = Módulo Contenedor (Base Contenedor) (Base Contenedor)
tresCañones = Módulo Cañón (Base Cañón) (Base Cañón)

contenedorYCañon = Módulo Contenedor (Base Cañón) (Base Contenedor)
otroCañon = Módulo Contenedor (Base Contenedor) (Base Cañón)

escudoSinCañon = Módulo Escudo (Base Contenedor) (Base Contenedor)

protegido = Módulo Escudo (Base Contenedor) (Base Cañón)
protegidoNivel1Estribor = Módulo Contenedor soloUnMotor protegido

superProtegido = Módulo Motor protegido protegido

desbalanceado = Módulo Escudo (Base Contenedor) protegido



--Ejercicio 1
foldNave :: (Componente -> a -> a -> a) -> (Componente -> a) -> NaveEspacial -> a
foldNave fModulo fBase (Base comp) = fBase comp
foldNave fModulo fBase (Módulo  comp subNave1 subNave2) = fModulo comp (rec subNave1) (rec subNave2)
                                                        where rec = foldNave fModulo fBase

--Ejercicio 2

cantidadComponente :: Componente -> NaveEspacial -> Int
cantidadComponente comp  = foldNave (\c rec1 rec2 -> rec1 + rec2 + (soyComponente c))  (\c -> soyComponente c) 
            where soyComponente  d = (if d == comp then 1 else 0)

capacidad :: NaveEspacial -> Int
capacidad = cantidadComponente Contenedor

poderDeAtaque :: NaveEspacial -> Int
poderDeAtaque = cantidadComponente Cañón

puedeVolar :: NaveEspacial -> Bool
puedeVolar = (\n -> 0 < cantidadComponente Motor n)


mismoPotencial :: NaveEspacial -> NaveEspacial -> Bool
mismoPotencial nave1 nave2 = (igualCantidadDe Cañón) && (igualCantidadDe Contenedor) && (igualCantidadDe Motor) && (igualCantidadDe Escudo)
    where igualCantidadDe comp = cantidadComponente comp nave1 == cantidadComponente comp nave2

--Ejercicio 3

mayorCapacidad :: [NaveEspacial] -> NaveEspacial

mejorSegun p = foldr1 (\x rec -> if p x rec then x else rec)
mayorCapacidad = mejorSegun (\nave1 nave2 -> capacidad nave1 > (capacidad nave2))

--Ejercicio 4

transformar :: (Componente -> Componente) -> NaveEspacial -> NaveEspacial
transformar f = foldNave (\comp rec1 rec2 -> (Módulo (f comp) rec1 rec2)) (\comp -> Base (f comp))

-- Ejercicio 5
impactar :: Peligro -> NaveEspacial -> NaveEspacial
impactar (_, 0, Torpedo) n = Base Contenedor
impactar (_, 0, Pequeño) (Base Escudo) = (Base Escudo)
impactar (_, 0, Pequeño) (Base _) = Base Contenedor
impactar (_, 0, Pequeño) (Módulo Escudo n1 n2) =  (Módulo Escudo n1 n2)
impactar (_, 0, Pequeño) (Módulo c n1 n2) =  Base Contenedor
impactar (d, 0, Grande ) n =  if poderDeAtaque n > 0 then impactar (d,0,Pequeño) n else Base Contenedor
impactar (d,n,peligro) (Módulo c n1 n2) = if d == Babor then  (Módulo c (impactar (d,n-1,peligro) n1) n2) 
                                                        else  (Módulo c n1 (impactar (d,n-1,peligro) n2))
impactar (d,n,peligro) (Base c) = Base c    -- apuntaron a un nivel mayor a la altura


f P1 Q1 = ...
f P2 Q2 = ...

f x y = case (x, y) of
	      (P1, Q1) -> ...
		  (P2, Q2) -> ...



-- No es adecuado usar foldNave porque hace recursión obligadamente sobre ambas ramas de la estructura. Como lo que queremos hacer con impactar
-- es hacer la recursión sólo sobre una de las ramas e ignorar la otra (manteniendola intacta). Entonces si usamos foldNave vamos a tener que computar
-- partes de la estructura que no nos sirven. Ademas, tampoco conocemos la estructura original por lo que no podemos mantener intacta la rama a ignorar

-- Adicionalmente, al ejecutar la recursion sobre las subnaves, se mantienen los cambios sobre las mismas y el llamado principal devuelve la nave 
-- con las subnaves modificadas, cuando deberia modifiacar una sola subnave dependiendo de la direccion del peligro.
-- Esto se solucionaria guardando la subanve original en cada llamado recursivo, pero no es posible con fold. 
-- O incluir esa información en parámetros adicionales

-- Ejercicio 6
maniobrar :: NaveEspacial -> [Peligro] -> NaveEspacial
maniobrar n = foldl (\rec1 p -> impactar p rec1) n    

-- Ejercicio 7
pruebaDeFuego :: [Peligro] -> [NaveEspacial] -> [NaveEspacial]
pruebaDeFuego p ns = filter (\x -> puedeVolar (maniobrar x p)) ns

-- Ejercicio 8
--componentesPorNivel :: NaveEspacial -> Int -> Int
--componentesPorNivel (Base c) a = if a == 0 then 1 else 0
--componentesPorNivel (Módulo c n1 n2) a = if a == 0 then 1 else componentesPorNivel n1 (a-1) + componentesPorNivel n2 (a-1)

componentesPorNivel :: NaveEspacial -> Int -> Int
componentesPorNivel  = foldNave (\c rec1 rec2 -> \a -> if (a == 0) then 1 else rec1 (a-1) + rec2 (a-1)) (\c -> \a -> if (a == 0) then 1 else 0) 


largo :: NaveEspacial -> Int
largo = foldNave (\c rec1 rec2 -> 1 + max rec1 rec2) (const 1)

ancho :: NaveEspacial -> Int
ancho n = maximum [componentesPorNivel n a | a <- [0.. largo n - 1]]

dimensiones :: NaveEspacial -> (Int, Int)
dimensiones = \n -> (largo n, ancho n)
