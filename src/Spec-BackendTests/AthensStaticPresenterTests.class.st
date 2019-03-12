Class {
	#name : #AthensStaticPresenterTests,
	#superclass : #AbstractAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #accessing }
AthensStaticPresenterTests >> circle: aSurface [
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

{ #category : #accessing }
AthensStaticPresenterTests >> classToTest [
	^ AthensStaticPresenter
]

{ #category : #accessing }
AthensStaticPresenterTests >> initializeTestedInstance [
	presenter drawBlock: [ "nothing to do" ].
	presenter surfaceExtent: 800@600
]

{ #category : #accessing }
AthensStaticPresenterTests >> testDrawedBlackSquareIsActuallyBlack [
	| form |
	self presenter
		drawBlock: [ :canvas | 
			canvas
				setPaint: Color black;
				setShape: (self circle: canvas surface);
				draw ].
	self adapter redraw.
	form := self adapter surface asForm.
	self assert: (form colorAt: 0 @ 0) equals: Color transparent.
	self assert: (form colorAt: 100 @ 100) equals: Color black.
]

{ #category : #accessing }
AthensStaticPresenterTests >> testPresentersBlockReceivesAthensCanvas [
	| receivedCanvas |
	self presenter drawBlock: [ :canvas | receivedCanvas := canvas ].
	self adapter redraw.
	self assert: receivedCanvas isNotNil.
	self assert: (receivedCanvas isKindOf: AthensCanvas)
]

{ #category : #accessing }
AthensStaticPresenterTests >> testSmokeCreates [
	self presenter .
	
]
