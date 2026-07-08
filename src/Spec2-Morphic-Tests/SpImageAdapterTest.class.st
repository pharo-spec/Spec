Class {
	#name : 'SpImageAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Morphic-Tests',
	#package : 'Spec2-Morphic-Tests'
}

{ #category : 'accessing' }
SpImageAdapterTest >> classToTest [

	^ SpImagePresenter
]

{ #category : 'building' }
SpImageAdapterTest >> imageForm [

	^ (PNGReadWriter on: 
			(ZnBase64Encoder new decode: PolymorphSystemSettings pharoLogoContents) readStream) 
			nextImage
]

{ #category : 'building' }
SpImageAdapterTest >> testSettingAnImageSetsTheImage [

	self presenter image: self imageForm.
	backendForTest assertImage: self adapter image equals: self imageForm.

]

{ #category : 'building' }
SpImageAdapterTest >> testSettingAnImageSetsTheImageAndThrowsEvent [

	| happened |
	self presenter whenImageChangeDo: [ happened := true ].
	self presenter image: self imageForm.
	
	backendForTest assertImage: self adapter image equals: self imageForm.
	self assert: happened
]

{ #category : 'building' }
SpImageAdapterTest >> testSettingNilClearsTheImage [

	self presenter image: self imageForm.
	self presenter image: nil.
	
	backendForTest assertImage: self adapter image equals: nil.

]
