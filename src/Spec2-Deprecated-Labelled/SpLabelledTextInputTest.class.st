Class {
	#name : 'SpLabelledTextInputTest',
	#superclass : 'SpTextInputFieldPresenterTest',
	#category : 'Spec2-Deprecated-Labelled-Core-Widgets',
	#package : 'Spec2-Deprecated-Labelled',
	#tag : 'Core-Widgets'
}

{ #category : 'running' }
SpLabelledTextInputTest >> classToTest [
	^ SpLabelledTextInput
]

{ #category : 'private' }
SpLabelledTextInputTest >> textInputAdapter [

	^ presenter input adapter
]
