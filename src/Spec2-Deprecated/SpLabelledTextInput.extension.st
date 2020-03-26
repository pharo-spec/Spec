Extension { #name : #SpLabelledTextInput }

{ #category : #'*Spec2-Deprecated' }
SpLabelledTextInput >> acceptOnCR: aBoolean [

	self 
		deprecated: 'Autoaccept property has been removed because all text presenters are autoaccept 
		now, and accept actions are not needed anymore. Often, this actions were used to trigger 
		actions while saving (cmd+s) or while pressing enter. Consider use a key binding to supply 
		that functionality.'
		on: '2020-03-26' 
		in: #Pharo9.

	^ self input acceptOnCR: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledTextInput >> ghostText: aText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder: instead.' transformWith: '`@receiver ghostText: `@statement' -> '`@receiver placeholder: `@statement'.
	self placeholder: aText
]
