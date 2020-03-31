Extension { #name : #SpSliderInput }

{ #category : #'*Spec2-Deprecated' }
SpSliderInput >> autoAccept [
	
	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.

	^ input autoAccept
]

{ #category : #'*Spec2-Deprecated' }
SpSliderInput >> autoAccept: aBoolean [

	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.
	
	input autoAccept: aBoolean
]
