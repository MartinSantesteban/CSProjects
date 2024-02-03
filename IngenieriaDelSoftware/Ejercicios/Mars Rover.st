!classDefinition: #MarsRoverTestSuite category: 'Mars Rover'!
TestCase subclass: #MarsRoverTestSuite
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 20:36:48'!
test01_MarsRoverIsInDesignatedInitialPositionAndDirection
	| marsRover |
	marsRover  := MarsRover in: (5@4) facing: #North.
	self assert: (marsRover isIn: (5@4) andFacing: #North).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 21:20:46'!
test02_MarsRoverDoesNothingAfterProcessingEmptyString
	| marsRover |
	marsRover  := MarsRover in: (5@4) facing: #North.
	marsRover process: ''.
	self assert: (marsRover isIn: (5@4) andFacing: #North).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 21:21:11'!
test03_MarsRoverMovesFowardsFacingNorth
	| marsRover |
	marsRover  := MarsRover in: (5@4) facing: #North.
	marsRover process: 'f'.
	self assert: (marsRover isIn: (5@5) andFacing: #North).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 21:21:37'!
test04_MarsRoverMovesFowardFacingEast
	| marsRover |
	marsRover  := MarsRover in: (5@4) facing: #East.
	marsRover process: 'f'.
	self assert: (marsRover isIn: (6@4) andFacing: #East).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 21:22:03'!
test05_MarsRoverMovesBackwardFacingNorth
	| marsRover |
	marsRover  := MarsRover in: (5@4) facing: #North.
	marsRover process: 'b'.
	self assert: (marsRover isIn: (5@3) andFacing: #North).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 21:22:21'!
test06_MarsRoverMovesBackwardFacingEast
	| marsRover |
	marsRover  := MarsRover in: (5@4) facing: #East.
	marsRover process: 'b'.
	self assert: (marsRover isIn: (4@4) andFacing: #East).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 22:26:20'!
test07_MarsRoverRotatesToTheRight
	| marsRover |
	marsRover  := MarsRover in: (5@4) facing: #West.
	marsRover process: 'r'.
	self assert: (marsRover isIn: (5@4) andFacing: #North).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 21:22:53'!
test08_MarsRoverRotatesToTheLeft
	| marsRover |
	marsRover  := MarsRover in: (5@4) facing: #East.
	marsRover process: 'l'.
	self assert: (marsRover isIn: (5@4) andFacing: #North).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 22:03:53'!
test09_MarsRoverCanProcessMultipleCommands
	| marsRover |
	marsRover  := MarsRover in: (0@0) facing: #North.
	marsRover process: 'ffrfflffrbb'.
	self assert: (marsRover isIn: (0@4) andFacing: #East).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 22:04:33'!
test10_MarsRoverStopsProcessingAfterInvalidCommand
	| marsRover |
	marsRover  := MarsRover in: (0@0) facing: #North.
	marsRover process: 'ffrff lffrbb'.
	self assert: (marsRover isIn: (2@2) andFacing: #East).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 22:40:12'!
test11_MarsRoverMovesInASquareToTheLeft
	| marsRover |
	marsRover  := MarsRover in: (0@0) facing: #South.
	marsRover process: 'ffblffblffblffb$   fr'.
	self assert: (marsRover isIn: (0@0) andFacing: #West).! !

!MarsRoverTestSuite methodsFor: 'testing' stamp: 'MS 10/8/2023 22:40:30'!
test12_MarsRoverMovesInASquareToTheRight
	| marsRover |
	marsRover  := MarsRover in: (0@0) facing: #South.
	marsRover process: 'ffbrffbrffbrffb'.
	self assert: (marsRover isIn: (0@0) andFacing: #East).! !


!classDefinition: #CardinalDirections category: 'Mars Rover'!
Object subclass: #CardinalDirections
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalDirections methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:17:03'!
moveBackward

	self subclassResponsibility! !

!CardinalDirections methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:12:21'!
moveForward

	self subclassResponsibility! !

!CardinalDirections methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:42:34'!
rotateLeft

	self subclassResponsibility! !

!CardinalDirections methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:42:42'!
rotateRight

	self subclassResponsibility! !

!CardinalDirections methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:59:06'!
symbol

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirections class' category: 'Mars Rover'!
CardinalDirections class
	instanceVariableNames: ''!

!CardinalDirections class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:53:59'!
canHandle: aDirectionSymbol

	self subclassResponsibility! !

!CardinalDirections class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:57:23'!
invalidSymbolError
	^'This symbol is not a cardinal direction!!'! !

!CardinalDirections class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:56:50'!
pointing: aDirectionSymbol
	^(self subclasses detect: [ :aCardinalDirection | aCardinalDirection canHandle: aDirectionSymbol.] ifNone: [self error: self invalidSymbolError]) new.! !


!classDefinition: #East category: 'Mars Rover'!
CardinalDirections subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!East methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:17:22'!
moveBackward
	^(-1@0)
	! !

!East methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:12:43'!
moveForward
	^(1@0)! !

!East methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:44:04'!
rotateLeft
	^North new.! !

!East methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:44:13'!
rotateRight
	^South new.! !

!East methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:59:15'!
symbol
	^#East! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'Mars Rover'!
East class
	instanceVariableNames: 'uniqueInstance'!

!East class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:54:28'!
canHandle: aDirectionSymbol
	^aDirectionSymbol = #East! !

!East class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 22:19:37'!
initialize
	uniqueInstance := self basicNew.! !

!East class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 22:20:50'!
new
	^uniqueInstance ! !


!classDefinition: #North category: 'Mars Rover'!
CardinalDirections subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!North methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:17:43'!
moveBackward

	^(0@-1)! !

!North methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:12:53'!
moveForward
	^(0@1)! !

!North methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:44:21'!
rotateLeft
	^West new! !

!North methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:44:32'!
rotateRight
	^East new! !

!North methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:59:22'!
symbol
	^#North! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'Mars Rover'!
North class
	instanceVariableNames: 'uniqueInstance'!

!North class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:54:40'!
canHandle: aDirectionSymbol
	^aDirectionSymbol = #North! !

!North class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 22:22:32'!
initialize
	uniqueInstance := self basicNew.! !

!North class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 22:22:43'!
new
	^uniqueInstance ! !


!classDefinition: #South category: 'Mars Rover'!
CardinalDirections subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!South methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:17:54'!
moveBackward

	^(0@1)! !

!South methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:13:09'!
moveForward
	^(0@-1)! !

!South methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:44:48'!
rotateLeft
	^East new! !

!South methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:45:06'!
rotateRight
	^West new! !

!South methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:59:29'!
symbol
	^#South! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'Mars Rover'!
South class
	instanceVariableNames: 'uniqueInstance'!

!South class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:54:48'!
canHandle: aDirectionSymbol
	^aDirectionSymbol = #South! !

!South class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 22:23:25'!
initialize
	uniqueInstance := self basicNew.
	! !

!South class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 22:23:38'!
new
	^uniqueInstance! !


!classDefinition: #West category: 'Mars Rover'!
CardinalDirections subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!West methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:18:05'!
moveBackward

	^(1@0)! !

!West methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:13:19'!
moveForward
	^(-1@0)! !

!West methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:45:28'!
rotateLeft
	^South new! !

!West methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:45:36'!
rotateRight
	^North new! !

!West methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:59:36'!
symbol
	^#West! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'Mars Rover'!
West class
	instanceVariableNames: 'uniqueInstance'!

!West class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:54:54'!
canHandle: aDirectionSymbol
	^aDirectionSymbol = #West! !

!West class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 22:24:16'!
initialize
	uniqueInstance := self basicNew.! !

!West class methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 22:24:32'!
new
	^uniqueInstance! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'initialitation' stamp: 'MS 10/8/2023 20:49:53'!
in: initialPosition facing: initialDirection 
	currentPosition := initialPosition.
	currentDirection := CardinalDirections pointing: initialDirection .! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 20:58:55'!
isIn: aPosition andFacing: aDirection
	^(currentPosition = aPosition) and: [currentDirection symbol = aDirection]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 22:03:03'!
process: aStringOfCommands 
	aStringOfCommands do: [: aCommand | (#($f,$b,$r,$l) includes: aCommand) 
		ifTrue: [self processSingleCommand: aCommand]
		ifFalse: [^self].]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/8/2023 21:50:18'!
processSingleCommand: aCommand 
	(aCommand = $f) ifTrue: [
		currentPosition := currentPosition + currentDirection moveForward.
	].

	(aCommand = $b) ifTrue: [
		currentPosition := currentPosition + currentDirection moveBackward.
	].

	(aCommand = $r) ifTrue: [currentDirection := currentDirection rotateRight.].	
	(aCommand = $l) ifTrue: [currentDirection := currentDirection rotateLeft.].	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'class initialization' stamp: 'MS 10/8/2023 20:13:39'!
in: initialPosition facing: initialDirection
	^self new in: initialPosition facing: initialDirection ! !

East initialize!
North initialize!
South initialize!
West initialize!