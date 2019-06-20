"
ComposablePresenter is an abstract class which represent a applicative presenter made to be composed with other ComposablePresenter

Most often, I am used to display other subclasses of ComposablePresenter or subclasses of AbstractWidgetPresenter.

I collaborate with 
-  ValueHolder to managed some of my variables.
- SpecFocusOrder when no focusOrder are specified.
- SpecLayout
- WindowPresenter or DialogWindowPresenter to display myself.

A new subclass of ComposablePresenter must at least define initializeWidgets and defaultSpec on the class side.

I provide the following methods
- aboutText: set the text displayed in the About.
- title: set the title of the window.
- extent: set the initial size of the window, alternative possibility is define again initialExtent, it must be called before have displayed the widget. 
- focusOrder: set an instance what manage the order of focus of the keyboard navigation.
- bindKeyCombination:toAction: create a shortcut on keyboard what perform the block of the  action.
- owner getter of my parent.
- window getter of the window displaying me.

On my class side, I provide methods returning standard height and width for some elements.

todo
- announce:
- applyMenuModel: and neglectMenuModel:
- keyStrokeForNextFocus: , giveFocusToNextFrom: and takeKeyboardFocus
- ensureExtentFor:
- hide
- needRebuild
- on:do:
- update:
- widget

Window
=======

- openWithSpec instantiate a WindowPresenter using the lookup to found the layout to use.
- openDialogWithSpec instanciate a DialogWindowPresenter using the lookup to found the layout to use.
Their variants openWithSpec: and openDialogWithSpec:  use the layout parameter.

These methods can be useful to manage the window
- isDisplayed return true if the window of the widget is displayed
- hasWindow return true if the widget have a window
- centered to center the window in the world.
- delete to delete the window.

todo
- cancelled
- setModal:
- windowIcon:


Instantiation
===========

* initializeWidgets is called by the initialize method, it should contain initialization of subwidgets and of the focusorder.

The instantiation of a subwidget should use one of that way
- instantiate: take a class in parameter and return the created instance.
- methods named 'new' followed by a widget name are shortcut working with instatiate:

Usually, the subwidgets must be added in the focusOrder using something like 'self focusOrder add: accessor of  the  subwidget'

Note that instantiateModels: is legacy code in ComposablePresenter and must not be used. It will be deprecated and removed.

* initializePresenter is called by the initialize method after initializeWidgets, it should manage interaction of subwidgets.

Methods named 'when' followed by an event provide hook to perform the action in parameter.

Note
-------
Be careful about code order if you are overriding initialize method.
Normally in Spec initializing instance variables should be done BEFORE calling super initialize (so the opposite of the normal approach), because super initialize calls initalizeWidgets and initializePresenter that normally would make use of those variables.

Layout
======

See SpecLayout

defaultSpec or a method containing the pragma <spec: #default> must be defined in the class side of my subclasses.
It contains informations about how place its elements.
It possible to define more than one method to give the possibility to use another layout, by default the one containing the pragma will be used if it exists, if not defaultSpec will be used.
"
Class {
	#name : #SpComposablePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#layout',
		'#application',
		'#focusOrder',
		'#extentHolder',
		'#additionalKeyBindings',
		'#keyStrokesForNextFocusHolder',
		'#keyStrokesForPreviousFocusHolder',
		'#windowIcon',
		'#aboutText',
		'#askOkToClose',
		'#titleHolder',
		'#transmissions',
		'#additionalSubpresentersMap',
		'#visible => SpObservableSlot'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #specs }
SpComposablePresenter class >> defaultSpec [

	^ self subclassResponsibility
]

{ #category : #accessing }
SpComposablePresenter class >> iconNamed: aSymbol [
	^ Smalltalk ui icons iconNamed: aSymbol
]

{ #category : #'instance creation' }
SpComposablePresenter class >> newApplication: anApplication [

	^ self basicNew
		application: anApplication;
		initialize;
		yourself
]

{ #category : #'instance creation' }
SpComposablePresenter class >> newApplication: anApplication model: aModel [

	^ self basicNew
		application: anApplication;
		setModelBeforeInitialization: aModel;
		initialize;
		yourself
]

{ #category : #'instance creation' }
SpComposablePresenter class >> newApplication: anApplication owner: anOwningPresenter [

	^ self basicNew
		application: anApplication;
		owner: anOwningPresenter;
		initialize;
		yourself
]

{ #category : #'instance creation' }
SpComposablePresenter class >> newApplication: anApplication owner: anOwningPresenter model: aDomainObject [

	^ self basicNew
		application: anApplication;
		owner: anOwningPresenter;
		setModelBeforeInitialization: aDomainObject;
		initialize;
		yourself
]

{ #category : #'instance creation' }
SpComposablePresenter class >> on: aDomainObject [

	"self 
		deprecated: 'ComposablePresenters are instantiated in the context of an application!' 
		on: '2019-02-26' 
		in: #Pharo8."
		
	^ self 
		newApplication: SpNullApplication new 
		model: aDomainObject 
]

{ #category : #'instance creation' }
SpComposablePresenter class >> owner: anOwningPresenter on: aDomainObject [

	^ self basicNew
		owner: anOwningPresenter;
		setModelBeforeInitialization: aDomainObject;
		initialize;
		yourself
]

{ #category : #specs }
SpComposablePresenter class >> title [
	
	^ 'Untitled window'
]

{ #category : #TOREMOVE }
SpComposablePresenter >> aboutText [
	"DO NOT USE
	With Spec 2, ComposablePresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.
	
	This method cannot be deprecated because during a transition phase we keep this mecanism. "

	^ aboutText value
]

{ #category : #private }
SpComposablePresenter >> addAll: aWindow withSpec: aSpec [

	aWindow
		addMorph: (self buildWithSpec: aSpec)
		frame: (0@0 corner: 1@1).
]

{ #category : #private }
SpComposablePresenter >> addAll: aWindow withSpecLayout: aSpec [

	aWindow
		addMorph: (self buildWithSpecLayout: aSpec)
		frame: (0@0 corner: 1@1).
]

{ #category : #'window menu' }
SpComposablePresenter >> addMenuItemsToWindowMenu: aMenu [
	"Do nothing"
]

{ #category : #'api-shortcuts' }
SpComposablePresenter >> additionalKeyBindings [

	self flag: #TODO. "Think is... not all presenters can have keybindings. Why are we
	putting this functionality here and not in a trait?"
	^ additionalKeyBindings
]

{ #category : #TOREMOVE }
SpComposablePresenter >> additionalSubpresentersMap [

	"additionalSubpresentersMap serves for storing of sub-presenters that are not
	stored in instance variables"
	
	self flag: #TOREMOVE. "This is now provided by TDynamicPresenter"
	^ additionalSubpresentersMap ifNil: [ additionalSubpresentersMap := Dictionary new ]
]

{ #category : #'private-traversing' }
SpComposablePresenter >> allPresenters [
	| allPresenters |

	allPresenters := OrderedCollection new.
	self traversePresentersDo: [ :each | 
		allPresenters add: each ].
	^ allPresenters
]

{ #category : #api }
SpComposablePresenter >> announce: anAnnouncement [

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
SpComposablePresenter >> application [

	^ self hasOwner 
		ifTrue: [ self owner application ]
		ifFalse: [
			application ifNil: [ 
				self flag: #TODO. "This is incorrect, no component who is also a root
				(it does not has owner) should not have an application. But in older times
				it was not like that and to support such components we assign them to a 
				default application"
				application := SpApplication defaultApplication ] ]
]

{ #category : #accessing }
SpComposablePresenter >> application: anApplication [

	application := anApplication
]

{ #category : #'window menu' }
SpComposablePresenter >> applyMenuModel: aMenuModel [

	aMenuModel menuGroups do: [ :group |
		group menuItems do: [ :item |
			item shortcut ifNotNil: [ :shortcut | 
				self 
					bindKeyCombination: shortcut 
					toAction: [ item performMenuActionWith: #() ] ].
			item subMenu ifNotNil: [ :subMenu | subMenu applyTo: self	] ] ]
]

{ #category : #converting }
SpComposablePresenter >> asPresenter [
	"This allows to use presenter instances inside layouts directly"
	^ self
]

{ #category : #TOREMOVE }
SpComposablePresenter >> askOkToClose [

	"DO NOT USE
	With Spec 2, ComposablePresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.
	
	This method cannot be deprecated because during a transition phase we keep this mecanism. "
	^ askOkToClose value
]

{ #category : #'api-shortcuts' }
SpComposablePresenter >> bindKeyCombination: aShortcut toAction: aBlock [

	additionalKeyBindings ifNil: [ additionalKeyBindings := Dictionary new ].
	additionalKeyBindings at: aShortcut put: aBlock.
	self withAdapterDo: [ :anAdapter | 
		anAdapter bindKeyCombination: aShortcut toAction: aBlock ]
]

{ #category : #'api-window' }
SpComposablePresenter >> cancelled [
	self flag: #TODO. "just for dialogs... I wonder if we need it here?"

	self withWindowDo: #cancelled
]

{ #category : #TOMOVE }
SpComposablePresenter >> centerWidget: aWindow [

	self changed: #centerWidget: with: { aWindow }
]

{ #category : #'api-window' }
SpComposablePresenter >> centered [

	self withWindowDo: #centered
]

{ #category : #TOMOVE }
SpComposablePresenter >> centeredRelativeTo: aModel [

	self withWindowDo: [ :w | 
		w centeredRelativeTo: aModel ]
]

{ #category : #private }
SpComposablePresenter >> createInstanceFor: aClassSymbol [
	"Retrieve the class corresponding to aClassSymbol using the bindings, then create a new instance of theis class"
	| class |
	
	class := self resolveSymbol: aClassSymbol.
	^ self instantiate: class.
]

{ #category : #specs }
SpComposablePresenter >> defaultSpec [

	^ self class perform: self defaultSpecSelector
]

{ #category : #'api-showing' }
SpComposablePresenter >> defaultWindowPresenterClass [

	^ SpWindowPresenter
]

{ #category : #private }
SpComposablePresenter >> delete [

	self withWindowDo: #delete
]

{ #category : #accessing }
SpComposablePresenter >> enabled: aBoolean [

	self presentersDo: [ :each | 
		each enabled: aBoolean ]
]

{ #category : #TOMOVE }
SpComposablePresenter >> ensureExtentFor: widget [

	self extent
		ifNil: [ self initialExtent
			ifNotNil: [ :ex | 
				(widget respondsTo: #extent:)
					ifTrue: [ widget extent: ex ] ] ]
		ifNotNil: [ :ex | 
			(widget respondsTo: #extent:)
				ifTrue: [ widget extent: ex ] ].
	
]

{ #category : #'private-focus' }
SpComposablePresenter >> ensureKeyBindingsFor: aWidget [

	self registerKeyStrokesForNextFor: aWidget.
	self registerKeyStrokesForPreviousFor: aWidget.
	
	self additionalKeyBindings associationsDo: [:association | aWidget bindKeyCombination: association key toAction: association value ]
]

{ #category : #'api-focus' }
SpComposablePresenter >> eventKeyStrokesForNextFocus [
	"String describing the keystroke to perform to jump to the next widget"

	^ keyStrokesForNextFocusHolder value
]

{ #category : #'api-focus' }
SpComposablePresenter >> eventKeyStrokesForPreviousFocus [
	"String describing the keystroke to perform to jump to the previous widget"

	^ keyStrokesForPreviousFocusHolder value
]

{ #category : #TOMOVE }
SpComposablePresenter >> extent [

	^  extentHolder value
]

{ #category : #TOMOVE }
SpComposablePresenter >> extent: aPoint [

	^  extentHolder value: aPoint
]

{ #category : #accessing }
SpComposablePresenter >> focusOrder [

	^ focusOrder ifNil: [ focusOrder := OrderedCollection new ].
]

{ #category : #accessing }
SpComposablePresenter >> focusOrder: anObject [
	^ focusOrder := anObject
]

{ #category : #'private-focus' }
SpComposablePresenter >> giveFocusToNextFrom: aModel [
	| focus |
	
	focus := self focusOrder.
	^ true
]

{ #category : #'private-focus' }
SpComposablePresenter >> giveFocusToPreviousFrom: aModel [ 
	| focus |
	
	focus := self focusOrder.

	(focus includes: aModel)
		ifTrue: [
			| index previous |
			index := (focus indexOf: aModel) - 1.
			(index > 0)
				ifTrue: [
					previous := focus at: index.
					previous takeLastKeyboardFocus.
					^ true ]].

	^ owner 
		ifNil: [ " I loop "
			| next |
			next := focus at: focus size ifAbsent: [ ^ false ].
			next takeLastKeyboardFocus.
			true]
		ifNotNil: [ 
			owner giveFocusToPreviousFrom: self.
			true ]
]

{ #category : #'private-focus' }
SpComposablePresenter >> handlesKeyboard: evt [

	^ true
]

{ #category : #api }
SpComposablePresenter >> hide [

	visible := false
]

{ #category : #accessing }
SpComposablePresenter >> iconNamed: aSymbol [

	^ self class iconNamed: aSymbol
]

{ #category : #TOREMOVE }
SpComposablePresenter >> initialExtent [
	
	"DO NOT USE
	With Spec 2, ComposablePresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.
	
	This method cannot be deprecated because during a transition phase we keep this mecanism. "
	^ nil
]

{ #category : #initialization }
SpComposablePresenter >> initialize [

	super initialize.

	visible := true.
	additionalSubpresentersMap := nil.

	self initializePrivateAnnouncer.
	self initializePrivateValueHolders.
	self initializePrivateHooks.
	self initializePrivateAnnouncements
]

{ #category : #initialization }
SpComposablePresenter >> initializePresenter [
	"Used to specify the subwidgets, and/or to bind them together"

	"By default, do not do anything"

	extentHolder whenChangedDo: [ :ex | 
		self withAdapterDo: [ :widget | 
			(widget respondsTo: #extent:)
				ifTrue: [ widget extent: ex ] ] ]
]

{ #category : #'initialization - private' }
SpComposablePresenter >> initializePrivateAnnouncements [

	keyStrokesForNextFocusHolder whenChangedDo: [ self registerKeyStrokesForNextFor: self widget ].
	keyStrokesForPreviousFocusHolder whenChangedDo: [ self registerKeyStrokesForPreviousFor: self widget ].
	titleHolder whenChangedDo: [ self updateTitle ]
]

{ #category : #'initialization - private' }
SpComposablePresenter >> initializePrivateAnnouncer [

  announcer := Announcer new.

]

{ #category : #'initialization - private' }
SpComposablePresenter >> initializePrivateHooks [

	self initializeWidgets.
	self initializePresenter.
	self updatePresenter.

]

{ #category : #'initialization - private' }
SpComposablePresenter >> initializePrivateValueHolders [

	extentHolder := nil asValueHolder.
	keyStrokesForNextFocusHolder := { KMNoShortcut new } asValueHolder.
	keyStrokesForPreviousFocusHolder := { KMNoShortcut new } asValueHolder.
	aboutText := nil asValueHolder.
	windowIcon := nil asValueHolder.
	askOkToClose := false asValueHolder.
	titleHolder := self class title asValueHolder.
	

]

{ #category : #initialization }
SpComposablePresenter >> initializeWidgets [
	
	self subclassResponsibility
]

{ #category : #initialization }
SpComposablePresenter >> initializeWindow: aWindowPresenter [
	"override this to set window values before opening. 
	 You may want to add a menu, a toolbar or a statusbar"

	"IMPORTANT: Please ovirride this method and set yourself the informations you want in your window.
	The content of this method is here to help the transition between Spec 1 and 2.
	In the next Spec version the content of this method will be removed and it will do nothing by default because the goal is to remove the management of all of those informations from Composable to put them in WindowPresenter."

	aWindowPresenter
		title: self title;
		initialExtent: self initialExtent;
		windowIcon: self windowIcon;
		askOkToClose: self askOkToClose;
		aboutText: self aboutText
]

{ #category : #'instance creation' }
SpComposablePresenter >> instantiate: aComposablePresenterClass [
	"Instantiate a ComposablePresenter subclass and set its instance owner"
	^ aComposablePresenterClass owner: self
]

{ #category : #'instance creation' }
SpComposablePresenter >> instantiate: aComposablePresenterClass on: aModel [
	"Instantiate a ComposablePresenter subclass and set its instance owner and model"
	^ aComposablePresenterClass owner: self on: aModel
]

{ #category : #'instance creation' }
SpComposablePresenter >> instantiatePresenters: aCollectionOfPairs [
	"instantiatePresenters: is legacy code in ComposablePresenter and must not be used. It will be deprecated and removed."

	"Used to instantiate multiple sub widget at once. Take aCollectionOfPairs where each odd element is an inst var name and each even element is a class name, create an instance from the class name and store it into the inst var"

	(aCollectionOfPairs anySatisfy: [ :e | e isKindOf: Association ])
		ifTrue: [ aCollectionOfPairs
				do: [ :a | 
					| k v |
					k := a key.
					v := a value.
					self instVarNamed: k asString put: (self createInstanceFor: v) ] ]
		ifFalse: [ aCollectionOfPairs
				pairsDo: [ :k :v | self instVarNamed: k asString put: (self createInstanceFor: v) ] ]
]

{ #category : #api }
SpComposablePresenter >> isDisplayed [
	"Return true if the widget is currently displayed on screen"
	
	self flag: #TODO. "To move to WindowPresenter exclusive?"
	^ self hasWindow 
		ifTrue: [ self root isDisplayed ]
		ifFalse: [ false ]
]

{ #category : #testing }
SpComposablePresenter >> isVisible [
	
	^ visible value
]

{ #category : #'api-focus' }
SpComposablePresenter >> keyStrokeForNextFocus: aKMShortcut [

	keyStrokesForNextFocusHolder value: { aKMShortcut }
]

{ #category : #'api-focus' }
SpComposablePresenter >> keyStrokeForPreviousFocus: aKMShortcut [

	keyStrokesForPreviousFocusHolder value: { aKMShortcut }
]

{ #category : #'api-focus' }
SpComposablePresenter >> keyStrokesForNextFocus: aCollection [

	keyStrokesForNextFocusHolder value: aCollection
]

{ #category : #'api-focus' }
SpComposablePresenter >> keyStrokesForPreviousFocus: aCollection [

	keyStrokesForPreviousFocusHolder value: aCollection 
]

{ #category : #accessing }
SpComposablePresenter >> layout [
	^ layout
]

{ #category : #'window menu' }
SpComposablePresenter >> neglectMenuModel: aMenuModel [

	aMenuModel menuGroups do: [ :group |
		group menuItems do: [ :item |
			item shortcut ifNotNil: [ :shortcut | self removeKeyCombination: shortcut ].
			item subMenu ifNotNil: [ :subMenu | subMenu neglect: self	] ] ]
]

{ #category : #widgets }
SpComposablePresenter >> newActionBar [

	^ self instantiate: SpActionBarPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newButton [
	^ self instantiate: SpButtonPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newButtonBar [

	^ self instantiate: SpButtonBarPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newCheckBox [
	^ self instantiate: SpCheckBoxPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newCode [
	^ self instantiate: SpCodePresenter
]

{ #category : #widgets }
SpComposablePresenter >> newDiff [
	^ self instantiate: SpDiffPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newDropList [
	^ self instantiate: SpDropListPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newDynamicPresentersListIn: accessorSymbol usingBuilder: aDynamicPresentersListBuilder [
	|mutatorSymbol newDynamicPresenter |
	mutatorSymbol := (accessorSymbol , ':') asSymbol.
	(self perform: accessorSymbol)
		ifNotNil: [ :dynamicPresenter | dynamicPresenter owner: nil ].
	newDynamicPresenter := aDynamicPresentersListBuilder build.
	
	self perform: mutatorSymbol with: newDynamicPresenter.
	
	newDynamicPresenter owner: self.
	
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #widgets }
SpComposablePresenter >> newImage [
	^ self instantiate: SpImagePresenter
]

{ #category : #widgets }
SpComposablePresenter >> newLabel [
	^ self instantiate: SpLabelPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newLink [
	^ self instantiate: SpLinkPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newList [
	^ self instantiate: SpListPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newMenu [
	^ self instantiate: SpMenuPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newMenuBar [
	^ self instantiate: SpMenuBarPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newNotebook [

	^ self instantiate: SpNotebookPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newNotebookPage [

	self flag: #TODO. "NotebookPage needs to be a Presenter?"
	^ NotebookPage new
]

{ #category : #widgets }
SpComposablePresenter >> newNullPresenter [
	^ self instantiate: SpNullPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newNumberInput [
	^ self instantiate: SpNumberInputFieldPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newProgressBar [
	^ self instantiate: SpProgressBarPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newRadioButton [
	^ self instantiate: SpRadioButtonPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newSlider [
	^ self instantiate: SpSliderPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newTable [

	^ self instantiate: SpTablePresenter
]

{ #category : #widgets }
SpComposablePresenter >> newText [
	^ self instantiate: SpTextPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newTextInput [
	^ self instantiate: SpTextInputFieldPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newToolBar [

	^ self instantiate: SpToolBarPresenter
]

{ #category : #widgets }
SpComposablePresenter >> newTreeTable [

	^ self instantiate: SpTreeTablePresenter
]

{ #category : #private }
SpComposablePresenter >> okToChange [

	^ self hasWindow
		ifTrue: [ self window okToChange ]
		ifFalse: [ true ] 
]

{ #category : #'api-announcements' }
SpComposablePresenter >> on: anAnnouncement send: aSelector to: aTarget [

	self announcer
		when: anAnnouncement 
		send: aSelector 
		to: aTarget
]

{ #category : #accessing }
SpComposablePresenter >> presenterAt: aName [
	"Retrieves a subpresenter of this composed presenter."

	^ self readSlotNamed: aName
]

{ #category : #accessing }
SpComposablePresenter >> presenterAt: aName ifAbsent: aBlock [
	"Retrieves a subpresenter of this composed presenter."

	^ [ self readSlotNamed: aName ]
		on: SlotNotFound
		do: aBlock
]

{ #category : #'private-traversing' }
SpComposablePresenter >> presenters [
	| allPresenters |

	allPresenters := OrderedCollection new.
	self presentersDo: [ :each | 
		allPresenters add: each ].
	^ allPresenters
]

{ #category : #'private-traversing' }
SpComposablePresenter >> presentersDo: aBlock [

	self class allSlots 
		reject: [ :each | each name = #owner ] 
		thenDo: [ :each | | var |
			var := self readSlot: each.
			(var isKindOf: SpPresenter) ifTrue: [ 
				aBlock value: var ] ]
]

{ #category : #'private-focus' }
SpComposablePresenter >> registerKeyStrokesForNextFor: aWidget [

	aWidget ifNil: [ ^ self ].
	
	self eventKeyStrokesForNextFocus do: [:each |
		aWidget bindKeyCombination: each toAction: [ self giveFocusToNextFrom: self ] ]
]

{ #category : #'private-focus' }
SpComposablePresenter >> registerKeyStrokesForPreviousFor: aWidget [

	aWidget ifNil: [ ^ self ].
	
	self eventKeyStrokesForPreviousFocus do: [:each |
		aWidget bindKeyCombination: each toAction: [ self giveFocusToPreviousFrom: self ] ]
]

{ #category : #'api-shortcuts' }
SpComposablePresenter >> removeKeyCombination: aShortcut [

	self additionalKeyBindings removeKey: aShortcut ifAbsent: [ ^ self ].
	self withAdapterDo: [ :anAdapter | 
		anAdapter removeKeyCombination: aShortcut ]
]

{ #category : #'api-window' }
SpComposablePresenter >> requestWindowClose [

	"returns <true> if the user is allowed to close the window. Useful if you want to ask user if he wants to save the changed content etc."
	
	^ true
]

{ #category : #private }
SpComposablePresenter >> resolveSymbol: aSymbol [

	^ Smalltalk at: aSymbol
]

{ #category : #api }
SpComposablePresenter >> retrieveSpec: aSelector [

	self layout ifNotNil: [ ^ self layout ].
	^ super retrieveSpec: aSelector
]

{ #category : #TOMOVE }
SpComposablePresenter >> setExtentAndBindingTo: widget [

	self flag: #TODO. "This is bad. Extent needs to be 'ensured' at adapter level. 
	Same for keybindings"
	self ensureExtentFor: widget.
	self ensureKeyBindingsFor: widget
]

{ #category : #'accessing model' }
SpComposablePresenter >> setModel: aDomainObject [


]

{ #category : #'accessing model' }
SpComposablePresenter >> setModelBeforeInitialization: aDomainObject [


]

{ #category : #api }
SpComposablePresenter >> show [

	visible := true
]

{ #category : #TOREMOVE }
SpComposablePresenter >> specSpacer [

	^ SpacerPresenter new
]

{ #category : #'private-focus' }
SpComposablePresenter >> takeKeyboardFocus [

	self focusOrder ifNotEmpty:[:focus | ^ focus first takeKeyboardFocus ].
	^ self changed: #takeKeyboardFocus with: #()
]

{ #category : #'private-focus' }
SpComposablePresenter >> takeLastKeyboardFocus [

	self focusOrder
		ifEmpty: [ self takeKeyboardFocus ]
		ifNotEmpty: [:focus | focus last takeKeyboardFocus ].
]

{ #category : #TOREMOVE }
SpComposablePresenter >> title [
	"DO NOT USE
	With Spec 2, ComposablePresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.
	
	This method cannot be deprecated because during a transition phase we keep this mecanism. "

	^ titleHolder value
]

{ #category : #TOREMOVE }
SpComposablePresenter >> toolName [

	^ self class toolName
]

{ #category : #'private-traversing' }
SpComposablePresenter >> traversePresentersDo: aBlock [

	self 
		traversePresentersDo: aBlock 
		excluding: Set new
]

{ #category : #'private-traversing' }
SpComposablePresenter >> traversePresentersDo: aBlock excluding: excludes [

	(excludes includes: self) ifTrue: [ ^ self ]. 
	excludes add: self.
	aBlock value: self.

	self class allSlots do: [ :each | | var |
		var := self readSlot: each.
		(var isKindOf: SpPresenter) ifTrue: [ 
			var traversePresentersDo: aBlock excluding: excludes ] ]
]

{ #category : #updating }
SpComposablePresenter >> update [
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #initialization }
SpComposablePresenter >> updatePresenter [
]

{ #category : #api }
SpComposablePresenter >> updateTitle [

	self flag: #TODO. "To move to WindowPresenter"
	"Update the window title"
	self withWindowDo: #updateTitle
]

{ #category : #api }
SpComposablePresenter >> visibleIf: aValuable [
	visible := aValuable
]

{ #category : #'api-events' }
SpComposablePresenter >> whenShortcutsChanged: aBlock [
	"Set a block to value when the shortcuts block has changed"
	
	self additionalKeyBindings whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpComposablePresenter >> whenVisibleChangedDo: aBlock [
	
	self property: #visible whenChangedDo: aBlock
]

{ #category : #'api-window' }
SpComposablePresenter >> whenWindowChanged: aBlock [

	self flag: #TODO. "This is here for backwards compatibility (you can have same 
	functionality in #initializeWindow:"
	self announcer 
		when: WindowBuilt 
		do: [ :ann | aBlock cull: ann model ]
]

{ #category : #TOREMOVE }
SpComposablePresenter >> windowIcon [
	"DO NOT USE
	With Spec 2, ComposablePresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.
	
	This method cannot be deprecated because during a transition phase we keep this mecanism. "

	^ windowIcon value
]
