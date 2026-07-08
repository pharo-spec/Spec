Class {
	#name : 'SpMorphicBackendForTest',
	#superclass : 'SpAbstractBackendForTest',
	#traits : 'SpTMorphicUIRedrawer',
	#classTraits : 'SpTMorphicUIRedrawer classTrait',
	#instVars : [
		'app'
	],
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'asserting' }
SpMorphicBackendForTest >> assertHasHeader: anAdapter [
	self waitUntilUIRedrawed.

	self assert: (anAdapter widget instVarNamed: #showColumnHeaders)
]

{ #category : 'asserting' }
SpMorphicBackendForTest >> assertIcon: anAlphaImageMorph equals: aForm [ 
	
	self assert: (anAlphaImageMorph ifNotNil: #form) = aForm
]

{ #category : 'testing' }
SpMorphicBackendForTest >> assertImage: actual equals: expected [ 
	
	(expected isNil and: [ actual isNil or: [actual width = 1 and: [ actual height =1 ]] ]) ifTrue: [ ^ self ].
	
	self assert: actual width = expected width.
	self assert: actual height = expected height.	
	self assert: actual bits = expected bits.		
]

{ #category : 'asserting' }
SpMorphicBackendForTest >> assertList: anAdapter displayItems: aCollection [ 
	
	| tableContainer tableRowContents |
	
	self waitUntilUIRedrawed.
	
	tableContainer := anAdapter widget submorphs first.
	tableRowContents := tableContainer submorphs collect: [ :row | 
		| cell |
		cell := row submorphs first.
		(cell submorphs detect: [:e | e isKindOf: StringMorph]) contents ].
	
	self assert: tableRowContents first = aCollection first.
	self assert: tableRowContents second = aCollection second.
	self assert: tableRowContents third = aCollection third.
]

{ #category : 'asserting' }
SpMorphicBackendForTest >> assertListHeaderOf: anAdapter equals: aCollection [ 

	| tableContainer tableRowMorph cells |
	
	self waitUntilUIRedrawed.
	
	tableContainer := anAdapter widget submorphs first.
	tableRowMorph := tableContainer submorphs first.
	cells := tableRowMorph submorphs.
	
	self assert: (cells collect: [ :c | c submorphs first contents]) asArray = aCollection asArray
]

{ #category : 'testing' }
SpMorphicBackendForTest >> canChangeFonts [
	
	^ true
]

{ #category : 'emulating' }
SpMorphicBackendForTest >> clickFirstRowAndColumn: anAdapter [ 

	self waitUntilUIRedrawed.
	
	anAdapter widget mouseDown: (MouseEvent new
		setHand: HandMorph new;
		setPosition: anAdapter widget submorphs first submorphs first bounds center;
		yourself).

]

{ #category : 'asserting' }
SpMorphicBackendForTest >> denyHasHeader: anAdapter [ 

	| tableContainer |
	self waitUntilUIRedrawed.

	tableContainer := anAdapter widget submorphs first.
	self assert: tableContainer submorphs size = 3
]

{ #category : 'simulating' }
SpMorphicBackendForTest >> doubleClickFirstRowAndColumn: anAdapter [ 
	| event position |

	self waitUntilUIRedrawed.

	position := anAdapter widget submorphs first submorphs first bounds center.
	event := MouseButtonEvent new
		setType: #mouseDown
			position: position 
			buttons: 0
			hand: HandMorph new; 
		yourself.
		
	"simulating double click means send one mouseDown: and one double-click because 
	 when doing a real one, we always receive the first click then the one we want."
	anAdapter widget 
		mouseDown: event;
		doubleClick: event
]

{ #category : 'initialization' }
SpMorphicBackendForTest >> initialize [
	super initialize.
	self initializeSemaphore
]

{ #category : 'opening' }
SpMorphicBackendForTest >> openInstanceOf: aTest [

	aTest window ifNil: [ 
		aTest presenter application: app.
		aTest window: aTest presenter open ].

	self waitUntilUIRedrawed
]

{ #category : 'running' }
SpMorphicBackendForTest >> runTest: aBlock [
	app := SpApplication new.
	app useBackend: #Morphic.
	aBlock value
]
