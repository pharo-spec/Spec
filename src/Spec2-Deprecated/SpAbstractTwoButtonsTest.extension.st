Extension { #name : #SpAbstractTwoButtonsTest }

{ #category : #'*Spec2-Deprecated' }
SpAbstractTwoButtonsTest >> classToTest [
	^ SpTestingAbstractTwoButtons
]

{ #category : #'*Spec2-Deprecated' }
SpAbstractTwoButtonsTest class >> isDeprecated [
	"This presenter does not add enough value to Spec to be kept in it. If you are using it, please copy the code in your own application."

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpAbstractTwoButtonsTest >> testFirstActionSecondAction [
	| action1 action2 |
	action1 := false.
	action2 := false.
	presenter firstAction: [ action1 := true ] secondAction: [ action2 := true ].
	presenter firstButton performAction.
	presenter secondButton performAction.
	self assert: action1.
	self assert: action2
]

{ #category : #'*Spec2-Deprecated' }
SpAbstractTwoButtonsTest >> testFirstIconSecondIcon [
	presenter firstIcon: #thumbsUp secondIcon: #thumbsDown.
	self assert: presenter firstButton icon == (self iconNamed: #thumbsUp).
	self assert: presenter secondButton icon == (self iconNamed: #thumbsDown)
]

{ #category : #'*Spec2-Deprecated' }
SpAbstractTwoButtonsTest >> testFirstLabelSecondLabel [
	presenter firstLabel: 'label 1' secondLabel: 'label 2'.
	self assert: presenter firstButton label asString equals: 'label 1'.
	self assert: presenter secondButton label asString equals: 'label 2'
]
