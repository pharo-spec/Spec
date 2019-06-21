"
I'm a base for all presenters. 
I define common behaviours for widget presenters and also for composable presenters (the ones an user regularly uses).
"
Class {
	#name : #SpPresenter,
	#superclass : #Model,
	#traits : 'TSpObservable',
	#classTraits : 'TSpObservable classTrait',
	#instVars : [
		'#owner',
		'#adapter',
		'#needRebuild => SpObservableSlot'
	],
	#category : #'Spec2-Core-Base'
}

{ #category : #TOREMOVE }
SpPresenter class >> buttonHeight [

	^ self defaultFont height + 12
]

{ #category : #TOREMOVE }
SpPresenter class >> buttonWidth [

	^ (self defaultFont widthOfString: 'eilwp') + 44
]

{ #category : #TOREMOVE }
SpPresenter class >> defaultFont [ 

	self flag: #TODO. "This is so wrong. All this needs to be in the theme and in the 
	application"
	^ StandardFonts defaultFont
]

{ #category : #TOREMOVE }
SpPresenter class >> inputTextHeight [

	^ self defaultFont height + 12
]

{ #category : #TOREMOVE }
SpPresenter class >> labelHeight [

	^ self defaultFont height
]

{ #category : #'instance creation' }
SpPresenter class >> owner: anOwningPresenter [

	^ self basicNew
		owner: anOwningPresenter;
		initialize;
		yourself
]

{ #category : #'as yet unclassified' }
SpPresenter class >> systemIconName [

	^ #smallWindow
]

{ #category : #accessing }
SpPresenter class >> toolName [
	"The tool name can be used in some places such as the About window's title."
	
	^ self name
]

{ #category : #TOREMOVE }
SpPresenter class >> toolbarHeight [

	^ self defaultFont height + 12
]

{ #category : #accessing }
SpPresenter >> adapter [

	^ adapter
]

{ #category : #accessing }
SpPresenter >> adapter: anAdapter [

	adapter := anAdapter
]

{ #category : #accessing }
SpPresenter >> application [
	"Answer application owner of this composition.
	 The tree for a composition starts always with an application, which is responsible of 
	 providing all resources the presenter needs. "

	^ self owner application
]

{ #category : #'private building' }
SpPresenter >> basicBuildAdapterWithSpecLayout: aSpecLayout [
	"I assume the SpecBindings is well defined"
	
	self announcer announce: (SpWidgetWillBeBuilt model: self).

	self adapter: (aSpecLayout asSpecLayout 
		buildAdapterFor: self 
		bindings: SpBindings value).

	self announcer announce: (SpWidgetBuilt 
		model: self 
		widget: adapter widget).
	
	^ adapter
]

{ #category : #'private building' }
SpPresenter >> buildAdapterWithSpecLayout: aSpecLayout [
	"Build the adapter using the spec name provided as argument"
	
	^ SpBindings 
		value: self application adapterBindings
		during: [ self basicBuildAdapterWithSpecLayout: aSpecLayout ]
]

{ #category : #building }
SpPresenter >> buildWithSpec [
	"Build the widget using the default spec"
	
	^ self buildWithSpecLayout: self retrieveDefaultSpec
]

{ #category : #building }
SpPresenter >> buildWithSpec: aSpec [
	"Build the widget using the spec name provided as argument"
	
	^ self buildWithSpecLayout: (self retrieveSpec: aSpec)
]

{ #category : #building }
SpPresenter >> buildWithSpecLayout: aSpecLayout [
	"Build the widget using the spec name provided as argument"

	^ (self buildAdapterWithSpecLayout: aSpecLayout) widget
]

{ #category : #'private building' }
SpPresenter >> defaultSpecSelector [
	| selectors |
	
	selectors := 
		(Pragma allNamed: #spec: from: self class class  to: SpPresenter class class),
		(Pragma allNamed: #spec from: self class class to: SpPresenter class class).
	
	selectors ifEmpty: [ ^ #defaultSpec ].	
	selectors size = 1 ifTrue: [ ^ selectors first methodSelector ].
	^ (selectors detect: [ :each | (each argumentAt: 1) = #default ]) methodSelector
	

]

{ #category : #accessing }
SpPresenter >> enabled: aBoolean [ 

	^ self subclassResponsibility
]

{ #category : #testing }
SpPresenter >> hasOwner [

	^ self owner notNil
]

{ #category : #testing }
SpPresenter >> hasWindow [

	^ self root isWindowPresenter
]

{ #category : #initialization }
SpPresenter >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	needRebuild := true
]

{ #category : #initialization }
SpPresenter >> initializeDialogWindow: aDialogWindowPresenter [
	"used to initialize the model in the case of the use into a dialog window.
	 Override this to set buttons other than the default (Ok, Cancel)."
	
	aDialogWindowPresenter
		addButton: 'Ok' do: [ :presenter | 
			presenter triggerOkAction.
			presenter close ];
		addButton: 'Cancel' do: [ :presenter | 
			presenter triggerCancelAction.
			presenter close ]	
]

{ #category : #initialization }
SpPresenter >> initializeWindow: aWindowPresenter [
	"override this to set window values before opening. 
	 You may want to add a menu, a toolbar or a statusbar"

	self flag: #TODO. "Does presenters needs to understand this? (they do if we 
	want to do ButtonPresenter new openWithSpec)."
]

{ #category : #testing }
SpPresenter >> isMenuPresenter [

	^ false
]

{ #category : #testing }
SpPresenter >> isPresenter [

	^ true
]

{ #category : #testing }
SpPresenter >> isWindowPresenter [

	^ false
]

{ #category : #accessing }
SpPresenter >> needRebuild [

	^ needRebuild
]

{ #category : #accessing }
SpPresenter >> needRebuild: aBoolean [

	needRebuild := aBoolean
]

{ #category : #events }
SpPresenter >> observablePropertyNamed: aName [
	| slot |
	
	slot := self class slotNamed: aName.
	slot isObservableSlot
		ifFalse: [ SpNonObservableSlotError signal: aName ].

	"Obtain the raw value.
	We need to access the underlying value holder to subscribe to it"
	^ slot rawRead: self
]

{ #category : #showing }
SpPresenter >> openDialogWithSpec [
	"Build the widget using the default spec and display it into a dialog. 
	 Beware: this way will not create a real modal in the sense that the user will keep the focus on other windows. If you want to make the user focus on your dialog only you should use #openModalWithSpec instead."
	
	^ self application 
		openDialog: self
		withSpecLayout: self retrieveDefaultSpec
]

{ #category : #showing }
SpPresenter >> openDialogWithSpec: aSelector [
	"Build the widget using the default spec and display it into a dialog. 
	 Beware: this way will not create a real modal in the sens that the user will keep the focus on other windows. If you want to make the user focus on your dialog only you should use #openModalWithSpec: instead."
	
	^ self application 
		openDialog: self
		withSpecLayout: (self retrieveSpec: aSelector)
]

{ #category : #showing }
SpPresenter >> openDialogWithSpecLayout: aSpecLayout [

	^ self application 
		openDialog: self
		withSpecLayout: aSpecLayout
]

{ #category : #showing }
SpPresenter >> openModalWithSpec [

	^ self application 
		openModal: self
		withSpecLayout: self retrieveDefaultSpec
]

{ #category : #showing }
SpPresenter >> openModalWithSpec: aSelector [

	^ self application 
		openModal: self
		withSpecLayout: (self retrieveSpec: aSelector)
]

{ #category : #showing }
SpPresenter >> openModalWithSpecLayout: aSpecLayout [

	^ self application 
		openModal: self
		withSpecLayout: aSpecLayout
]

{ #category : #showing }
SpPresenter >> openWithSpec [

	^ self application 
		open: self
		withSpecLayout: self retrieveDefaultSpec
]

{ #category : #showing }
SpPresenter >> openWithSpec: aSelector [

	^ self application 
		open: self
		withSpecLayout: (self retrieveSpec: aSelector)
]

{ #category : #showing }
SpPresenter >> openWithSpecLayout: aSpecLayout [

	^ self application 
		open: self
		withSpecLayout: aSpecLayout
]

{ #category : #accessing }
SpPresenter >> owner [

	^ owner
]

{ #category : #accessing }
SpPresenter >> owner: aPresenter [

	owner := aPresenter
]

{ #category : #'private building' }
SpPresenter >> retrieveDefaultSpec [

	^ self retrieveSpec: self defaultSpecSelector
]

{ #category : #'private building' }
SpPresenter >> retrieveSpec: aSelector [
	| layout |

	layout := self class perform: aSelector.
	layout isSpecLayout ifTrue: [ 
		layout selector: aSelector ].
	^ layout
]

{ #category : #accessing }
SpPresenter >> root [
	"Answer root presenter of this composition."
	
	^ self owner 
		ifNotNil: [ :presenter | presenter root ]
		ifNil: [ self ]
]

{ #category : #accessing }
SpPresenter >> spec [
	self flag: #TODO. "This needs to be removed, but there is a problem with the interpreter.
	(it will be solved as soon as the interpreter is removed :P)"
	
	^ self adapter
]

{ #category : #accessing }
SpPresenter >> spec: anAdapter [
	"This is a remaining of other times... spec accesor in fact contains an adapter"
	
	self flag: #TODO. "Same as #spec, it needs to go"
	self adapter: anAdapter
]

{ #category : #updating }
SpPresenter >> update: aParameter [

	self changed: aParameter
]

{ #category : #events }
SpPresenter >> whenBuiltDo: aBlock [

	self announcer 
		when: SpWidgetBuilt
		do: aBlock
]

{ #category : #events }
SpPresenter >> whenWillBeBuiltDo: aBlock [

	self announcer 
		when: SpWidgetWillBeBuilt
		do: aBlock
]

{ #category : #accessing }
SpPresenter >> window [
	"Answer window containing this composition."
	
	^ self hasWindow
		ifTrue: [ self root ]
		ifFalse: [ nil ]
]

{ #category : #'private utils' }
SpPresenter >> withAdapterDo: aValuable [
	"a convenience method to avoid verify by nil all the time"
	
	^ self adapter ifNotNil: aValuable
]

{ #category : #'private utils' }
SpPresenter >> withWidgetDo: aValuable [
	"a convenience method to avoid verify by nil all the time"

	^ self adapter ifNotNil: aValuable
]

{ #category : #'private utils' }
SpPresenter >> withWindowDo: aValuable [

	self hasWindow ifFalse: [ ^ self ].
	"Since Presenter has window, root = window"
	aValuable value: self root
]
