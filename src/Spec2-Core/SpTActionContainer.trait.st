Trait {
	#name : #SpTActionContainer,
	#instVars : [
		'actionGroup'
	],
	#category : #'Spec2-Core-Base-Command'
}

{ #category : #'api - actions' }
SpTActionContainer >> actionGroup [

	^ actionGroup
]

{ #category : #'api - actions' }
SpTActionContainer >> actionGroup: aSpCommandGroup [

	aSpCommandGroup beRoot.
	actionGroup := aSpCommandGroup

]

{ #category : #'api - actions' }
SpTActionContainer >> actionsWith: aBlock [

	actionGroup := nil.
	aBlock value: self ensureActionGroup
]

{ #category : #'api - actions' }
SpTActionContainer >> addAction: aSpCommand [

	self ensureActionGroup register: aSpCommand
]

{ #category : #'api - actions' }
SpTActionContainer >> addActionWith: aBlock [

	self ensureActionGroup addActionWith: aBlock
]

{ #category : #'api - actions' }
SpTActionContainer >> addShortcutWith: aBlock [

	self ensureActionGroup addShortcutWith: aBlock
]

{ #category : #private }
SpTActionContainer >> ensureActionGroup [

	^ actionGroup ifNil: [ actionGroup := SpActionGroup new beRoot ]
]

{ #category : #initialization }
SpTActionContainer >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : #'api - events' }
SpTActionContainer >> whenCommandGroupChangedDo: aBlock [
	"Inform when menu definition changed. 
	 `aBlock` receives zero arguments."

	self property: #actionGroup whenChangedDo: aBlock
]
