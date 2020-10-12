Class {
	#name : #SpBrowseMethodsContainingStringCommandTest,
	#superclass : #SpToolCommandTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #tests }
SpBrowseMethodsContainingStringCommandTest >> testExecute [
	| command mockContext mockNavigation selectedTextOrLine string |

	mockNavigation := SpToolCommandMock new
		when: #environment: do: [ :env | "ignore" ];
		when: #browseMethodsWithSourceString:matchCase:  do: [ :ref :env | string := ref ].
	mockContext := SpToolCommandMock new
		when: #environment do: [ Smalltalk globals ];
		when: #selectedTextOrLine do: [ selectedTextOrLine ];
		when: #systemNavigation do: [ mockNavigation ].
		
	command := SpBrowseMethodsContainingStringCommand forContext: mockContext.
	
	selectedTextOrLine := 'some string'.
	command execute.
	self assert: string equals: 'some string'.

]
