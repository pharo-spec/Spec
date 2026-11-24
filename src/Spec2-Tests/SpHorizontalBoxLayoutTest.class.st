Class {
	#name : 'SpHorizontalBoxLayoutTest',
	#superclass : 'SpBoxLayoutTest',
	#category : 'Spec2-Tests-Layout',
	#package : 'Spec2-Tests',
	#tag : 'Layout'
}

{ #category : 'initialization' }
SpHorizontalBoxLayoutTest >> initializeTestedInstance [

	layout := SpBoxLayout newLeftToRight.
	presenter layout: layout
]

{ #category : 'private' }
SpHorizontalBoxLayoutTest >> layoutDiagnosticsOf: widgets history: boundsHistory [
	"Describe the widgets and the bounds they had after each world cycle to understand why a layout did not fit in its window"

	^ String streamContents: [ :stream |
		  stream nextPutAll: 'widgets (class, bounds, minimum width, minimum height, horizontal resizing): '.
		  widgets
			  do: [ :widget |
				  stream
					  print: widget class;
					  space;
					  print: widget bounds;
					  space;
					  print: widget minWidth;
					  space;
					  print: widget minHeight;
					  space;
					  print: widget hResizing ]
			  separatedBy: [ stream nextPutAll: '; ' ].
		  stream
			  nextPutAll: '. Bounds of the window, the search field and the button after each world cycle: ';
			  print: boundsHistory;
			  nextPutAll: '. Default font: ';
			  print: StandardFonts defaultFont ]
]

{ #category : 'tests' }
SpHorizontalBoxLayoutTest >> testPresenterExtentFollowsChildrenExtent [
	| label button |

	layout 
		add: ((label := presenter newLabel) label: 'Label1');
		add: ((button := presenter newButton) label: 'Button1').
		
	self openInstance.
	
	self assert: (self widthOf: presenter) >= ((self widthOf: label) + (self widthOf: button)).
	self assert: (self heightOf: presenter) >= ((self heightOf: label) max: (self heightOf: button))
]

{ #category : 'tests' }
SpHorizontalBoxLayoutTest >> testReplaceWithFixedWidth [
	| p1 toReplace p3 replacement |

	layout add: (p1 := SpLabelPresenter new).
	layout add: (toReplace := SpLabelPresenter new) width: 100.
	layout add: (p3 := SpLabelPresenter new).
	
	self assert: layout children second equals: toReplace.
	
	replacement := SpButtonPresenter new.
	layout replace: toReplace with: replacement.
	
	self assert: layout children second equals: replacement.
	self assert: layout children size equals: 3.
	self assert: layout children equals: { p1. replacement. p3 }
]

{ #category : 'tests' }
SpHorizontalBoxLayoutTest >> testReplaceWithFixedWidthAllFixed [
	| p1 toReplace p3 replacement |

	layout add: (p1 := SpLabelPresenter new) width: 100.
	layout add: (toReplace := SpLabelPresenter new) width: 100.
	layout add: (p3 := SpLabelPresenter new) width: 100.
	
	self assert: layout children second equals: toReplace.
	
	replacement := SpButtonPresenter new.
	layout replace: toReplace with: replacement.
	
	self assert: layout children second equals: replacement.
	self assert: layout children size equals: 3.
	self assert: layout children equals: { p1. replacement. p3 }
]

{ #category : 'tests' }
SpHorizontalBoxLayoutTest >> testReplaceWithFixedWidthComposed [
	| p1 layoutToReplace toReplace p3 replacement |

	layout add: (p1 := SpLabelPresenter new) width: 100.
	layout add: ((layoutToReplace := SpBoxLayout newLeftToRight)  
		add: (toReplace := SpLabelPresenter new) width: 100;
		add: (SpLabelPresenter new) width: 100;
		yourself).
	layout add: (p3 := SpLabelPresenter new) width: 100.
	
	replacement := SpButtonPresenter new.
	layoutToReplace 
		replace: toReplace 
		with: replacement.
	
	self assert: layout children second children first equals: replacement
]

{ #category : 'tests' }
SpHorizontalBoxLayoutTest >> testSpSearchInputFieldPresenterResizeCorrectlyWhenWindowHeightDecrease [

	| searchPresenter buttonPresenter windowWidget buttonWidget searchWidget originalExtent previousButtonBounds attempts boundsHistory |
	searchPresenter := SpSearchInputFieldPresenter new.
	buttonPresenter := SpButtonPresenter new label: 'click me'.
	presenter := SpPresenter new
		             layout: (SpBoxLayout newLeftToRight
			              add: searchPresenter;
			              add: buttonPresenter;
			              yourself);
		             yourself.
	window := presenter asWindow
		          initialExtent: 400 @ 300;
		          open;
		          yourself.
	windowWidget := window adapter widget.
	buttonWidget := buttonPresenter adapter widget.
	searchWidget := searchPresenter adapter widget.

	self assert: (windowWidget bounds containsRect: buttonWidget bounds) description: (String streamContents: [ :stream |
		 stream
			 nextPutAll: 'Button outside window before resize, window: ';
			 print: windowWidget bounds;
			 nextPutAll: ', button: ';
			 print: buttonWidget bounds ]).
	self assert: (windowWidget bounds containsRect: searchWidget bounds) description: (String streamContents: [ :stream |
		 stream
			 nextPutAll: 'Search field outside window before resize, window: ';
			 print: windowWidget bounds;
			 nextPutAll: ', search: ';
			 print: searchWidget bounds ]).

	originalExtent := windowWidget extent.
	windowWidget extent: windowWidget extent - (0 @ 100).
	"Window layout may not be finished after a single world cycle, so run cycles until the button bounds stop changing. The attempt limit prevents waiting forever."
	attempts := 0.
	boundsHistory := OrderedCollection new.
	previousButtonBounds := nil.
	[ previousButtonBounds = buttonWidget bounds or: [ attempts >= 10 ] ] whileFalse: [
		previousButtonBounds := buttonWidget bounds.
		attempts := attempts + 1.
		self currentWorld doOneCycle.
		boundsHistory add: {
			windowWidget bounds.
			searchWidget bounds.
			buttonWidget bounds } ].

	self assert: (windowWidget bounds containsRect: buttonWidget bounds) description: (String streamContents: [ :stream |
		 stream
			 nextPutAll: 'Button outside window after resize, extent before: ';
			 print: originalExtent;
			 nextPutAll: ', extent after: ';
			 print: windowWidget extent;
			 nextPutAll: ', window: ';
			 print: windowWidget bounds;
			 nextPutAll: ', button: ';
			 print: buttonWidget bounds;
			 nextPutAll: ', attempts: ';
			 print: attempts;
			 nextPutAll: ', platform: ';
			 print: OSPlatform current;
			 nextPutAll: '. ';
			 nextPutAll: (self
				  layoutDiagnosticsOf: {
					  windowWidget.
					  searchWidget.
					  buttonWidget }
				  history: boundsHistory) ]).
	self assert: (windowWidget bounds containsRect: searchWidget bounds) description: (String streamContents: [ :stream |
		 stream
			 nextPutAll: 'Search field outside window after resize, extent before: ';
			 print: originalExtent;
			 nextPutAll: ', extent after: ';
			 print: windowWidget extent;
			 nextPutAll: ', window: ';
			 print: windowWidget bounds;
			 nextPutAll: ', search: ';
			 print: searchWidget bounds;
			 nextPutAll: '. ';
			 nextPutAll: (self
				  layoutDiagnosticsOf: {
					  windowWidget.
					  searchWidget.
					  buttonWidget }
				  history: boundsHistory) ])
]

{ #category : 'tests' }
SpHorizontalBoxLayoutTest >> testSpSearchInputFieldPresenterResizeCorrectlyWhenWindowWidthDecrease [

	| searchPresenter buttonPresenter windowWidget buttonWidget searchWidget originalExtent previousButtonBounds attempts boundsHistory |
	searchPresenter := SpSearchInputFieldPresenter new.
	buttonPresenter := SpButtonPresenter new label: 'click me'.
	presenter := SpPresenter new
		             layout: (SpBoxLayout newLeftToRight
			              add: searchPresenter;
			              add: buttonPresenter;
			              yourself);
		             yourself.
	window := presenter asWindow
		          initialExtent: 400 @ 300;
		          open;
		          yourself.
	windowWidget := window adapter widget.
	buttonWidget := buttonPresenter adapter widget.
	searchWidget := searchPresenter adapter widget.

	self assert: (windowWidget bounds containsRect: buttonWidget bounds) description: (String streamContents: [ :stream |
		 stream
			 nextPutAll: 'Button outside window before resize, window: ';
			 print: windowWidget bounds;
			 nextPutAll: ', button: ';
			 print: buttonWidget bounds ]).
	self assert: (windowWidget bounds containsRect: searchWidget bounds) description: (String streamContents: [ :stream |
		 stream
			 nextPutAll: 'Search field outside window before resize, window: ';
			 print: windowWidget bounds;
			 nextPutAll: ', search: ';
			 print: searchWidget bounds ]).

	originalExtent := windowWidget extent.
	windowWidget extent: windowWidget extent - (100 @ 0).
	"Window layout may not be finished after a single world cycle, so run cycles until the button bounds stop changing. The attempt limit prevents waiting forever."
	attempts := 0.
	boundsHistory := OrderedCollection new.
	previousButtonBounds := nil.
	[ previousButtonBounds = buttonWidget bounds or: [ attempts >= 10 ] ] whileFalse: [
		previousButtonBounds := buttonWidget bounds.
		attempts := attempts + 1.
		self currentWorld doOneCycle.
		boundsHistory add: {
			windowWidget bounds.
			searchWidget bounds.
			buttonWidget bounds } ].

	self assert: (windowWidget bounds containsRect: buttonWidget bounds) description: (String streamContents: [ :stream |
		 stream
			 nextPutAll: 'Button outside window after resize, extent before: ';
			 print: originalExtent;
			 nextPutAll: ', extent after: ';
			 print: windowWidget extent;
			 nextPutAll: ', window: ';
			 print: windowWidget bounds;
			 nextPutAll: ', button: ';
			 print: buttonWidget bounds;
			 nextPutAll: ', attempts: ';
			 print: attempts;
			 nextPutAll: ', platform: ';
			 print: OSPlatform current;
			 nextPutAll: '. ';
			 nextPutAll: (self
				  layoutDiagnosticsOf: {
					  windowWidget.
					  searchWidget.
					  buttonWidget }
				  history: boundsHistory) ]).
	self assert: (windowWidget bounds containsRect: searchWidget bounds) description: (String streamContents: [ :stream |
		 stream
			 nextPutAll: 'Search field outside window after resize, extent before: ';
			 print: originalExtent;
			 nextPutAll: ', extent after: ';
			 print: windowWidget extent;
			 nextPutAll: ', window: ';
			 print: windowWidget bounds;
			 nextPutAll: ', search: ';
			 print: searchWidget bounds;
			 nextPutAll: '. ';
			 nextPutAll: (self
				  layoutDiagnosticsOf: {
					  windowWidget.
					  searchWidget.
					  buttonWidget }
				  history: boundsHistory) ])
]
