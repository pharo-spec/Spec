"
A presenter that acts as tab label for the notebook page.
It is possible to put any widget in as label, this is just the ""default"" implementation.
"
Class {
	#name : #SpNotebookPageLabelPresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'labelPresenter',
		'iconPresenter'
	],
	#category : #'Spec2-Core-Widgets-Tab'
}

{ #category : #initialization }
SpNotebookPageLabelPresenter >> initializePresenters [

	self layout: (SpBoxLayout newLeftToRight
		spacing: 3;
		yourself).

	self model icon ifNotNil: [
		self layout
			add: (iconPresenter := (self newImage image: self model icon))
			expand: false ].

	self layout
		vAlignCenter;
		add: (labelPresenter := self newLabel
			label: self model title asString;
			yourself)
		expand: false.

	self model isCloseable ifTrue: [
		self layout
			addLast: (self newButton
				addStyle: 'small';
				addStyle: 'flat';
				icon: (self iconNamed: #windowCloseInactive);
				action: [ self model removeFromNotebook ];
				yourself)
			expand: false ].

	"self eventHandler whenDoubleClickDo: [ :event | 'ok' crTrace  ]."
]

{ #category : #accessing }
SpNotebookPageLabelPresenter >> label [

	^ labelPresenter label
]

{ #category : #'accessing - model' }
SpNotebookPageLabelPresenter >> model: aModel [

	(model notNil 
		and: [ model ~= aModel ])
		ifTrue: [ self unsubscribePage: model ].

	model := aModel.
	self updatePresenter
]

{ #category : #subscription }
SpNotebookPageLabelPresenter >> unsubscribePage: aPage [

	aPage unsubscribe: self
]

{ #category : #'private - updating' }
SpNotebookPageLabelPresenter >> updateIcon [

	iconPresenter image: self model icon
]

{ #category : #initialization }
SpNotebookPageLabelPresenter >> updatePresenter [

	self model 
		whenTitleChangedDo: [ self updateTitle ];
		whenIconChangedDo: [ self updateIcon ]
]

{ #category : #'private - updating' }
SpNotebookPageLabelPresenter >> updateTitle [

	labelPresenter label: self model title
]
