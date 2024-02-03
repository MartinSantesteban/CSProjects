!classDefinition: #MineFieldTest category: 'ISW1-2023-2C-Recuperatorio'!
TestCase subclass: #MineFieldTest
	instanceVariableNames: 'randoms'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test01BoardExtentXMustBeGreaterOrEqualTo2

	"No hago una aserción de creación inválida de instancia porque no agregaría mucho valor - Hernan"
	self 
		should: [ MineField extent: 1@2 startingInPosition: 1@1 withLives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidBoardExtentErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test02BoardExtentYMustBeGreaterOrEqualTo2

	self 
		should: [ MineField extent: 2@1 startingInPosition: 1@1 withLives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidBoardExtentErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test03PlayerMustStartAtRow1

	self 
		should: [ MineField extent: 2@2 startingInPosition: 1@2 withLives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test04PlayerLivesMustBeStrictlyPositive

	self 
		should: [ MineField extent: 2@2 startingInPosition: 1@1 withLives: 0 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidNumberOfLivesErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test05PlayerLivesMustBeInteger

	self 
		should: [ MineField extent: 2@2 startingInPosition: 1@1 withLives: 1.5 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidNumberOfLivesErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test06PlayerMustStartInsideBoard

	self 
		should: [ MineField extent: 2@2 startingInPosition: 0@1 withLives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription.
		
	self 
		should: [ MineField extent: 2@2 startingInPosition: 3@1 withLives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription 
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test07PlayerMustStartAtAnEmptyPosition

	self 
		should: [ MineField extent: 2@2 startingInPosition: 1@1 withLives: 1 elements: { LowPowerMine at: 1@1 } randomizingWith: self]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription.
		
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test08PlayerCanMoveUp

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerUp.
	
	self deny: (mineField isPlayerAt: 1@1).
	self assert: (mineField isPlayerAt: 1@2).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test09PlayerCanMoveLeft

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 2@1 withLives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerLeft.
	
	self deny: (mineField isPlayerAt: 2@1).
	self assert: (mineField isPlayerAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test10PlayerCanMoveRight

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerRight.
	
	self deny: (mineField isPlayerAt: 1@1).
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test11PlayerCanMoveDown

	| mineField |
	
	mineField :=  MineField extent: 2@3 startingInPosition: 1@1 withLives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerUp; movePlayerDown.
	
	self assert: (mineField isPlayerAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test12PlayerStaysOnBoardWhenMovingDown

	| mineField |
	
	mineField :=  MineField extent: 2@3 startingInPosition: 1@1 withLives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerDown.
	
	self assert: (mineField isPlayerAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test13PlayerStaysOnBoardWhenMovingLeft

	| mineField |
	
	mineField :=  MineField extent: 2@3 startingInPosition: 1@1 withLives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerLeft.
	
	self assert: (mineField isPlayerAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test14PlayerStaysOnBoardWhenMovingRight

	| mineField |
	
	mineField :=  MineField extent: 2@3 startingInPosition: 2@1 withLives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test15PlayerLoosesLiveWhenStepsIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 2 elements: { LowPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: mineField playerLives equals: 1.
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test16LowPowerMineExplotesOnlyOnce

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 2 elements: { LowPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerLeft; movePlayerRight.
	
	self assert: mineField playerLives equals: 1.
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test17PlayerLoosesLiveWhenStepsIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(0 0).
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 2 elements: { HighPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: mineField playerLives equals: 0.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test18HighPowerMineExplotesOnlyOnce

	| mineField |
	
	self randomPositionIncrementsAre: #(0 0).
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 3 elements: { HighPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerLeft; movePlayerRight.
	
	self assert: mineField playerLives equals: 1.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test19PlayerFliesWhenSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(-1 1).
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 3 elements: { HighPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 1@2)! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test20PlayerDoesNotMoveWhenFliesOutOfBoardSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(10 10).
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 2 elements: { HighPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@1)! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test21PlayerDoesNotLooseLiveWhenWearingLightArmorAndSteppingIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 2 elements: { 
		ArmorRack at: 2@1 with: LightArmor new. LowPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test22PlayerDoesNotLooseLiveWhenWearingLightArmorAndSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(0 0).
	mineField :=  MineField extent: 5@5 startingInPosition: 1@1 withLives: 2 elements: { 
		ArmorRack at: 2@1 with: LightArmor new. HighPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2.
	self assert: (mineField isPlayerAt: 2@2)
	
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test23PlayerFliesHalfWhenWearingLightArmorAndSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 5@5 startingInPosition: 1@1 withLives: 2 elements: { 
		ArmorRack at: 2@1 with: LightArmor new. HighPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2.
	self assert: (mineField isPlayerAt: 3@3)
	
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test24HeavyArmorCanUsedTwiceWhenSteppingIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField 
		extent: 3@3 
		startingInPosition: 1@1 
		withLives: 2 
		elements: { 
			ArmorRack at: 2@1 with: HeavyArmor new. 
			LowPowerMine at: 2@2.
			LowPowerMine at: 1@2 } 
		randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp; movePlayerLeft.
	
	self assert: mineField playerLives equals: 2! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test24PlayerDoesNotLooseLiveWhenWearingHeavyArmorAndSteppingIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 2 elements: { 
		ArmorRack at: 2@1 with: HeavyArmor new. LowPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test26PlayerDoesNotLooseLifeNorFliesWhenWearingHeavyArmorAndSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 2 elements: { 
		ArmorRack at: 2@1 with: HeavyArmor new. HighPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2.
	self assert: (mineField isPlayerAt: 2@2)
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test27ArmorIsWeardOnlyOnce

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 3@3 startingInPosition: 1@1 withLives: 2 elements: { 
		ArmorRack at: 2@1 with: HeavyArmor new. 
		HighPowerMine at: 2@2 .
		LowPowerMine at: 1@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp; movePlayerDown; movePlayerLeft; movePlayerUp.
	
	self assert: mineField playerLives equals: 1.
	self assert: (mineField isPlayerAt: 1@2)
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test28WhenPlayerSteppsIntoFirstTunnelHoleAppearsInOther

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 3@3 startingInPosition: 1@1 withLives: 2 elements: { Tunnel at: 2@1 and: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@2)
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test29WhenPlayerSteppsIntoSecondTunnelHoleAppearsInOther

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 3@3 startingInPosition: 1@1 withLives: 2 elements: { Tunnel at: 2@1 and: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerLeft; movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@1)
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/7/2023 22:58:26'!
test30FieldElementsCanNotSharePosition

	self assertCannotSharePositionsFor: { LowPowerMine at: 2@2. HighPowerMine at: 2@3. HighPowerMine at: 2@3.} ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 12:17:22'!
test31TunnelDoesNotSharePositionForFirstHole

	self assertCannotSharePositionsFor: { Tunnel at: 2@2 and: 3@3. LowPowerMine at: 2@2. } 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 12:17:32'!
test32TunnelDoesNotSharePositionWithSecondHole

	self assertCannotSharePositionsFor: { Tunnel at: 2@2 and: 3@3. Tunnel at: 1@2 and: 3@3. } 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test33PlayerWinsWhenAtTopRowAndLeftLives

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 1 elements: {} randomizingWith: self.
	
	mineField movePlayerUp.
	
	self assert: mineField isOver.
	self assert: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test34PlayerDoesNotWinWhenAtTopRowButWithoutLives

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 1 elements: {LowPowerMine at: 1@2} randomizingWith: self.
	
	mineField movePlayerUp.
	
	self assert: mineField isOver.
	self deny: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test35PlayerDoesNotWinWhenNotAtTopRow

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 1 elements: {} randomizingWith: self.
	
	self deny: mineField isOver.
	self deny: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test36GameIsOverWhenNoLivesLeft

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingInPosition: 1@1 withLives: 1 elements: {LowPowerMine at: 2@1} randomizingWith: self.
	mineField movePlayerRight.
	
	self assert: mineField isOver.
	self deny: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test37CannotMoveWhenGameIsOver

	| mineField |
	
	mineField :=  MineField extent: 3@3 startingInPosition: 1@1 withLives: 1 elements: {LowPowerMine at: 2@2} randomizingWith: self.
	mineField movePlayerRight;movePlayerUp.
	
	self 
		assertIsOverWhenMoving: [mineField movePlayerUp ] in: mineField;
		assertIsOverWhenMoving: [ mineField movePlayerDown ] in: mineField;
		assertIsOverWhenMoving: [ mineField movePlayerRight ] in: mineField;
		assertIsOverWhenMoving: [ mineField movePlayerLeft ] in: mineField
		
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 12:00:12'!
test38TunnelMustHaveDifferentHoles

	self 
		should: [ Tunnel at: 1@1 and: 1@1 ]
		raise: Error
		withMessageText: Tunnel holesMustBeAtDifferentPositionsErrorDescription! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 12:16:11'!
test39TunnelErrorsWhenAskForExitingFromInvalidHole

	| tunnel |
	
	tunnel := Tunnel at: 1@1 and: 2@2.
	
	self 
		should: [ tunnel exitWhenEnteringAt: 3@3 ]
		raise: Error
		withMessageText: Tunnel invalidHoleErrorDescription! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 18:34:31'!
test40ElementsMustBeInsideBoard

	self
		should: [ MineField extent: 2@2 startingInPosition: 1@1 withLives: 1 elements: { LowPowerMine at: 3@3 } randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField fieldElementsMustBeInsideBoardErrorDescription! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:54'!
test41_bothTeamsShouldHaveTheSameTotalLives

"Estuve siguiento las recomendaciones, para cuando escribo este test, ya existe el soldado con bayoneta y el minefield ya tiene dos equipos, uno con un solo jugador y el otro vacio. Para este punto los equipos son solo colecciones ordenadas."

	| fstTeam sndTeam |
	
	fstTeam := {BayonetSoldier inPosition: 1@1 withHP: 5.}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 4.}.
		
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: {} randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:49'!
test42_bothTeamsShouldHaveTheSameNumberOfPlayers

	| fstTeam sndTeam |
	
	fstTeam := {BayonetSoldier inPosition: 1@1 withHP: 5.}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 4. BayonetSoldier inPosition: 2@10 withHP: 1.}.
		
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: {} randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:46'!
test43_allFirstTeamPlayersShouldStartInTheFirstRow

	| fstTeam sndTeam |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@2 withHP: 5. BayonetSoldier inPosition: 1@3 withHP: 5. BayonetSoldier inPosition: 1@1 withHP: 5.}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 4. BayonetSoldier inPosition: 2@10 withHP: 1.BayonetSoldier inPosition: 3@10 withHP: 10.}.
		
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: {} randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:43'!
test44_allSecondTeamPlayersShouldStartInTheUpperRow

	| fstTeam sndTeam |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: 5. BayonetSoldier inPosition: 2@1 withHP: 5. BayonetSoldier inPosition: 3@1 withHP: 5.}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 4. BayonetSoldier inPosition: 2@9 withHP: 1.BayonetSoldier inPosition: 3@7 withHP: 10.}.
		
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: {} randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:40'!
test45_allFirstTeamSoldiersAreInDifferentPositions

	| fstTeam sndTeam |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: 5. BayonetSoldier inPosition: 1@1 withHP: 6}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 5. BayonetSoldier inPosition: 2@10 withHP: 6}.
		
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: {} randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:37'!
test46_allSecondTeamSoldiersAreInDifferentPositions

	| fstTeam sndTeam |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: 5. BayonetSoldier inPosition: 2@1 withHP: 6}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 5. BayonetSoldier inPosition: 1@10 withHP: 6}.
		
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: {} randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:34'!
test47_playersCannotStartOffOnTopOfItems

	| fstTeam sndTeam fieldElements |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: 5. BayonetSoldier inPosition: 2@1 withHP: 6}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 5. BayonetSoldier inPosition: 2@10 withHP: 6}.
	fieldElements := {HighPowerMine at: 2@10. LowPowerMine at: 1@10 . Tunnel at: 1@1  and: 2@1}.
	
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:30'!
test48_playersCannotStartOffOnTopOfItems

	| fstTeam sndTeam fieldElements |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: 5. BayonetSoldier inPosition: 2@1 withHP: 6}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 5. BayonetSoldier inPosition: 2@10 withHP: 6}.
	fieldElements := {HighPowerMine at: 2@10. LowPowerMine at: 1@10 . Tunnel at: 1@1  and: 2@1}.
	
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:27'!
test49_playerLivesArePositive

	| fstTeam sndTeam fieldElements |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: -5. BayonetSoldier inPosition: 2@1 withHP: 6}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: -5. BayonetSoldier inPosition: 2@10 withHP: 6}.
	fieldElements := {}.
	
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:52:23'!
test50_playerLivesAreIntegers

	| fstTeam sndTeam fieldElements |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: 5. BayonetSoldier inPosition: 2@1 withHP: 1.6}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 5. BayonetSoldier inPosition: 2@10 withHP: 1.6}.
	fieldElements := {}.
	
	self 
		should: [MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidTeamsErrorMessage.
		

	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:54:02'!
test51_firstTeamPlaysFirst

	| fstTeam sndTeam fieldElements aMineField |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: 5. BayonetSoldier inPosition: 2@1 withHP: 6}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 5. BayonetSoldier inPosition: 2@10 withHP: 6}.
	fieldElements := {}.
	
	aMineField := MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self .
	
	self assert: aMineField itsFirstTeamsTurn.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 19:55:16'!
test52_itsSndTeamsTurnAfterPlaying

	| fstTeam sndTeam fieldElements aMineField |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: 5. BayonetSoldier inPosition: 2@1 withHP: 6}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 5. BayonetSoldier inPosition: 2@10 withHP: 6}.
	fieldElements := {}.
	
	aMineField := MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self .
	
	aMineField movePlayerUp.
	
	self deny: aMineField itsFirstTeamsTurn.
	self assert: aMineField itsSecondTeamsTurn.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 20:02:53'!
test53_itsCorrectTeamTurnAfterBothTeamsPlay

	| fstTeam sndTeam fieldElements aMineField |
	
	fstTeam :=   {BayonetSoldier inPosition: 1@1 withHP: 5. BayonetSoldier inPosition: 2@1 withHP: 6}.
	sndTeam := {BayonetSoldier inPosition: 1@10 withHP: 5. BayonetSoldier inPosition: 2@10 withHP: 6}.
	fieldElements := {}.
	
	aMineField := MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self .
	
	aMineField movePlayerUp ; movePlayerUp ; movePlayerDown ; movePlayerRight.
	
	self assert: aMineField itsFirstTeamsTurn.
	self deny: aMineField itsSecondTeamsTurn.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 20:40:59'!
test54_correctPlayerTurnsAfterMovingOnce

	| fstTeam sndTeam fieldElements aMineField fstPlayer sndPlayer |
	
	fstPlayer := BayonetSoldier inPosition: 1@1 withHP: 5.
	sndPlayer := BayonetSoldier inPosition: 1@10 withHP: 6.
	
	fstTeam :=   {fstPlayer . BayonetSoldier inPosition: 2@1 withHP: 6}.
	sndTeam := {sndPlayer. BayonetSoldier inPosition: 2@10 withHP: 5}.
	fieldElements := {}.
	
	aMineField := MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self .
	
	self assert: (aMineField isPlayersTurn: fstPlayer).
	
	aMineField movePlayerUp.
	
	self assert: (aMineField isPlayersTurn: sndPlayer).
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 20:49:04'!
test55_correctPlayerTurnsAfterMovingManyTimes

	| fstTeam sndTeam fieldElements aMineField fstPlayer sndPlayer frthPlayer thrdPlayer |
	
	fstPlayer := BayonetSoldier inPosition: 1@1 withHP: 5.
	sndPlayer := BayonetSoldier inPosition: 1@10 withHP: 6.
	thrdPlayer := BayonetSoldier inPosition: 2@1 withHP: 6.
	frthPlayer :=  BayonetSoldier inPosition: 2@10 withHP: 5.
	
	fstTeam :=   {fstPlayer . thrdPlayer }.
	sndTeam := {sndPlayer. frthPlayer }.
	
	fieldElements := {}.
	
	aMineField := MineField extent: (10@10) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self .
	
	self assert: (aMineField isPlayersTurn: fstPlayer).
	
	aMineField movePlayerUp.
	self assert: (aMineField isPlayersTurn: sndPlayer).
	
	aMineField movePlayerDown.
	self assert: (aMineField isPlayersTurn: thrdPlayer).
	
	aMineField movePlayerLeft.
	self assert: (aMineField isPlayersTurn: frthPlayer ).
	
	aMineField movePlayerRight.
	self assert: (aMineField isPlayersTurn: fstPlayer ).
	
	aMineField movePlayerUp.
	self assert: (aMineField isPlayersTurn: sndPlayer ).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 20:52:02'!
test56_gameEndsWhenFirstTeamsPlayerGetsToTheUpperRow

	| fstTeam sndTeam fieldElements aMineField fstPlayer sndPlayer |
	
	fstPlayer := BayonetSoldier inPosition: 1@1 withHP: 5.
	sndPlayer := BayonetSoldier inPosition: 1@3 withHP: 5.
	
	fstTeam :=   {fstPlayer }.
	sndTeam := {sndPlayer}.
	
	fieldElements := {}.
	
	aMineField := MineField extent: (3@3) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self .
	
	aMineField movePlayerUp.
	self deny: (aMineField isOver). 
	
	aMineField movePlayerUp.
	self deny: (aMineField isOver).
	
	aMineField movePlayerUp .
	self assert: (aMineField isOver). ! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 20:52:53'!
test57_gameEndsWhenSecondTeamsPlayerGetsToTheLowerRow

	| fstTeam sndTeam fieldElements aMineField fstPlayer sndPlayer |
	
	fstPlayer := BayonetSoldier inPosition: 1@1 withHP: 5.
	sndPlayer := BayonetSoldier inPosition: 1@3 withHP: 5.
	
	fstTeam :=   {fstPlayer }.
	sndTeam := {sndPlayer}.
	
	fieldElements := {}.
	
	aMineField := MineField extent: (3@3) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self .
	
	aMineField movePlayerLeft.
	self deny: (aMineField isOver). 
	
	aMineField movePlayerDown.
	self deny: (aMineField isOver).
	
	aMineField movePlayerRight .
	self deny: (aMineField isOver). 
	
	aMineField movePlayerDown.
	self assert: (aMineField isOver).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 21:06:16'!
test58_gameEndsWhenAllPlayersAreDead

	| fstTeam sndTeam fieldElements aMineField fstPlayer sndPlayer |
	
	fstPlayer := BayonetSoldier inPosition: 1@1 withHP: 1.
	sndPlayer := BayonetSoldier inPosition: 2@3 withHP: 1.
	
	fstTeam :=   {fstPlayer }.
	sndTeam := {sndPlayer}.
	
	fieldElements := {LowPowerMine at: 2@2 . LowPowerMine at: 1@2 }.
	
	aMineField := MineField extent: (2@3) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self .
	
	self deny: (aMineField isOver).
	aMineField movePlayerUp.
	self deny: (aMineField isOver). 
	aMineField movePlayerDown.
	self assert: (aMineField isOver).
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Ms 12/11/2023 21:15:43'!
test59_whenAPlayerDiesHeCantPlayAnymore

	| fstTeam sndTeam fieldElements aMineField fstPlayer sndPlayer frthPlayer thrdPlayer |
	
	fstPlayer := BayonetSoldier inPosition: 1@1 withHP: 1.
	sndPlayer := BayonetSoldier inPosition: 1@4 withHP: 2.
	thrdPlayer := BayonetSoldier inPosition: 2@1 withHP: 5.
	frthPlayer :=  BayonetSoldier inPosition: 2@4 withHP: 4.
	
	fstTeam :=   {fstPlayer . thrdPlayer }.
	sndTeam := {sndPlayer. frthPlayer }.
	
	fieldElements := {LowPowerMine at: 1@2}.
	
	aMineField := MineField extent: (4@4) withFirstTeam: fstTeam andSecondTeam: sndTeam elements: fieldElements randomizingWith: self .
	
	aMineField movePlayerUp. "<- murio frstPlayer"
	
	self assert: (aMineField isPlayersTurn: sndPlayer).
	
	aMineField movePlayerLeft. 
	
	self assert: (aMineField isPlayersTurn: thrdPlayer).
	
	aMineField movePlayerLeft. 
	
	self assert: (aMineField isPlayersTurn: frthPlayer ).
	
	aMineField movePlayerLeft.
	
	self deny: (aMineField isPlayersTurn: fstPlayer ).
	self assert: (aMineField isPlayersTurn: thrdPlayer).
	! !


!MineFieldTest methodsFor: 'random simulation' stamp: 'HAW 11/27/2023 19:19:32'!
nextInteger: aMaxValue

	| random |
	
	random := randoms peek.
	randoms next.
	
	^random! !

!MineFieldTest methodsFor: 'random simulation' stamp: 'HAW 11/27/2023 20:03:52'!
randomPositionIncrementsAre: aCollectionOfRandoms 
	
	randoms := ReadStream on: (aCollectionOfRandoms collect: [ :aPosition | aPosition + 4 ])! !


!MineFieldTest methodsFor: 'assertions' stamp: 'Ms 12/11/2023 18:34:31'!
assertCannotSharePositionsFor: elements

	self
		should: [ MineField 
			extent: 3@3 
			startingInPosition: 1@1 
			withLives: 2 
			elements: elements
			randomizingWith: self. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField fieldElementsShouldNotSharePositionsErrorDescription! !

!MineFieldTest methodsFor: 'assertions' stamp: 'HAW 12/4/2023 11:58:37'!
assertIsOverWhenMoving: aMovingBlock in: aMineField

	self 
		should: aMovingBlock 
		raise:  Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MineField gameIsOverErrorDescription.
			self assert: (aMineField isPlayerAt: 2@2) ]. 
	! !


!classDefinition: #Armor category: 'ISW1-2023-2C-Recuperatorio'!
Object subclass: #Armor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!Armor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:37'!
defendFromHighPowerMine: aHighPowerMine in: aMineField

	self subclassResponsibility! !

!Armor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:41'!
defendFromLowPowerMine: aLowPowerMine in: aMineField

	self subclassResponsibility! !


!Armor methodsFor: 'flying' stamp: 'HAW 12/4/2023 09:35:05'!
flyingThroughtTheAirStep: aMineField

	^ (aMineField nextInteger: 7) - 4 @ ((aMineField nextInteger: 7) - 4)! !


!classDefinition: #HeavyArmor category: 'ISW1-2023-2C-Recuperatorio'!
Armor subclass: #HeavyArmor
	instanceVariableNames: 'usedTimesWithLowPowerMine'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!HeavyArmor methodsFor: 'defend from mine' stamp: 'HAW 11/27/2023 20:04:16'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	aMineField armorUsed.
	^0@0! !

!HeavyArmor methodsFor: 'defend from mine' stamp: 'HAW 12/2/2023 20:38:07'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	usedTimesWithLowPowerMine := usedTimesWithLowPowerMine + 1.
	usedTimesWithLowPowerMine = 2 ifTrue: [ aMineField armorUsed ]! !


!HeavyArmor methodsFor: 'initialization' stamp: 'HAW 12/2/2023 20:38:26'!
initialize

	super initialize.
	usedTimesWithLowPowerMine := 0.! !


!classDefinition: #LightArmor category: 'ISW1-2023-2C-Recuperatorio'!
Armor subclass: #LightArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!LightArmor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:28'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	| step |
	
	aMineField armorUsed.
	step := (self flyingThroughtTheAirStep: aMineField) // 2.
	
	^step
! !

!LightArmor methodsFor: 'defend from mine' stamp: 'HAW 11/28/2023 10:21:42'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	aMineField armorUsed! !


!classDefinition: #NoArmor category: 'ISW1-2023-2C-Recuperatorio'!
Armor subclass: #NoArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!NoArmor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 11:00:16'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	| step |
	
	aMineField decreasePlayerLives; decreasePlayerLives.
	step := self flyingThroughtTheAirStep: aMineField.
	
	^step
	! !

!NoArmor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 11:00:16'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	aMineField decreasePlayerLives ! !


!classDefinition: #BayonetSoldier category: 'ISW1-2023-2C-Recuperatorio'!
Object subclass: #BayonetSoldier
	instanceVariableNames: 'position lives armor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!BayonetSoldier methodsFor: 'testing' stamp: 'Ms 12/11/2023 17:39:25'!
currentLives

	^lives! !

!BayonetSoldier methodsFor: 'testing' stamp: 'Ms 12/11/2023 17:38:56'!
isAlive

	^ lives > 0.! !

!BayonetSoldier methodsFor: 'testing' stamp: 'Ms 12/11/2023 17:34:11'!
isAt: aPosition

	^position = aPosition ! !

!BayonetSoldier methodsFor: 'testing' stamp: 'Ms 12/11/2023 19:01:35'!
isInRow: aRow

	^position y = aRow! !

!BayonetSoldier methodsFor: 'testing' stamp: 'Ms 12/11/2023 17:35:20'!
isPlayerAtTopRowInFieldWithExtensions: boardExtent

	^ position y = boardExtent y! !

!BayonetSoldier methodsFor: 'testing' stamp: 'Ms 12/11/2023 17:44:57'!
position

	^position ! !


!BayonetSoldier methodsFor: 'stepping on items' stamp: 'Ms 12/11/2023 17:37:16'!
armorUsed

	armor := NoArmor new! !

!BayonetSoldier methodsFor: 'stepping on items' stamp: 'Ms 12/11/2023 17:38:56'!
decreasePlayerLives

	lives := lives - 1! !

!BayonetSoldier methodsFor: 'stepping on items' stamp: 'Ms 12/11/2023 17:52:40'!
defendFromHighPowerMine: aHighPowerMine in: aMineField

	^armor defendFromHighPowerMine: aHighPowerMine in: aMineField.! !

!BayonetSoldier methodsFor: 'stepping on items' stamp: 'Ms 12/11/2023 17:52:57'!
defendFromLowPowerMine: aLowPowerMine in: aMineField

	^armor defendFromLowPowerMine: aLowPowerMine in: aMineField.

	! !

!BayonetSoldier methodsFor: 'stepping on items' stamp: 'Ms 12/11/2023 17:46:49'!
wearArmor: anArmorRack

	armor := anArmorRack ! !


!BayonetSoldier methodsFor: 'initialization' stamp: 'Ms 12/11/2023 17:39:04'!
initializeInPosition: aStartingPosition withLives: aNumberOfLives

	position := aStartingPosition.
	lives := aNumberOfLives .
	armor := NoArmor new.! !


!BayonetSoldier methodsFor: 'moving' stamp: 'Ms 12/11/2023 17:45:50'!
moveTo: newPosition

	position := newPosition.! !

!BayonetSoldier methodsFor: 'moving' stamp: 'Ms 12/11/2023 18:02:15'!
takeStep: aStep within: boardExtent 

	position := ({{position x + aStep x . boardExtent x} min . 1 } max)@({{position y + aStep y . boardExtent y} min . 1 } max)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BayonetSoldier class' category: 'ISW1-2023-2C-Recuperatorio'!
BayonetSoldier class
	instanceVariableNames: ''!

!BayonetSoldier class methodsFor: 'as yet unclassified' stamp: 'Ms 12/11/2023 17:39:04'!
inPosition: aStartingPosition withHP: aNumberOfLives

	^ self new initializeInPosition: aStartingPosition withLives: aNumberOfLives.! !


!classDefinition: #FieldElement category: 'ISW1-2023-2C-Recuperatorio'!
Object subclass: #FieldElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!FieldElement methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField

	self subclassResponsibility! !


!classDefinition: #EmptyFieldElement category: 'ISW1-2023-2C-Recuperatorio'!
FieldElement subclass: #EmptyFieldElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!EmptyFieldElement methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	! !


!classDefinition: #NotEmptyFieldPosition category: 'ISW1-2023-2C-Recuperatorio'!
FieldElement subclass: #NotEmptyFieldPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!NotEmptyFieldPosition methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:42:40'!
isAt: aPosition

	self subclassResponsibility! !

!NotEmptyFieldPosition methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:42:12'!
isSharingPositionWith: aFieldElement

	self subclassResponsibility! !


!classDefinition: #ArmorRack category: 'ISW1-2023-2C-Recuperatorio'!
NotEmptyFieldPosition subclass: #ArmorRack
	instanceVariableNames: 'position armor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!ArmorRack methodsFor: 'initialization' stamp: 'HAW 11/27/2023 20:00:21'!
initializeAt: aPosition with: anArmor
	
	position := aPosition.
	armor := anArmor ! !


!ArmorRack methodsFor: 'position testing' stamp: 'HAW 11/27/2023 19:28:56'!
isAt: aPosition

	^position = aPosition ! !

!ArmorRack methodsFor: 'position testing' stamp: 'HAW 12/4/2023 12:26:10'!
isInsideBoardOf: anExtent 
	
	^position between: 1@1 and: anExtent ! !

!ArmorRack methodsFor: 'position testing' stamp: 'HAW 12/2/2023 21:04:55'!
isSharingPositionWith: aFieldElement 
	
	^aFieldElement isAt: position ! !


!ArmorRack methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoArmorRack: self with: armor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ArmorRack class' category: 'ISW1-2023-2C-Recuperatorio'!
ArmorRack class
	instanceVariableNames: ''!

!ArmorRack class methodsFor: 'instance creation' stamp: 'HAW 11/27/2023 20:00:05'!
at: aPosition with: anArmor

	^self new initializeAt: aPosition with: anArmor! !


!classDefinition: #Mine category: 'ISW1-2023-2C-Recuperatorio'!
NotEmptyFieldPosition subclass: #Mine
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!Mine methodsFor: 'initialization' stamp: 'HAW 11/27/2023 19:08:03'!
initializeAt: aPosition 
	
	position := aPosition.! !


!Mine methodsFor: 'position testing' stamp: 'HAW 11/27/2023 19:08:09'!
isAt: aPosition 
	
	^position = aPosition ! !

!Mine methodsFor: 'position testing' stamp: 'HAW 12/4/2023 12:25:42'!
isInsideBoardOf: anExtent 
	
	^position between: 1@1 and: anExtent ! !

!Mine methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:43:04'!
isSharingPositionWith: aFieldElement 
	
	^aFieldElement isAt: position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mine class' category: 'ISW1-2023-2C-Recuperatorio'!
Mine class
	instanceVariableNames: ''!

!Mine class methodsFor: 'instance creation' stamp: 'HAW 11/28/2023 12:55:22'!
at: aPosition 
	
	^self new initializeAt: aPosition! !


!classDefinition: #HighPowerMine category: 'ISW1-2023-2C-Recuperatorio'!
Mine subclass: #HighPowerMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!HighPowerMine methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoHighPowerMine: self! !


!classDefinition: #LowPowerMine category: 'ISW1-2023-2C-Recuperatorio'!
Mine subclass: #LowPowerMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!LowPowerMine methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoLowPowerMine: self! !


!classDefinition: #Tunnel category: 'ISW1-2023-2C-Recuperatorio'!
NotEmptyFieldPosition subclass: #Tunnel
	instanceVariableNames: 'hole anotherHole'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!Tunnel methodsFor: 'initialization' stamp: 'HAW 12/2/2023 20:44:14'!
initializeAt: aHole and: anAnotherHole 
	
	hole := aHole.
	anotherHole := anAnotherHole.! !


!Tunnel methodsFor: 'position testing' stamp: 'HAW 12/2/2023 20:45:30'!
isAt: aPosition 
	
	^hole = aPosition or: [ anotherHole = aPosition ]! !

!Tunnel methodsFor: 'position testing' stamp: 'HAW 12/4/2023 12:26:43'!
isInsideBoardOf: anExtent 
	
	^(hole between: 1@1 and: anExtent) and: [ anotherHole between: 1@1 and: anExtent ]! !

!Tunnel methodsFor: 'position testing' stamp: 'HAW 12/2/2023 21:08:52'!
isSharingPositionWith: aFieldElement 
	
	^(aFieldElement isAt: hole) or: [ aFieldElement isAt: anotherHole ]! !


!Tunnel methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 12:04:59'!
exitWhenEnteringAt: aPosition 
	
	aPosition = hole ifTrue: [ ^anotherHole ].
	aPosition = anotherHole ifTrue: [ ^hole ].
	
	self error: self class invalidHoleErrorDescription 
	
	
	! !

!Tunnel methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoTunnel: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tunnel class' category: 'ISW1-2023-2C-Recuperatorio'!
Tunnel class
	instanceVariableNames: ''!

!Tunnel class methodsFor: 'instance creation' stamp: 'HAW 12/4/2023 12:02:03'!
assert: aHole doesNotSharePositionWith: anotherHole

	^ aHole = anotherHole ifTrue: [ self error: self holesMustBeAtDifferentPositionsErrorDescription ]! !

!Tunnel class methodsFor: 'instance creation' stamp: 'HAW 12/4/2023 12:02:03'!
at: aHole and: anotherHole 
	
	self assert: aHole doesNotSharePositionWith: anotherHole.
	
	^self new initializeAt: aHole and: anotherHole ! !


!Tunnel class methodsFor: 'error description' stamp: 'HAW 12/4/2023 12:00:43'!
holesMustBeAtDifferentPositionsErrorDescription
	
	^'Holes must be at different positions'! !

!Tunnel class methodsFor: 'error description' stamp: 'HAW 12/4/2023 12:04:05'!
invalidHoleErrorDescription
	
	^'Invalid hole'! !


!classDefinition: #MineField category: 'ISW1-2023-2C-Recuperatorio'!
Object subclass: #MineField
	instanceVariableNames: 'boardExtent fieldElements random firstTeam secondTeam teams firstTeamPlayers secondTeamPlayers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!MineField methodsFor: 'initialization' stamp: 'Ms 12/11/2023 21:44:51'!
initializeExtent: anExtent withFirstTeam: aTeam andASecondTeam: aSecondTeam elements: aCollectionOfFieldElements randomizingWith: aRandom   

	boardExtent := anExtent.
	fieldElements := aCollectionOfFieldElements asOrderedCollection .
	random := aRandom.
	
	firstTeamPlayers := aTeam.
	secondTeamPlayers := aSecondTeam.
	firstTeam := CircularReadStream on: aTeam moving: NullUnit new.
	secondTeam := CircularReadStream on: aSecondTeam moving: NullUnit new.
	
	teams := CircularReadStream on: {firstTeam . secondTeam} moving: NullUnit new.! !


!MineField methodsFor: 'random' stamp: 'HAW 11/28/2023 12:53:15'!
nextInteger: aMaxInteger

	^random nextInteger: aMaxInteger ! !


!MineField methodsFor: 'testing' stamp: 'Ms 12/11/2023 21:35:13'!
allPlayersAreDead

	^ (firstTeamPlayers allSatisfy: [:aPlayer | aPlayer isAlive not]) and: (secondTeamPlayers allSatisfy: [:aPlayer | aPlayer isAlive not])! !

!MineField methodsFor: 'testing' stamp: 'HAW 12/4/2023 10:48:44'!
hasPlayerWon
	
	^self isOver and: [ self isPlayerStillAlive ]! !

!MineField methodsFor: 'testing' stamp: 'Ms 12/11/2023 21:35:17'!
isOver
	
	^(firstTeamPlayers anySatisfy: [:aPlayer | aPlayer isInRow: boardExtent y.]) or: [secondTeamPlayers anySatisfy: [:aPlayer | aPlayer isInRow: 1.]] or:  (self allPlayersAreDead)! !

!MineField methodsFor: 'testing' stamp: 'Ms 12/11/2023 18:19:36'!
isPlayerAt: aPosition

	^self currentPlayer isAt: aPosition. ! !

!MineField methodsFor: 'testing' stamp: 'Ms 12/11/2023 20:27:40'!
isPlayerAtTopRow

	^ self currentPlayer isPlayerAtTopRowInFieldWithExtensions: boardExtent.! !

!MineField methodsFor: 'testing' stamp: 'Ms 12/11/2023 18:19:47'!
isPlayerStillAlive

	^  self currentPlayer isAlive.! !


!MineField methodsFor: 'player' stamp: 'Ms 12/11/2023 18:16:49'!
armorUsed
	
	self currentPlayer armorUsed.
	! !

!MineField methodsFor: 'player' stamp: 'Ms 12/11/2023 20:24:58'!
currentPlayer

	^(self currentTeam) current.! !

!MineField methodsFor: 'player' stamp: 'Ms 12/11/2023 18:17:22'!
decreasePlayerLives
	
	self currentPlayer decreasePlayerLives.! !

!MineField methodsFor: 'player' stamp: 'Ms 12/11/2023 18:17:27'!
playerLives
	
	^self currentPlayer currentLives.! !


!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:24:49'!
movePlayerDown
	
	self movePlayer: 0@-1! !

!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:25:00'!
movePlayerLeft
	
	self movePlayer: -1@0! !

!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:25:09'!
movePlayerRight
	
	self movePlayer: 1@0! !

!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:24:20'!
movePlayerUp
	
	self movePlayer: 0@1! !


!MineField methodsFor: 'moving - private' stamp: 'Ms 12/11/2023 18:18:57'!
fieldElementAtPlayerPosition

	^ fieldElements detect: [ :aFieldElement | aFieldElement isAt: self currentPlayer position] ifNone: [ EmptyFieldElement new ]! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/4/2023 11:01:47'!
isInBoard: aPosition

	^ aPosition between: 1@1 and: boardExtent! !

!MineField methodsFor: 'moving - private' stamp: 'Ms 12/11/2023 20:45:22'!
movePlayer: aStep

	self movePlayer: aStep ifGameOver: [ self error: self class gameIsOverErrorDescription ].
	self nextPlayersTurn.! !

!MineField methodsFor: 'moving - private' stamp: 'Ms 12/11/2023 18:17:40'!
movePlayer: aStep ifGameOver: aBlock

	
	self isOver ifTrue: [ ^aBlock value ].
	
	self currentPlayer takeStep: aStep within: boardExtent .
	
	self fieldElementAtPlayerPosition playerSteppedIntoFrom: self
	
	! !


!MineField methodsFor: 'steep into field element' stamp: 'Ms 12/11/2023 18:17:46'!
playerSteppedIntoArmorRack: anArmorRack with: anArmor 
	
	self currentPlayer wearArmor: anArmor.
	self removeFieldElement: anArmorRack ! !

!MineField methodsFor: 'steep into field element' stamp: 'Ms 12/11/2023 18:17:52'!
playerSteppedIntoHighPowerMine: aHighPowerMine 
	
	| step |
	
	step := self currentPlayer defendFromHighPowerMine: aHighPowerMine in: self.
	self removeFieldElement: aHighPowerMine .
	self movePlayer: step ifGameOver: []
	
! !

!MineField methodsFor: 'steep into field element' stamp: 'Ms 12/11/2023 18:17:58'!
playerSteppedIntoLowPowerMine: aLowPowerMine 
	
	self currentPlayer defendFromLowPowerMine: aLowPowerMine in: self.
	self removeFieldElement: aLowPowerMine ! !

!MineField methodsFor: 'steep into field element' stamp: 'Ms 12/11/2023 18:20:19'!
playerSteppedIntoTunnel: aTunnel 
	
	| exitPosition |
	
	exitPosition := aTunnel exitWhenEnteringAt: self currentPlayer position.
	self currentPlayer moveTo: exitPosition.! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 11/27/2023 19:01:18'!
removeFieldElement: aFieldElement 
	
	fieldElements remove: aFieldElement ! !


!MineField methodsFor: 'teams' stamp: 'Ms 12/11/2023 20:21:44'!
currentTeam 

	^ (teams current).
	! !

!MineField methodsFor: 'teams' stamp: 'Ms 12/11/2023 20:06:48'!
isPlayersTurn: aPlayer

	^ self currentPlayer = aPlayer
	
	! !

!MineField methodsFor: 'teams' stamp: 'Ms 12/11/2023 19:56:25'!
itsFirstTeamsTurn
	
	^self currentTeam = firstTeam 
	! !

!MineField methodsFor: 'teams' stamp: 'Ms 12/11/2023 20:01:11'!
itsSecondTeamsTurn
	
	^ self currentTeam = secondTeam ! !

!MineField methodsFor: 'teams' stamp: 'Ms 12/11/2023 21:16:23'!
nextPlayersTurn

	(self currentTeam next). 
	teams next.
	(secondTeamPlayers isEmpty) ifTrue: [teams next.].
	(self currentPlayer isAlive) ifFalse: [self currentTeam next].
	
							! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineField class' category: 'ISW1-2023-2C-Recuperatorio'!
MineField class
	instanceVariableNames: ''!

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/5/2023 16:50:37'!
assert: aCollectionOfFieldElements areInsideBoardOfExtent: anExtent

	(aCollectionOfFieldElements allSatisfy: [ :aFieldElement | aFieldElement isInsideBoardOf: anExtent ]) 
		ifFalse: [ self error: self fieldElementsMustBeInsideBoardErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:56:39'!
assert: aStartingPosition isAtFirstRow: anExtent

	(aStartingPosition between: 1@1 and: anExtent x @ 1) ifFalse: [self error: self invalidStartingPositionErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:57:00'!
assert: aStartingPosition isInBoundsFor: anExtent andNotUsedBy: aCollectionOfFieldElements .
	
	self assert: aStartingPosition isAtFirstRow: anExtent.
	self assert: aStartingPosition isNotUsedBy: aCollectionOfFieldElements! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:57:00'!
assert: aStartingPosition isNotUsedBy: aCollectionOfFieldElements

	^ (aCollectionOfFieldElements anySatisfy: [ :aFieldElement | aFieldElement isAt: aStartingPosition ]) 
		ifTrue: [self error: self invalidStartingPositionErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/7/2023 23:20:51'!
assertElementsDoNotSharePosition: aCollectionOfFieldElements

	aCollectionOfFieldElements combinations: 2 atATimeDo: [ :elements |
		(elements first isSharingPositionWith: elements second) ifTrue: [
			self error: self fieldElementsShouldNotSharePositionsErrorDescription ]]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/4/2023 11:12:42'!
assertIsValidExtent: anExtent

	^ anExtent >=(2@2) ifFalse: [ self error: self invalidBoardExtentErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:57:32'!
assertIsValidNumberOfLives: aNumberOfLives

	^ (aNumberOfLives strictlyPositive and: [ aNumberOfLives isInteger ]) ifFalse: [ self error: self invalidNumberOfLivesErrorDescription ]! !


!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/4/2023 12:20:01'!
fieldElementsMustBeInsideBoardErrorDescription
	
	^'Field elements must be inside board'
! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/2/2023 21:00:39'!
fieldElementsShouldNotSharePositionsErrorDescription
	
	^'Field elements should not share positions'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/2/2023 21:30:59'!
gameIsOverErrorDescription
	
	^'Cannot move when game is over'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 11/27/2023 11:51:11'!
invalidBoardExtentErrorDescription
	
	^'Board extent must be greater or equal to 2@2'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 11/27/2023 12:00:56'!
invalidNumberOfLivesErrorDescription
	
	^'Number of lives must be an strictly positive integer'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 11/27/2023 12:13:28'!
invalidStartingPositionErrorDescription
	
	^'Player must start at an empty position, inside the board and at row 1'! !

!MineField class methodsFor: 'error descriptions' stamp: 'Ms 12/11/2023 18:49:06'!
invalidTeamsErrorMessage
	
	^'Both teams should have the same ammount of players and the same sum of health points!!'! !


!MineField class methodsFor: 'instance creation' stamp: 'Ms 12/11/2023 18:45:28'!
extent: anExtent startingInPosition: aPosition withLives: numberOfLives elements: aCollectionOfFieldElements randomizingWith: aRandom     
	
	self assertIsValidExtent: anExtent.
	self assert: aCollectionOfFieldElements areInsideBoardOfExtent: anExtent.
	self assertElementsDoNotSharePosition: aCollectionOfFieldElements.
	
	self assert: aPosition isInBoundsFor: anExtent andNotUsedBy: aCollectionOfFieldElements. 
	self assertIsValidNumberOfLives: numberOfLives.
	
	^self new initializeExtent: anExtent  withFirstTeam: {BayonetSoldier inPosition: aPosition withHP: numberOfLives } andASecondTeam: {} elements: aCollectionOfFieldElements randomizingWith: aRandom 
	
	
! !

!MineField class methodsFor: 'instance creation' stamp: 'Ms 12/11/2023 21:38:19'!
extent: anExtent withFirstTeam: firstTeam andSecondTeam: secondTeam elements: aCollectionOfFieldElements randomizingWith: aRandom     
	
	(firstTeam size = 1 and: [secondTeam size = 0])
	 ifTrue: [
		^ MineField extent: anExtent startingInPosition: (firstTeam at: 1) position withLives: (firstTeam at: 1) currentLives elements: aCollectionOfFieldElements randomizingWith: aRandom]. 
	
	self assertIsValidExtent: anExtent.
	self assert: aCollectionOfFieldElements areInsideBoardOfExtent: anExtent.
	self assertElementsDoNotSharePosition: aCollectionOfFieldElements.
	
	self assertTeam: firstTeam andTeam: secondTeam areValidInBoardWithExtent: anExtent andFieldElements: aCollectionOfFieldElements .
	
	^self new initializeExtent: anExtent withFirstTeam: firstTeam andASecondTeam: secondTeam elements: aCollectionOfFieldElements randomizingWith: aRandom    
! !


!MineField class methodsFor: 'team assertions' stamp: 'Ms 12/11/2023 19:17:42'!
assert: firstTeam hasTheSameSizeAndHealthPointsAs: secondTeam

	^((secondTeam size = firstTeam size) and:	 [(self teamHealthPoints: secondTeam) = (self teamHealthPoints: firstTeam)]) ifFalse: [self error: self invalidTeamsErrorMessage ].! !

!MineField class methodsFor: 'team assertions' stamp: 'Ms 12/11/2023 19:23:40'!
assert: aTeam playersAreAllInRow: aNumber

	^(aTeam allSatisfy: [:aPlayer | aPlayer isInRow: aNumber])  ifFalse: [self error: self invalidTeamsErrorMessage ].
	
! !

!MineField class methodsFor: 'team assertions' stamp: 'Ms 12/11/2023 19:39:48'!
assertPlayerLivesArePositiveIntegers: aTeam

	(aTeam allSatisfy: [:aPlayer | (aPlayer currentLives isInteger) and: [aPlayer currentLives > 0]]) ifFalse: [self error: self invalidTeamsErrorMessage ]! !

!MineField class methodsFor: 'team assertions' stamp: 'Ms 12/11/2023 19:21:33'!
assertPlayerPositionsAreDifferent: aTeam

	^((aTeam inject: Set new into: [:aSet :aPlayer | aSet add: aPlayer position ; yourself ]) size = aTeam size) ifFalse: [self error: self invalidTeamsErrorMessage ].! !

!MineField class methodsFor: 'team assertions' stamp: 'Ms 12/11/2023 19:34:06'!
assertPlayersOfTeam: aTeam areNotOnTopOfFieldElements: fieldElements

	(aTeam anySatisfy: [:aPlayer | fieldElements anySatisfy: [:anElement | anElement isAt: aPlayer position]]) ifTrue: [self error: self invalidTeamsErrorMessage.].! !

!MineField class methodsFor: 'team assertions' stamp: 'Ms 12/11/2023 19:38:53'!
assertTeam: firstTeam andTeam: secondTeam areValidInBoardWithExtent: anExtent andFieldElements: fieldElements 

	self assert: firstTeam hasTheSameSizeAndHealthPointsAs: secondTeam.
	
	self assert: firstTeam playersAreAllInRow: 1.
	self assert: secondTeam playersAreAllInRow: anExtent y.
	
	self assertPlayerPositionsAreDifferent: firstTeam.
	self assertPlayerPositionsAreDifferent: secondTeam.
	
	self assertPlayersOfTeam: firstTeam areNotOnTopOfFieldElements: fieldElements asOrderedCollection .
	self assertPlayersOfTeam: secondTeam areNotOnTopOfFieldElements: fieldElements asOrderedCollection .
	
	self assertPlayerLivesArePositiveIntegers: firstTeam.
	self assertPlayerLivesArePositiveIntegers: secondTeam .! !

!MineField class methodsFor: 'team assertions' stamp: 'Ms 12/11/2023 18:55:42'!
teamHealthPoints: aTeam

	^aTeam sum: [:aPlayer | aPlayer currentLives ].! !
