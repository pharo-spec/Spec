"
Description
--------------------

I contains extensions to FTPluggableIconListMorphAdaptorDataSource but later all my code should go in Pharo directly and in my superclass
"
Class {
	#name : #FTSpecPluggableIconListMorphAdaptorDataSource,
	#superclass : #FTPluggableIconListMorphAdaptorDataSource,
	#category : #'Spec-MorphicAdapters-Support'
}

{ #category : #private }
FTSpecPluggableIconListMorphAdaptorDataSource >> cellColumn: column row: rowIndex [
	| object text icon |
	object := self elementAt: rowIndex.
	
	icon := self getIconSelector ifNotNil: [ :selector | 
		self model perform: selector with: object ].
	text := column transform: (self elementWrapped: object index: rowIndex).
	
	^ self createCellText: text icon: icon.
]

{ #category : #private }
FTSpecPluggableIconListMorphAdaptorDataSource >> elementWrapped: anObject index: anIndex [
	^ self wrapSelector 
		ifNil: [ anObject ]
		ifNotNil:
			[ :selector | selector numArgs == 0 ifTrue: [ anObject perform: selector ] ifFalse: [ self model perform: selector withEnoughArguments: {anObject. anIndex} ] ]
]
