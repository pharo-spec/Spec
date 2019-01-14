Class {
	#name : #MorphicTreeTableAdapter,
	#superclass : #MorphicTableAdapter,
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #'private factory' }
MorphicTreeTableAdapter >> newDataSource [ 

	^ MorphicTreeTableDataSource new 
		rootItem: (self rootForItems: self model roots);
		childrenBlock: [ :data :item | self model childrenFor: data ];
		yourself
]

{ #category : #private }
MorphicTreeTableAdapter >> rootForItems: aCollection [

	^ FTRootItem new
		data: aCollection;
		yourself
]
