Class {
	#name : #SpWindowPresenterTest,
	#superclass : #SpTest,
	#category : #'Spec2-Tests-Core'
}

{ #category : #running }
SpWindowPresenterTest >> classToTest [

	^ SpWindowPresenter
]

{ #category : #tests }
SpWindowPresenterTest >> testInitialPosition [

	presenter presenter: SpLabelPresenter new.
	presenter initialPosition: 100 @ 100.
	window := presenter openWithSpecLayout: SpLabelPresenter defaultSpec.
	self 
		assert: window adapter widget position 
		equals: 100 @ 100
]

{ #category : #tests }
SpWindowPresenterTest >> testIsClosed [

	self assert: presenter isClosed.
	presenter presenter: SpLabelPresenter new.
	window := presenter openWithSpecLayout: SpLabelPresenter defaultSpec.
	self deny: presenter isClosed.
	presenter close.
	self assert: presenter isClosed
	
]

{ #category : #tests }
SpWindowPresenterTest >> testWhenClosedDo [
	| closed |

	closed := false.
	presenter presenter: SpLabelPresenter new.
	presenter whenClosedDo: [ closed := true ].
	window := presenter openWithSpecLayout: SpLabelPresenter defaultSpec.
	presenter close.
	self assert: closed
]

{ #category : #tests }
SpWindowPresenterTest >> testWhenOpenedDo [
	| opened |

	opened := false.
	presenter presenter: SpLabelPresenter new.
	presenter whenOpenedDo: [ opened := true ].
	window := presenter openWithSpecLayout: SpLabelPresenter defaultSpec.
	self assert: opened

]

{ #category : #tests }
SpWindowPresenterTest >> testWhenWillCloseDo [
	| willClose closed |

	willClose := false.
	closed := false.
	presenter presenter: SpLabelPresenter new.
	presenter whenWillCloseDo: [ willClose := true ].
	presenter whenClosedDo: [ closed := willClose ].
	window := presenter openWithSpecLayout: SpLabelPresenter defaultSpec.
	presenter close.
	self assert: willClose.
	self assert: closed
]
