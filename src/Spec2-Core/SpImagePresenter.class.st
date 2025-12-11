"
A presenter to display  images.
Images need to be instances of `Form`.  
"
Class {
	#name : 'SpImagePresenter',
	#superclass : 'SpAbstractWidgetPresenter',
	#instVars : [
		'#image => ObservableSlot',
		'#action => ObservableSlot',
		'#autoScale'
	],
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'specs' }
SpImagePresenter class >> adapterName [

	^ #ImageAdapter
]

{ #category : 'documentation' }
SpImagePresenter class >> documentFactoryMethodSelector [

	^ #newImage
]

{ #category : 'TOREMOVE' }
SpImagePresenter >> action [

	^ action
]

{ #category : 'TOREMOVE' }
SpImagePresenter >> action: aBlock [
	"Set the action of the image"

	action := aBlock
]

{ #category : 'TOREMOVE' }
SpImagePresenter >> autoScale [
	"Answer if image has autoscale activated."

	self 
		deprecated: 'Use #isAutoScale' 
		transformWith: '`@receiver autoScale -> `@receiver isAutoScale'.	

	^ self isAutoScale
]

{ #category : 'api' }
SpImagePresenter >> autoScale: aBoolean [
	"Set whether image will autoscale or not."

	autoScale := aBoolean
]

{ #category : 'api' }
SpImagePresenter >> image [
	"Answer the `Form` instance that will be displayed."

	^ image
]

{ #category : 'api' }
SpImagePresenter >> image: aForm [
	"Set a `Form` instance to be displayed."
	
	image := aForm
]

{ #category : 'initialization' }
SpImagePresenter >> initialize [

	super initialize.
	action := [  ].
	autoScale := false
]

{ #category : 'testing' }
SpImagePresenter >> isAutoScale [

	^ autoScale
]

{ #category : 'api' }
SpImagePresenter >> switchAutoscale [
	"Toggles autoscale state."
	
	autoScale := autoScale not

]

{ #category : 'api - events' }
SpImagePresenter >> whenImageChangeDo: aBlock [ 
	"Inform when image to display has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"
	
	self property: #image whenChangedDo: aBlock 
]
