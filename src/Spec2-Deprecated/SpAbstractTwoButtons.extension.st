Extension { #name : 'SpAbstractTwoButtons' }

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons classSide >> abstractExample [
	^ self new
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons >> firstAction: firstActionBlock secondAction: secondActionBlock [
	self firstButton action: firstActionBlock.
	self secondButton action: secondActionBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons >> firstButton [
	^ firstButton
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons >> firstIcon: firstIconName secondIcon: secondIconName [
	self firstButton icon: (self iconNamed: firstIconName).
	self secondButton icon: (self iconNamed: secondIconName)
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons >> firstLabel: firstLabel secondLabel: secondLabel [
	self firstButton label: firstLabel.
	self secondButton label: secondLabel
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons classSide >> horizontal [
	<spec>
	^ SpLayout composed
		newRow: [ :row | 
			row
				add: #firstButton;
				add: #secondButton ];
		yourself
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons >> initializeButtons [
self subclassResponsibility
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons >> initializePresenters [
	firstButton := self instantiate: SpButtonPresenter.
	secondButton := self instantiate: SpButtonPresenter.
	self initializeButtons.
	self focusOrder
		add: firstButton;
		add: secondButton
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons classSide >> isDeprecated [
	"This presenter does not add enough value to Spec to be kept in it. If you are using it, please copy the code in your own application."

	^ true
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons >> secondButton [
	^ secondButton
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTwoButtons classSide >> vertical [
	<spec: #default>
	^ SpLayout composed
		newColumn: [ :column | 
			column
				add: #firstButton;
				add: #secondButton ];
		yourself
]
