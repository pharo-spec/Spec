Class {
	#name : #SpPillarTextPresenter,
	#superclass : #SpRichTextPresenter,
	#category : #'Spec2-Pillar'
}

{ #category : #accessing }
SpPillarTextPresenter >> defaultContentProvider [
	^ SpPillarContentHandler new
]

{ #category : #rendering }
SpPillarTextPresenter >> parseRaw: aFormatString [
	^ PRPillarParser parse: aFormatString 
]
