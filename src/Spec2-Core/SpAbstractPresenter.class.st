"
A base for all presenters. 
I define common behaviors for widget presenters and also for composable presenters (the ones an user regularly uses).

From a Spec2 users, my key methods are 
- `SpAbstractPresenter>>#application` to get access to the application into which I play.
- `SpAbstractPresenter>>#initializeDialogWindow:` defines the default buttons that decorated a dialog. Subclasses can override it to be able to customize how dialog get decorated.
- `SpAbstractPresenter>>#initializeWindow:` is a hook to define the window title and extend.
- `SpAbstractPresenter>>#openWithSpec` to open the receiver with the default layout. 
- `SpAbstractPresenter>>#openWithSpec: aSpecLayout` to open the receiver with the specified layout.
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

{ #category : #layout }
SpAbstractPresenter class >> defaultLayout [
	"Overrides me to define a layout in a static way"

	| specDefinition |
	(self respondsTo: #defaultSpec) 
		ifFalse: [ Error signal: 'You must define a layout either by defining #defaulLayout on your presenter or setting explicitly a layout with #layout:' ].

	self inform: 'SpPresenter class>>#defaultSpec is now deprecated. Please define #defaultLayout on instance or class side'.
	specDefinition := self class lookupSelector: #defaultSpec.
	(SpRenameDefaultSpecToDefaultLayoutRefactoring onPresenter: specDefinition methodClass) execute.
		
	"#defaultSpec is rewritten as #defaultLayout. Let's call it. Will only be used one time since bar is now overrided."
	^ self defaultLayout
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

{ #category : #accessing }
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
SpAbstractPresenter >> basicBuildAdapterWithLayout: aSpecLayout [
	"I assume the SpecBindings is well defined"
	aSpecLayout ifNil: [ Error signal: 'You must define a layout either by defining #defaulLayout on your presenter or setting explicitly a layout with #layout:' ].
	self announcer announce: (SpWidgetWillBeBuilt model: self).

	self adapter: (aSpecLayout asSpLayout 
		buildAdapterFor: self 
		bindings: SpBindings value).

	self announcer announce: (SpWidgetBuilt 
		model: self 
		widget: adapter widget).
	
	^ adapter
]

{ #category : #building }
SpAbstractPresenter >> build [
	"Build the widget using the default layout"
	
	^ self buildWithLayout: self layout
]

{ #category : #'private - building' }
SpAbstractPresenter >> buildAdapterWithLayout: aSpecLayout [
	"Build the adapter using the spec name provided as argument"
	
	^ SpBindings 
		value: self application adapterBindings
		during: [ self basicBuildAdapterWithLayout: aSpecLayout ]
]

{ #category : #building }
SpAbstractPresenter >> buildWithLayout: aSpecLayout [

	"Build the widget using the layout provided as argument"

	^ (self buildAdapterWithLayout: aSpecLayout) widget
]

{ #category : #building }
SpAbstractPresenter >> buildWithSelector: aSelector [

	"Build the widget using the layout selector name provided as argument"

	^ self buildWithLayout: (self retrieveLayout: aSelector)
]

{ #category : #'private - showing' }
SpAbstractPresenter >> defaultBlockedDialogWindowPresenterClass [

	^ self application defaultBlockedDialogWindowPresenterClass
]

{ #category : #'private - showing' }
SpAbstractPresenter >> defaultDialogWindowPresenterClass [
		
	^ self application defaultDialogWindowPresenterClass
]

{ #category : #initialization }
SpAbstractPresenter >> defaultLayout [
	"This method is there for compatibility purposes with Spec 1 
	where the layout (was named Spec) was defined on class side in a method #defaultSpec.
	
	In a near future, it should be replaced by self subclassResponsibility.
	"

	^ self class defaultLayout
]

{ #category : #'private - showing' }
SpAbstractPresenter >> defaultModalWindowPresenterClass [
		
	^ self application defaultModalWindowPresenterClass
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
SpAbstractPresenter >> hasAnnouncer [

	^ announcer notNil
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
SpAbstractPresenter >> layout [
	self subclassResponsibility 
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
SpAbstractPresenter >> open [

	^ self asWindow open
]

{ #category : #showing }
SpAbstractPresenter >> openBlockedDialog [
	"Build the widget using the default layout and display it into a dialog. 
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
SpAbstractPresenter >> openBlockedDialogWithLayout: aSpecLayout [
	"Build the widget using the given layout and display it into a dialog. 
	 Beware: this way will not create a real modal in the sense that the user will keep the focus on other windows. If you want to make the user focus on your dialog only you should use #openDialogAsModalWithSpec: instead."

	^ self asBlockedDialogWindow openWith: aSpecLayout
]

{ #category : #showing }
SpAbstractPresenter >> openDialog [
	"Build the widget using the default layout and display it into a dialog. 
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
SpAbstractPresenter >> openDialogWithLayout: aSpecLayout [
	"Build the widget using the provided spec layout and display it into a dialog. 
	 Beware: this way will not create a real modal in the sense that the user will 
	 keep the focus on other windows. If you want to make the user focus on your 
	 dialog only you should use #openModalWithSpec: instead."
	
	^ self asDialogWindow openWith: aSpecLayout
]

{ #category : #showing }
SpAbstractPresenter >> openModal [

	^ self asModalWindow open
]

{ #category : #showing }
SpAbstractPresenter >> openModalWithLayout: aSpecLayout [

	^ self asModalWindow openWith: aSpecLayout
]

{ #category : #showing }
SpAbstractPresenter >> openWithLayout: aSpecLayout [

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
SpAbstractPresenter >> retrieveLayout: aSelector [
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

{ #category : #subscription }
SpAbstractPresenter >> unsubscribe: anObject [
	"Observable slots keep subscriptions to them that can leak if not removed in certain cases."
	| observableSlots |
	
	observableSlots := self class allSlots 
		select: [ :aSlot | aSlot isObservableSlot ].

	observableSlots do: [ :aSlot |
		| slotValue | 
		slotValue := aSlot rawRead: self.
		slotValue ifNotNil: [ 
			slotValue unsubscribe: anObject ] ]
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
