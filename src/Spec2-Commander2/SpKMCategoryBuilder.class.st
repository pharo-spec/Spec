Class {
	#name : 'SpKMCategoryBuilder',
	#superclass : 'CmVisitor',
	#instVars : [
		'kmCategory'
	],
	#category : 'Spec2-Commander2-Visitors',
	#package : 'Spec2-Commander2',
	#tag : 'Visitors'
}

{ #category : 'accessing' }
SpKMCategoryBuilder class >> menuPresenterClass [
	^ SpMenuPresenter
]

{ #category : 'initialization' }
SpKMCategoryBuilder >> initialize [
	
	super initialize.
	kmCategory := KMCategory new
]

{ #category : 'accessing' }
SpKMCategoryBuilder >> kmCategory [

	^ kmCategory
]

{ #category : 'visiting' }
SpKMCategoryBuilder >> visitCommand: aCmCommand [

	aCmCommand hasShortcutKey ifFalse: [ ^ self ].

	kmCategory addKeymapEntry: (KMKeymap
		shortcut: aCmCommand shortcutKey
		action: [ 
			aCmCommand canBeExecuted 
				ifTrue: [ aCmCommand execute ] ])
]
