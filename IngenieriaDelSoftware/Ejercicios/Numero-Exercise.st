!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:

	a/b + c/d = (a.d + c.b) / (b.d)

	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:

	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:

	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly

	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |

	sixFifth := (Entero with: 6) / (Entero with: 5).

	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |

	threeHalfs := (Entero with: 3) / (Entero with: 2).

	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |

	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three.
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.

	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated

	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription

	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 15:58:09'!
* aMultiplier

	^ aMultiplier  multiplicateAEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 15:51:44'!
+ anAdder
	
	^anAdder sumateAEntero: self.
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/13/2023 23:28:31'!
- aSubtrahend
"	Metodo con menos codigo:
	^aSubtrahend * -1 + self
"
	^ aSubtrahend restateAEntero: self
"
	(aSubtrahend isKindOf: Entero) ifTrue: [^self class with: value - aSubtrahend integerValue].
	(aSubtrahend isKindOf: Fraccion) ifTrue: [^Fraccion with: (self  * aSubtrahend denominator  - aSubtrahend numerator) over: 	(aSubtrahend denominator )].
"! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 20:57:46'!
/ aDivisor
	^aDivisor dividiteAEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/13/2023 23:28:46'!
// aDivisor

	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 20:55:22'!
dividiteAEntero: enteroADividir

	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:33:14'!
dividiteAFraccion: fraccionADividir
	^Fraccion with:  fraccionADividir numerator over: (fraccionADividir denominator * self)
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 17:41:09'!
fibonacci

	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/13/2023 23:29:11'!
greatestCommonDivisorWith: anEntero

	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/13/2023 23:29:19'!
multiplicateAEntero: primerEnteroAMultiplicar
	^self class with: (value * primerEnteroAMultiplicar integerValue)
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:11:51'!
multiplicateAFraccion: primerFraccionAMultiplicar
	^(primerFraccionAMultiplicar numerator * self) / (primerFraccionAMultiplicar denominator)
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/13/2023 23:29:29'!
restateAEntero: primerRestandoEntero

	^self class with: primerRestandoEntero integerValue - value
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 17:00:46'!
restateAFraccion: primerRestandoFraccion

	^Fraccion with: (primerRestandoFraccion numerator - (self * primerRestandoFraccion denominator)) over: primerRestandoFraccion denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'psm 9/13/2023 23:29:38'!
sumateAEntero: primerSumandoEntero

	^ self class with: (value + primerSumandoEntero integerValue).
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:14:14'!
sumateAFraccion: primerSumandoFraccion
	^Fraccion with: ((self * primerSumandoFraccion denominator) + primerSumandoFraccion numerator) over: primerSumandoFraccion denominator! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'psm 9/13/2023 23:27:18'!
initalizeWith: aValue

	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"

	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative

	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne

	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero

	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'psm 9/13/2023 23:26:31'!
initalizeSubClasifiedWith: aValue

	(aValue < 0) ifTrue: [^EnteroNegativo new initalizeWith: aValue].
	(aValue = 1) ifTrue: [^EnteroUnidad new initalizeWith: aValue].
	(aValue = 0) ifTrue: [^EnteroNulo new initalizeWith: aValue].
	(aValue > 1) ifTrue: [^EnteroPositivo new initalizeWith: aValue]! !

!Entero class methodsFor: 'instance creation' stamp: 'psm 9/12/2023 18:17:13'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'psm 9/13/2023 23:26:41'!
with: aValue

	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].

	^self initalizeSubClasifiedWith: aValue! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!


!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 20:59:11'!
dividiteAEntero: enteroADividir
	^self negated dividiteAEntero: enteroADividir negated
	
! !

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 17:41:47'!
fibonacci

	self error: self class negativeFibonacciErrorDescription
		! !


!classDefinition: #EnteroNulo category: 'Numero-Exercise'!
Entero subclass: #EnteroNulo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!


!EnteroNulo methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 20:55:22'!
dividiteAEntero: enteroADividir
	^self error: self class canNotDivideByZeroErrorDescription 
	
! !

!EnteroNulo methodsFor: 'arithmetic operations' stamp: 'psm 9/13/2023 23:31:05'!
fibonacci

	^self class with: 1.
		! !


!classDefinition: #EnteroPositivo category: 'Numero-Exercise'!
Entero subclass: #EnteroPositivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivo methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 21:52:48'!
dividiteACoprimo: numerator

	|fraccionDeLaDivisionCoprima|
	
	fraccionDeLaDivisionCoprima := Fraccion new.
	
	^fraccionDeLaDivisionCoprima initializeWith: numerator over: self! !

!EnteroPositivo methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 21:52:48'!
dividiteAEntero: aDivisor
	| greatestCommonDivisor numerator denominator |

	greatestCommonDivisor := self greatestCommonDivisorWith: aDivisor.
	numerator := aDivisor // greatestCommonDivisor.
	denominator := self // greatestCommonDivisor.

	^denominator dividiteACoprimo: numerator! !

!EnteroPositivo methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 17:46:00'!
fibonacci

	| one two |

	one := Entero with: 1.
	two := Entero with: 2.

	^ (self - one) fibonacci + (self - two) fibonacci
		! !



!classDefinition: #EnteroUnidad category: 'Numero-Exercise'!
EnteroPositivo subclass: #EnteroUnidad
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroUnidad methodsFor: 'as yet unclassified' stamp: 'psm 9/13/2023 23:32:25'!
dividiteACoprimo: enteroADividir
	^self class with: enteroADividir integerValue 
	! !

!EnteroUnidad methodsFor: 'as yet unclassified' stamp: 'psm 9/12/2023 21:52:48'!
dividiteAEntero: enteroADividir
	^self dividiteACoprimo: enteroADividir
	! !

!EnteroUnidad methodsFor: 'as yet unclassified' stamp: 'psm 9/12/2023 17:45:36'!
fibonacci
	^self! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:09:49'!
* aMultiplier
	^aMultiplier multiplicateAFraccion: self
	"
	(aMultiplier isKindOf: Entero) ifTrue: [^(numerator * aMultiplier)/(denominator)].
	(aMultiplier isKindOf: Fraccion) ifTrue: [^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator) ].	
	"
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:06:24'!
+ anAdder
	^ anAdder sumateAFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:18:39'!
- aSubtrahend
	^aSubtrahend restateAFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:31:24'!
/ aDivisor
	^aDivisor dividiteAFraccion: self
	"
	(aDivisor isKindOf: Fraccion) ifTrue: [^(numerator * aDivisor denominator) / (denominator * aDivisor numerator)].
	(aDivisor isKindOf: Entero) ifTrue: [^Fraccion with: self numerator over: self denominator * aDivisor].
	"! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'psm 9/12/2023 20:55:22'!
dividiteAEntero: enteroADividir
	^Fraccion with: enteroADividir * denominator over: numerator
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:49:07'!
dividiteAFraccion: fraccionADividir
	^(fraccionADividir numerator * denominator) / (fraccionADividir denominator * numerator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:49:38'!
multiplicateAEntero: enteroAMultiplicar
	^(numerator * enteroAMultiplicar )/(denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:49:54'!
multiplicateAFraccion: fraccionAMultiplicar
	^(numerator * fraccionAMultiplicar numerator) / (denominator * fraccionAMultiplicar denominator) ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:50:09'!
restateAEntero: primerRestandoEntero
	^Fraccion with: ((primerRestandoEntero  * denominator) - numerator ) over: 	(denominator )! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:50:39'!
restateAFraccion: primerRestandoFraccion
	| newNumerator newDenominator |
		newNumerator := (denominator * primerRestandoFraccion numerator) - (numerator * primerRestandoFraccion denominator). 
		newDenominator := denominator * primerRestandoFraccion denominator.
		^newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 15:54:03'!
sumateAEntero: primerSumandoEntero
	^Fraccion with: (primerSumandoEntero * self denominator + self numerator) over: self denominator.
		
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 9/12/2023 16:03:51'!
sumateAFraccion: primerSumandoFraccion
	| newNumerator newDenominator |
		newNumerator := (numerator * primerSumandoFraccion denominator) + (denominator * primerSumandoFraccion numerator).
		newDenominator := denominator * primerSumandoFraccion denominator.
		^newNumerator / newDenominator! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'psm 9/12/2023 21:06:59'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative

	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne

	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero

	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'psm 9/12/2023 21:07:38'!
with: aDividend over: aDivisor

	^aDivisor dividiteAEntero: aDividend 
	! !
