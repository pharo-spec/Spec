Class {
	#name : #SpTestApplicationWithLocale,
	#superclass : #SpApplication,
	#instVars : [
		'locale'
	],
	#category : #'Spec2-Tests-Localization'
}

{ #category : #initialization }
SpTestApplicationWithLocale >> initialize [ 

	super initialize.
	
	locale := Locale isoLanguage: 'en' isoCountry: 'US'.
]

{ #category : #accessing }
SpTestApplicationWithLocale >> locale [
	^ locale
]

{ #category : #accessing }
SpTestApplicationWithLocale >> locale: anObject [
	locale := anObject
]
