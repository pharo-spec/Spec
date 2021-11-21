"
I'm a base for all presenters. 
I define common behaviours for widget presenters and also for composable presenters (the ones an user regularly uses).

From a Spec2 users, my key methods are 
- `SpAbstractPresenter>>#application` to get access to the application into which I play.
- `SpAbstractPresenter>>#initializeDialogWindow:` defines the default buttons that decorated a dialog. Subclasses can override it to be able to customize how dialog get decorated.
- `SpAbstractPresenter>>#initializeWindow:` is a hook to define the window title and extend.
- `SpAbstractPresenter>>#openWithSpec` to open the receiver with the default layout. 
- `SpAbstractPresenter>>#openWithSpec: aSelector` to open the receiver with the specified layout.
"
Class {
	#name : #SpAbstractPresenter,
	#superclass : #Model,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'owner',
		'adapter',
		'needRebuild',
		'eventHandler'
	],
	#category : #'Spec2-Core-Base'
}

{ #category : #TOREMOVE }
SpAbstractPresenter class >> buttonHeight [

	^ self defaultFont height + 12
]

{ #category : #TOREMOVE }
SpAbstractPresenter class >> buttonWidth [

	^ (self defaultFont widthOfString: 'eilwp') + 44
]

{ #category : #TOREMOVE }
SpAbstractPresenter class >> defaultFont [ 

	self flag: #TODO. "This is so wrong. All this needs to be in the theme and in the 
	application"
		
	self class environment at: #StandardFonts ifPresent: [ :standardFonts | 
		^ standardFonts defaultFont ].
	
	^ LogicalFont
		familyName: 'Source Sans Pro'
		pointSize: 10
		stretchValue: 5
		weightValue: 400
		slantValue: 0

]

{ #category : #TOREMOVE }
SpAbstractPresenter class >> inputTextHeight [

	^ self defaultFont height + 12
]

{ #category : #testing }
SpAbstractPresenter class >> isAbstract [
	^ self = SpAbstractPresenter
]

{ #category : #TOREMOVE }
SpAbstractPresenter class >> labelHeight [

	^ self defaultFont height
]

{ #category : #'instance creation' }
SpAbstractPresenter class >> owner: anOwningPresenter [

	^ self basicNew
		owner: anOwningPresenter;
		initialize;
		yourself
]

{ #category : #'as yet unclassified' }
SpAbstractPresenter class >> systemIconName [

	^ #smallWindow
]

{ #category : #accessing }
SpAbstractPresenter class >> toolName [
	"The tool name can be used in some places such as the About window's title."
	
	^ self name
]

{ #category : #TOREMOVE }
SpAbstractPresenter class >> toolbarHeight [

	^ self defaultFont height + 12
]

{ #category : #accessing }
SpAbstractPresenter >> adapter [

	^ adapter
]

{ #category : #accessing }
SpAbstractPresenter >> adapter: anAdapter [

	"if there existed an adapter already, we need to unsubscribe it to avoid memory leaks"
	adapter ifNotNil: [
		self removeDependent: adapter.
		adapter unsubscribe ].
	
	adapter := anAdapter
]

{ #category : #accessing }
SpAbstractPresenter >> application [
	"Answer application owner of this composition.
	 The tree for a composition starts always with an application, which is responsible of 
	 providing all resources the presenter needs. "

	^ self owner application
]

{ #category : #showing }
SpAbstractPresenter >> asBlockedDialogWindow [

	^ self defaultBlockedDialogWindowPresenterClass presenter: self
]

{ #category : #showing }
SpAbstractPresenter >> asDialogWindow [

	^ self defaultDialogWindowPresenterClass presenter: self
]

{ #category : #showing }
SpAbstractPresenter >> asModalWindow [

	^ self defaultModalWindowPresenterClass presenter: self
]

{ #category : #showing }
SpAbstractPresenter >> asWindow [

	^ self defaultWindowPresenterClass presenter: self
]

{ #category : #TOREMOVE }
SpAbstractPresenter >> autoAccept: aBoolean [
]

{ #category : #'private - building' }
SpAbstractPresenter >> basicBuildAdapterWithSpecLayout: aSpecLayout [
	"I assume the SpecBindings is well defined"
	
	self announcer announce: (SpWidgetWillBeBuilt model: self).

	self adapter: (aSpecLayout asSpLayout 
		buildAdapterFor: self 
		bindings: SpBindings value).

	self announcer announce: (SpWidgetBuilt 
		model: self 
		widget: adapter widget).
	
	^ adapter
]

{ #category : #'private - building' }
SpAbstractPresenter >> buildAdapterWithSpecLayout: aSpecLayout [
	"Build the adapter using the spec name provided as argument"
	
	^ SpBindings 
		value: self application adapterBindings
		during: [ self basicBuildAdapterWithSpecLayout: aSpecLayout ]
]

{ #category : #building }
SpAbstractPresenter >> buildWithSpec [
	"Build the widget using the default spec"
	
	^ self buildWithSpecLayout: self retrieveDefaultSpec
]

{ #category : #building }
SpAbstractPresenter >> buildWithSpec: aSpec [
	"Build the widget using the spec name provided as argument"
	
	^ self buildWithSpecLayout: (self retrieveSpec: aSpec)
]

{ #category : #building }
SpAbstractPresenter >> buildWithSpecLayout: aSpecLayout [
	"Build the widget using the spec name provided as argument"

	^ (self buildAdapterWithSpecLayout: aSpecLayout) widget
]

{ #category : #'private - showing' }
SpAbstractPresenter >> defaultBlockedDialogWindowPresenterClass [

	^ self application defaultBlockedDialogWindowPresenterClass
]

{ #category : #'private - showing' }
SpAbstractPresenter >> defaultDialogWindowPresenterClass [
		
	^ self application defaultDialogWindowPresenterClass
]

{ #category : #'private - showing' }
SpAbstractPresenter >> defaultModalWindowPresenterClass [
		
	^ self application defaultModalWindowPresenterClass
]

{ #category : #'private - building' }
SpAbstractPresenter >> defaultSpecSelector [
	(Pragma allNamed: #spec: from: self class class to: SpAbstractPresenter class class) detect: [ :each | (each argumentAt: 1) = #default ] ifFound: [ :pragma | ^ pragma methodSelector ].

	^ (Pragma allNamed: #spec from: self class class to: SpAbstractPresenter class class)
		ifEmpty: [ #defaultSpec ]
		ifNotEmpty: [ :pragmas | pragmas size = 1 ifTrue: [ pragmas first methodSelector ] ifFalse: [ #defaultSpec ] ]
]

{ #category : #'private - showing' }
SpAbstractPresenter >> defaultWindowPresenterClass [ 

	^ self application defaultWindowPresenterClass
]

{ #category : #accessing }
SpAbstractPresenter >> enabled: aBoolean [ 

	^ self subclassResponsibility
]

{ #category : #accessing }
SpAbstractPresenter >> eventHandler [
	"Answers an generic event handler where you can make your presenter listen to specific 
	low-level events. 
	Example of usage: 
	    myPresenter eventHandler whenLostFocusDo: [ ... ]
	
	WARNING: Now all events are available to all presenters (for example, presenters who can't
	take focus will not respong to focus events even if you register them)."
	
	^ eventHandler ifNil: [ eventHandler := SpEventHandler for: self ]
]

{ #category : #'private - utilities' }
SpAbstractPresenter >> forceUpdateSlot: aSymbol [

	^ (self rawValueHolderNamed: aSymbol) valueChanged
]

{ #category : #testing }
SpAbstractPresenter >> hasAdapter [

	^ adapter notNil
]

{ #category : #testing }
SpAbstractPresenter >> hasEventHandler [

	^ eventHandler notNil and: [ eventHandler hasEvents ]
]

{ #category : #testing }
SpAbstractPresenter >> hasOwner [

	^ self owner notNil
]

{ #category : #testing }
SpAbstractPresenter >> hasWindow [

	^ self root isWindowPresenter
]

{ #category : #initialization }
SpAbstractPresenter >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	needRebuild := true
]

{ #category : #initialization }
SpAbstractPresenter >> initializeDialogWindow: aDialogWindowPresenter [
	"Used to initialize the model in the case of the use into a dialog window.
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
SpAbstractPresenter >> initializeWindow: aWindowPresenter [
	"Override this to set window values before opening. 
	 You may want to add a menu, a toolbar or a statusbar"

	self flag: #TODO. "Does presenters needs to understand this? (they do if we 
	want to do ButtonPresenter new openWithSpec)."
]

{ #category : #testing }
SpAbstractPresenter >> isMenuPresenter [

	^ false
]

{ #category : #testing }
SpAbstractPresenter >> isPresenter [

	^ true
]

{ #category : #testing }
SpAbstractPresenter >> isWindowPresenter [

	^ false
]

{ #category : #accessing }
SpAbstractPresenter >> needRebuild [

	^ needRebuild
]

{ #category : #accessing }
SpAbstractPresenter >> needRebuild: aBoolean [

	needRebuild := aBoolean
]

{ #category : #showing }
SpAbstractPresenter >> openBlockedDialogWithSpec [
	"Build the widget using the default spec and display it into a dialog. 
	 Beware: this way will not create a real modal in the sense that the user will keep the focus on other windows. If you want to make the user focus on your dialog only you should use #openModalWithSpec instead."

	"A typical use of openBlockedDialogWithSpec is to configure it with callbackscallbacks: 
open
	^ self openBlockedDialogWithSpec
		okAction: [ self accept ];
		cancelAction: [ self cancel ];
		yourself
"

	^ self asBlockedDialogWindow open
]

{ #category : #showing }
SpAbstractPresenter >> openBlockedDialogWithSpec: aSelector [
	"Build the widget using the default spec and display it into a dialog. 
	 Beware: this way will not create a real modal in the sense that the user will keep the focus on other windows. If you want to make the user focus on your dialog only you should use #openDialogAsModalWithSpec: instead."

	^ self asBlockedDialogWindow openWith: (self retrieveSpec: aSelector)
]

{ #category : #showing }
SpAbstractPresenter >> openDialogWithSpec [
	"Build the widget using the default spec and display it into a dialog. 
	 Beware: this way will not create a real modal in the sense that the user will keep the focus on other windows. If you want to make the user focus on your dialog only you should use #openModalWithSpec instead."
	
	"A typical use of openDialogWithSpec is to configure it with callbackscallbacks: 

open
	^ self openDialogWithSpec
		okAction: [ self accept ];
		cancelAction: [ self cancel ];
		yourself
"

	^ self asDialogWindow open
]

{ #category : #showing }
SpAbstractPresenter >> openDialogWithSpec: aSelector [
	"Build the widget using the default spec and display it into a dialog. 
	 Beware: this way will not create a real modal in the sense that the user will 
	 keep the focus on other windows. If you want to make the user focus on your 
	 dialog only you should use #openModalWithSpec: instead."
	
	^ self asDialogWindow openWith: (self retrieveSpec: aSelector)
]

{ #category : #showing }
SpAbstractPresenter >> openModalWithSpec [

	^ self asModalWindow open
]

{ #category : #showing }
SpAbstractPresenter >> openModalWithSpec: aSelector [

	^ self asModalWindow openWith: (self retrieveSpec: aSelector)
]

{ #category : #showing }
SpAbstractPresenter >> openWithSpec [

	^ self asWindow open
]

{ #category : #showing }
SpAbstractPresenter >> openWithSpec: aSelector [

	^ self asWindow openWith: (self retrieveSpec: aSelector)
]

{ #category : #'private - showing' }
SpAbstractPresenter >> openWithSpecLayout: aSpecLayout [

	^ self asWindow openWith: aSpecLayout
]

{ #category : #accessing }
SpAbstractPresenter >> owner [

	^ owner
]

{ #category : #accessing }
SpAbstractPresenter >> owner: aPresenter [

	owner := aPresenter
]

{ #category : #'private - utilities' }
SpAbstractPresenter >> rawValueHolderNamed: aSymbol [

	^ (self class slotNamed: aSymbol) rawRead: self.
]

{ #category : #'private - building' }
SpAbstractPresenter >> retrieveDefaultSpec [

	^ self retrieveSpec: self defaultSpecSelector
]

{ #category : #'private - building' }
SpAbstractPresenter >> retrieveSpec: aSelector [
	| layout |

	layout := self class perform: aSelector.
	layout isSpLayout ifTrue: [ 
		layout selector: aSelector ].
	^ layout
]

{ #category : #accessing }
SpAbstractPresenter >> root [
	"Answer root presenter of this composition."
	
	^ self owner 
		ifNotNil: [ :presenter | presenter root ]
		ifNil: [ self ]
]

{ #category : #accessing }
SpAbstractPresenter >> spec [
	self flag: #TODO. "This needs to be removed, but there is a problem with the interpreter.
	(it will be solved as soon as the interpreter is removed :P)"
	
	^ self adapter
]

{ #category : #accessing }
SpAbstractPresenter >> spec: anAdapter [
	"This is a remaining of other times... spec accesor in fact contains an adapter"
	
	self flag: #TODO. "Same as #spec, it needs to go"
	self adapter: anAdapter
]

{ #category : #updating }
SpAbstractPresenter >> update: aParameter [

	self changed: aParameter
]

{ #category : #events }
SpAbstractPresenter >> whenBuiltDo: aBlock [

	self announcer 
		when: SpWidgetBuilt
		do: aBlock
]

{ #category : #events }
SpAbstractPresenter >> whenWillBeBuiltDo: aBlock [

	self announcer 
		when: SpWidgetWillBeBuilt
		do: aBlock
]

{ #category : #accessing }
SpAbstractPresenter >> window [
	"Answer window containing this composition."
	
	^ self hasWindow
		ifTrue: [ self root ]
		ifFalse: [ nil ]
]

{ #category : #'private - utilities' }
SpAbstractPresenter >> withAdapterDo: aValuable [
	"a convenience method to avoid verify by nil all the time"
	
	^ self adapter ifNotNil: aValuable
]

{ #category : #'private - utilities' }
SpAbstractPresenter >> withWidgetDo: aValuable [
	"a convenience method to avoid verify by nil all the time"

	^ self adapter ifNotNil: aValuable
]

{ #category : #'private - utilities' }
SpAbstractPresenter >> withWindowDo: aValuable [

	self hasWindow ifFalse: [ ^ self ].
	"Since Presenter has window, root = window"
	aValuable value: self root
]
