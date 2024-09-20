Class {
	#name : 'SpAbstractEasyPresenter',
	#superclass : 'SpPresenter',
	#traits : 'SpTSearchable',
	#classTraits : 'SpTSearchable classTrait',
	#instVars : [
		'#contentView',
		'#searchInput',
		'#lastSelectedRow => WeakSlot'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> actions [

	^ contentView actions
]

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> actions: aSpCommandGroup [

	contentView actions: aSpCommandGroup
]

{ #category : 'initialization' }
SpAbstractEasyPresenter >> connectPresenters [

	searchInput 
		addAction: (SpAction
			newShortcutKey: Character escape asKeyCombination 
			action: [ self deactivateSearch: false ]);
		addAction: (SpAction
			newShortcutKey: Character cr asKeyCombination 
			action: [ self deactivateSearch: true ]);
		whenTextChangedDo: [ :aString | self selectFirst: aString ].
	
	contentView eventHandler 
		whenKeyDownDo: [ :event | self maybeActivateSearchOn: event ];
		whenFocusReceivedDo: [ :event | searchInput hide ]
]

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> contextMenuFromCommandsGroup: aValuable [
	
	self actions: aValuable value
]

{ #category : 'private - actions' }
SpAbstractEasyPresenter >> ensureActions [

	^ contentView ensureActions
]
