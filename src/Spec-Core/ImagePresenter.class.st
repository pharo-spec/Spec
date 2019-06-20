"
An ImagePresenter is a spec presenter for images.
See AbstractWidgetPresenter

I provide the following variables and their accessors
- action is the action performed when I am displayed.
- image is the form i display.
"
Class {
	#name : #ImagePresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'#image => SpObservableSlot',
		'#action => SpObservableSlot',
		'#autoScale => SpObservableSlot'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
ImagePresenter class >> adapterName [

	^ #ImageAdapter
]

{ #category : #api }
ImagePresenter >> action [

	^ action
]

{ #category : #api }
ImagePresenter >> action: aBlock [
	"Set the action of the image"
	action := aBlock
]

{ #category : #api }
ImagePresenter >> autoScale [
	^ autoScale
]

{ #category : #api }
ImagePresenter >> autoScale: aBoolean [
	autoScale := aBoolean
]

{ #category : #api }
ImagePresenter >> image [

	^ image
]

{ #category : #api }
ImagePresenter >> image: aForm [
	
	image := aForm
]

{ #category : #initialization }
ImagePresenter >> initialize [

	super initialize.
	
	image := nil.
	action := [ ].
	autoScale := false.

"	imageHolder whenChangedDo: [ self changed: #getImage ].
"
]

{ #category : #api }
ImagePresenter >> switchAutoscale [
	autoScale := autoScale not.

]

{ #category : #events }
ImagePresenter >> whenAutoScaleChangeDo: aBlockClosure [
	self property: #autoScale whenChangedDo: aBlockClosure
]

{ #category : #events }
ImagePresenter >> whenImageChangeDo: aBlockClosure [ 
	
	self property: #image whenChangedDo: aBlockClosure 
]
