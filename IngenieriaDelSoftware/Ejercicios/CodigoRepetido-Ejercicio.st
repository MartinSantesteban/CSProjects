!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'utility' stamp: 'psm 9/5/2023 12:48:41'!
assertCustomerMetrics: customerBook numberOfActiveCustomers: activeCustomers numberOfSuspendedCustomers: suspendedCustomers totalNumberOfCustomers: numberOfCostumers 
	
	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfCostumers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'utility' stamp: 'MS 9/5/2023 15:00:12'!
assertOnlyJohnLennon: aCustomerBook

	self assert: 	aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: 'John Lennon').! !

!CustomerBookTest methodsFor: 'utility' stamp: 'MS 9/5/2023 14:23:01'!
cantDo: aClosure errorExpected: anError errorHandler: aHandler
	[aClosure value. self fail]
		on: anError 
		do: aHandler.! !

!CustomerBookTest methodsFor: 'utility' stamp: 'MS 9/5/2023 14:00:38'!
medirTiempo: aBlock

	|millisecondsBeforeRunning millisecondsAfterRunning|

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning)! !


!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/5/2023 14:00:38'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook|
	
	customerBook := CustomerBook new.
	
	self assert: ((self medirTiempo: 
			[customerBook addCustomerNamed: 'John Lennon'.])
		 	< (50 * millisecond))
 	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/5/2023 14:36:05'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.	
	customerBook  := CustomerBook singleCustomerBook: paulMcCartney.
	
	self assert: ((self medirTiempo: 
			[customerBook removeCustomerNamed: paulMcCartney.] )
		
			< (100 * millisecond))
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/5/2023 14:23:01'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self cantDo: [customerBook addCustomerNamed: ''.] 
		errorExpected:  Error 
		errorHandler: 	[ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/5/2023 15:01:28'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook singleCustomerBook:  johnLennon.
	
	self cantDo: [ customerBook removeCustomerNamed: 'Paul McCartney'.] 
		errorExpected:  NotFound  
		errorHandler: 	[ :anError | self assertOnlyJohnLennon: customerBook]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/5/2023 15:01:49'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook singleCustomerBook:  paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCustomerMetrics: customerBook 
		numberOfActiveCustomers: 0 
		numberOfSuspendedCustomers: 1 
		totalNumberOfCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/5/2023 15:01:55'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook singleCustomerBook:  paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerMetrics: customerBook 
		numberOfActiveCustomers: 0 
		numberOfSuspendedCustomers: 0 
		totalNumberOfCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/5/2023 15:00:48'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook singleCustomerBook: johnLennon.
	
	self cantDo: [ customerBook suspendCustomerNamed: 'George Harrison'.]
		errorExpected:  CantSuspend
		errorHandler: [ :anError | self assertOnlyJohnLennon: customerBook].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/5/2023 15:01:04'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook singleCustomerBook:  johnLennon.
	customerBook suspendCustomerNamed: johnLennon.

	self cantDo: [ customerBook suspendCustomerNamed: johnLennon.]
		errorExpected:  CantSuspend
		errorHandler: [ :anError | self assertOnlyJohnLennon: customerBook].
	
	
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'psm 9/5/2023 16:03:41'!
removeCustomerFrom: list Named: aName ifNotFoundDo: aBlock
 
    1 to: list size do:
    [ :index |
        aName = (list at: index)
            ifTrue: [
                list removeAt: index.
                ^ aName 
            ] 
    ].

    ^ aBlock value! !

!CustomerBook methodsFor: 'customer management' stamp: 'psm 9/5/2023 16:09:51'!
removeCustomerNamed: aName 

	^(self removeCustomerFrom: active 
		Named: aName 
		ifNotFoundDo: [
			self removeCustomerFrom: suspended 
				Named: aName 
				ifNotFoundDo: 
					[^NotFound signal]
				]
		)! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:48'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:52'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !


!CustomerBook class methodsFor: 'custom initializers' stamp: 'MS 9/5/2023 14:40:21'!
singleCustomerBook:  aName
	^(self new addCustomerNamed: aName)! !
