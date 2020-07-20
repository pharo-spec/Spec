"
@@TODO

!! Transmissions
- #inputTextPort (default)
- #outputTextChangedPort (default)
"
Class {
	#name : #SpPillarTextPresenter,
	#superclass : #SpRichTextPresenter,
	#instVars : [
		'formatString'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #accessing }
SpPillarTextPresenter >> defaultTextStyler [
	^ SpPillarTextStyler new
]

{ #category : #rendering }
SpPillarTextPresenter >> formatString [
	^  formatString 
]

{ #category : #rendering }
SpPillarTextPresenter >> formatString: aString [
	super formatString: aString.
	formatString := aString
]
