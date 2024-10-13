"
I am the adapter used to bridget a SliderPresenter and a PluggableSliderMorph
"
Class {
	#name : 'SpMorphicSliderAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'factory' }
SpMorphicSliderAdapter >> buildWidget [

	| aSliderMorph |
	aSliderMorph :=
		(PluggableSliderMorph
			on: self
			getValue: #presenterValue
			setValue: #presenterValue:
			min: self presenter min
			max: self presenter max
			quantum: self presenter quantum)
				getLabelSelector: #presenterLabel;
				setBalloonText: self help;
				vResizing: #spaceFill;
				hResizing: #spaceFill;
				yourself.

	self presenter whenMinChangedDo: [ :newValue |
		aSliderMorph min: newValue ].
	self presenter whenMaxChangedDo: [ :newValue |
		aSliderMorph max: newValue ].
	self presenter whenQuantumChangedDo: [ :newValue |
		aSliderMorph quantum: newValue ].
	self presenter whenLabelChangedDo: [ :newLabel |
		aSliderMorph label: newLabel ].
	self presenter whenAbsoluteValueChangedDo: [ :newValue |
		aSliderMorph setValue: newValue ].

	^ aSliderMorph
]

{ #category : 'accessing' }
SpMorphicSliderAdapter >> presenterLabel [
	
	^ self presenter label
]

{ #category : 'accessing' }
SpMorphicSliderAdapter >> presenterValue [

	^ self presenter value
]

{ #category : 'accessing' }
SpMorphicSliderAdapter >> presenterValue: aValue [

	self presenter value: aValue
]

{ #category : 'debug' }
SpMorphicSliderAdapter >> widgetAbsoluteValue [

	^ widget value asFloat
]

{ #category : 'debug' }
SpMorphicSliderAdapter >> widgetLabel [

	^ widget label
]

{ #category : 'debug' }
SpMorphicSliderAdapter >> widgetValue [

	^ widget scaledValue
]

{ #category : 'debug' }
SpMorphicSliderAdapter >> widgetValue: aNumber [
	"Emulate a change in the widget value, as if there was a scroll.
	Note: We intentionally use #setValue: instead of #value: due to a bug in
	the widget, that doesn't perform the setValue selector with the new value
	when using #value:, and we need it."

	widget setValue: (self presenter valueToAbsoluteValue: aNumber)
]
