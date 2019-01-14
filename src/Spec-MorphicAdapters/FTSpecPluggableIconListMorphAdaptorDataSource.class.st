"
Description
--------------------

I contains extensions to FTPluggableIconListMorphAdaptorDataSource but later all my code should go in Pharo directly and in my superclass
"
Class {
	#name : #FTSpecPluggableIconListMorphAdaptorDataSource,
	#superclass : #FTPluggableIconListMorphAdaptorDataSource,
	#instVars : [
		'backgroundColoringBlockOrSelector'
	],
	#category : #'Spec-MorphicAdapters-Support'
}

{ #category : #accessing }
FTSpecPluggableIconListMorphAdaptorDataSource >> backgroundColoringBlockOrSelector [
	^ backgroundColoringBlockOrSelector
]

{ #category : #accessing }
FTSpecPluggableIconListMorphAdaptorDataSource >> backgroundColoringBlockOrSelector: anObject [
	backgroundColoringBlockOrSelector := anObject
]

{ #category : #private }
FTSpecPluggableIconListMorphAdaptorDataSource >> cellColumn: column row: rowIndex [
	| object text icon cell |
	object := self elementAt: rowIndex.

	icon := self getIconSelector ifNotNil: [ :selector | self model perform: selector with: object ].
	text := column transform: (self elementWrapped: object index: rowIndex).

	cell := self createCellText: text icon: icon.
	self setColorOf: cell object: object rowIndex: rowIndex.

	^ cell
]

{ #category : #private }
FTSpecPluggableIconListMorphAdaptorDataSource >> elementWrapped: anObject index: anIndex [
	^ self wrapSelector 
		ifNil: [ anObject ]
		ifNotNil:
			[ :selector | selector numArgs == 0 ifTrue: [ anObject perform: selector ] ifFalse: [ self model perform: selector withEnoughArguments: {anObject. anIndex} ] ]
]

{ #category : #private }
FTSpecPluggableIconListMorphAdaptorDataSource >> setColorOf: cell object: object rowIndex: rowIndex [
	| valuable color |
	(valuable := self backgroundColoringBlockOrSelector) ifNil: [ ^ self ].

	color := valuable isBlock
		ifTrue: [ valuable cull: object cull: rowIndex ]
		ifFalse: [ valuable numArgs == 0
				ifTrue: [ object perform: valuable ]
				ifFalse: [ self model perform: valuable withEnoughArguments: {object . rowIndex} ] ].

	cell color: color
]
