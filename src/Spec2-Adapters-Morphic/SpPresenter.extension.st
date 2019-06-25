Extension { #name : #SpPresenter }

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> beginsWith: aString fromList: aMorph [
	"This method is used bu the list for the search of elements when you are typing directly in the list"
	
	^ self ensureMorphicAdapterDo: [ :adapter | adapter beginsWith: aString fromList: aMorph ]
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> detectMorphicAdapterDo: aBlock [

	^ self dependents 
		detect: [:e | e isMorphicAdapter ]
		ifFound: aBlock
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> detectMorphicAdapterDo: doBlock ifNone: aBlock [

	^ self dependents 
		detect: [:e | e isMorphicAdapter ]
		ifFound: doBlock
		ifNone: aBlock
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> ensureMorphicAdapter [

	^ self dependents 
		detect: [:e | e isMorphicAdapter ]
		ifNone: [ self buildWithSpec ]
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> ensureMorphicAdapterDo: aBlock [

	^ aBlock value: self ensureMorphicAdapter
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> heightToDisplayInList: aList [
	"Return the width of my representation as a list item"
	
	^ self ensureMorphicAdapterDo: [ :adapter | adapter heightToDisplayInList: aList ]
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> heightToDisplayInTree: aTree [
	"Return the width of my representation as a list item"
	
	^ self ensureMorphicAdapterDo: [ :adapter | adapter heightToDisplayInTree: aTree ]
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> listRenderOn: aCanvas atRow: aRow bounds: drawBounds color: drawColor backgroundColor: backgroundColor from: aMorph [
	"Specify how this object as a list item should be drawn"

	^ self ensureMorphicAdapterDo: [ :adapter | adapter
		listRenderOn: aCanvas
		atRow: aRow
		bounds: drawBounds
		color: drawColor
		backgroundColor: backgroundColor
		from: aMorph ]
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> openWorldWithSpec [
	"Build the widget using the default spec and display it into the world"

	^ self openWorldWithSpec: self defaultSpecSelector.
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> openWorldWithSpec: aSpec [
	"Build the widget using the spec name provided as argument and display it into the world"

	^ self openWorldWithSpecLayout: (self retrieveSpec: aSpec)
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> openWorldWithSpecLayout: aSpec [
	"Build the widget using the spec name provided as argument and display it into the world"

	self flag: #TODO. "Fix this"
	"^ self openWithSpecLayout: aSpec in: WorldPresenter"
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> treeRenderOn: aCanvas bounds: drawBounds color: drawColor font: aFont from: aMorph [
	"Specify how this object as a list item should be drawn"

	^ self ensureMorphicAdapterDo: [ :adapter | adapter 
		treeRenderOn: aCanvas 
		bounds: drawBounds 
		color: drawColor 
		font: aFont 
		from: aMorph ]
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> widthToDisplayInList: aList [
	"Return the width of my representation as a list item"
	
	^ self ensureMorphicAdapterDo: [ :adapter | adapter widthToDisplayInList: aList ]
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpPresenter >> widthToDisplayInTree: aTree [
	"Return the width of my representation as a list item"
	
	^ self ensureMorphicAdapterDo: [ :adapter | adapter widthToDisplayInTree: aTree ]
]
