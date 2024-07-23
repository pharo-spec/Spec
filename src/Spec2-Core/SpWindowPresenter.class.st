"
I'm a presenter defining a Window.
`SpWindowPresenter` defines common behavior for windows (such as title, extent, position). 
It can also hold a menuBar, a toolBar, and a statusBar.

Typically you do not use this presenter directly but through a presenter you want to show. 
When you execute `aPresenter openWithSpec`, what happens is that a `SpWindowPresenter` is created. Then the `SpPresenter>>#initializeWindow:` message is sent and an user can configure its window there.

You can also access your window when your presenter is active by using `SpAbstractPresenter>>#withWindowDo:`.

## Usage 

Typically, you do not instantiate directly a window, but you open a presenter as one.

```
SpTextPresenter new
	text: 'The answer is 42';
	openWithSpec.
```

"
Class {
	#name : 'SpWindowPresenter',
	#superclass : 'SpAbstractWidgetPresenter',
	#instVars : [
		'#presenter => ObservableSlot',
		'#initialPosition => ObservableSlot',
		'#initialExtent => ObservableSlot',
		'#menu => ObservableSlot',
		'#centered => ObservableSlot',
		'#isClosed => ObservableSlot',
		'#toolbar => ObservableSlot',
		'#statusbar => ObservableSlot',
		'#window => ObservableSlot',
		'#decorations => ObservableSlot',
		'#resizable => ObservableSlot'
	],
	#category : 'Spec2-Core-Windows',
	#package : 'Spec2-Core',
	#tag : 'Windows'
}

{ #category : 'specs' }
SpWindowPresenter class >> adapterName [

	^ #WindowAdapter
]

{ #category : 'instance creation' }
SpWindowPresenter class >> application: anApplication [
	^ self new
		application: anApplication;
		yourself
]

{ #category : 'accessing' }
SpWindowPresenter class >> defaultTitle [

	^ 'Untitled window'
]

{ #category : 'testing' }
SpWindowPresenter class >> isWindow [

	^ true
]

{ #category : 'instance creation' }
SpWindowPresenter class >> presenter: aPresenter [
	^ (self application: aPresenter application)
		presenter: aPresenter;
		yourself
]

{ #category : 'TOREMOVE' }
SpWindowPresenter >> aboutText [
	^ aboutText ifNil: [ aboutText := 'The about text for this window has not been set.' ]
]

{ #category : 'TOREMOVE' }
SpWindowPresenter >> aboutText: aString [
	aboutText := aString
]

{ #category : 'TOREMOVE' }
SpWindowPresenter >> aboutTitle [
	"Answer the title of my About window"

	(self presenter respondsTo: #aboutTitle) ifTrue: [ ^ self presenter aboutTitle ].
	
	^ self presenter toolName
]

{ #category : 'api' }
SpWindowPresenter >> activate [

	self withAdapterDo: [ :anAdapter | anAdapter activate ]
]

{ #category : 'private - building' }
SpWindowPresenter >> addPresenterIn: widget withSpecLayout: aSpec [
	
	self presenter ifNil: [ ^ self ].
	self withAdapterDo: [ :anAdapter |
		anAdapter addPresenterIn: widget withSpecLayout: aSpec ]
]

{ #category : 'TOREMOVE' }
SpWindowPresenter >> askOkToClose: aBoolean [

	askOkToClose := aBoolean
]

{ #category : 'private - building' }
SpWindowPresenter >> basicBuildWithSpecLayout: presenterSpecLayout [

	"Build the widget using the layout provided as argument"

	^ (self adapter isNil or: [ self needRebuild ])
		  ifTrue: [ 
			  self
				  buildWindowWithLayout: self defaultLayout
				  presenterLayout: presenterSpecLayout ]
		  ifFalse: [ self adapter widget ]
]

{ #category : 'api' }
SpWindowPresenter >> beNotResizable [
	"Make the window NOT resizable (borders will be undraggable). 
	 Window can still be resized progamatically."

	self resizable: false
]

{ #category : 'api' }
SpWindowPresenter >> beResizable [
	"Make the window resizable (borders will be draggable)"

	self resizable: true
]

{ #category : 'api' }
SpWindowPresenter >> beep [ 
	"Emits a beep if the backend allows it."
	
	self adapter beep
]

{ #category : 'private - building' }
SpWindowPresenter >> buildWindowWithLayout: windowSpecLayout presenterLayout: presenterSpecLayout [

	"set adapter of the window"
	self adapter: (windowSpecLayout asSpLayout
		buildAdapterFor: self 
		bindings: SpBindings value).
	self window: self adapter widget.
	self processDeferredActions.
	"add presenter"
	self addPresenterIn: self window withSpecLayout: presenterSpecLayout.
	"announce its result"
	self announce: (SpWidgetBuilt model: self widget: self window).
	self presenter announce: (SpWindowBuilt model: self).	
	
	^ self window
]

{ #category : 'private - building' }
SpWindowPresenter >> buildWithSpecLayout: aSpecLayout [
	
	^ SpBindings 
		value: self application adapterBindings
		during: [ self basicBuildWithSpecLayout: aSpecLayout ]
]

{ #category : 'dialog compatibility' }
SpWindowPresenter >> cancelled [

	^ false
]

{ #category : 'api' }
SpWindowPresenter >> centered [
	"Prepare the window to be centered"
	
	centered := true
]

{ #category : 'api' }
SpWindowPresenter >> centeredRelativeTo: aWindowPresenter [
	"Prepare the window to be centered to another window"

	self withAdapterPerformOrDefer: [ :anAdapter |
		anAdapter centeredRelativeTo: aWindowPresenter ]
]

{ #category : 'api' }
SpWindowPresenter >> centeredRelativeToTopWindow [
	"Prepare the window to be centered to top window (the window that is currently active)"

	self application topWindow
		ifNotNil: [ :aWindow | self centeredRelativeTo: aWindow ]
		ifNil: [ self centered ]
]

{ #category : 'api' }
SpWindowPresenter >> close [
	"Close current window."

	"Only manage closing if the presenter is really open"
	self isOpen ifFalse: [ ^ self ].
	self withAdapterDo: [ :anAdapter | 
		anAdapter close ]
]

{ #category : 'private' }
SpWindowPresenter >> defaultInitialExtent [
	
	^ 400@300
]

{ #category : 'private' }
SpWindowPresenter >> delete [
	"DO NOT USE. This will destroy the window and maybe you do not want that :/
	 I'm keeping this here because of testing."

	self withAdapterDo: [ :anAdapter | anAdapter delete ]
]

{ #category : 'testing' }
SpWindowPresenter >> hasDecorations [
	"Answer if window has decorations (header bar and buttons)"

	^ decorations
]

{ #category : 'testing' }
SpWindowPresenter >> hasMenu [ 
	"Answer if window has a menu defined"
	
	^ self menu isNotNil
]

{ #category : 'testing' }
SpWindowPresenter >> hasPresenter: aPresenter [
	"Answer if window includes `aPresenter`"

	^ aPresenter isNotNil and: [aPresenter adapter isNotNil
		and: [ self adapter hasWidget: aPresenter adapter ]]
]

{ #category : 'testing' }
SpWindowPresenter >> hasStatusBar [
	"Answer if window has a status bar defined"
	
	^ self statusBar isNotNil
]

{ #category : 'testing' }
SpWindowPresenter >> hasToolbar [
	"Answer if window has a toolbar defined"

	^ self toolbar isNotNil and: [ self toolbar notEmpty ]
]

{ #category : 'api' }
SpWindowPresenter >> initialExtent [
	"Answer initial extent of the window. By default, it answer what is defined 
	 in `SpWindowPresenter>>#defaultInitialExtent`"

	^ initialExtent ifNil: [ self defaultInitialExtent ]
]

{ #category : 'api' }
SpWindowPresenter >> initialExtent: anExtent [
	"Set initial extent of the window. 
	 `anExtent` is an instance of `Point`, indicating width@height"

	initialExtent := anExtent
]

{ #category : 'api' }
SpWindowPresenter >> initialPosition [
	"Answer initial position of the window (if previously set).
	 If initial position is not set, the backend will place the window within its own logic."

	^ initialPosition
]

{ #category : 'api' }
SpWindowPresenter >> initialPosition: aPoint [
	"Set initial position of the window. 
	 `aPoint` is an instance of `Point`, indicating x@y coordinates
	 WARNING: Not all backends will support this (for example Gtk lets
	 the window manager position windows and hence it ignores any positioning 
	 we set)."

	initialPosition := aPoint
]

{ #category : 'initialization' }
SpWindowPresenter >> initialize [

	super initialize.

	titleHolder := self class defaultTitle.
	isClosed := true.
	resizable := true.
	centered := false.
	askOkToClose := true.
	decorations := true.

	"presenter whenChangedDo: [ :m | self updateTitle ]."
	self 
		property: #titleHolder 
		whenChangedDo: [ :aString | 
			self withAdapterDo: [ :anAdapter | anAdapter title: aString ] ].
	self 
		property: #centered 
		whenChangedDo: [ :aBoolean | 
			self withAdapterDo: [ :anAdapter | anAdapter centered ] ]
]

{ #category : 'initialization' }
SpWindowPresenter >> initializeWindow [
		
	self presenter initializeWindow: self
]

{ #category : 'testing' }
SpWindowPresenter >> isCentered [
	"Answer if window is centered to screen."

	^ centered
]

{ #category : 'testing' }
SpWindowPresenter >> isClosed [
	"Answer if window has is closed"

	^ isClosed
]

{ #category : 'testing' }
SpWindowPresenter >> isDialog [
	"Answer if window instance is a dialog"

	^ false
]

{ #category : 'testing' }
SpWindowPresenter >> isDisplayed [
	"Answer if window is displayed (visible)"

	^ self adapter
		ifNotNil: [ :w | w isDisplayed ]
		ifNil: [ false ] 
]

{ #category : 'testing' }
SpWindowPresenter >> isMaximized [
	"Answer if window is maximized"

	self withAdapterDo: [ :anAdapter | ^ anAdapter isMaximized ].
	^ false
]

{ #category : 'testing' }
SpWindowPresenter >> isMinimized [
	"Answer if window is minimized"

	self withAdapterDo: [ :anAdapter | ^ anAdapter isMinimized ].
	^ false
]

{ #category : 'testing' }
SpWindowPresenter >> isOpen [
	"Answer if window is open."
	
	^ self isClosed not
]

{ #category : 'testing' }
SpWindowPresenter >> isResizable [
	"Answer if window is resizeable"

	^ resizable
]

{ #category : 'testing' }
SpWindowPresenter >> isTopWindow [
	"Answer true if this si the active window (the one that has the focus)"
	
	self withAdapterDo: [ :anAdapter | 
		^ anAdapter isTopWindow ].

	^ false
]

{ #category : 'testing' }
SpWindowPresenter >> isWindowPresenter [
	"Answer if current presenter instance is a window presenter"
	
	^ true
]

{ #category : 'api' }
SpWindowPresenter >> maximize [
	"Maximise the window"

	self withAdapterDo: [ :anAdapter | anAdapter maximize ]
]

{ #category : 'api' }
SpWindowPresenter >> menu [
	"Answer the menu of the window (if defined). 
	 See also `SpWindowPresenter>>#menu:`"

	^ menu
]

{ #category : 'api' }
SpWindowPresenter >> menu: aMenuBarPresenter [
	"Set a menu bar associated with this window.
	 Menu will appear on top of the window allowing user to interact with it."
	
	aMenuBarPresenter ifNotNil: [ aMenuBarPresenter owner: self ].
	^ menu := aMenuBarPresenter
]

{ #category : 'api' }
SpWindowPresenter >> minimize [
	"Minimize the window."
	
	self withAdapterDo: [ :anAdapter | anAdapter minimize ]
]

{ #category : 'api' }
SpWindowPresenter >> moveTo: aPoint [
	"Moves the window to a specific location. 
	 `aPoint` is an instance of `Point`, indicating x@y coordinates
	
	 To set initial position of a window, use #initialPosition:, not this.
	 WARNING: Not all backends will support this (for example Gtk lets
	 the window manager position windows and hence it ignores any positioning 
	 we set)."
	
	self withAdapterPerformOrDefer: [ :anAdapter | anAdapter moveTo: aPoint ]	

]

{ #category : 'private' }
SpWindowPresenter >> nearWindow [

	^ self
]

{ #category : 'notifying' }
SpWindowPresenter >> notify: aSpecNotification [
	"Receives a notification and delivers it as required"

	self withAdapterDo: [ :anAdapter |
		aSpecNotification type 
			notify: aSpecNotification 
			on: anAdapter ]
]

{ #category : 'private' }
SpWindowPresenter >> okToChange [

	self flag: #TODO. "Maybe wrong?"
	self presenter canDiscardEdits ifTrue: [ ^ true ].
	"Solicit cancel from view"
	self changed: #wantToChange.  
	^ self canDiscardEdits
]

{ #category : 'api - showing' }
SpWindowPresenter >> open [

	self openWith: self presenter layout
]

{ #category : 'api - showing' }
SpWindowPresenter >> openWith: aSpecLayout [

	self openWithLayout: aSpecLayout
]

{ #category : 'private - showing' }
SpWindowPresenter >> openWithLayout: aSpecLayout [

	self buildWithSpecLayout: aSpecLayout.
	self application registerWindow: self.
	self withAdapterDo: [ :anAdapter | 
		anAdapter openWithDeferredAction: [ 
			self allPresenters do: [ :each | each announceDisplayed ].
			self updateTitle ] ]
]

{ #category : 'api' }
SpWindowPresenter >> presenter [
	"Answer the presenter to show as content of the window."

	^ presenter
]

{ #category : 'api' }
SpWindowPresenter >> presenter: aPresenter [
	"Set the presenter to show as content of the window."

	aPresenter owner: self.
	presenter := aPresenter.
	self initializeWindow
]

{ #category : 'private - building' }
SpWindowPresenter >> rebuildWithSpecLayout: aSpecLayout [

	self withAdapterDo: [ :anAdapter | 
		anAdapter rebuildWithSpecLayout: aSpecLayout ]
]

{ #category : 'private' }
SpWindowPresenter >> requestWindowClose [

	^ self presenter
		ifNotNil: [ :aPresenter | aPresenter requestWindowClose ]
		ifNil: [ true ]
]

{ #category : 'private' }
SpWindowPresenter >> resizable: aBoolean [

	resizable := aBoolean
]

{ #category : 'api' }
SpWindowPresenter >> resize: anExtent [

	self withAdapterPerformOrDefer: [ :anAdapter | 
		anAdapter resize: anExtent ]
]

{ #category : 'api' }
SpWindowPresenter >> restore [
	"Restore the window"

	self withAdapterDo: [ :anAdapter | anAdapter restore ]
]

{ #category : 'api' }
SpWindowPresenter >> statusBar [
	"Answer the status bar associated with this window (if defined)"

	^ statusbar
]

{ #category : 'api' }
SpWindowPresenter >> statusBar: aStatusBarPresenter [
	"Set a status bar for the window. 
	 Status bar will be shown at the bottom of the window."

	aStatusBarPresenter ifNotNil: [ aStatusBarPresenter owner: self ].
	^ statusbar := aStatusBarPresenter
]

{ #category : 'TOREMOVE' }
SpWindowPresenter >> taskbarIcon [

	^ self windowIcon
		ifNil: [
			self iconNamed:  (self presenter
				ifNotNil: [ :aPresenter | aPresenter taskbarIconName ]
				ifNil: [ self taskbarIconName ]) ]
]

{ #category : 'private' }
SpWindowPresenter >> title [
	^ titleHolder
]

{ #category : 'private' }
SpWindowPresenter >> title: aString [
	titleHolder := aString
]

{ #category : 'api' }
SpWindowPresenter >> toolbar [
	"Answer the toolbar associated with this window (if defined)"

	^ toolbar
]

{ #category : 'api' }
SpWindowPresenter >> toolbar: aToolbarPresenter [
	"Set a toolbar associated with this window.
	 Menu will appear on top of the window allowing user to interact with it."

	aToolbarPresenter ifNotNil: [ aToolbarPresenter owner: self ].
	^ toolbar := aToolbarPresenter
]

{ #category : 'private - traversing' }
SpWindowPresenter >> traverseInFocusOrderDo: aBlock excluding: excludes [

	"I am not focusable (not with tab)"
	self presenter 
		traverseInFocusOrderDo: aBlock 
		excluding: excludes
]

{ #category : 'private - traversing' }
SpWindowPresenter >> traversePresentersDo: aBlock excluding: excludes [
	
	super traversePresentersDo: aBlock excluding: excludes.
	presenter traversePresentersDo: aBlock excluding: excludes
]

{ #category : 'dialog compatibility' }
SpWindowPresenter >> triggerCancelAction [
	"Do nothing (ensure polymorphism with DialogWindow)"
]

{ #category : 'dialog compatibility' }
SpWindowPresenter >> triggerOkAction [
	"Do nothing (ensure polymorphism with DialogWindow)"
]

{ #category : 'private' }
SpWindowPresenter >> updateTitle [
	"Update the window title"

	self withAdapterDo: [ :anAdapter | anAdapter title: self title ]
]

{ #category : 'api - events' }
SpWindowPresenter >> whenClosedDo: aBlock [
	"Inform when window is closed.
	 `aBlock` receives zero arguments."
	
	self 
		property: #isClosed 
		whenChangedDo: [ :value | value ifTrue: aBlock ]
]

{ #category : 'api - events' }
SpWindowPresenter >> whenDecorationsChangedDo: aBlock [
	"Inform when decorations property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #decorations whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpWindowPresenter >> whenFocusLostDo: aBlock [
	"Inform when window lost focus. 
	 This is a convenience method that exposes a functionality of the event handler 
	 (See `SpEventHandler>>#whenFocusLostDo:`, but in the case of windows is 
	 useful to have it here."

	self eventHandler whenFocusLostDo: aBlock
]

{ #category : 'api - events' }
SpWindowPresenter >> whenFocusReceivedDo: aBlock [
	"Inform when window receives focus. 
	 This is a convenience method that exposes a functionality of the event handler 
	 (See `SpEventHandler>>#whenFocusReceivedDo:`, but in the case of windows is 
	 useful to have it here."

	self eventHandler whenFocusReceivedDo: aBlock
]

{ #category : 'api - events' }
SpWindowPresenter >> whenOpenedDo: aBlock [
	"Inform when window is opened. 
	 `aBlock` receives zero arguments."

	self 
		property: #isClosed 
		whenChangedDo: [ :value | value ifFalse: aBlock ]
]

{ #category : 'api - events' }
SpWindowPresenter >> whenResizableChangedDo: aBlock [

	self property: #resizable whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpWindowPresenter >> whenResizingDo: aBlock [
	"Inform when window is resizing. 
	 `aBlock` receives one optional argument (an instance of the announcement `SpWindowResizing`)"

	self announcer 
		when: SpWindowResizing 
		do: aBlock 
		for: aBlock receiver
]

{ #category : 'api - events' }
SpWindowPresenter >> whenToolbarChangedDo: aBlock [
	"Inform when the toolbar has been changed.
	
	 `aBlock` receives two optional arguments 
	 - new toolbar
	 - old toolbar"
	
	self property: #toolbar whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpWindowPresenter >> whenWillCloseDo: aBlock [
	"Inform when window will close, allowing process before the close happen. 
	 Note that user cannot cancel the close operation using this event. 
	 `aBlock` receives one optional argument (an instance of the announcement `SpWindowWillClose`)."

	self announcer
		when: SpWindowWillClose
		do: aBlock
		for: aBlock receiver
]

{ #category : 'private' }
SpWindowPresenter >> window [
	^ window
]

{ #category : 'private' }
SpWindowPresenter >> window: aWindow [
	window := aWindow
]

{ #category : 'private' }
SpWindowPresenter >> windowClosed [
	
	isClosed := true.
	self application windowClosed: self
]

{ #category : 'private' }
SpWindowPresenter >> windowIcon [
	^ windowIcon
]

{ #category : 'private' }
SpWindowPresenter >> windowIcon: aForm [
	windowIcon := aForm
]

{ #category : 'updating' }
SpWindowPresenter >> windowIsClosing [

	self presenter windowIsClosing
]

{ #category : 'updating' }
SpWindowPresenter >> windowIsOpened [

	isClosed := false
]

{ #category : 'TOREMOVE' }
SpWindowPresenter >> windowIsOpening [

	self windowIsOpened
]

{ #category : 'api' }
SpWindowPresenter >> withDecorations [
	"Add decorations on window (header bar and buttons)"
	
	decorations := true
]

{ #category : 'api' }
SpWindowPresenter >> withoutDecorations [
	"Remove decorations on window (header bar and buttons)"
	
	decorations := false
]
