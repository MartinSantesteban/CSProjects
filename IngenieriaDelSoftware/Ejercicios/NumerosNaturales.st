!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:47:00'!
* aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:47:00'!
+ aNaturalNumber
	^aNaturalNumber next! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 23:29:30'!
- aNaturalNumber
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 23:34:16'!
/ aNaturalNumber
	(aNaturalNumber  = self)
		ifTrue: [^self].
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:47:00'!
< aNaturalNumber
	^aNaturalNumber  > self! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 21:11:51'!
<= aNaturalNumber
	^true! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:47:00'!
> aNaturalNumber
	^false! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 23:34:36'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 23:29:15'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:53:35'!
divideA: aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:47:24'!
next
	next ifNil:[next := self cloneNamed: self name, 'I'].
	next previous: self.
	^next! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 23:39:44'!
previous
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:47:00'!
restateA: aNaturalNumber
	^(aNaturalNumber previous )! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'psm 8/31/2023 19:09:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'previous next'!

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:46:36'!
* aNaturalNumber
	^(self previous * aNaturalNumber + aNaturalNumber)! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:46:36'!
+ aNaturalNumber
	^(self previous + aNaturalNumber) next! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:46:36'!
- aNaturalNumber
	^aNaturalNumber restateA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 23:33:05'!
/ aNaturalNumber
	(aNaturalNumber <= self)
		"si es mayor hago recursion"
		ifTrue: [^aNaturalNumber divideA: self] .
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:46:36'!
< aNaturalNumber
	^aNaturalNumber  > self! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 21:11:11'!
<= aNaturalNumber
	^(self = aNaturalNumber)  or: (self < aNaturalNumber)! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:49:36'!
> aNaturalNumber
	(aNaturalNumber = I)
	ifTrue: [^true] ifFalse: [^(self previous > aNaturalNumber  previous)].! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 23:39:15'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 21:07:44'!
divideA: aNaturalNumber
	| pasoPrevio|.
	"este codigo se divide en muchas partes debido a la falta de un 0"
	
	(self = aNaturalNumber )
		"si son iguales devuelvo uno"
		ifTrue: [^I] .
	
	pasoPrevio :=aNaturalNumber - self.
	( pasoPrevio < self)
		ifTrue: [^I] 
		ifFalse: [^(pasoPrevio / self) next]! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:46:48'!
next
	next ifNil:[next := II createChildNamed: self name, 'I'].
	next previous: self.
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:46:36'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:46:36'!
previous: aNatualNumber
	previous := aNatualNumber .
	^previous ! !

!II class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:58:22'!
restateA: aNaturalNumber
	^(aNaturalNumber previous - self previous)! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'psm 8/31/2023 19:09:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'psm 8/31/2023 19:09:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.
	next := IIII.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'psm 8/31/2023 19:09:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.
	next := IIIII.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'psm 8/31/2023 19:09:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIII.
	next := IIIIII.! !


!classDefinition: #IIIIII category: 'Numeros Naturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'psm 8/31/2023 19:09:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIII.
	next := IIIIIII.! !


!classDefinition: #IIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numeros Naturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'psm 8/31/2023 19:09:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIII.
	next := IIIIIIII.! !


!classDefinition: #IIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numeros Naturales'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'psm 8/31/2023 19:09:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIII.
	next := nil.! !


!classDefinition: #conversor category: 'Numeros Naturales'!
DenotativeObject subclass: #conversor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'conversor class' category: 'Numeros Naturales'!
conversor class
	instanceVariableNames: ''!

!conversor class methodsFor: 'as yet unclassified' stamp: 'psm 8/31/2023 19:09:00'!
pasarEnteroANatural: aPositiveNumber
	(aPositiveNumber > 0)
	ifTrue: [
	|natural |.
	natural  := I.
	(aPositiveNumber - 1) timesRepeat: [natural := natural next.].
	^natural .
	]. 
	self error: 'tiene que ser positivo'
! !

!conversor class methodsFor: 'as yet unclassified' stamp: 'psm 8/30/2023 20:48:57'!
pasarNaturalAEntero: aNaturalNumber
	(aNaturalNumber  = I)
	ifTrue: [^1] .
	^(self pasarNaturalAEntero: aNaturalNumber previous) + 1
	! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!