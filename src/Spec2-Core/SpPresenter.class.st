"
`SpPresenter` is an abstract class which represents an presenter made to be composed with other `SpPresenter` instances.

Often, I am used to display other subclasses of `SpPresenter` or subclasses of `SpAbstractWidgetPresenter`.

I collaborate with 
- `ObservableSlot` to manage some of my variables.
- `SpLayout`
- `SpWindowPresenter` or `SpDialogWindowPresenter` to display myself.

A new subclass of `SpPresenter` must at least define `initializeWidgets` and `defaultSpec` on the class side.

I provide the following methods
- aboutText: set the text displayed in the About.
- initializeWindow: to set the title, and other information related to the window.
- extent: set the initial size of the window, alternative possibility is define again initialExtent, it must be called before have displayed the widget. 
- focusOrder: set an instance what manage the order of focus of the keyboard navigation.
- bindKeyCombination:toAction: create a shortcut on keyboard what perform the block of the  action.
- owner getter of my parent.
- window getter of the window displaying me.

On my class side, I provide methods returning standard height and width for some elements.

## Window

- `SpPresenter>>#openWithSpec` instantiates a `SpWindowPresenter` using the lookup to found the layout to use.
- `SpPresenter>>#openDialogWithSpec` instanciates a `SpDialogWindowPresenter` using the lookup to found the layout to use.
Their variants `openWithSpec:` and `openDialogWithSpec:` use the layout parameter.

These methods can be useful to manage the window
- `SpPresenter>>#isDisplayed` returns true if the window of the widget is displayed
- `SpPresenter>>#hasWindow` returns true if the widget have a window
- `SpPresenter>>#centered` to center the window in the world.
- `SpPresenter>>#delete` to delete the window.

## Instantiation

`SpPresenter>>#initializePresenters` is called by the initialize method, it should contain initialization of subwidgets.

The instantiation of a subwidget should use one of that way
- `instantiate:` take a presenter class as parameter and return the created instance.
- methods named 'new' followed by a widget name are shortcut working with `instantiate:`

```
	list := self newList.
	list2 := self instantiate: SpListPresenter
```

Usually, the subwidgets must be added in the focusOrder using something like 'self focusOrder add: accessor of  the  subwidget'

`SpPresenter>>#connectPresenters` is called by the initialize method after initializePresenters, it should manage interaction of subwidgets.

Methods named 'when' followed by an event provide hook to perform the action in parameter.

### Note
Be careful about code order if you are overriding initialize method.
Normally in Spec initializing instance variables should be done BEFORE calling `super initialize` (so the opposite of the normal approach), because super initialize calls `initalizePresenters` and `connectPresenters` that normally would make use of those variables.

## Layout

As a general principle refer to the subclasses of`SpExecutableLayout`.

`defaultSpec` or a method containing the pragma `<spec: #default>` must be defined in the class side of my subclasses.
It contains information about how visually position its elements.
It possible to define more than one method to give the possibility to use another layout, by default the one containing the pragma will be used if it exists, if not `defaultSpec` will be used.

Developer may also want to define instance level layouts. A good idiom is the following one:

```
SpMyPresenter >> initializePresenters
	... instantiate presenters ...
	self initializeLayout
```

```
SpMyPresenter >> initializeLayout
	self layout: (SpXXLayout new add: ...; yourself)
```




"
Class {
	#name : 'SpPresenter',
	#superclass : 'SpAbstractPresenter',
	#traits : 'SpTPresenterBuilder + SpTActionContainer',
	#classTraits : 'SpTPresenterBuilder classTrait + SpTActionContainer classTrait',
	#instVars : [
		'#application',
		'#focusOrder',
		'#contextKeyBindings => ObservableSlot',
		'#windowIcon => ObservableSlot',
		'#aboutText => ObservableSlot',
		'#askOkToClose => ObservableSlot',
		'#titleHolder => ObservableSlot',
		'#additionalSubpresentersMap',
		'#layout => ObservableSlot',
		'#visible => ObservableSlot',
		'#extent => ObservableSlot',
		'#styles'
	],
	#classInstVars : [
		'#customExtent'
	],
	#category : 'Spec2-Core-Base',
	#package : 'Spec2-Core',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpPresenter class >> currentApplication [ 

	^ SpApplication defaultApplication
]

{ #category : 'accessing' }
SpPresenter class >> defaultPreferredExtent [

	^ 700@500
]

{ #category : 'labeled-presenters' }
SpPresenter class >> iconWidth [
	^ 24
]

{ #category : 'testing' }
SpPresenter class >> isAbstract [
	^ self = SpPresenter
]

{ #category : 'TOREMOVE' }
SpPresenter class >> labelWidth [
	^ 100
]

{ #category : 'instance creation' }
SpPresenter class >> newApplication: anApplication [

	^ self basicNew
		application: anApplication;
		initialize;
		yourself
]

{ #category : 'instance creation' }
SpPresenter class >> newApplication: anApplication model: aModel [

	^ self basicNew
		application: anApplication;
		setModelBeforeInitialization: aModel;
		initialize;
		yourself
]

{ #category : 'instance creation' }
SpPresenter class >> newApplication: anApplication owner: anOwningPresenter [

	^ self basicNew
		application: anApplication;
		owner: anOwningPresenter;
		initialize;
		yourself
]

{ #category : 'instance creation' }
SpPresenter class >> newApplication: anApplication owner: anOwningPresenter model: aDomainObject [

	^ self basicNew
		application: anApplication;
		owner: anOwningPresenter;
		setModelBeforeInitialization: aDomainObject;
		initialize;
		yourself
]

{ #category : 'instance creation' }
SpPresenter class >> on: aDomainObject [

	^ self 
		newApplication: self currentApplication
		model: aDomainObject 
]

{ #category : 'instance creation' }
SpPresenter class >> owner: anOwningPresenter on: aDomainObject [

	^ self basicNew
		owner: anOwningPresenter;
		setModelBeforeInitialization: aDomainObject;
		initialize;
		yourself
]

{ #category : 'accessing' }
SpPresenter class >> preferredExtent [
	"Note that we do not store here the defaultPreferredExtent because this way this is only when resizing is happening that we store the new size. 
	It means in particular that if the defaultPreferredExtent is dynamically computed we honore it and not blindly returns the first value."
	
	^ customExtent ifNil: [ self defaultPreferredExtent ]
]

{ #category : 'accessing' }
SpPresenter class >> preferredExtent: aPoint [
	
	customExtent := aPoint
]

{ #category : 'accessing' }
SpPresenter class >> resetRememberedResizeExtent [
	
	customExtent := nil 
]

{ #category : 'specs' }
SpPresenter class >> title [
	
	^ 'Untitled window'
]

{ #category : 'TOREMOVE' }
SpPresenter >> aboutText [
	"DO NOT USE
	With Spec 2, SpPresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.
	
	This method cannot be deprecated because during a transition phase we keep this mecanism. "

	^ aboutText
]

{ #category : 'visiting' }
SpPresenter >> acceptVisitor: aVisitor [

	aVisitor visitPresenter: self
]

{ #category : 'private' }
SpPresenter >> addAll: aWindow withSpecLayout: aSpec [

	aWindow
		addMorph: (self buildWithSpecLayout: aSpec)
		frame: (0@0 corner: 1@1).
]

{ #category : 'api' }
SpPresenter >> addStyle: aName [
	"Add a style-class to a presenter. Styles are defined in the application stylesheet and will 
	 affect presenters by applying the properties the user adds to the class.
	 Styles can be added and removed dynamically (see `SpPresenter>>#removeStyle:`)
	
	```language=Smalltalk
	button := self newButton 
		label: 'Example of style';
		addStyle: 'myButton';
		yourself.
	```"

	(styles includes: aName) ifTrue: [ ^ self ].
	styles := styles copyWith: aName.
	self withAdapterDo: [ :anAdapter | anAdapter addStyle: aName ]
]

{ #category : 'TOREMOVE' }
SpPresenter >> additionalSubpresentersMap [

	"additionalSubpresentersMap serves for storing of sub-presenters that are not
	stored in instance variables"
	
	self flag: #TOREMOVE. "This is now provided by TDynamicPresenter"
	^ additionalSubpresentersMap ifNil: [ additionalSubpresentersMap := Dictionary new ]
]

{ #category : 'simple dialog helpers' }
SpPresenter >> alert: aString [
	"Displays a simple inform dialog, for more configurable version please use `self application newInform title: ....`."

	^ self application alert: aString
]

{ #category : 'private - traversing' }
SpPresenter >> allPresenters [
	"This answers ALL presenters included in this presenter, the ones that are in the layout 
	 BUT ALSO the presenters in other embeded presenters
	 e.g. 
	 1. presenter A includes presenters B and C.
	 2. presenter B includes presenters B1 and B2
	 3. presenter C includes presenter C1
	 then `A allPresenters` = { B. B1. B2. C. C1 }
	
	See also `SpPresenter>>#presenters`.
	"

	^ Array streamContents: [ :stream |
		self traversePresentersDo: [ :each | 
			stream << each ] ]
]

{ #category : 'private' }
SpPresenter >> allPresentersInFocusOrder [
	"This answers ALL presenters included in this presenter, the ones that are in the layout 
	 BUT ALSO the presenters in other embeded presenters. 
	 And it answers the list *in focus order*. 
	 See also `SpPresenter>>#allPresenters`"

	^ Array streamContents: [ :stream |
		self traverseInFocusOrderDo: [ :each |
			stream << each  ] ]
]

{ #category : 'accessing' }
SpPresenter >> announce: anAnnouncement [

	announcer ifNil: [ ^ self ].
	self announcer announce: anAnnouncement
]

{ #category : 'private' }
SpPresenter >> announceDisplayed [
	"When using a VersatileDialogPresenter the adapter is nil.
	We do not know if that is a correct behaviour"

	self announcer
		announce:
			(SpWidgetDisplayed new
				presenter: self;
				widget: (adapter ifNotNil: [ adapter widget ]);
				yourself)
]

{ #category : 'accessing' }
SpPresenter >> application [

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

{ #category : 'accessing' }
SpPresenter >> application: anApplication [

	application := anApplication
]

{ #category : 'private' }
SpPresenter >> applyKeyBindingsFromMenu: aMenuPresenter [
	"traverses aMenuPresenter and bind shortcuts associated "

	aMenuPresenter menuGroups do: [ :group |
		group menuItems do: [ :item |
			item shortcut ifNotNil: [ :shortcut | 
				self addShortcutWith: [ :action | action
					shortcutKey: shortcut;
					action: [ item performMenuActionWith: #() ] ] ].
			item subMenu ifNotNil: [ :subMenu | subMenu addKeyBindingsTo: self	] ] ]
]

{ #category : 'converting' }
SpPresenter >> asPopover [

	^ self owner newPopover
		presenter: self;
		yourself
]

{ #category : 'converting' }
SpPresenter >> asPresenter [
	"This allows to use presenter instances inside layouts directly"

	^ self
]

{ #category : 'converting' }
SpPresenter >> asPresenterOn: aPresenter [
	"This allows to use presenter instances inside layouts directly"

	^ self
]

{ #category : 'TOREMOVE' }
SpPresenter >> askOkToClose [
	"DO NOT USE
	With Spec 2, SpPresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.
	
	This method cannot be deprecated because during a transition phase we keep this mecanism. "

	^ askOkToClose
]

{ #category : 'private - building' }
SpPresenter >> basicBuildAdapterWithLayout: aSpecLayout [

	layout == aSpecLayout ifFalse: [ layout := aSpecLayout ].
	^ super basicBuildAdapterWithLayout: aSpecLayout
]

{ #category : 'api - shortcuts' }
SpPresenter >> bindKeyCombination: aShortcut toAction: aBlock [
	"Adds a single shortcut to the list of `SpPresenter>>#contextKeyBindings`. Action `aBlock` 
	 will be executed when presenter the key combination is presseed.
	 - `aShortcut` is an instance of `KMKeyCombination`
	 - `aBlock` receive zero arguments."

	"self 
		deprecated: 'Keybindings usege is deprecated in favor of addShortcut: system' 
		on: '2024/09/11' 
		in: #Pharo13."

	contextKeyBindings ifNil: [ contextKeyBindings := KMCategory new ].
	contextKeyBindings addKeymapEntry: (KMKeymap
		shortcut: aShortcut
		action: aBlock).
	self withAdapterDo: [ :anAdapter | 
		anAdapter bindKeyCombination: aShortcut toAction: aBlock ]
]

{ #category : 'testing' }
SpPresenter >> canTakeKeyboardFocus [
	"Answer when the presenter can take keyboard focus."

	^ true
]

{ #category : 'TOREMOVE' }
SpPresenter >> cancelled [
	self flag: #TODO. "just for dialogs... I wonder if we need it here?"

	self withWindowDo: #cancelled
]

{ #category : 'TOREMOVE' }
SpPresenter >> centered [

	self withWindowDo: [ :each | each centered ]
]

{ #category : 'simple dialog helpers' }
SpPresenter >> confirm: aString [
	"Displays a simple confirm dialog, for more configurable version please use `self application newConfirm title: ....`."

      ^  self application confirm: aString

]

{ #category : 'initialization' }
SpPresenter >> connectPresenters [
	"The method connectPresenters defines the interactions between the different widgets. By connecting the behaviors of the different widgets it specifies the overall presentation, i.e., how the overall UI responds to interactions by the user. Usually this method consists of specifications of actions to perform when a certain event is received by a widget. The whole interaction flow of the UI then emerges from the propagation of those events."
]

{ #category : 'api - shortcuts' }
SpPresenter >> contextKeyBindings [
	"Answer contextKeyBindings stores a KMCategory with keybindings for this presenter. 
	 Note that not all presenters can have key bindings, just the ones that can take the 
	 keyboard focus. 
	 Also, all user defined presenters can have context key bindings."

	^ contextKeyBindings
]

{ #category : 'api - shortcuts' }
SpPresenter >> contextKeyBindings: aKMCategory [
	"Set the context keybindings for this presenter."
	
	"self
		deprecated: 'contextKeyBindings have been deprecated in favor of actions.'  
		on: '2024/09/15' 
		in: #Pharo13."
	
	contextKeyBindings := contextKeyBindings 
		ifNotNil: [ contextKeyBindings, aKMCategory ]
		ifNil: [ aKMCategory ]
]

{ #category : 'private' }
SpPresenter >> createInstanceFor: aClassSymbol [
	"Retrieve the class corresponding to aClassSymbol using the bindings, then create a new instance of this class"

	| class |
	class := self resolveSymbol: aClassSymbol.
	^ self instantiate: class.
]

{ #category : 'api - focus' }
SpPresenter >> defaultKeyboardFocus [
	"Answer the presentar that will act as default responder when showing this presenter or 
	 receive the `SpPresenter>>#takeKeyboardFocus` message. By default, this answers self, 
	 but it can be overriden to place the focus somewhere else"

	^ self
]

{ #category : 'accessing' }
SpPresenter >> defer: aBlock [

	self application defer: aBlock
]

{ #category : 'private' }
SpPresenter >> delete [

	self withWindowDo: #delete
]

{ #category : 'accessing' }
SpPresenter >> enabled: aBoolean [

	self presentersDo: [ :each | 
		each enabled: aBoolean ]
]

{ #category : 'accessing' }
SpPresenter >> extent [
	"Usually a presenter does not set its extent explicitly, it does it by defining a class method named defaultPreferredExtent. If extent is not set, by default return its preferredExtent."
	
	^ extent ifNil: [ self preferredExtent ]
]

{ #category : 'accessing' }
SpPresenter >> extent: aPoint [
	^ extent := aPoint
]

{ #category : 'accessing' }
SpPresenter >> focusOrder [

	^ focusOrder ifNil: [ focusOrder := OrderedCollection new ].
]

{ #category : 'accessing' }
SpPresenter >> focusOrder: anObject [
	^ focusOrder := anObject
]

{ #category : 'api - focus' }
SpPresenter >> focusedPresenter [
	"Answer the focused presenter if any (nil if no presenter is focused)"

	^ self allPresentersInFocusOrder
		detect: [ :each | each hasKeyboardFocus ]
		ifNone: [ nil ]
]

{ #category : 'api - focus' }
SpPresenter >> hasKeyboardFocus [
	"Answer true if this presenter has the active keyboard focus."

	self canTakeKeyboardFocus ifFalse: [ ^ false ].
	self withAdapterDo: [ :anAdapter | ^ anAdapter hasKeyboardFocus ].
	^ false
]

{ #category : 'api' }
SpPresenter >> hide [
	"hide current presenter making it invisible for the user"

	self visible: false
]

{ #category : 'accessing' }
SpPresenter >> iconNamed: aSymbol [

	^ self application iconNamed: aSymbol
]

{ #category : 'simple dialog helpers' }
SpPresenter >> inform: aString [
	"Displays a simple inform dialog, for more configurable version please use `self application newInform title: ....`."

	^ self application inform: aString
]

{ #category : 'simple dialog helpers' }
SpPresenter >> informUser: aString during: aBlock [
	"Displays a simple inform dialog while a task is perform without progress bar."

	^ self application informUser: aString during: aBlock
]

{ #category : 'TOREMOVE' }
SpPresenter >> initialExtent [
	
	"DO NOT REDEFINE
	
	- You should define a defaultPreferredExtent class method return the 
	extent of your window. 
	
	If you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened. "
	^ nil
]

{ #category : 'initialization' }
SpPresenter >> initialize [

	super initialize.

	visible := true.
	styles := #().

	self initializePrivateAnnouncer.
	self initializePrivateValueHolders.
	self initializePrivateHooks.
	self initializePrivateAnnouncements
]

{ #category : 'initialization' }
SpPresenter >> initializePopover: aPopoverPresenter [
	"This presenter will be shown in a popover, which may need to be 
	 configured accordingly. Override this method to add that configuration"
]

{ #category : 'initialization - deprecated' }
SpPresenter >> initializePresenter [
	"Now, presenters should implement #connectPresenters instead."
	"Obsolete. Do not use me, use connectPresenters"
	self 
		property: #extent 
		whenChangedDo: [ :ex | 
			self withAdapterDo: [ :widget | 
				(widget respondsTo: #extent:) 
					ifTrue: [ widget extent: ex ] ] ]
]

{ #category : 'initialization' }
SpPresenter >> initializePresenters [
	"The method initializePresenters instantiates, saves in instance vari- ables, and partially configures the different widgets that will be part of the UI.
	In general the initializePresenters method should follow the pattern:
		• widget instantiation
		• widget configuration specification
		• specification of focus order"

	"self subclassResponsibility"
]

{ #category : 'private - initialization' }
SpPresenter >> initializePrivateAnnouncements [

	self 
		property: #titleHolder 
		whenChangedDo: [ self withWindowDo: [ :w | w title: titleHolder ] ].
	self 
		property: #layout 
		whenChangedDo: [ :newLayout | self replaceLayoutWith: newLayout ]
]

{ #category : 'private - initialization' }
SpPresenter >> initializePrivateAnnouncer [

  announcer := Announcer new
]

{ #category : 'private - initialization' }
SpPresenter >> initializePrivateHooks [
	self flag: #todo. "We should remove later #initializeWidgets and #initializePresenter."
	self initializeWidgets.
	self initializePresenters.
	self initializePresenter.
	self connectPresenters.
	self updatePresenter.

]

{ #category : 'private - initialization' }
SpPresenter >> initializePrivateValueHolders [

	askOkToClose := false.
	titleHolder := self windowTitle
]

{ #category : 'initialization - deprecated' }
SpPresenter >> initializeWidgets [
	"Now, presenters should implement #initializePresenters instead."
]

{ #category : 'inspector - extensions' }
SpPresenter >> inspectionSubPresenters: aBuilder [
	<inspectorPresentationOrder: 910 title: 'Subpresenters'>
	
	^ aBuilder newTree
		roots: self presenters;
		children: [ :each | each presenters ];
		expandRoots;
		yourself
]

{ #category : 'inspector - extensions' }
SpPresenter >> inspectionSubPresentersContext: aContext [
	
	aContext active: self presenters notEmpty
]

{ #category : 'instance creation' }
SpPresenter >> instantiatePresenters: aCollectionOfPairs [
	"instantiatePresenters: is legacy code in SpPresenter and must not be used. It will be deprecated and removed."

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

{ #category : 'testing' }
SpPresenter >> isBuilt [
	"Answer if this presenter has been built."

	^ self isDisplayed
]

{ #category : 'testing' }
SpPresenter >> isDisplayed [
	"Answer if the widget is currently displayed on screen"

	^ self hasWindow and: [ self root isDisplayed ]
]

{ #category : 'testing' }
SpPresenter >> isPopover [
	^ false
]

{ #category : 'testing' }
SpPresenter >> isRoot [
	"Answer if this presenter is the root of the presenter hierarchy.
	 To be root, the presenter has to be contained in a window"

	self withWindowDo: [ :w |
		^ w presenter = self ].

	^ false
]

{ #category : 'testing' }
SpPresenter >> isVisible [
	"Answer when the presenter is visible. 
	 See `SpPresenter>>#show` and `SpPresenter>>#hide`."
	
	^ visible value
]

{ #category : 'testing' }
SpPresenter >> isWindow [

	^ false
]

{ #category : 'accessing' }
SpPresenter >> layout [

	^ layout ifNil: [ self layout: self defaultLayout ]
]

{ #category : 'api' }
SpPresenter >> layout: aLayout [
	"Set the layout for current presenter. 
	 See `SpExecutableLayout` hierarchy for details on what can be set as layout."

	layout := aLayout.
	^ layout
]

{ #category : 'private' }
SpPresenter >> layoutPresenters [

	layout ifNil: [ ^ self presenters ].
	
	^ layout allPresenters
		select: [ :each | each isSymbol or: [ each isPresenter ] ]
		thenCollect: [ :each | 
			each isPresenter 
				ifTrue: [ each ]
				ifFalse:[ self presenterAt: each ] ]
]

{ #category : 'accessing' }
SpPresenter >> locale [ 

	^ self application locale
]

{ #category : 'localization' }
SpPresenter >> localeChanged [

	"do nothing here. Override me in subclasses to update strings presented to the users"
	
]

{ #category : 'simple dialog helpers' }
SpPresenter >> notify: aString [
	self application notify: aString
]

{ #category : 'private' }
SpPresenter >> okToChange [

	^ self hasWindow
		ifTrue: [ self window okToChange ]
		ifFalse: [ true ] 
]

{ #category : 'TOREMOVE' }
SpPresenter >> on: anAnnouncement send: aSelector to: aTarget [

	self announcer
		when: anAnnouncement 
		send: aSelector 
		to: aTarget
]

{ #category : 'accessing' }
SpPresenter >> preferredExtent [
	"The preferred extent logic manages the fact that if the user resizes a window, the preferred extent reflects this new size. Notice that this preferred extent is on a per presenter (i.e. class level) shared between all the instances of the class."
	
	^ self class preferredExtent 
]

{ #category : 'accessing' }
SpPresenter >> preferredExtent: aSize [

	(self window isMaximized 
		or: [ self window isMinimized ])
		ifTrue: [ ^ self ].
	self class preferredExtent: aSize
]

{ #category : 'accessing' }
SpPresenter >> presenterAt: aName [
	"Retrieves a subpresenter of this composed presenter."

	^ self readSlotNamed: aName
]

{ #category : 'accessing' }
SpPresenter >> presenterAt: aName ifAbsent: aBlock [
	"Retrieves a subpresenter of this composed presenter."

	^ [ self readSlotNamed: aName ]
		on: SlotNotFound
		do: aBlock
]

{ #category : 'private - traversing' }
SpPresenter >> presenters [
	"This answers ALL presenters included in this layout (including nested layouts). 
	 BUT IT DOES NOT INCLUDES presenters of embeded presenters.
	 e.g. 
	 1. presenter A includes presenters B and C.
	 2. presenter B includes presenters B1 and B2
	 3. presenter C includes presenter C1
	 then `A presenters` = { B. C }
	
	See also `SpPresenter>>#allPresenters`"

	^ Array streamContents: [ :stream |
		self presentersDo: [ :each | 
			stream << each ] ]
]

{ #category : 'private - traversing' }
SpPresenter >> presentersDo: aBlock [

	self layout ifNil: [ ^ self ].
	self layout allPresenters do: [ :each |
		aBlock value: (each asPresenterOn: self) ]
]

{ #category : 'private' }
SpPresenter >> presentersInFocusOrder [

	^ focusOrder ifNil: [ 
		self layoutPresenters
			select: [ :each | each isVisible and: [ each canTakeKeyboardFocus ] ] ]
]

{ #category : 'private' }
SpPresenter >> rebuildLayout [

	self replaceLayoutWith: self layout
]

{ #category : 'api - shortcuts' }
SpPresenter >> removeKeyCombination: aShortcut [
	"Remove the action associated to `aShortcut`"

	"self 
		deprecated: 'Keybindings usege is deprecated in favor of addShortcut: system' 
		on: '2024/09/11' 
		in: #Pharo13."

	self contextKeyBindings removeKey: aShortcut ifAbsent: [ ^ self ].
	self withAdapterDo: [ :anAdapter | 
		anAdapter removeKeyCombination: aShortcut ]
]

{ #category : 'api' }
SpPresenter >> removeStyle: aName [
	"Remove style from presenter.
	 See `SpPresenter>>#removeStyle:`"

	(styles includes: aName) ifFalse: [ ^ self ].
	styles := styles copyWithout: aName.
	self withAdapterDo: [ :anAdapter | anAdapter removeStyle: aName ]
]

{ #category : 'private' }
SpPresenter >> replaceLayoutWith: aLayout [

	self withAdapterDo: [ :anAdapter |
		anAdapter replaceLayoutWith: aLayout ]
]

{ #category : 'TOREMOVE' }
SpPresenter >> requestWindowClose [

	"returns <true> if the user is allowed to close the window. Useful if you want to ask user if he wants to save the changed content etc."
	
	^ true
]

{ #category : 'private' }
SpPresenter >> resolveSymbol: aSymbol [

	^ Smalltalk at: aSymbol
]

{ #category : 'private - building' }
SpPresenter >> retrieveLayout: aSelector [

	^ layout ifNil: [ super retrieveLayout: aSelector ]
]

{ #category : 'accessing - model' }
SpPresenter >> setModel: aDomainObject [


]

{ #category : 'accessing - model' }
SpPresenter >> setModelBeforeInitialization: aDomainObject [


]

{ #category : 'api' }
SpPresenter >> show [
	"show current presenter making it visible for the user"

	self visible: true
]

{ #category : 'private' }
SpPresenter >> showContextMenu [
	"If the presenter is displayed, shows the associated context menu. 
	 WARNING: Not all presenters have an associated context menu"

	self withAdapterDo: [ :anAdapter | anAdapter showContextMenu ]
]

{ #category : 'api' }
SpPresenter >> styles [ 
	"Answer the collection of styles to be applied to this presenter"

	^ styles
]

{ #category : 'api - focus' }
SpPresenter >> takeKeyboardFocus [
	"Causes this presenter to have the keyboard focus for the window it's inside. The presenter must 
	 be focusable (it has to answer true to `SpPresenter>>#canTakeKeyboardFocus`."
	| focus |

	focus := self defaultKeyboardFocus ifNil: [ self ].
	focus == self ifFalse: [ ^ focus takeKeyboardFocus ].
	
	self withAdapterDo: [ :anAdapter | 
		anAdapter takeKeyboardFocus ]
]

{ #category : 'accessing - deprecated' }
SpPresenter >> title [
	"Deprecated use the windowTitle method instead."

	^ titleHolder
]

{ #category : 'TOREMOVE' }
SpPresenter >> toolName [

	^ self class toolName
]

{ #category : 'private - traversing' }
SpPresenter >> traverseInFocusOrderDo: aBlock [

	self 
		traverseInFocusOrderDo: aBlock 
		excluding: Set new
]

{ #category : 'private - traversing' }
SpPresenter >> traverseInFocusOrderDo: aBlock excluding: excludes [

	"(excludes includes: self) ifTrue: [ ^ self ]. 
	excludes add: self.
	aBlock value: self."
	self presentersInFocusOrder do: [ :each |
		each traverseInFocusOrderDo: aBlock excluding: excludes ]
]

{ #category : 'private - traversing' }
SpPresenter >> traversePresentersDo: aBlock [

	self 
		traversePresentersDo: aBlock 
		excluding: Set new
]

{ #category : 'private - traversing' }
SpPresenter >> traversePresentersDo: aBlock excluding: excludes [

	(excludes includes: self) ifTrue: [ ^ self ]. 
	excludes add: self.
	aBlock value: self.

	self layout ifNil: [ ^ self ].
	self layout allPresenters do: [ :each | | var |
		var := each asPresenterOn: self. 
		var traversePresentersDo: aBlock excluding: excludes ]
]

{ #category : 'TOREMOVE' }
SpPresenter >> update [

	"self deprecated: 'This method is a remaining from ancient times and should not be used, 
	while it works on morphic backend in certain cases, it will not translate correctly and 
	it will cause memory leaks'.  "

	self needRebuild: false.
	self build
]

{ #category : 'initialization' }
SpPresenter >> updatePresenter [
]

{ #category : 'api' }
SpPresenter >> visible: aBoolean [
	"set the visibility status of the presenter (it can be hidden or shown)"

	visible := aBoolean
]

{ #category : 'TOREMOVE' }
SpPresenter >> visibleIf: aValuable [

	visible := aValuable
]

{ #category : 'api - events' }
SpPresenter >> whenContextKeyBindingsChangedDo: aBlock [
	"Inform when context keybindings have been changed (See `SpPresenter>>#contextKeyBindings:`).
	 `aBlock` receives two optional arguments 
	 - new keybinginds KMCategory
	 - old keybinginds KMCategory"
	
	self property: #contextKeyBindings whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpPresenter >> whenDisplayDo: aBlock [
	"Inform when presenter has been displayed.
	 `aBlock` receives one argument 
	 - an announcement (instance of `SpWidgetDisplayed`)"

	self announcer
		when: SpWidgetDisplayed
		do: aBlock
		for: aBlock receiver
]

{ #category : 'api - events' }
SpPresenter >> whenVisibleChangedDo: aBlock [
	"Inform when visible property have been changed (See `SpPresenter>>#show` and `SpPresenter>>#hide`).
	 `aBlock` receives two optional arguments 
	 - new visible status (a Boolean)
	 - old visible status (a Boolean)"
	
	self property: #visible whenChangedDo: aBlock
]

{ #category : 'TOREMOVE' }
SpPresenter >> whenWindowChanged: aBlock [

	self flag: #TODO. "This is here for backwards compatibility (you can have same 
	functionality in #initializeWindow:"
	self announcer
		when: SpWindowBuilt
		do: [ :ann | aBlock cull: ann model ]
		for: self
]

{ #category : 'accessing' }
SpPresenter >> windowIcon [
	"Returns the icon of the window.
	In general this is the responsibility of the application to manage its icons.
	You can specialize this method following for example this pattern.
		windowIcon 
		    ^ self iconNamed: #testRunner
	
	
	"

	^ windowIcon
]

{ #category : 'private' }
SpPresenter >> windowResizedTo: aSize [

	self window isResizable ifFalse: [ ^ self ].
	self preferredExtent: aSize
]

{ #category : 'accessing' }
SpPresenter >> windowTitle [
	"You can specialize this method to provide a nice window title.
	
	A possible approach if your presenter has a model is to delegate to the model as follows: 

		windowTitle

			^ self model windowTitle
	"

	^ titleHolder ifNil: [ titleHolder := 'Unnamed Window' ]
]

{ #category : 'private' }
SpPresenter >> withPopoverDo: aBlock [
	"Execute a block in the first popover in the DOM"
	
	self isPopover ifTrue: [ ^ aBlock cull: self ].
	self owner ifNotNil: [ 
		self owner withPopoverDo: aBlock ]
]
