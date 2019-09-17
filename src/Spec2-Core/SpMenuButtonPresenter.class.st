"
I'm a presenter to create a menu button (a button who exposes a menu instead having an action) 

self example
"
Class {
	#name : #SpMenuButtonPresenter,
	#superclass : #SpAbstractButtonPresenter,
	#instVars : [
		'#menu => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #specs }
SpMenuButtonPresenter class >> adapterName [

	^ #MenuButtonAdapter
]

{ #category : #example }
SpMenuButtonPresenter class >> example [
	| menuButton |

	menuButton := SpMenuButtonPresenter new 
		menu: (SpMenuPresenter new
			addGroup: [ :group | group
				addItem: [ :item | item name: 'One' ];
				addItem: [ :item | item name: 'Two' ];
				addItem: [ :item | item name: 'Three' ] ];
			yourself);
		yourself.
]

{ #category : #specs }
SpMenuButtonPresenter class >> title [

	^ 'MenuButton'
]

{ #category : #initialization }
SpMenuButtonPresenter >> initialize [
	super initialize.
]

{ #category : #api }
SpMenuButtonPresenter >> menu [

	^ menu
]

{ #category : #api }
SpMenuButtonPresenter >> menu: aMenuPresenter [

	menu := aMenuPresenter.
	menu owner: self
]

{ #category : #'api-events' }
SpMenuButtonPresenter >> whenMenuChangedDo: aBlock [

	self property: #menu whenChangedDo: aBlock
]
