Class {
	#name : #VersionBrowser2,
	#superclass : #AbstractMessageCentricBrowser,
	#instVars : [
		'rgMethod',
		'sourcePresenter',
		'isShowingDiff'
	],
	#category : #'Spec-Tools-VersionBrowser'
}

{ #category : #api }
VersionBrowser2 class >> browseVersionsForClass: aClass selector: aSelector [
	^ aClass
		compiledMethodAt: aSelector
		ifPresent: [ :method | self browseVersionsForMethod: method ]
		ifAbsent: [ self
				inform:
					('No method {1} in class {2}'
						format:
							{aSelector.
							aClass printString}) ]
]

{ #category : #api }
VersionBrowser2 class >> browseVersionsForMethod: aRingMethod [
	^ (self on: aRingMethod) openWithSpec
]

{ #category : #specs }
VersionBrowser2 class >> defaultSpec [
	^ SpecPanedLayout newVertical
		add: #messageList;
		add:
			(SpecBoxLayout newVertical
				add: #toolbarPresenter withConstraints: [ :constraints | constraints height: self buttonHeight ];
				add: #sourcePresenter;
				yourself);
		yourself
]

{ #category : #visiting }
VersionBrowser2 >> accept: text notifying: notifyer [
	^ self selectedMessage
		ifNotNil: [:message | 
			message methodClass 
				compile: text 
				classified: message protocol
				notifying: notifyer ]
]

{ #category : #'instance creation' }
VersionBrowser2 >> buildChangeList [
	rgMethod sourcePointer ifNil:[ ^ #() ].
	
	^ (SourceFiles
		changeRecordsFrom: rgMethod sourcePointer
		className: rgMethod instanceSideParentName
		isMeta: rgMethod isMetaSide)
		collectWithIndex: [ :c :i | | rg |
			rg := c asRingDefinition.
			rg annotationNamed: #versionIndex put: i ]
]

{ #category : #accessing }
VersionBrowser2 >> changeList [
	^ messageList messages
]

{ #category : #initialization }
VersionBrowser2 >> initialize [
	isShowingDiff := false.
	super initialize
]

{ #category : #initialization }
VersionBrowser2 >> initializePresenter [
	messageList
		whenSelectionChangedDo: [ :selection | self selectItem: selection selectedItem ];
		messages: self buildChangeList.
		
	toolbarPresenter dropListModel selectedIndex: 1
]

{ #category : #initialization }
VersionBrowser2 >> initializeWidgets [
	messageList := self instantiate: MessageList.
	toolbarPresenter := self instantiate: MethodToolbar.

	messageList
		topologicSort: false;
		sortingBlock: [ :a :b | a annotationNamed: #versionIndex ifAbsent: [ 0 ] ] ascending.

	toolbarPresenter
		addItemLabeled: 'Side By Side' do: [ self showDiffMorphWithConverter: (DiffMorphChangeRecordConverter methodReference: self textConverter method referencesList: self changeList) ];
		addItemLabeled: 'Source' do: [ self showSourceWithConverter: (SourceMethodConverter method: self textConverter method) ];
		addItemLabeled: 'Diff' do: [ self showSourceWithConverter: (DiffChangeRecordConverter methodReference: self textConverter method referencesList: self changeList) ].
		
	toolbarPresenter  versionModel
		label: 'Revert';
		action: [ self revert: self selectedMessage ]
]

{ #category : #initialization }
VersionBrowser2 >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Recent versions of ' , rgMethod displayName
]

{ #category : #private }
VersionBrowser2 >> installIconStylerFor: anItem [
	"icons styler are only supported for method definitions (not nil / not for comment definitions    
	 (those may occure for comment or general string searches)) and in the case the source presenter is not a diff"

	((self isMethodDefinition: anItem) or: [ isShowingDiff not ]) ifFalse: [ ^ self ].

	IconStyler styleText: sourcePresenter withAst: anItem ast
]

{ #category : #'instance creation' }
VersionBrowser2 >> revert: aChangeRecord [
	aChangeRecord
		ifNil: [ ^ self inform: 'nothing selected, so nothing done' ]
		ifNotNil: [ rgMethod realClass
				compile: aChangeRecord sourceCode
				classified: aChangeRecord category
				withStamp: aChangeRecord stamp
				notifying: nil ].

	"reinitialize me"
	self setRGMethodFrom: rgMethod realClass >> rgMethod selector.

	messageList
		messages: self buildChangeList;
		selectIndex: 1
]

{ #category : #private }
VersionBrowser2 >> selectItem: item [
	sourcePresenter ifNil: [ ^ self ].

	self
		setSourceContentWith:
			(self textConverter
				method: item;
				getText).

	sourcePresenter clearUndoManager.
	self installIconStylerFor: item
]

{ #category : #'accessing model' }
VersionBrowser2 >> setModelBeforeInitialization: aMethod [
	self setRGMethodFrom: aMethod.
]

{ #category : #initialization }
VersionBrowser2 >> setRGMethodFrom: aMethod [
"asHistorical, because active RGMethods don't always have the source pointer attached"
	rgMethod := aMethod asRingDefinition asHistorical.
]

{ #category : #private }
VersionBrowser2 >> setSourceContentWith: content [
	isShowingDiff
		ifTrue: [ (content isText or: [ content isString ])
				ifTrue: [ sourcePresenter leftText: ''.
					sourcePresenter rightText: content ]
				ifFalse: [ sourcePresenter leftText: content first.
					sourcePresenter rightText: content second ] ]
		ifFalse: [ sourcePresenter text: content ]
]

{ #category : #'instance creation' }
VersionBrowser2 >> showDiffMorphWithConverter: aConverter [
	sourcePresenter := self newDiff.
	isShowingDiff := true.
	self needRebuild: false.
	self buildWithSpec.
	self textConverter: aConverter.
	sourcePresenter contextClass: self selectedMessage methodClass.
	messageList selectIndex: (messageList selectedIndex)
]

{ #category : #'instance creation' }
VersionBrowser2 >> showSourceWithConverter: aConverter [
	sourcePresenter := self newCode.
	isShowingDiff := false.
	self needRebuild: false.
	self buildWithSpec.
	self textConverter: aConverter.
	sourcePresenter acceptBlock: [ :text :notifyer | (self accept: text notifying: notifyer) notNil ].
	sourcePresenter behavior: self selectedMessage methodClass.
	messageList selectIndex: (messageList selectedIndex)
]
