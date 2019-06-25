Extension { #name : #SpComposablePresenter }

{ #category : #'*Spec2-Adapters-Morphic' }
SpComposablePresenter >> openWorldWithSpec [
	"Build the widget using the default spec and display it into the world"

	^ self openWorldWithSpec: self defaultSpecSelector.
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpComposablePresenter >> openWorldWithSpec: aSpec [
	"Build the widget using the spec name provided as argument and display it into the world"

	^ self openWorldWithSpecLayout: (self retrieveSpec: aSpec)
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpComposablePresenter >> openWorldWithSpecLayout: aSpec [
	"Build the widget using the spec name provided as argument and display it into the world"

	self flag: #TODO. "Fix this"
	"^ self openWithSpecLayout: aSpec in: WorldPresenter"
]
