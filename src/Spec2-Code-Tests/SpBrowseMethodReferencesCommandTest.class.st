Class {
	#name : #SpBrowseMethodReferencesCommandTest,
	#superclass : #SpToolCommandTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #tests }
SpBrowseMethodReferencesCommandTest >> testExecute [
	| command mockContext mockNavigation selectedTextOrLine varRef globalRef selectorRef |

	mockNavigation := SpToolCommandMock new
		when: #environment: do: [ :env | "ignore" ];
		when: #browseAllReferencesTo: do: [ :aSelector | selectorRef := aSelector ].
	mockContext := SpToolCommandMock new
		when: #environment do: [ Smalltalk globals ];
		when: #selectedTextOrLine do: [ selectedTextOrLine ];
		when: #systemNavigation do: [ mockNavigation ].
		
	command := SpBrowseMethodReferencesCommand forContext: mockContext.
	
	varRef := globalRef := selectorRef := nil.
	selectedTextOrLine := 'initialize'.
	command execute.
	self assert: selectorRef equals: #initialize.

	varRef := globalRef := selectorRef := nil.
	selectedTextOrLine := 'self initialize'.
	command execute.
	self assert: selectorRef equals: #initialize.
	
	varRef := globalRef := selectorRef := nil.
	selectedTextOrLine := 'self initialize: 42'.
	command execute.
	self assert: selectorRef equals: #initialize:
]
