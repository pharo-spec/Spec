"
I am the bridge between an ImagePresenter and a AlphaImageMorph
"
Class {
	#name : #MorphicImageAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #initialization }
MorphicImageAdapter >> adapt: aComposablePresenter [

	super adapt: aComposablePresenter.
	widget
		on: #click
		send: #click
		to: self
]

{ #category : #factory }
MorphicImageAdapter >> buildWidget [
	| alphaImage |
	alphaImage := AlphaImageMorph new.
	alphaImage model: self.
	alphaImage
		getImageSelector: #getImage;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		layout: self layoutValue;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		setBalloonText: self help;
		update: #getImage.

	self model
		whenImageChangeDo: [ alphaImage image: (self getImage ifNil: [ Form extent: 1 @ 1 depth: 32 ]) ];
		whenAutoScaleChangeDo: [ widget layout: self layoutValue ].

	^ alphaImage
]

{ #category : #private }
MorphicImageAdapter >> click [

	^ self model action value
]

{ #category : #'widget protocol' }
MorphicImageAdapter >> getImage [

	^ self model image
]

{ #category : #accessing }
MorphicImageAdapter >> image [
	
	^ widget scaledImage
]

{ #category : #'widget protocol' }
MorphicImageAdapter >> layoutValue [
	^ self model autoScale
		ifTrue: [ #scaledAspect ]
		ifFalse: [ #center ]
]

{ #category : #'widget protocol' }
MorphicImageAdapter >> switchAutoscale [
	self widgetDo: [ :w | w layout: self layoutValue ]
]
