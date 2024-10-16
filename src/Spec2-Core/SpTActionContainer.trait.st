"
A trait to contain the actions associated to a presenter.
Actions can be **visible** (hence, they will be shown in a context menu) or **not visible** (hence, they will be shortcuts).
"
Trait {
	#name : 'SpTActionContainer',
	#instVars : [
		'#userActionGroup => ObservableSlot',
		'#internalActionGroup'
	],
	#category : 'Spec2-Core-Base',
	#package : 'Spec2-Core',
	#tag : 'Base'
}

{ #category : 'api - actions' }
SpTActionContainer >> actions [

	^ userActionGroup
]

{ #category : 'api - actions' }
SpTActionContainer >> actions: anActionGroup [
	"WARNING. Defining action in presenters that are not able to grab the keyboard focus 
	 is mostly useless (because they will never have the focus to answer to). 
	 Shortcut actions, however, can be installed and they will be available in children 
	 presenters when they are focused."

	userActionGroup := anActionGroup 
		name: #userActionGroup;
		beRoot
]

{ #category : 'api - actions' }
SpTActionContainer >> actionsWith: aBlock [
	| actionGroup |

	actionGroup := SpActionGroup new beRoot.
	aBlock value: actionGroup.
	self actions: actionGroup
]

{ #category : 'api - actions' }
SpTActionContainer >> addAction: aSpCommand [
	"WARNING. Defining action in presenters that are not able to grab the keyboard focus 
	 is mostly useless (because they will never have the focus to answer to). 
	 Shortcut actions, however, can be installed and they will be available in children 
	 presenters when they are focused."

	self ensureActions add: aSpCommand
]

{ #category : 'api - actions' }
SpTActionContainer >> addActionGroup: aCommandGroup [
	"WARNING. Defining action in presenters that are not able to grab the keyboard focus 
	 is mostly useless (because they will never have the focus to answer to). 
	 Shortcut actions, however, can be installed and they will be available in children 
	 presenters when they are focused."

	aCommandGroup beDisplayedAsGroup.
	self addAction: aCommandGroup
]

{ #category : 'api - actions' }
SpTActionContainer >> addActionGroupWith: aBlock [
	"WARNING. Defining action in presenters that are not able to grab the keyboard focus 
	 is mostly useless (because they will never have the focus to answer to). 
	 Shortcut actions, however, can be installed and they will be available in children 
	 presenters when they are focused."
	| commandGroup |

	commandGroup := SpActionGroup new.	
	commandGroup beDisplayedAsGroup.
	aBlock value: commandGroup.
	self actions: commandGroup
]

{ #category : 'api - actions' }
SpTActionContainer >> addActionWith: aBlock [

	self ensureActions addActionWith: aBlock
]

{ #category : 'api - actions' }
SpTActionContainer >> addShortcutWith: aBlock [
	"WARNING. Defining action in presenters that are not able to grab the keyboard focus 
	 is mostly useless (because they will never have the focus to answer to). 
	 Shortcut actions, however, can be installed and they will be available in children 
	 presenters when they are focused."

	self ensureActions addShortcutWith: aBlock
]

{ #category : 'private - actions' }
SpTActionContainer >> ensureActions [

	^ userActionGroup ifNil: [
		userActionGroup := SpActionGroup new 
			name: #userActionGroup;
			beRoot ]
]

{ #category : 'private - actions' }
SpTActionContainer >> ensureInternalActions [

	^ internalActionGroup ifNil: [
		internalActionGroup := SpActionGroup new 
			name: #internalActionGroup;
			beRoot ]
]

{ #category : 'initialization' }
SpTActionContainer >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : 'private - actions' }
SpTActionContainer >> internalActions [
	"Internal actions are actions defined internally by a presenter (e.g. meta+t to show 
	 the context menu, or meta+s to trigger the submit action in text fields).
	 Since this is NOT meant to be shown to the user (for now, at least), all actions 
	 registered here will be considered NOT VISIBLE, and will not popup in menus."

	^ internalActionGroup
]

{ #category : 'private - actions' }
SpTActionContainer >> internalActions: anActionGroup [
	"to be used internally by the presenters"

	internalActionGroup := anActionGroup beRoot
]

{ #category : 'enumerating' }
SpTActionContainer >> whenActionsChangedDo: aBlock [
	"Inform when menu definition changed. 
	 `aBlock` receives zero arguments."

	self property: #userActionGroup whenChangedDo: aBlock
]
