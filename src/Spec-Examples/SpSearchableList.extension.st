Extension { #name : #SpSearchableList }

{ #category : #'*Spec-Examples' }
SpSearchableList class >> example [
	<sampleInstance>
	"self example"

	^ self new
		items: #(#aaa #abc #axz #bbb #bfbg #bof #c); openWithSpec
]
