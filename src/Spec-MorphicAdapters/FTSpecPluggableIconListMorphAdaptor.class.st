"
Description
--------------------

I contains extensions to FTPluggableIconListMorphAdaptor but later all my code should go in Pharo directly and in my superclass
"
Class {
	#name : #FTSpecPluggableIconListMorphAdaptor,
	#superclass : #FTPluggableIconListMorphAdaptor,
	#instVars : [
		'getIndexesSelector',
		'setIndexesSelector'
	],
	#category : #'Spec-MorphicAdapters-Support'
}

{ #category : #accessing }
FTSpecPluggableIconListMorphAdaptor >> backgroundColoringBlockOrSelector: anObject [
	self dataSource backgroundColoringBlockOrSelector: anObject
]

{ #category : #accessing }
FTSpecPluggableIconListMorphAdaptor >> getIndexesSelector [
	^ getIndexesSelector
]

{ #category : #accessing }
FTSpecPluggableIconListMorphAdaptor >> getIndexesSelector: anObject [
	getIndexesSelector := anObject
]

{ #category : #initialization }
FTSpecPluggableIconListMorphAdaptor >> initialize [
	super initialize.
	self dataSource: FTSpecPluggableIconListMorphAdaptorDataSource new
]

{ #category : #private }
FTSpecPluggableIconListMorphAdaptor >> selectionChangedUpdateStatus: ann [
	"Updates the status of selection (informs new selections and deselections)"

	self setIndexesSelector ifNil: [ ^ self ].

	self model perform: self setIndexesSelector with: ann newSelectedRowIndexes
]

{ #category : #accessing }
FTSpecPluggableIconListMorphAdaptor >> setIndexesSelector [
	^ setIndexesSelector
]

{ #category : #accessing }
FTSpecPluggableIconListMorphAdaptor >> setIndexesSelector: anObject [
	setIndexesSelector := anObject
]
