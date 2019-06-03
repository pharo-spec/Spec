Extension { #name : #RubTextFieldArea }

{ #category : #'*Spec-Pharo7To8Compatibility' }
RubTextFieldArea >> wrapped: aBoolean [
	self deprecated: 'Obsolete' transformWith: '`@receiver wrapped: `@statements' -> ''
]
