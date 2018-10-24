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
		'#maximum => SpecPropertySlot',
		'#digits => SpecPropertySlot'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
NumberInputFieldPresenter class >> adapterName [

	^ #NumberInputFieldAdapter
]

{ #category : #accessing }
NumberInputFieldPresenter class >> defaultDigits [

	^ 2
]

{ #category : #accessing }
NumberInputFieldPresenter >> beFloat [

	self numberType: Float
]

{ #category : #accessing }
NumberInputFieldPresenter >> beInteger [

	self numberType: Integer
]

{ #category : #accessing }
NumberInputFieldPresenter >> digits [
	"digits to show when we have a float number"

	^ digits
]

{ #category : #accessing }
NumberInputFieldPresenter >> digits: aNumber [
	"digits to show when we have a float number"

	digits := aNumber
]

{ #category : #initialization }
NumberInputFieldPresenter >> initialize [

	super initialize.
	self beInteger.
	self digits: self class defaultDigits
]

{ #category : #testing }
NumberInputFieldPresenter >> isFloat [ 

	^ self numberType = Float
]

{ #category : #testing }
NumberInputFieldPresenter >> isInteger [ 

	^ self numberType = Integer
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
NumberInputFieldPresenter >> rangeMinimum: minNumber maximum: maxNumber [ 

	self minimum: minNumber.
	self maximum: maxNumber
]
