Extension { #name : #SpSliderInputPresenter }

{ #category : #'*Spec2-Examples' }
SpSliderInputPresenter class >> example [

	<sampleInstance>
	| example |
	example := self new
		           min: 0;
		           max: 250;
		           value: 120;
		           extent: 400 @ 50;
		           open.
	example withWindowDo: [ :window | 
		window title: 'SliderInput example' ].
	^ example
]
