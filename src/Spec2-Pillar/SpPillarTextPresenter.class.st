Class {
	#name : #SpPillarTextPresenter,
	#superclass : #SpRichTextPresenter,
	#category : #'Spec2-Pillar'
}

{ #category : #accessing }
SpPillarTextPresenter >> defaultTextStyler [
	^ SpPillarTextStyler new
]

{ #category : #writing }
SpPillarTextPresenter >> formatString [
	^ PRTextWriter new write: self model 
]
