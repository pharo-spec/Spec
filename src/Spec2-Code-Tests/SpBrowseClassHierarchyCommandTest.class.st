Class {
	#name : #SpBrowseClassHierarchyCommandTest,
	#superclass : #SpToolCommandTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #tests }
SpBrowseClassHierarchyCommandTest >> testExecute [
	| command mockContext mockNavigation selectedTextOrLine object |

	mockNavigation := SpToolCommandMock new
		when: #environment: do: [ :env | "ignore" ];
		when: #browseHierarchy: do: [ :anObject | object := anObject ].
	mockContext := SpToolCommandMock new
		when: #environment do: [ Smalltalk globals ];
		when: #selectedTextOrLine do: [ selectedTextOrLine ];
		when: #systemNavigation do: [ mockNavigation ].
		
	command := SpBrowseClassHierarchyCommand forContext: mockContext.
	
	object := nil.
	selectedTextOrLine := 'Object'.
	command execute.
	self assert: object equals: Object.

	object := nil.
	selectedTextOrLine := '42'.
	command execute.
	self assert: object equals: SmallInteger.
	
	object := nil.
	selectedTextOrLine := '1000 factorial'.
	command execute.
	self assert: object equals: LargePositiveInteger.
	
	object := nil.
	selectedTextOrLine := '1000/0'.
	command execute.
	self assert: object equals: nil

]
