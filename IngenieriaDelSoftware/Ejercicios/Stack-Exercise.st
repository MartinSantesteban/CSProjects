!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack orderedCollectionWithHola sentenceFinderByPrefix stackWithHola bigStack emptyCollection bigStack2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'stackAuxiliaryOperationsForTesting' stamp: 'MS 9/17/2023 23:46:34'!
assertExpectedOutput: aCollectionOfValidSentences withStackOfSentences: aStackOfSentences andPrefix: aPrefix
	| anOrderedCollection |

	anOrderedCollection := sentenceFinderByPrefix findSentencesIn: aStackOfSentences withPrefix: aPrefix.
	self assert: (anOrderedCollection = aCollectionOfValidSentences).
! !

!SentenceFinderByPrefixTest methodsFor: 'stackAuxiliaryOperationsForTesting' stamp: 'psm 9/18/2023 15:47:44'!
bigStackRemainsTheSameAfterUsingPrefix: aPrefix
	sentenceFinderByPrefix findSentencesIn: bigStack withPrefix: aPrefix.
	self assert: (bigStack = bigStack2).
	! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/17/2023 22:18:00'!
setUp
	orderedCollectionWithHola  := (OrderedCollection new).
	orderedCollectionWithHola add: 'hola'.
	
	emptyStack := OOStack new.
	
	emptyCollection := OrderedCollection new.
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	
	stackWithHola := OOStack new.
	stackWithHola push: 'hola'.
	
	bigStack := OOStack new. 
	bigStack  push:  'winter is coming' ;
        			push:  'winning is everything' ;
			push:  'The winds of Winter' ; 
			push:  'Summer sucks'  ;
			push:  'wind'.
	

	bigStack2 := OOStack new.                   
	bigStack2 push:  'winter is coming' ;
        		  	push:  'winning is everything' ;
			push:  'The winds of Winter' ; 
			push:  'Summer sucks'  ;
			push:  'wind'.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/17/2023 23:26:06'!
test011_prefixWithSpacesFails

	self
		should: [sentenceFinderByPrefix findSentencesIn: bigStack withPrefix: 'wi n'.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix spacesInPrefixError .].


! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/17/2023 23:26:17'!
test01_nonEmptyString
	self
		should: [sentenceFinderByPrefix findSentencesIn: emptyStack withPrefix: ''.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix emptyPrefixError .].
	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/17/2023 23:47:46'!
test02_succesfulFindOnStackWithOnlyPrefix
	
	self assertExpectedOutput: orderedCollectionWithHola withStackOfSentences: stackWithHola andPrefix: 'hola'.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/17/2023 23:48:34'!
test03_succesfulFindOnStackWithOneWord

	self assertExpectedOutput: orderedCollectionWithHola withStackOfSentences: stackWithHola andPrefix: 'ho'.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/17/2023 23:49:27'!
test04_failedFindOnStackWithOneWord

	self assertExpectedOutput: emptyCollection withStackOfSentences: stackWithHola andPrefix: 'Hi'.
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/17/2023 23:50:09'!
test05_failedFindOnEmptyStack

	self assertExpectedOutput: emptyCollection withStackOfSentences: emptyStack andPrefix: 'hola'.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'psm 9/18/2023 01:09:43'!
test06_succesfulFindOnBigStack
	| sentences |
	
	sentences := OrderedCollection new. 
	sentences add: 'winter is coming' ; add: 'winning is everything' ; add:  'wind'.
	self assertExpectedOutput: sentences withStackOfSentences: bigStack andPrefix: 'win'.

	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/17/2023 23:51:34'!
test07_failedFindOnBigStackBecauseOfLowerCase
	
	self assertExpectedOutput: emptyCollection withStackOfSentences: bigStack andPrefix: 'Win'.

	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'psm 9/18/2023 15:22:07'!
test08_sameStackEqualitySuccesful

	self assert: (bigStack = bigStack ).


! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'psm 9/18/2023 15:21:57'!
test09_differentStacksEqualitySuccesful
	
	self assert: (bigStack = bigStack2 ).


! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'psm 9/18/2023 15:21:38'!
test10_differentStacksEqualityFailed
	
	self deny: (bigStack = emptyStack ).


! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/18/2023 00:00:15'!
test11_stackRemainsTheSameAfterFailedFindByPrefix
	
	self bigStackRemainsTheSameAfterUsingPrefix: 'Windows'.


	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 9/18/2023 00:00:20'!
test12_stackRemainsTheSameAfterSuccesfulFindByPrefix
	
	self bigStackRemainsTheSameAfterUsingPrefix: 'win'.
	


! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'MS 9/17/2023 18:40:50'!
pop
	|value|
	value := topElement value.
	topElement := topElement lowerElement.
	^value
	! !

!OOStack methodsFor: 'operations' stamp: 'MS 9/17/2023 18:37:14'!
push: anElement
	topElement := StackElement initializeWith: anElement Over: topElement .! !

!OOStack methodsFor: 'operations' stamp: 'MS 9/17/2023 17:58:12'!
size
	^topElement size! !

!OOStack methodsFor: 'operations' stamp: 'MS 9/17/2023 18:38:47'!
top
	^topElement value! !


!OOStack methodsFor: 'testing' stamp: 'psm 9/18/2023 15:54:42'!
= anotherStack
	"chanchada orientada a objetos: uso interesante de polimorfismo"
	^((anotherStack isKindOf: self class) or: (anotherStack isKindOf: topElement class)) 
		and: [anotherStack = topElement] .! !

!OOStack methodsFor: 'testing' stamp: 'MS 9/17/2023 17:57:51'!
isEmpty
	^topElement isEmpty! !


!OOStack methodsFor: 'initialization' stamp: 'psm 9/17/2023 19:05:32'!
initialize
	topElement := StackBase new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #StackBase category: 'Stack-Exercise'!
OOStack subclass: #StackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBase methodsFor: 'testing' stamp: 'psm 9/18/2023 15:34:54'!
= aStackBase
	^aStackBase isKindOf: self class.! !

!StackBase methodsFor: 'testing' stamp: 'MS 9/17/2023 18:00:38'!
isEmpty
	^true! !

!StackBase methodsFor: 'testing' stamp: 'MS 9/17/2023 18:01:21'!
size
	^0! !


!StackBase methodsFor: 'operations' stamp: 'psm 9/17/2023 19:06:19'!
lowerElement
	^ self error: self class stackEmptyErrorDescription ! !

!StackBase methodsFor: 'operations' stamp: 'psm 9/17/2023 19:06:24'!
value
	^ self error: self class stackEmptyErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackBase class' category: 'Stack-Exercise'!
StackBase class
	instanceVariableNames: 'uniqueInstance'!

!StackBase class methodsFor: 'instance creation' stamp: 'psm 9/17/2023 19:01:36'!
new

	^uniqueInstance! !


!StackBase class methodsFor: 'initialization' stamp: 'psm 9/17/2023 19:04:51'!
initialize

	^uniqueInstance := self basicNew ! !


!classDefinition: #StackElement category: 'Stack-Exercise'!
OOStack subclass: #StackElement
	instanceVariableNames: 'lowerElement value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'operations' stamp: 'MS 9/17/2023 18:40:08'!
lowerElement
	^lowerElement! !

!StackElement methodsFor: 'operations' stamp: 'MS 9/17/2023 18:39:20'!
value
	^value! !


!StackElement methodsFor: 'initialization' stamp: 'psm 9/17/2023 18:45:16'!
initializeWith: aValue Over: aLowerElement
	value := aValue.
	lowerElement := aLowerElement.
	
	! !


!StackElement methodsFor: 'testing' stamp: 'psm 9/18/2023 15:46:28'!
= aStackElement

	^(aStackElement isKindOf: self class) and:
		 [aStackElement value = self value and: aStackElement lowerElement = self lowerElement ].! !

!StackElement methodsFor: 'testing' stamp: 'MS 9/17/2023 18:01:06'!
isEmpty
	^false! !

!StackElement methodsFor: 'testing' stamp: 'MS 9/17/2023 18:01:48'!
size
	^ 1 + lowerElement size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackElement class' category: 'Stack-Exercise'!
StackElement class
	instanceVariableNames: ''!

!StackElement class methodsFor: 'initialization' stamp: 'psm 9/17/2023 18:45:36'!
initializeWith: value Over: lowerElement

	^(self new) initializeWith: value Over: lowerElement.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'auxiliar operations' stamp: 'psm 9/18/2023 01:37:08'!
array: anArray at: index ifItHasPrefix: aPrefix saveAtTheBeginingOf: validSentences

	((anArray at: index) is: aPrefix substringAt: 1)
            ifTrue:[validSentences addFirst: (anArray at: index). ].

	! !

!SentenceFinderByPrefix methodsFor: 'auxiliar operations' stamp: 'psm 9/18/2023 02:59:06'!
iterateInStack: aStack withPrefix: aPrefix toBeRestoredIn: stackElements andSaveFindsIn: validSentences
	 aStack size to: 1 by: -1 do: [:index|
 		stackElements at: index put: aStack pop.
    	        self 
			array: stackElements 
			at: index 
			ifItHasPrefix: aPrefix 
			saveAtTheBeginingOf: validSentences .
        ].

	! !

!SentenceFinderByPrefix methodsFor: 'auxiliar operations' stamp: 'psm 9/18/2023 01:27:58'!
lookForSentencesIn: aStack withPrefix: aPrefix
    | validSentences stackElements|

    validSentences := OrderedCollection new.
    stackElements := Array new: aStack size.
    
    self 
	iterateInStack: aStack 
	withPrefix: aPrefix 
	toBeRestoredIn: stackElements 
	andSaveFindsIn: validSentences .

    self restoreStack: aStack withElements: stackElements .

    ^validSentences.

	! !

!SentenceFinderByPrefix methodsFor: 'auxiliar operations' stamp: 'psm 9/18/2023 01:22:00'!
restoreStack: aStack withElements: stackElements

    stackElements do: [:stackElement | aStack push: stackElement ].

	! !


!SentenceFinderByPrefix methodsFor: 'check for valid entry' stamp: 'psm 9/18/2023 01:28:43'!
validPrefix: aPrefix
	aPrefix isEmpty
		ifTrue: [self error: self class emptyPrefixError.].
	(aPrefix allSatisfy: [:character | character isSeparator not.]) 
		ifFalse: [self error: self class spacesInPrefixError .].! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'psm 9/18/2023 01:15:33'!
findSentencesIn: aStack withPrefix: aPrefix

    self validPrefix: aPrefix.

    ^self lookForSentencesIn: aStack withPrefix: aPrefix .

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'MS 9/17/2023 23:15:46'!
emptyPrefixError
	^'The prefix is empty!!'! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'MS 9/17/2023 23:16:12'!
spacesInPrefixError
	^'The prefix contains spaces!!'! !

StackBase initialize!