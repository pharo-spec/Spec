Extension { #name : 'SpLabelledSliderInput' }

{ #category : '*Spec2-Deprecated' }
SpLabelledSliderInput >> autoAccept [
	
	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.
		
	^ self sliderInput autoAccept
]

{ #category : '*Spec2-Deprecated' }
SpLabelledSliderInput >> autoAccept: aBoolean [

	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.

	^ self sliderInput autoAccept: aBoolean
]
