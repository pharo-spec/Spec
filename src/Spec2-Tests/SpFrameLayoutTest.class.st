Class {
	#name : 'SpFrameLayoutTest',
	#superclass : 'SpLayoutTest',
	#category : 'Spec2-Tests-Layout',
	#package : 'Spec2-Tests',
	#tag : 'Layout'
}

{ #category : 'initialization' }
SpFrameLayoutTest >> initializeTestedInstance [

	layout := SpFrameLayout new.
	presenter layout: layout
]

{ #category : 'tests' }
SpFrameLayoutTest >> testFrameCanNestLayouts [
	| childPresenterInTab tabPresenter1 |
	
	presenter layout: (SpFrameLayout new 
		child: (SpTabLayout new
			add: (tabPresenter1 := presenter newLabel 
					label: 'Tab1'; 
					yourself)
				label: 'Tab1';
			yourself);
		yourself).
		
	self openInstance.
	childPresenterInTab := presenter presenters anyOne.
	self assert: childPresenterInTab equals: tabPresenter1.
	self assert: childPresenterInTab adapter isNotNil
]
