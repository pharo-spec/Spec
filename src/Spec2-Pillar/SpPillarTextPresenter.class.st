"
@@TODO

!! Transmissions
- #inputTextPort (default)
- #outputTextChangedPort (default)
"
Class {
	#name : #SpPillarTextPresenter,
	#superclass : #SpRichTextPresenter,
	#category : #'Spec2-Pillar'
}

{ #category : #accessing }
SpPillarTextPresenter >> defaultTextStyler [
	^ SpPillarTextStyler new
]
