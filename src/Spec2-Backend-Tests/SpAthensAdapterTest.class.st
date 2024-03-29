Class {
	#name : 'SpAthensAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpAthensAdapterTest >> circle: aSurface [
	^ aSurface
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: 50 @ 150;
				ccwArcTo: 150 @ 250 angle: 90 degreesToRadians;
				ccwArcTo: 250 @ 150 angle: 90 degreesToRadians;
				ccwArcTo: 150 @ 50 angle: 90 degreesToRadians;
				ccwArcTo: 50 @ 150 angle: 90 degreesToRadians]
]

{ #category : 'accessing' }
SpAthensAdapterTest >> classToTest [
	^ SpAthensPresenter
]

{ #category : 'initialization' }
SpAthensAdapterTest >> initializeTestedInstance [
	presenter drawBlock: [ "nothing to do" ].
	presenter surfaceExtent: 800@600
]

{ #category : 'tests' }
SpAthensAdapterTest >> testContextMenu [
	| menu changed |
	
	self assert: presenter contextMenu isNil.
	menu := SpMenuPresenter new.
	changed := false.
	presenter whenMenuChangedDo: [ 
		changed := true. ].
	presenter contextMenu: menu.
	self assert: presenter contextMenu equals: menu.
	self assert: changed
]

{ #category : 'tests' }
SpAthensAdapterTest >> testPresentersBlockReceivesAthensCanvas [
	| receivedCanvas |
	self presenter drawBlock: [ :canvas | receivedCanvas := canvas ].
	self adapter redraw.
	self openInstance.
	
	1 second wait.
	self assert: receivedCanvas isNotNil.
	self assert: (receivedCanvas isKindOf: AthensCanvas)
]

{ #category : 'tests' }
SpAthensAdapterTest >> testResizeMakesCanvasResize [
	| extent |
	
	self presenter drawBlock: [ :canvas |
		extent := canvas surface extent ].
	self openInstance.
	self presenter window resize: 500@500.
	backendForTest waitUntilUIRedrawed.
	self assert: extent x > 100. 
	self assert: extent y > 100.	
	self presenter window resize: 100@100.
	backendForTest waitUntilUIRedrawed.
	self assert: extent x < 100. 
	self assert: extent y < 100.
]
