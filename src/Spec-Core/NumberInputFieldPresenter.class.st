"
I'm a text field specialised on numbers. 

I can accept number type (integer or float) and a range (min, max). 
"
Class {
	#name : #NumberInputFieldPresenter,
	#superclass : #TextInputFieldPresenter,
	#instVars : [
		'#numberType => SpecPropertySlot',
		'#minimum => SpecPropertySlot',
		'#maximum => SpecPropertySlot'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
NumberInputFieldPresenter class >> adapterName [

	^ #NumberInputFieldAdapter
]

{ #category : #accessing }
NumberInputFieldPresenter >> beFloat [

	self numberType: Float
]

{ #category : #accessing }
NumberInputFieldPresenter >> beInteger [

	self numberType: Integer
]

{ #category : #initialization }
NumberInputFieldPresenter >> initialize [
	super initialize.
	self numberType: Integer
]

{ #category : #accessing }
NumberInputFieldPresenter >> maximum [
	^ maximum
]

{ #category : #accessing }
NumberInputFieldPresenter >> maximum: aNumber [
	maximum := aNumber
]

{ #category : #accessing }
NumberInputFieldPresenter >> minimum [
	^ minimum
]

{ #category : #accessing }
NumberInputFieldPresenter >> minimum: aNumber [
	minimum := aNumber
]

{ #category : #accessing }
NumberInputFieldPresenter >> numberType [
	^ numberType
]

{ #category : #private }
NumberInputFieldPresenter >> numberType: aClass [
	"This can be Integer or Float, no more"

	numberType := aClass
]

{ #category : #accessing }
NumberInputFieldPresenter >> propertyAt: aName [

	^ (self class slotNamed: aName) propertyAt: self
]

{ #category : #accessing }
NumberInputFieldPresenter >> rangeMin: minNumber max: maxNumber [ 

	self minimum: minNumber.
	self maximum: maxNumber
]
