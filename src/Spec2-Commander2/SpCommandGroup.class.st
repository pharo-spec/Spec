"
I am a command group decorator adding informations useful when for usage in context of a Spec application.

Basically, I add:
- an #icon (#blank by default)
- the strategy to display commands group in a MenuPresenter
"
Class {
	#name : 'SpCommandGroup',
	#superclass : 'CmUICommandGroup',
	#instVars : [
		'iconProvider',
		'toolbarButtonKind'
	],
	#category : 'Spec2-Commander2-Core',
	#package : 'Spec2-Commander2',
	#tag : 'Core'
}

{ #category : 'converting' }
SpCommandGroup >> asKMCategory [

	^ SpKMCategoryBuilder new
		visit: self;
		kmCategory	
]

{ #category : 'converting' }
SpCommandGroup >> asMenuBarPresenter [

	^ SpMenuBarPresenterBuilder new
		visit: self;
		menuPresenter
]

{ #category : 'converting' }
SpCommandGroup >> asMenuBarPresenterWith: aBlock [
	| builder |

	builder := SpMenuBarPresenterBuilder new.
	aBlock value: builder menuPresenter.
	^ builder
		visit: self;
		menuPresenter
]

{ #category : 'converting' }
SpCommandGroup >> asMenuPresenter [

	^ SpMenuPresenterBuilder new
		visit: self;
		menuPresenter
]

{ #category : 'converting' }
SpCommandGroup >> asMenuPresenterWith: aBlock [
	| builder |

	builder := SpMenuPresenterBuilder new.
	aBlock value: builder menuPresenter.
	^ builder
		visit: self;
		menuPresenter
]

{ #category : 'initialization' }
SpCommandGroup >> assignUniqueName [

(self name isNotNil and: [ self name ~= CmCommandGroup defaultName ]) 
		ifTrue: [ ^ self ].

	self name: UUID new asString
]

{ #category : 'configuring' }
SpCommandGroup >> beToolbarGroup [

	toolbarButtonKind := nil
]

{ #category : 'configuring' }
SpCommandGroup >> beToolbarMenuButton [

	toolbarButtonKind := #menu
]

{ #category : 'configuring' }
SpCommandGroup >> beToolbarPopoverButton [

	toolbarButtonKind := #popover
]

{ #category : 'displaying' }
SpCommandGroup >> displayIn: aMenuPresenter do: aBlock [

	self displayStrategy 
		display: self 
		in: aMenuPresenter 
		do: aBlock
]

{ #category : 'accessing' }
SpCommandGroup >> icon [

	^ icon ifNil: [ 
		self iconName 
			ifNotNil: [ self iconProvider iconNamed: self iconName ]
			ifNil: [ super icon ] ]
]

{ #category : 'accessing' }
SpCommandGroup >> iconName [

	^ iconName
]

{ #category : 'accessing' }
SpCommandGroup >> iconName: aName [

	iconName := aName
]

{ #category : 'accessing' }
SpCommandGroup >> iconProvider [

	^ iconProvider
]

{ #category : 'accessing' }
SpCommandGroup >> iconProvider: anIconProvider [

	iconProvider := anIconProvider
]

{ #category : 'initialization' }
SpCommandGroup >> initialize [

	super initialize.
	toolbarButtonKind := false
]

{ #category : 'shortcuts installation' }
SpCommandGroup >> installShortcutsIn: aPresenter [ 
	SpShortcutInstaller new
		presenter: aPresenter;
		visit: self
]

{ #category : 'testing' }
SpCommandGroup >> isToolbarMenuButton [

	^ toolbarButtonKind = #menu
]

{ #category : 'testing' }
SpCommandGroup >> isToolbarPopoverButton [

	^ toolbarButtonKind = #popover
]

{ #category : 'accessing' }
SpCommandGroup >> priority [
	
	^ 1
]
