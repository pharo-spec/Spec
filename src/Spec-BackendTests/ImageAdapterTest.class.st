Class {
	#name : #ImageAdapterTest,
	#superclass : #AbstractWidgetAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #accessing }
ImageAdapterTest >> classToTest [

	^ SpImagePresenter
]

{ #category : #building }
ImageAdapterTest >> imageForm [

	^ (PNGReadWriter on: 
			(ZnBase64Encoder new decode: PolymorphSystemSettings pharoLogoContents) readStream) 
			nextImage
]

{ #category : #building }
ImageAdapterTest >> testAutoscale [
	self presenter autoScale: false.
	self deny: self adapter hasImageAutoscaled.
	self presenter autoScale: true.
	self assert: self adapter hasImageAutoscaled.

]

{ #category : #building }
ImageAdapterTest >> testSettingAnImageSetsTheImage [

	self presenter image: self imageForm.
	backendForTest assertImage: self adapter image equals: self imageForm.

]

{ #category : #building }
ImageAdapterTest >> testSettingAnImageSetsTheImageAndThrowsEvent [

	| happened |
	self presenter whenImageChangeDo: [ happened := true ].
	self presenter image: self imageForm.
	
	backendForTest assertImage: self adapter image equals: self imageForm.
	self assert: happened
]

{ #category : #building }
ImageAdapterTest >> testSettingNilClearsTheImage [

	self presenter image: self imageForm.
	self presenter image: nil.
	
	backendForTest assertImage: self adapter image equals: nil.

]
