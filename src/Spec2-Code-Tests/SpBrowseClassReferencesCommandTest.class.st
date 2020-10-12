Class {
	#name : #SpBrowseClassReferencesCommandTest,
	#superclass : #SpToolCommandTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #tests }
SpBrowseClassReferencesCommandTest >> testExecute [
	| command mockContext mockNavigation selectedTextOrLine class |

	mockNavigation := SpToolCommandMock new
		when: #environment: do: [ :env | "ignore" ];
		when: #browseAllCallsOnClass: do: [ :anObject | class := anObject ].
	mockContext := SpToolCommandMock new
		when: #environment do: [ Smalltalk globals ];
		when: #selectedTextOrLine do: [ selectedTextOrLine ];
		when: #systemNavigation do: [ mockNavigation ].
		
	command := SpBrowseClassReferencesCommand forContext: mockContext.
	
	class := nil.
	selectedTextOrLine := 'Object'.
	command execute.
	self assert: class equals: Object.

	class := nil.
	selectedTextOrLine := '42'.
	command execute.
	self assert: class equals: SmallInteger.
	
	class := nil.
	selectedTextOrLine := '1000 factorial'.
	command execute.
	self assert: class equals: LargePositiveInteger.
	
	class := nil.
	selectedTextOrLine := '1000/0'.
	command execute.
	self assert: class equals: nil

]
