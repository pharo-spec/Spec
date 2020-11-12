"
I am an abstract class for browsers centered around messages such as class `MessageBrowser` or class `VersionBrowser`.
"
Class {
	#name : #AbstractMessageCentricBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'messageList',
		'textConverter',
		'toolbarPresenter'
	],
	#category : #'Spec2-Tools-VersionBrowser'
}

{ #category : #specs }
AbstractMessageCentricBrowser class >> defaultSpec [

	^ self subclassResponsibility
]

{ #category : #testing }
AbstractMessageCentricBrowser class >> isAbstract [ 
	 ^self name = #AbstractMessageCentricBrowser
]

{ #category : #initialization }
AbstractMessageCentricBrowser >> initialize [
	super initialize.
	textConverter := SourceMethodConverter new.
	
]

{ #category : #initialization }
AbstractMessageCentricBrowser >> initializePresenters [

	messageList := self instantiate: MessageList.
	toolbarPresenter := self instantiate: SpMethodToolbar
]

{ #category : #initialization }
AbstractMessageCentricBrowser >> initializeWindow: aWindowPresenter [

	aWindowPresenter initialExtent: RealEstateAgent standardWindowExtent
]

{ #category : #'private - testing' }
AbstractMessageCentricBrowser >> isMethodDefinition: anItem [
	"an item can be nil, a compiled method, or a ring object. Whereas a ring object can be a ring method or comment definition.
	 Some operations are only valid for compiled methods or ring object that are a method definitions"

	anItem ifNil: [ ^ false ].
	
	"assume it is a compiled method or ring method definition"
	^ (anItem isRingObject and: [ anItem isMethod and: [ anItem compiledMethod isNotNil ] ])
		or: [  anItem isCompiledMethod ]
]

{ #category : #api }
AbstractMessageCentricBrowser >> selectedMessage [
	^ messageList selectedMessage
]

{ #category : #accessing }
AbstractMessageCentricBrowser >> textConverter [
	^ textConverter
]

{ #category : #accessing }
AbstractMessageCentricBrowser >> textConverter: aTextConverter [
	textConverter := aTextConverter method: self textConverter method
]
