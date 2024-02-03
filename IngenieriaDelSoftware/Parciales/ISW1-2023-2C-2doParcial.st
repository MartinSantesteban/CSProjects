!classDefinition: #MineFieldTests category: 'ISW1-2023-2C-2doParcial'!
TestCase subclass: #MineFieldTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test01_playerStartsInStartingPosition

	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
					
	self assert: (aGame playerIsAt: (5@1)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test02_playerIsOnlyInStartingPosition

	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
					
	self deny: (aGame playerIsAt: (5@2)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test03_playerCanOnlyStartInFirstRow

	self 
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@2)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorMessage.
					
	! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test04_startingPositionMustBePositive

	self 
		should: [MineField withExtensions: (10@10)
					 startingIn: (-5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorMessage.
					
	! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test05_mapExtensionsShouldBeAtLeast2x2

	self 
		should: [MineField withExtensions: (1@1)
					 startingIn: (1@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidMapExtensionsErrorMessage.
					
	! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test06_startingPositionShouldBeIntegers

	self 
		should: [MineField withExtensions: (10@10)
					 startingIn: (1/7@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorMessage .
					
	! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test07_mapExtensionsShouldBeIntegers

	self 
		should: [MineField withExtensions: (100/3@10)
					 startingIn: (5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidMapExtensionsErrorMessage..
					
	! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test08_playerCanCorrectlyMoveForward				
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
	aGame movePlayerForward.
	
	self assert: (aGame playerIsAt: (5@2)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test09_playerCanCorrectlyMoveBackwards
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
	
	aGame movePlayerForward.
	aGame movePlayerBackwards.
	
	self assert: (aGame playerIsAt: (5@1)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test10_playerCanCorrectlyMoveRight
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
					
	aGame movePlayerRight.
	
	self assert: (aGame playerIsAt: (6@1)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test11_playerCanCorrectlyMoveLeft
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
					
	aGame movePlayerLeft.
	
	self assert: (aGame playerIsAt: (4@1)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test12_playerCannotMoveRightOutOfBounds
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (10@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
					
	aGame movePlayerRight.
	
	self assert: (aGame playerIsAt: (10@1)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test13_playerCannotMoveLeftOutOfBounds
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (1@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
					
	aGame movePlayerLeft.
	
	self assert: (aGame playerIsAt: (1@1)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test14_playerCannotMoveBackwardsOutOfBounds
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
					
	aGame movePlayerBackwards.
	
	self assert: (aGame playerIsAt: (5@1)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test15_playerHasCorrectHP
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {} withStartingHealthPoints: 10 withRandomPositionGenerator: self.
				
	self assert: (aGame playerHasHP: 10).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test16_playerHasCorrectHP
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.
	
	self deny: (aGame playerHasHP: 15).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test17_cannotHaveLittleBombOutOfBounds
	
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {LittleBomb inPosition: (-5@-5)} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
			! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test18_littleBombCorrectlyReducesPlayersHP
	
	| aGame |
	
	aGame := MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {LittleBomb inPosition: (5@5)} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.
					
	aGame movePlayerForward. 
	aGame movePlayerForward		.
	aGame movePlayerForward.
	aGame movePlayerForward.
	
	self assert: (aGame playerIsAt: (5@5)).
	self assert: (aGame playerHasHP: 9).					
	
	! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test19_littleBombPositionShouldBeIntegers

	
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {LittleBomb inPosition: (5/3@10/7)} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
			! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:16:26'!
test20_cannotHaveLightArmorOutOfBounds

	
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {LightArmor inPosition: (-5 @ -4)} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
			! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:16:31'!
test21_lightArmorPositionShouldBeIntegers

	
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {LightArmor inPosition: (5/10 @ 4/3)} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
			! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:16:37'!
test22_1_playerIsNotArmoredInNewGame

	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {LightArmor inPosition: (5@5)} 
						 withStartingHealthPoints: 10 withRandomPositionGenerator: self.

		self deny: (aGame playerHasLightArmor).					
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:16:41'!
test22_lightArmorCanBeGrabbedByPlayer

	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {LightArmor inPosition: (5@5)} 
						 withStartingHealthPoints: 10 withRandomPositionGenerator: self.
						
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.
		aGame movePlayerForward.
		
		self assert: (aGame playerIsAt: (5@5)).					
		self assert: (aGame playerHasLightArmor).					
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:16:47'!
test23_lightArmorCorrectlyProtectsPlayerFromLightBomb

	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {LittleBomb inPosition: (5@6) . LightArmor inPosition: (5@5)} 
						 withStartingHealthPoints: 10 withRandomPositionGenerator: self.
						
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.
		aGame movePlayerForward.
		
		self assert: (aGame playerHasLightArmor).					
		
		aGame movePlayerForward.
		
		self assert: (aGame playerHasHP: 10).					! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:16:54'!
test24_lightArmorWearsOffAfterLightBomb

	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {LittleBomb inPosition: (5@6) . LightArmor inPosition: (5@5)} 
						 withStartingHealthPoints: 10 withRandomPositionGenerator: self.
						
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.
		aGame movePlayerForward.
		aGame movePlayerForward.
		
		self assert: (aGame playerHasHP: 10).					
		self deny: (aGame playerHasLightArmor).					! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test25_bigBombCannotHaveInvalidPosition

	"Para heavyArmor & bigBomb unifico los tests que chequean su correcta inicializacion porque al introducirlos heredan todo lo necesario para chequear todo"
	
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {BigBomb inPosition: (5/10 @ 4/3)} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
		
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {BigBomb inPosition: (11 @ 20)} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:33:52'!
test26_bigBombDecreasesPlayersHPBy2

	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {BigBomb inPosition: (5@5)} 
						 withStartingHealthPoints: 10 withRandomPositionGenerator: self.
						
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.
		aGame movePlayerForward.
		
		self assert: (aGame playerHasHP: 8).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:42:56'!
test27_BigBombMovesPlayer
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {BigBomb inPosition: (5@5)} 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
						
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.
		aGame movePlayerForward.
		
		self assert: (aGame playerIsAt: (5@5) + self randomPosition).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:17:04'!
test28_LightArmorReducesPlayersMovementWhenSteppingOnBigBomb
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {BigBomb inPosition: (5@5) . LightArmor inPosition: (5@4)} 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
						
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.
		aGame movePlayerForward.
		
		self assert: (aGame playerIsAt: (6@6)).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:17:08'!
test29_LightArmorWearsOffAfterSteppingOnBigBomb
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {BigBomb inPosition: (5@5) . LightArmor inPosition: (5@4)} 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
						
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.
		aGame movePlayerForward.
		
		self deny: (aGame playerHasLightArmor ).! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:51:00'!
test30_heavyArmorCannotHaveInvalidPosition
	
	"Para heavyArmor & bigBomb unifico los tests que chequean su correcta inicializacion porque al introducirlos heredan todo lo necesario para chequear todo"
	
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {HeavyArmor inPosition: (5/10 @ 4/3)} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
		
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {HeavyArmor inPosition: (11 @ 20)} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:55:45'!
test31_playerDoesNotStartWithHeavyArmor
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {HeavyArmor inPosition: (5@4)} 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.

		self deny: (aGame playerHasHeavyArmor ).
		
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 19:59:23'!
test32_heavyArmorCanBeGrabbedByPlayer
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {HeavyArmor inPosition: (5@4)} 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
								
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.

		self assert: (aGame playerHasHeavyArmor ).
		
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:03:29'!
test33_heavyArmorProtectsAgainstLittleBomb
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {HeavyArmor inPosition: (5@4) . LittleBomb inPosition: (5@5)} 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
								
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.
		aGame movePlayerForward.
		
		self assert: (aGame playerHasHeavyArmor).
		self assert: (aGame playerHasHP: 10).
	
		
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:03:51'!
test34_heavyArmorProtectsAgainstTwoLittleBombsAndWearsOff
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {HeavyArmor inPosition: (5@4) . LittleBomb inPosition: (5@5) .  LittleBomb inPosition: (5@6)} 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
								
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward.
		aGame movePlayerForward. " <- pisa primer bomba"
		
		self assert: (aGame playerHasHeavyArmor).
		self assert: (aGame playerHasHP: 10).
		
		aGame movePlayerForward. " <- pisa segunda bomba, se le va la armadura pero no pierde vida"
		
		self deny: (aGame playerHasHeavyArmor).
		self assert: (aGame playerHasHP: 10).
		
		
		
	
		
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:45:21'!
test35_lastGrabbedArmorPersists
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {HeavyArmor inPosition: (5@2) . LightArmor inPosition: (5@3) .  HeavyArmor inPosition: (5@4)} 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
								
		aGame movePlayerForward. 
		self assert: (aGame playerHasHeavyArmor).
		self deny: (aGame playerHasLightArmor).
		
		aGame movePlayerForward		.
		self deny: (aGame playerHasHeavyArmor).
		self assert: (aGame playerHasLightArmor).
		
		
		aGame movePlayerForward.
		self assert: (aGame playerHasHeavyArmor).
		self deny: (aGame playerHasLightArmor).
		
		
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:47:00'!
test36_heavyArmorProtectsAgainstBigBomb
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {HeavyArmor inPosition: (5@2) . BigBomb inPosition: (5@3)} 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
								
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		
		self assert: (aGame playerHasHeavyArmor).
	
		
		
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 20:47:55'!
test37_heavyArmorProtectsAgainstTwoBigBombs
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {HeavyArmor inPosition: (5@2) . BigBomb inPosition: (5@3) . BigBomb inPosition: (5@4)}  
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
								
		aGame movePlayerForward. 
		aGame movePlayerForward		.
		aGame movePlayerForward		.
		
		self deny: (aGame playerHasHeavyArmor).
	
		
		
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 21:07:17'!
test38_ItemsCanBeGrabbedMovingInAllDirections
	
	"Quizas aca debria asegurarme mas rigurosamente que todos los items pueden agarrarse en todas las direcciones posibles, pero prefiero seguir con la funcionalidad."
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {LittleBomb inPosition: (5@2) . LightArmor inPosition: (7@2) . HeavyArmor inPosition: (7@1) . LightArmor inPosition: (6@1) . BigBomb inPosition: (6@3)}  
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
								
		aGame movePlayerForward. 
		self assert: (aGame playerHasHP: 9).
		
		aGame movePlayerRight.
		aGame movePlayerRight.
		self assert: (aGame playerHasLightArmor).
		
		aGame movePlayerBackwards.
		self assert: (aGame playerHasHeavyArmor).
		
		aGame movePlayerLeft.
		self assert: (aGame playerHasLightArmor).
		
		aGame movePlayerForward.
		aGame movePlayerForward.
		self deny: (aGame playerHasLightArmor).
		! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 21:15:34'!
test39_TunnelCannotHaveInvalidPositions
	
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {Tunnel from: (-5@-2) to: (6@3).} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
		
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {Tunnel from: (5@2) to: (-6@-3).} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 21:17:05'!
test40_TunnelPositionsHaveToBePointsOfIntegers
	
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {Tunnel from: (5/3@2/3) to: (6@3).} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
		
	self
		should: [MineField withExtensions: (10@10)
					 startingIn: (5@1)
					 withItems: {Tunnel from: (5@2) to: (9/5@8/5).} 
					 withStartingHealthPoints: 10 withRandomPositionGenerator: self.]
		raise: Error - MessageNotUnderstood
		withMessageText: MineField invalidItemPositionErrorMessage.
! !

!MineFieldTests methodsFor: 'testing' stamp: 'MS 11/30/2023 21:23:45'!
test41_tunnelTransportsPlayerInOneDirection
	
	| aGame |
		
		aGame := MineField withExtensions: (10@10)
						 startingIn: (5@1)
						 withItems: {Tunnel from: (5@2) to: (8@8) } 
						 withStartingHealthPoints: 10 
						 withRandomPositionGenerator: self.
						
		aGame movePlayerForward. 
		
		self assert: (aGame playerIsAt: (8@8))! !


!MineFieldTests methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 19:46:26'!
randomPosition

	^ (3@3)! !


!classDefinition: #MapItems category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #MapItems
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MapItems methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 19:40:26'!
affectPlayer: aPlayer andRandomPosition: aRandomPosition 

	self subclassResponsibility! !

!MapItems methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 19:40:27'!
checkAndAffect: aPlayer withRandomPosition: aRandomPosition 

	(aPlayer isAt: position) ifTrue: [self affectPlayer: aPlayer andRandomPosition: aRandomPosition].! !

!MapItems methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 18:54:58'!
initializeInPosition: aPosition

	position := aPosition.! !

!MapItems methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 18:55:02'!
isAt: aPosition
	
	^position = aPosition ! !

!MapItems methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 18:55:09'!
isInInterval: anInterval

	^(position x <= anInterval x) and: [(position y <= anInterval y)] and: [(1 <= position x)] and: [(1 <= position y)]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MapItems class' category: 'ISW1-2023-2C-2doParcial'!
MapItems class
	instanceVariableNames: ''!

!MapItems class methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 19:25:12'!
inPosition: aPosition
	
	^self new initializeInPosition: aPosition! !


!classDefinition: #BigBomb category: 'ISW1-2023-2C-2doParcial'!
MapItems subclass: #BigBomb
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!BigBomb methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 19:40:56'!
affectPlayer: aPlayer andRandomPosition: aRandomPosition 

	aPlayer affectedByBigBomb: aRandomPosition.! !


!classDefinition: #HeavyArmor category: 'ISW1-2023-2C-2doParcial'!
MapItems subclass: #HeavyArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!HeavyArmor methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 19:58:58'!
affectPlayer: aPlayer andRandomPosition: aRandomPosition 

	aPlayer affectedByHeavyArmor.! !


!classDefinition: #LightArmor category: 'ISW1-2023-2C-2doParcial'!
MapItems subclass: #LightArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!LightArmor methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:16:00'!
affectPlayer: aPlayer andRandomPosition: aRandomPosition 

	aPlayer affectedByLightArmor.! !


!classDefinition: #LittleBomb category: 'ISW1-2023-2C-2doParcial'!
MapItems subclass: #LittleBomb
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!LittleBomb methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 19:40:27'!
affectPlayer: aPlayer andRandomPosition: aRandomPosition 

	aPlayer affectedByLittleBomb.! !


!classDefinition: #TunnelEntry category: 'ISW1-2023-2C-2doParcial'!
MapItems subclass: #TunnelEntry
	instanceVariableNames: 'otherEnd'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!TunnelEntry methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 21:34:45'!
affectPlayer: aPlayer andRandomPosition: aRandomPosition 

	aPlayer takeTunnelTo: otherEnd 

	! !

!TunnelEntry methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 21:36:53'!
initializeInPosition: initialPosition to: otherPosition

	position := initialPosition.
	otherEnd := otherPosition.! !

!TunnelEntry methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 21:44:05'!
isAt: aPosition
	
	^position isAt: aPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TunnelEntry class' category: 'ISW1-2023-2C-2doParcial'!
TunnelEntry class
	instanceVariableNames: ''!

!TunnelEntry class methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 21:41:14'!
inPosition: initialPosition to: otherPosition

	^ self new initializeInPosition: initialPosition to: otherPosition! !


!classDefinition: #MineField category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #MineField
	instanceVariableNames: 'arrayOfItems mapExtensions items player randomPositionGenerator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineField methodsFor: 'initialization' stamp: 'MS 11/30/2023 19:42:37'!
initializeWithExtensions: mapDimensions startingIn: aPosition withItems: anArrayOfItems withStartingHealthPoints: startingHP andRandomPositionGenerator: aRandomPositionGenerator   
	
	
	(self assertValidMapDimensions: mapDimensions) ifFalse: [self error: self class invalidMapExtensionsErrorMessage ].
	mapExtensions := mapDimensions.
	
	(self assertValidStartingPosition: aPosition) ifFalse: [self error: self class invalidStartingPositionErrorMessage].
	player := MineFieldPlayer at: aPosition withHP: startingHP.
	
	(self assertValidItems: anArrayOfItems) ifFalse: [self error: self class invalidItemPositionErrorMessage.].
	items := anArrayOfItems.
	
	randomPositionGenerator := aRandomPositionGenerator.
	! !


!MineField methodsFor: 'testing' stamp: 'MS 11/30/2023 18:43:48'!
playerHasHP: aHPValue 
	
	^player hasHP: aHPValue ! !

!MineField methodsFor: 'testing' stamp: 'MS 11/30/2023 18:44:31'!
playerIsAt: aPosition 
	
	^player isAt: aPosition.! !


!MineField methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 18:12:24'!
assertValidItems: anArrayOfItems

	^anArrayOfItems allSatisfy: [:anItem | anItem isInInterval: mapExtensions.].! !

!MineField methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 17:38:50'!
assertValidMapDimensions: mapDimensions
	
	^ (1 < mapDimensions x) and: [(1 < mapDimensions y)] and: [(mapDimensions x isInteger and: mapDimensions y isInteger)]! !

!MineField methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 17:37:35'!
assertValidStartingPosition: aPosition

	^(aPosition y = 1) and: [self positionInMapBounds: aPosition] and: [(aPosition x isInteger and: aPosition y isInteger)].! !

!MineField methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 17:32:47'!
positionInMapBounds: aPosition

	^(0 < aPosition x)	 and: [0 < aPosition y] and: [aPosition x <= mapExtensions x] and: [aPosition y <= mapExtensions y] ! !


!MineField methodsFor: 'player' stamp: 'MS 11/30/2023 21:52:34'!
checkForMapItemsEffect

	^ items do: [:anItem | (anItem checkAndAffect: player withRandomPosition: randomPositionGenerator randomPosition)]
	
	"Me falto hacer que los items desaparezcan una vez usados, pero eso se soluciona rapido en este metodo. Habra que hacer un detect y sacar el item que el jugador tiene que usar, 
	para usarlo y luego eliminarlo de la coleccion de items."
	
	
	! !

!MineField methodsFor: 'player' stamp: 'MS 11/30/2023 21:49:49'!
movePlayerBackwards
	
	(player isInYAxis: 1) ifFalse:[player moveBackwards].
	self checkForMapItemsEffect. ! !

!MineField methodsFor: 'player' stamp: 'MS 11/30/2023 21:49:49'!
movePlayerForward
	
	player moveForwards.
	self checkForMapItemsEffect. ! !

!MineField methodsFor: 'player' stamp: 'MS 11/30/2023 21:49:49'!
movePlayerLeft
	
	(player isInXAxis: 1) ifFalse: [player moveLeft].
	self checkForMapItemsEffect. ! !

!MineField methodsFor: 'player' stamp: 'MS 11/30/2023 21:49:49'!
movePlayerRight
	
	(player isInXAxis: mapExtensions x) ifFalse: [player moveRight].
	self checkForMapItemsEffect. ! !

!MineField methodsFor: 'player' stamp: 'MS 11/30/2023 19:52:05'!
playerHasHeavyArmor
	
	^player hasHeavyArmor! !

!MineField methodsFor: 'player' stamp: 'MS 11/30/2023 18:43:06'!
playerHasLightArmor

	^player hasLightArmor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineField class' category: 'ISW1-2023-2C-2doParcial'!
MineField class
	instanceVariableNames: ''!

!MineField class methodsFor: 'instance creation' stamp: 'MS 11/30/2023 19:39:03'!
withExtensions: mapDimensions startingIn: aPosition withItems: anArrayOfItems withStartingHealthPoints: HPValue withRandomPositionGenerator: aRandomPositionGenerator   

	^self new initializeWithExtensions: mapDimensions startingIn: aPosition withItems: anArrayOfItems withStartingHealthPoints: HPValue andRandomPositionGenerator: aRandomPositionGenerator ! !


!MineField class methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 18:24:47'!
invalidItemPositionErrorMessage
	
	^'Item position should be composed of integers and in map bounds!!'! !

!MineField class methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 17:34:54'!
invalidMapExtensionsErrorMessage

	^'Map extensions should be composed by two integers greater than 1!!'! !

!MineField class methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 17:33:15'!
invalidStartingPositionErrorMessage

	^'Starting position should be in the first row within map bounds!!'! !


!classDefinition: #MineFieldPlayer category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #MineFieldPlayer
	instanceVariableNames: 'position currentHP armor'
	classVariableNames: 'HP'
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineFieldPlayer methodsFor: 'move' stamp: 'MS 11/30/2023 18:39:02'!
moveBackwards

	position := position + (0@-1)! !

!MineFieldPlayer methodsFor: 'move' stamp: 'MS 11/30/2023 18:40:46'!
moveForwards

	position := position + (0@1)! !

!MineFieldPlayer methodsFor: 'move' stamp: 'MS 11/30/2023 18:39:20'!
moveLeft

	position := position + (-1@0)! !

!MineFieldPlayer methodsFor: 'move' stamp: 'MS 11/30/2023 18:39:26'!
moveRight

	position := position + (1@0)! !


!MineFieldPlayer methodsFor: 'testing' stamp: 'MS 11/30/2023 18:44:02'!
hasHP: aHPValue 
	
	^ currentHP = aHPValue ! !

!MineFieldPlayer methodsFor: 'testing' stamp: 'MS 11/30/2023 20:28:30'!
hasHeavyArmor
	
	^ armor hasHeavyArmor ! !

!MineFieldPlayer methodsFor: 'testing' stamp: 'MS 11/30/2023 20:28:20'!
hasLightArmor 

	^ armor hasLightArmor ! !

!MineFieldPlayer methodsFor: 'testing' stamp: 'MS 11/30/2023 18:46:36'!
isAt: aPosition

	^position = aPosition ! !

!MineFieldPlayer methodsFor: 'testing' stamp: 'MS 11/30/2023 18:42:38'!
isInXAxis: anAxis

	^position x = anAxis ! !

!MineFieldPlayer methodsFor: 'testing' stamp: 'MS 11/30/2023 18:42:35'!
isInYAxis: anAxis

	^position y = anAxis ! !


!MineFieldPlayer methodsFor: 'initialization' stamp: 'MS 11/30/2023 20:19:12'!
initializeAt: startingPosition withHP: startingHP.

	position := startingPosition .
	currentHP := startingHP .
	armor := NoArmorState for: self.! !


!MineFieldPlayer methodsFor: 'items' stamp: 'MS 11/30/2023 20:42:18'!
affectedByBigBomb: aRandomPosition

	armor affectedByBigBomb: aRandomPosition 
! !

!MineFieldPlayer methodsFor: 'items' stamp: 'MS 11/30/2023 20:33:09'!
affectedByHeavyArmor

	armor grabbedHeavyArmor 
	! !

!MineFieldPlayer methodsFor: 'items' stamp: 'MS 11/30/2023 20:21:30'!
affectedByLightArmor

	armor grabbedLightArmor.! !

!MineFieldPlayer methodsFor: 'items' stamp: 'MS 11/30/2023 20:37:00'!
affectedByLittleBomb
		
	armor affectedByLittleBomb
		
		! !

!MineFieldPlayer methodsFor: 'items' stamp: 'MS 11/30/2023 20:41:27'!
steppedOnBigBombWithLightArmor: aRandomPosition

	position := position + ((aRandomPosition x // 2)@(aRandomPosition y // 2))! !

!MineFieldPlayer methodsFor: 'items' stamp: 'MS 11/30/2023 20:39:54'!
steppedOnBigBombWithoutArmor: aRandomPosition

	currentHP := currentHP - 2.
	position := position + aRandomPosition ! !

!MineFieldPlayer methodsFor: 'items' stamp: 'MS 11/30/2023 20:31:59'!
steppedOnLittleBombWithoutAmor

	currentHP := currentHP - 1.! !


!MineFieldPlayer methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:22:35'!
has: anArmorState

	armor := anArmorState for: self.! !

!MineFieldPlayer methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 21:28:23'!
takeTunnelTo: otherEnd
	
	position := otherEnd ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineFieldPlayer class' category: 'ISW1-2023-2C-2doParcial'!
MineFieldPlayer class
	instanceVariableNames: ''!

!MineFieldPlayer class methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 18:45:38'!
at: startingPosition withHP: startingHP

	^self new initializeAt: startingPosition withHP: startingHP.! !


!classDefinition: #PlayerArmorState category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #PlayerArmorState
	instanceVariableNames: 'player'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!PlayerArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:24:15'!
hasHeavyArmor

	self subclassResponsibility! !

!PlayerArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:25:15'!
hasLightArmor

	self subclassResponsibility! !

!PlayerArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:26:25'!
initializeFor: aPlayer

	player := aPlayer ! !


!PlayerArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:34:10'!
affectedByBigBomb: aRandomPosition

	self subclassResponsibility! !

!PlayerArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:30:14'!
affectedByLittleBomb

	self subclassResponsibility! !

!PlayerArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:23:17'!
grabbedHeavyArmor

	player has: NewHeavyArmorState.! !

!PlayerArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:23:02'!
grabbedLightArmor

	player has: LightArmorState.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerArmorState class' category: 'ISW1-2023-2C-2doParcial'!
PlayerArmorState class
	instanceVariableNames: ''!

!PlayerArmorState class methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:20:07'!
for: aPlayer

	^ self new initializeFor: aPlayer! !


!classDefinition: #BrokenHeavyArmorState category: 'ISW1-2023-2C-2doParcial'!
PlayerArmorState subclass: #BrokenHeavyArmorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!BrokenHeavyArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:24:26'!
hasHeavyArmor

	^true! !

!BrokenHeavyArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:25:15'!
hasLightArmor

	^false! !


!BrokenHeavyArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:38:50'!
affectedByBigBomb: aRandomPosition

	player has: NoArmorState ! !

!BrokenHeavyArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:30:29'!
affectedByLittleBomb

	player has: NoArmorState .! !


!classDefinition: #LightArmorState category: 'ISW1-2023-2C-2doParcial'!
PlayerArmorState subclass: #LightArmorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!LightArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:24:35'!
hasHeavyArmor

	^false! !

!LightArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:25:15'!
hasLightArmor

	^true! !


!LightArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:40:35'!
affectedByBigBomb: aRandomPosition

	player steppedOnBigBombWithLightArmor: aRandomPosition.
	player has: NoArmorState! !

!LightArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:30:41'!
affectedByLittleBomb

	player has: NoArmorState ! !


!classDefinition: #NewHeavyArmorState category: 'ISW1-2023-2C-2doParcial'!
PlayerArmorState subclass: #NewHeavyArmorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!NewHeavyArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:24:43'!
hasHeavyArmor

	^true! !

!NewHeavyArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:25:15'!
hasLightArmor

	^false! !


!NewHeavyArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:38:18'!
affectedByBigBomb: aRandomPosition

	player has: BrokenHeavyArmorState ! !

!NewHeavyArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:30:52'!
affectedByLittleBomb

	player has: BrokenHeavyArmorState ! !


!classDefinition: #NoArmorState category: 'ISW1-2023-2C-2doParcial'!
PlayerArmorState subclass: #NoArmorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!NoArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:25:00'!
hasHeavyArmor

	^false! !

!NoArmorState methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 20:25:15'!
hasLightArmor

	^false! !


!NoArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:39:35'!
affectedByBigBomb: aRandomPosition

	player steppedOnBigBombWithoutArmor: aRandomPosition ! !

!NoArmorState methodsFor: 'items' stamp: 'MS 11/30/2023 20:31:25'!
affectedByLittleBomb

	player steppedOnLittleBombWithoutAmor.! !


!classDefinition: #Tunnel category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #Tunnel
	instanceVariableNames: 'startingPosition finishPosition entry exit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!Tunnel methodsFor: 'initialization' stamp: 'MS 11/30/2023 21:40:30'!
initializeFrom: initialPosition to: finalPosition 

	entry := TunnelEntry inPosition: initialPosition to: finalPosition. 
	exit :=   TunnelEntry inPosition: finalPosition to: initialPosition. 
	
	! !


!Tunnel methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 21:47:33'!
checkAndAffect: aPlayer withRandomPosition: aRandomPosition 

	exit checkAndAffect: aPlayer withRandomPosition: aRandomPosition. 
	
	entry checkAndAffect: aPlayer withRandomPosition: aRandomPosition.


! !

!Tunnel methodsFor: 'as yet unclassified' stamp: 'MS 11/30/2023 21:21:50'!
isInInterval: anInterval

	^ (entry isInInterval: anInterval) and: (exit isInInterval: anInterval)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tunnel class' category: 'ISW1-2023-2C-2doParcial'!
Tunnel class
	instanceVariableNames: ''!

!Tunnel class methodsFor: 'instance creation' stamp: 'MS 11/30/2023 21:09:41'!
from: initialPosition to: finalPosition 

	^self new initializeFrom: initialPosition to: finalPosition ! !
