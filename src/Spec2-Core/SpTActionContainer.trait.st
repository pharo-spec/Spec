Trait {
	#name : 'SpTActionContainer',
	#instVars : [
		'rootActionGroup'
	],
	#category : 'Spec2-Core-Base',
	#package : 'Spec2-Core',
	#tag : 'Base'
}

{ #category : 'api - actions' }
SpTActionContainer >> addAction: aSpCommand [
	"WARNING. Defining action in presenters that are not able to grab the keyboard focus 
	 is mostly useless (because they will never have the focus to answer to). 
	 Shortcut actions, however, can be installed and they will be available in children 
	 presenters when they are focused."

	self ensureActionGroup add: aSpCommand
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
SpTActionContainer >> addActionWith: aBlock [

	self ensureActionGroup addActionWith: aBlock
]

{ #category : 'api - actions' }
SpTActionContainer >> addShortcutWith: aBlock [
	"WARNING. Defining action in presenters that are not able to grab the keyboard focus 
	 is mostly useless (because they will never have the focus to answer to). 
	 Shortcut actions, however, can be installed and they will be available in children 
	 presenters when they are focused."

	self ensureActionGroup addShortcutWith: aBlock
]

{ #category : 'private' }
SpTActionContainer >> ensureActionGroup [

	self flag: #TODO. "This is a fake break of dependency (dependency is 
	still there, but hidden). Think about a real fix (like, not using commander for actions)"
	^ rootActionGroup ifNil: [
		| c | 
		c := self class environment at: #SpActionGroup.
		rootActionGroup := c new beRoot ]
]

{ #category : 'initialization' }
SpTActionContainer >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : 'api - actions' }
SpTActionContainer >> rootActionGroup [

	^ rootActionGroup
]

{ #category : 'api - events' }
SpTActionContainer >> whenCommandGroupChangedDo: aBlock [
	"Inform when menu definition changed. 
	 `aBlock` receives zero arguments."

	self property: #rootActionGroup whenChangedDo: aBlock
]

{ #category : 'api - actions' }
SpTActionContainer >> withRootActionGroupDo: aBlock [
	"WARNING. Defining action in presenters that are not able to grab the keyboard focus 
	 is mostly useless (because they will never have the focus to answer to). 
	 Shortcut actions, however, can be installed and they will be available in children 
	 presenters when they are focused."

	rootActionGroup := nil.
	aBlock value: self ensureActionGroup
]
