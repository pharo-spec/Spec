Class {
	#name : #SpBrowseClassCommandTest,
	#superclass : #SpToolCommandTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #tests }
SpBrowseClassCommandTest >> testExecute [
	| command mockContext mockNavigation selectedTextOrLine object |

	mockNavigation := SpToolCommandMock new
		when: #environment: do: [ :env | "ignore" ];
		when: #browse: do: [ :anObject | object := anObject ].
	mockContext := SpToolCommandMock new
		when: #environment do: [ Smalltalk globals ];
		when: #selectedTextOrLine do: [ selectedTextOrLine ];
		when: #systemNavigation do: [ mockNavigation ].
		
	command := SpBrowseClassCommand forContext: mockContext.
	
	object := nil.
	selectedTextOrLine := 'Object'.
	command execute.
	self assert: object equals: Object.

	object := nil.
	selectedTextOrLine := '42'.
	command execute.
	self assert: object equals: 42.
	
	object := nil.
	selectedTextOrLine := '1000 factorial'.
	command execute.
	self assert: object equals: 1000 factorial.
	
	object := nil.
	selectedTextOrLine := '1000/0'.
	command execute.
	self assert: object equals: nil

]
