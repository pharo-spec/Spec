Extension { #name : 'SpRadioButtonGroupPresenter' }

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> addRadioButton: aButton [
	self linkRadioButton: aButton.
	buttons add: aButton.
	aButton privateSetState: false;
		owner: self.
	self focusOrder add: aButton.
	self rebuildWidget
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> buttons [
	^ buttons
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> canDeselectByClick [
	self deprecated: 'This option is removed in Spec 2'.
	^ false
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> canDeselectByClick: aBoolean [
	self deprecated: 'This option is removed in Spec 2'
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> createWidgets [
	buttons
		withIndexDo: [ :each :i | 
			self assign: each to: ('radio' , i asString) asSymbol.
			 ]
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> currentActivated [
	^ currentActivated value
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> currentActivated: aRadioButton [
	currentActivated value: aRadioButton
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> default: aButton [
	aButton privateSetState: true.
	aButton takeKeyboardFocus.
	aButton
		whenBuiltDo: [ aButton privateSetState: true.
			self currentActivated: aButton]
	
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> defaultOnce: aButton [
	aButton privateSetState: true.
	self currentActivated: aButton.
	"This method is used to avoid a problem of default: with a DynamicPresenter but a fix would be better (if possible)"
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter classSide >> defaultSpec [
	<spec: #default>
	^ SpLayout composed
		newColumn: [ :column |  ];
		yourself
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> dynamicLayout [
	|lay|
	lay := SpLayout composed
		newColumn: [ :column | 
			self basicPresenters keysDo: [ :item | column newRow: [ :row | row add: item ] ].
			column newRow: [ :row |  ] ].
	self layout: lay.
	^ lay
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter classSide >> example [
	<sampleInstance>
	| example |
	example := self new.
	example
		addRadioButton: (SpRadioButtonPresenter new label: '1');
		addRadioButton: (SpRadioButtonPresenter new label: '2');
		addRadioButton: (SpRadioButtonPresenter new label: '3');
		whenCurrentActivatedChangedDo: [ self inform: example currentActivated label ].
	example openWithSpec.
	^ example
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> initialize [
	buttons := OrderedCollection new.
	currentActivated := nil asValueHolder.
	super initialize.
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter classSide >> isDeprecated [

	^ true
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> linkRadioButton: aButton [
	buttons
		do: [ :b | 
			aButton whenActivatedDo: [ b privateSetState: false ].
			b whenActivatedDo: [ aButton privateSetState: false ] ].
	aButton whenActivatedDo: [ self currentActivated: aButton ].
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> rebuildWidget [
	self widgets removeAll.
	self createWidgets.
	self needFullRebuild: false.
	self buildWithSpecLayout: self dynamicLayout
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> whenCanDeselectByClickChanged: aBlock [
	self deprecated: 'Use #whenCanDeselectByClickChangedDo: instead.' transformWith: '`@receiver whenCanDeselectByClickChanged: `@statements' -> '`@receiver whenCanDeselectByClickChangedDo: `@statements'.
	self whenCanDeselectByClickChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> whenCanDeselectByClickChangedDo: aBlock [
	self deprecated: 'This option is removed in Spec 2'
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> whenCurrentActivatedChanged: aBlock [
	self deprecated: 'Use #whenCurrentActivatedChangedDo: instead.' transformWith: '`@receiver whenCurrentActivatedChanged: `@statements' -> '`@receiver whenCurrentActivatedChangedDo: `@statements'.
	self whenCurrentActivatedChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpRadioButtonGroupPresenter >> whenCurrentActivatedChangedDo: aBlock [

	currentActivated whenChangedDo: aBlock
]
