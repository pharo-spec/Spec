Class {
	#name : #SpBrowseSendersCommandTest,
	#superclass : #SpToolCommandTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #tests }
SpBrowseSendersCommandTest >> testExecute [
	| command mockContext mockNavigation selectedTextOrLine varRef globalRef selectorRef |

	mockNavigation := SpToolCommandMock new
		when: #environment: do: [ :env | "ignore" ];
		when: #browseAllAccessesTo:from: do: [ :ref :env | varRef := ref ];
		when: #browseAllSendersOf: do: [ :aLiteral | globalRef := aLiteral key ];
		when: #browseAllReferencesTo: do: [ :aSelector | selectorRef := aSelector ].
	mockContext := SpToolCommandMock new
		when: #environment do: [ Smalltalk globals ];
		when: #selectedTextOrLine do: [ selectedTextOrLine ];
		when: #systemNavigation do: [ mockNavigation ].
		
	command := SpBrowseSendersCommand forContext: mockContext.
	
	varRef := globalRef := selectorRef := nil.
	selectedTextOrLine := 'Object'.
	command execute.
	self assert: globalRef equals: #Object.
	
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
