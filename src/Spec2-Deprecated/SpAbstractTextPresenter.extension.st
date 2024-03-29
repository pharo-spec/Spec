Extension { #name : 'SpAbstractTextPresenter' }

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> aboutToStyle: aBoolean [
	"Set if the text zone must be styled"
	
	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> aboutToStyleBlock [
	"Return the block used to know if the text must be styled"	

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8

]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> aboutToStyleBlock: aBlockReturningABoolean [
	"Set the block used to know if the text must be styled.
	The block must return a boolean"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8

]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> accept [
	"Accep the current pendingtext"

	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.

	self changed: #accept with: #().
	"Raise an announcement"
	self actionPerformed
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> acceptBlock [
	"Return the block to perform when the text is accepted.
	The block must have one argument, which will be the accepted text"

	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.

	^ actionToPerform
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> acceptBlock: aBlockWithOneArgument [
	"Set the block to perform when the text is accepted.
	The block must have one argument, which will be the accepted text.
	The block can return false if the candidate text is to be rejected"

	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.

	actionToPerform := aBlockWithOneArgument
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> autoAccept [
	"Return true if the text is accepted after ech keystroke"
	
	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.
		
	^ autoAccept
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> autoAccept: aBoolean [
	"Set if the text is accepted after each keystroke or not"

	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.
		
	autoAccept := aBoolean
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> beForCode [

	self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> beForText [

	self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> behavior [
	"Return the class corresponding to the method class of the source code you are editing"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> behavior: aClass [
	"Set the class corresponding to the method class of the source code you are editing"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> doItContext [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> doItContext: anObject [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> doItReceiver [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> doItReceiver: anObject [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> getSelection [
	"Get the text selection"
	
	self 
		deprecated: 'Use #selection instead.' 
		transformWith: '`@receiver getSelection' 
		            -> '`@receiver selection'.
		
	^ self selection
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> getText [
	self deprecated: 'Use #text instead' transformWith: '`@receiver getText' -> '`@receiver text'.
	^ self text
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> isAboutToStyle [
	"Return if the text zone is shouted or not"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> selection: anInterval [
	self
		deprecated:
			'#selection: was used to set an interval, and did not convey the correct meaning. Use #selectionInterval: instead.'
		transformWith: '`@receiver selection: `@arg' -> '`@receiver selectionInterval: `@arg'.
	self selectionInterval: anInterval
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> setSelection: anInterval [
	"Set the text selection without changing the readSelectionBlock"

	self
		deprecated: 'Use #selection: instead.'
		transformWith:
			'`@receiver setSelection: `@statement'
				-> '`@receiver selection: `@statement'.
	self selectionInterval: anInterval
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAboutToStyleBlockChanged: aBlock [
	self deprecated: 'Use #whenAboutToStyleBlockChangedDo: instead.' transformWith: '`@receiver whenAboutToStyleBlockChanged: `@statements' -> '`@receiver whenAboutToStyleBlockChangedDo: `@statements'.
	self whenAboutToStyleBlockChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAboutToStyleBlockChangedDo: aBlock [
	"Set a block to perform when the about to style block changed"
	
	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAboutToStyleChanged: aBlock [
	self deprecated: 'Use #whenAboutToStyleChangedDo: instead.' transformWith: '`@receiver whenAboutToStyleChanged: `@statements' -> '`@receiver whenAboutToStyleChangedDo: `@statements'.
	self whenAboutToStyleChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAcceptBlockChanged: aBlock [
	self deprecated: 'Use #whenAcceptBlockChangedDo: instead.' transformWith: '`@receiver whenAcceptBlockChanged: `@statements' -> '`@receiver whenAcceptBlockChangedDo: `@statements'.
	self whenAcceptBlockChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAutoAcceptChanged: aBlock [
	self deprecated: 'Use #whenAutoAcceptChangedDo: instead.' transformWith: '`@receiver whenAutoAcceptChanged: `@statements' -> '`@receiver whenAutoAcceptChangedDo: `@statements'.
	self whenAutoAcceptChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAutoAcceptChangedDo: aBlock [
	"aBlock will be performed when autoAccept changed"

	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.

	self property: #autoAccept whenChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenBehaviorChanged: aBlock [
	self deprecated: 'Use #whenBehaviorChangedDo: instead.' transformWith: '`@receiver whenBehaviorChanged: `@statements' -> '`@receiver whenBehaviorChangedDo: `@statements'.
	self whenBehaviorChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenBehaviorChangedDo: aBlock [
	"Set a block to perform when the behavior class changed"
	
	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenCodeCompletionAllowedChanged: aBlock [
	self
		deprecated: 'Use #whenTextIsAcceptedDo: instead or nothing. Currently, both those methods are doing the same thing but my name is really missleading. Thus, I''ll be removed.'
		transformWith: '`@receiver whenCodeCompletionAllowedChanged: `@statements' -> '`@receiver whenTextIsAcceptedDo: `@statements'.
	self whenTextIsAcceptedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenCodeCompletionAllowedChangedDo: aBlock [
	self
		deprecated: 'Use #whenTextIsAcceptedDo: instead or nothing. Currently, both those methods are doing the same thing but my name is really missleading. Thus, I''ll be removed.'
		transformWith: '`@receiver whenCodeCompletionAllowedChangedDo: `@statements' -> '`@receiver whenTextIsAcceptedDo: `@statements'.

	self whenTextIsAcceptedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenMenuHolderChanged: aBlock [
	self deprecated: 'Use #whenMenuHolderChangedDo: instead.' transformWith: '`@receiver whenMenuHolderChanged: `@statements' -> '`@receiver whenMenuHolderChangedDo: `@statements'.
	self whenMenuHolderChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenReadSelectionIsChanged: aBlock [
	self deprecated: 'Use #whenReadSelectionIsChangedDo: instead.' transformWith: '`@receiver whenReadSelectionIsChanged: `@statements' -> '`@receiver whenReadSelectionIsChangedDo: `@statements'.
	self whenReadSelectionIsChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenScrollValueChanged: aBlock [
	self deprecated: 'Use #whenScrollValueChangedDo: instead.' transformWith: '`@receiver whenScrollValueChanged: `@statements' -> '`@receiver whenScrollValueChangedDo: `@statements'.
	self whenScrollValueChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenTextChanged: aBlock [
	self deprecated: 'Use #whenTextChangedDo: instead.' transformWith: '`@receiver whenTextChanged: `@statement' -> '`@receiver whenTextChangedDo: `@statement'.
	self whenTextChangedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenTextIsAccepted: aBlock [
	self deprecated: 'Use #whenTextIsAcceptedDo: instead.' transformWith: '`@receiver whenTextIsAccepted: `@statements' -> '`@receiver whenTextIsAcceptedDo: `@statements'.
	self whenTextIsAcceptedDo: aBlock
]

{ #category : '*Spec2-Deprecated' }
SpAbstractTextPresenter >> whenTextIsAcceptedDo: aBlock [
	"Set a block to perform when the text is accepted"
	
	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.

	self property: #actionPerformed whenChangedDo: aBlock
]
