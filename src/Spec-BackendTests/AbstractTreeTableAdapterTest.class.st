Class {
	#name : #AbstractTreeTableAdapterTest,
	#superclass : #AbstractAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #testing }
AbstractTreeTableAdapterTest class >> isAbstract [ 
	
	^ self = AbstractTreeTableAdapterTest
]

{ #category : #accessing }
AbstractTreeTableAdapterTest >> classToTest [

	^ TreeTablePresenter 
]
