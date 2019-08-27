Class {
	#name : #SpCodeCommandTest,
	#superclass : #TestCase,
	#category : #'Spec2-Tests-Commands'
}

{ #category : #'as yet unclassified' }
SpCodeCommandTest >> commandToTest [

	^ self commandClass new 
		context: self newMockContext;
		yourself
]

{ #category : #'as yet unclassified' }
SpCodeCommandTest >> newMockContext [
	
	^ SpCodeCommandContextMock new
]

{ #category : #tests }
SpCodeCommandTest >> testExecute [

	self commandToTest execute
]
