"
Description
--------------------

I contains extensions to FTPluggableIconListMorphAdaptor but later all my code should go in Pharo directly and in my superclass
"
Class {
	#name : #FTSpecPluggableIconListMorphAdaptor,
	#superclass : #FTPluggableIconListMorphAdaptor,
	#category : #'Spec-MorphicAdapters-Support'
}

{ #category : #initialization }
FTSpecPluggableIconListMorphAdaptor >> initialize [
	super initialize.
	self dataSource: FTSpecPluggableIconListMorphAdaptorDataSource new
]
