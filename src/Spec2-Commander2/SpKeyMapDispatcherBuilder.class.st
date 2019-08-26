Class {
	#name : #SpKeyMapDispatcherBuilder,
	#superclass : #CmVisitor,
	#instVars : [
		'kmDispatcher'
	],
	#category : #'Spec2-Commander2-Visitors'
}

{ #category : #accessing }
SpKeyMapDispatcherBuilder class >> menuPresenterClass [
	^ SpMenuPresenter
]

{ #category : #initialization }
SpKeyMapDispatcherBuilder >> initialize [
	
	super initialize.
	kmDispatcher := KMDispatcher new
]

{ #category : #accessing }
SpKeyMapDispatcherBuilder >> kmDispatcher [

	^ kmDispatcher
]

{ #category : #visiting }
SpKeyMapDispatcherBuilder >> visitCommand: aCmCommand [

	aCmCommand hasShortcutKey ifFalse: [ ^ self ].

	kmDispatcher
		bindKeyCombination: aCmCommand shortcutKey 
		toAction: [ aCmCommand execute ]
]
