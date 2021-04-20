Class {
	#name : #SpWithLocaleTestApplication,
	#superclass : #SpApplication,
	#instVars : [
		'locale'
	],
	#category : #'Spec2-Tests-Localization'
}

{ #category : #accessing }
SpWithLocaleTestApplication >> initialize [ 

	super initialize.
	
	locale := Locale isoLanguage: 'en' isoCountry: 'US'.
]

{ #category : #accessing }
SpWithLocaleTestApplication >> locale [
	^ locale
]

{ #category : #accessing }
SpWithLocaleTestApplication >> locale: anObject [
	locale := anObject
]
