Class {
	#name : #AthensStaticPresenterTests,
	#superclass : #AbstractAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #accessing }
AthensStaticPresenterTests >> classToTest [
	^ AthensStaticPresenter
]

{ #category : #accessing }
AthensStaticPresenterTests >> initializeTestedInstance [
	presenter drawBlock: [ "nothing to do" ]
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
