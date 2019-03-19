"
I am the adapter used to bridget a SliderPresenter and a PluggableSliderMorph
"
Class {
	#name : #MorphicSliderAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #'widget API' }
MorphicSliderAdapter >> absoluteValue [

	^ self presenter absoluteValue
]

{ #category : #'widget API' }
MorphicSliderAdapter >> absoluteValue: aFloat [
	^ self presenter absoluteValue: aFloat
]

{ #category : #factory }
MorphicSliderAdapter >> buildWidget [
	| preWidget |
	preWidget := PluggableSliderMorph new
		model: self;
		getValueSelector: #value;
		setValueSelector: #value:;
		value: self absoluteValue;
		getLabelSelector: #label;
		max: self max;
		min: self min;
		quantum: self quantum;
		setBalloonText: self help;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		yourself.
	^ self presenter isHorizontal
		ifFalse: [ preWidget := TransformationMorph new asFlexOf: preWidget.
			preWidget transform withAngle: 90 degreesToRadians negated.
			preWidget ]
]

{ #category : #'widget API' }
MorphicSliderAdapter >> label [

	^ self presenter label
]

{ #category : #'widget API' }
MorphicSliderAdapter >> max [

	^ self presenter max
]

{ #category : #'widget API' }
MorphicSliderAdapter >> min [

	^ self presenter min
]

{ #category : #'widget API' }
MorphicSliderAdapter >> quantum [

	^ self model quantum
]

{ #category : #'widget API' }
MorphicSliderAdapter >> value [
	^ self presenter value
]

{ #category : #'widget API' }
MorphicSliderAdapter >> value: aValue [

	^ self presenter value: aValue
]
