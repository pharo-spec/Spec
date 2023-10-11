"
A simple browser to concentrate all examples in one place.
"
Class {
	#name : 'SpExampleBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'list',
		'code',
		'descriptionText',
		'runButton',
		'browseButton'
	],
	#category : 'Spec2-Examples-ExampleBrowser',
	#package : 'Spec2-Examples',
	#tag : 'ExampleBrowser'
}

{ #category : 'user interface' }
SpExampleBrowser class >> menuExamplesOn: aBuilder [
	"Add a custom menu item to the world menu"
	<worldMenu>

	(aBuilder item: #'Spec2 examples')
		iconName: #smallHelp;
		parent: #Help;
		order: 3.6;
		help: 'Open Spec2 example browser.';
		action: [ self open ].
	aBuilder withSeparatorAfter
]

{ #category : 'instance creation' }
SpExampleBrowser class >> open [
	<script>

	^ self new open
]

{ #category : 'private' }
SpExampleBrowser >> allPresentersWithExamples [

	^ SpExampleNode allExampleClasses
]

{ #category : 'actions' }
SpExampleBrowser >> browseSelectedExample [
	| entity |

	entity := list selectedItem entity.
	self systemNavigation browse: entity
]

{ #category : 'initialization' }
SpExampleBrowser >> connectPresenters [

	list transmitDo: [ :aNode |
		aNode ifNotNil: [ self updateNode: aNode ] ].
	list outputActivationPort transmitDo: [ :aNode |
		runButton isEnabled ifTrue: [ self runSelectedExample ] ]
]

{ #category : 'layout' }
SpExampleBrowser >> defaultLayout [

	^ SpPanedLayout newHorizontal
		positionOfSlider: 30 percent;
		add: list;
		add: (SpBoxLayout newTopToBottom
			add: (SpTabLayout new
				add: descriptionText label: 'Description';
				add: code label: 'Code';
				yourself);
			add: (SpBoxLayout newLeftToRight
					borderWidth: 3;
					spacing: 3;
					addLast: browseButton expand: false;
					addLast: runButton expand: false;
					yourself)
				expand: false;
			yourself);
		yourself
]

{ #category : 'initialization' }
SpExampleBrowser >> initializePresenters [

	list := self newTree
		display: [ :aNode | aNode name ];
		displayIcon: [ :aNode | aNode iconName ifNotNil: [ :aName | self iconNamed: aName ] ];
		children: [ :aNode | aNode children ];
		contextMenu: [ self listMenu  ];
		expandRoots.

	browseButton := self newButton
		icon: (self iconNamed: #smallSystemBrowser);
		label: 'Browse';
		action: [ self browseSelectedExample ];
		yourself.

	runButton := self newButton
		icon: (self iconNamed: #glamorousGo);
		label: 'Run';
		action: [ self runSelectedExample ];
		yourself.

	descriptionText := self newText.
	descriptionText beNotEditable.

	code := self newCode.
	code beNotEditable
]

{ #category : 'initialization' }
SpExampleBrowser >> initializeWindow: aWindow [

	aWindow
		title: 'Spec Example Browser';
		initialExtent: 800@600
]

{ #category : 'initialization' }
SpExampleBrowser >> listMenu [

	^ self newMenu
		addItem: [ :item | item
			name: 'Browse';
			action: [ self browseSelectedExample ] ];
		addItem: [ :item | item
			name: 'Run';
			enabled: runButton isEnabled;
			action: [ self runSelectedExample ] ]
]

{ #category : 'actions' }
SpExampleBrowser >> runSelectedExample [
	| method |

	method := list selectedItem entity.
	method
		valueWithReceiver: method methodClass instanceSide
		arguments: #()
]

{ #category : 'updating' }
SpExampleBrowser >> updateClass: aClass [

	self withWindowDo: [ :w | w title: ('Spec Examples: {1}' format: { aClass name  }) ].
	descriptionText text: aClass comment.
	code text: ''.
	runButton enabled: false
]

{ #category : 'updating' }
SpExampleBrowser >> updateMethod: aMethod [

	self withWindowDo: [ :w |
		w title: ('Spec Example: {1}>>#{2}' format: {
			aMethod methodClass name.
			aMethod selector }) ].
	descriptionText text: (aMethod ast firstPrecodeComment ifNil: [ 'Uncommented' ]).
	code
		beForMethod: aMethod;
		text: aMethod sourceCode.
	runButton enabled: true
]

{ #category : 'updating' }
SpExampleBrowser >> updateNode: aNode [

	aNode updateOn: self
]

{ #category : 'initialization' }
SpExampleBrowser >> updatePresenter [

	list items: self allPresentersWithExamples.
	runButton enabled: false
]
