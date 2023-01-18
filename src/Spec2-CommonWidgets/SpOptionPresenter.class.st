"
I'm a SpPresenter to be used in an SpOptionListPresenter as the content of an option. 
You can subclass me or implement the messages I define in your own presenter.
"
Class {
	#name : #SpOptionPresenter,
	#superclass : #SpPresenter,
	#category : #'Spec2-CommonWidgets-Core'
}

{ #category : #actions }
SpOptionPresenter >> doAccept [ 
	self validate.
]

{ #category : #initialization }
SpOptionPresenter >> optionIcon [
	"Answer a Form to be used to display the option"

	^ self iconNamed: #smallWindow
]

{ #category : #initialization }
SpOptionPresenter >> optionTitle [
	"Answer the title to be displayed in the option choices."

	^ self subclassResponsibility
]

{ #category : #validation }
SpOptionPresenter >> validate [
	
	| report |
	report := SpValidationReport new.
	self presenters do: [ :presenter | presenter validateInto: report ].
	^ report
]
