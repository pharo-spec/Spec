"
A column that displays text input field presenters.

It does not have sense to set the evaluation as the user can set different things like the text, placeholder and the maxLenght. Also the user can set some api events. See the methods in the api and api - events protocols.


## Example
```
self example
```
"
Class {
	#name : #SpTextInputFieldTableColumn,
	#superclass : #SpTableColumn,
	#instVars : [
		'placeholder',
		'maxLength',
		'text',
		'whenEditableChangedDo',
		'whenSubmitDo',
		'isEditable',
		'whenTextChangedDo'
	],
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #examples }
SpTextInputFieldTableColumn class >> example [

	^ SpTablePresenter new
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		addColumn: ((SpTextInputFieldTableColumn title: 'Text Input Field')
			placeholder: 'Write on me';
			yourself);
		items: self class environment allClasses;
		beResizable;
		open
]

{ #category : #visiting }
SpTextInputFieldTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitTextInputFieldColumn: self
]

{ #category : #api }
SpTextInputFieldTableColumn >> beEditable [

	isEditable := true
]

{ #category : #api }
SpTextInputFieldTableColumn >> beNotEditable [

	isEditable := false
]

{ #category : #initialization }
SpTextInputFieldTableColumn >> initialize [

	super initialize.
	self beEditable
]

{ #category : #testing }
SpTextInputFieldTableColumn >> isEditable [

	^ isEditable 
]

{ #category : #accessing }
SpTextInputFieldTableColumn >> maxLength [
	^ maxLength
]

{ #category : #api }
SpTextInputFieldTableColumn >> maxLength: anInteger [ 
	"Set maximum allowed length."
	
	maxLength := anInteger.
]

{ #category : #accessing }
SpTextInputFieldTableColumn >> placeholder [

	^ placeholder
]

{ #category : #api }
SpTextInputFieldTableColumn >> placeholder: aString [

	placeholder := aString 
]

{ #category : #accessing }
SpTextInputFieldTableColumn >> text [
	^ text
]

{ #category : #api }
SpTextInputFieldTableColumn >> text: aString [

	text := aString
]

{ #category : #accessing }
SpTextInputFieldTableColumn >> whenEditableChangedDo [
	^ whenEditableChangedDo
]

{ #category : #'api - events' }
SpTextInputFieldTableColumn >> whenEditableChangedDo: aBlock [

	whenEditableChangedDo := aBlock
]

{ #category : #accessing }
SpTextInputFieldTableColumn >> whenSubmitDo [
	^ whenSubmitDo
]

{ #category : #'api - events' }
SpTextInputFieldTableColumn >> whenSubmitDo: aBlock [

	whenSubmitDo := aBlock
]

{ #category : #accessing }
SpTextInputFieldTableColumn >> whenTextChangedDo [

	^ whenTextChangedDo
]

{ #category : #'api - events' }
SpTextInputFieldTableColumn >> whenTextChangedDo: aBlock [

	whenTextChangedDo := aBlock
]
