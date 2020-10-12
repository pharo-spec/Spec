Class {
	#name : #SpBrowseImplementorsCommandTest,
	#superclass : #SpToolCommandTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #tests }
SpBrowseImplementorsCommandTest >> testExecute [
	| command mockContext mockNavigation selectedTextOrLine varRef globalRef selectorRef |

	mockNavigation := SpToolCommandMock new
		when: #environment: do: [ :env | "ignore" ];
		when: #browseAllImplementorsOf: do: [ :aSelector | selectorRef := aSelector ].
	mockContext := SpToolCommandMock new
		when: #environment do: [ Smalltalk globals ];
		when: #selectedTextOrLine do: [ selectedTextOrLine ];
		when: #systemNavigation do: [ mockNavigation ].
		
	command := SpBrowseImplementorsCommand forContext: mockContext.
	
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
