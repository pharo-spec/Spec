"
This demo shows differenty styles of text inputs.
"
Class {
	#name : #SpDemoTextInputPresenter,
	#superclass : #SpComposablePresenter,
	#instVars : [
		'labelNormal',
		'fieldNormal',
		'labelDisabled',
		'fieldDisabled',
		'labelEncrypted',
		'fieldEncrypted',
		'fieldPlaceholderText',
		'labelPlaceholderText'
	],
	#category : #'Spec-Examples-Demo-TextInput'
}

{ #category : #specs }
SpDemoTextInputPresenter class >> defaultSpec [

	<spec: #default>

	| fontWidth labelsWidth rowHeight |
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	labelsWidth := fontWidth * 8.
	rowHeight := self inputTextHeight.
	
	^ SpLayout composed
		newColumn: [ :col | 

			col newRow: [ :row | 
				row add: #labelNormal right: labelsWidth.
				row add: #fieldNormal ]
			height: rowHeight.
		
			col newRow: [ :row | 
				row add: #labelDisabled right: labelsWidth.
				row add: #fieldDisabled ]
			height: rowHeight.

			col newRow: [ :row | 
				row add: #labelPlaceholderText right: labelsWidth.
				row add: #fieldPlaceholderText ]
			height: rowHeight.

			col newRow: [ :row | 
				row add: #labelEncrypted right: labelsWidth.
				row add: #fieldEncrypted ]
			height: rowHeight.

		"fill the rest of the space"
		col newRow: [ :row |  ] ]; 
			
		yourself.	
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldDisabled [
	^ fieldDisabled
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldDisabled: anObject [
	fieldDisabled := anObject
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldEncrypted [
	^ fieldEncrypted
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldEncrypted: anObject [
	fieldEncrypted := anObject
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldNormal [
	^ fieldNormal
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldNormal: anObject [
	fieldNormal := anObject
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldPlaceholderText [
	^ fieldPlaceholderText
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldPlaceholderText: anObject [
	fieldPlaceholderText := anObject
]

{ #category : #initialization }
SpDemoTextInputPresenter >> initializeWidgets [
	labelNormal := self newLabel label: 'Normal:'.
	fieldNormal := self newTextInput.
	
	labelDisabled := self newLabel label: 'Disabled:'.
	fieldDisabled := self newTextInput enabled: false.
	
	labelPlaceholderText := self newLabel label: 'Placeholder:'.
	fieldPlaceholderText := self newTextInput placeholder: 'Placeholder text'.
	
	labelEncrypted := self newLabel label: 'Password:'.
	fieldEncrypted := self newTextInput
		text: 'Password';
		bePassword
]

{ #category : #accessing }
SpDemoTextInputPresenter >> labelDisabled [
	^ labelDisabled
]

{ #category : #accessing }
SpDemoTextInputPresenter >> labelDisabled: anObject [
	labelDisabled := anObject
]

{ #category : #accessing }
SpDemoTextInputPresenter >> labelEncrypted [
	^ labelEncrypted
]

{ #category : #accessing }
SpDemoTextInputPresenter >> labelEncrypted: anObject [
	labelEncrypted := anObject
]

{ #category : #accessing }
SpDemoTextInputPresenter >> labelNormal [
	^ labelNormal
]

{ #category : #accessing }
SpDemoTextInputPresenter >> labelNormal: anObject [
	labelNormal := anObject
]

{ #category : #accessing }
SpDemoTextInputPresenter >> labelPlaceholderText [
	^ labelPlaceholderText
]

{ #category : #accessing }
SpDemoTextInputPresenter >> labelPlaceholderText: anObject [
	labelPlaceholderText := anObject
]
