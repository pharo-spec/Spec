"
I'm a code (Pharo code) presenter. 
I will style and provide completion according to the behaviour being edited.
"
Class {
	#name : #CodePresenter,
	#superclass : #TextPresenter,
	#instVars : [
		'doItContext',
		'doItReceiver',
		'behaviorHolder'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
CodePresenter class >> adapterName [

	^ #CodeAdapter
]

{ #category : #examples }
CodePresenter class >> example [
	<sampleInstance>

	^ self new
	 openWithSpec;
		text:
			'some method: 42'

]

{ #category : #specs }
CodePresenter class >> title [

	^ 'Code'
]

{ #category : #'api-shout' }
CodePresenter >> behavior [
	"<api: #inspect>"
	"Return the class corresponding to the method class of the source code you are editing"
	
	^ behaviorHolder value
]

{ #category : #'api-shout' }
CodePresenter >> behavior: aClass [
	"< api: #st getter: #behavior registration: #whenBehaviorChanged:>"
	"Set the class corresponding to the method class of the source code you are editing"

	behaviorHolder value: aClass
]

{ #category : #'api-doIt' }
CodePresenter >> doItContext [

	^ doItContext value
]

{ #category : #'api-doIt' }
CodePresenter >> doItContext: anObject [

	doItContext value: anObject
]

{ #category : #'api-doIt' }
CodePresenter >> doItReceiver [
	| receiver |
	
	receiver := doItReceiver value.
	receiver isBehavior ifTrue: [receiver  := receiver instanceSide].
	^receiver
]

{ #category : #'api-doIt' }
CodePresenter >> doItReceiver: anObject [

	doItReceiver value: anObject
]

{ #category : #initialization }
CodePresenter >> initialize [ 

	super initialize.
	behaviorHolder := nil asValueHolder.
	doItContext := nil asValueHolder.
	doItReceiver := nil asValueHolder.
	
	self registerEventsForStyling
]

{ #category : #initialization }
CodePresenter >> registerEventsForStyling [

	behaviorHolder whenChangedDo: [ :class | 
		self changed: #classOrMetaClass: with: { class }.
		self changed: #getText ]
]
