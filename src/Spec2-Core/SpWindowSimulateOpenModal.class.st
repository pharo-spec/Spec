"
To be used when I want the dialog to simulate a response instead of calling it.
To be used, variable needs to be a block with an argument: the dialog itself.

Example:
```smalltalk
SpWindowSimulateOpenModal 
	value: [ :aDialogPresenter |
		aDalogPresenter presenter inputText: 'The text of the sample'.
		aDialogPresenter beOk. 
		true ]
	durying [ ""some code thet will call dialog openModal"" ]
```
"
Class {
	#name : 'SpWindowSimulateOpenModal',
	#superclass : 'DynamicVariable',
	#category : 'Spec2-Core-Windows',
	#package : 'Spec2-Core',
	#tag : 'Windows'
}
