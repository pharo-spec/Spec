Class {
	#name : #SpPillarTextPresenter,
	#superclass : #SpRichTextPresenter,
	#category : #'Spec2-Pillar'
}

{ #category : #accessing }
SpPillarTextPresenter >> defaultTextStyler [
	^ SpPillarTextStyler new
]

{ #category : #rendering }
SpPillarTextPresenter >> parseRaw: aFormatString [
	^ PRPillarParser parse: aFormatString 
]
