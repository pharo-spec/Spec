Class {
	#name : 'SpMorphicFrameLayoutTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Morphic-Backend-Tests',
	#package : 'Spec2-Morphic-Backend-Tests'
}

{ #category : 'tests' }
SpMorphicFrameLayoutTest >> testFrameWithoutChildThrowsAnError [
	| presenter  |

	presenter := SpPresenter new.
	presenter layout: SpFrameLayout new.

	presenter build.
	self assert: presenter adapter children isEmpty
]

{ #category : 'tests' }
SpMorphicFrameLayoutTest >> testFrameWithoutLabelOpensWithoutError [
	| presenter tabPresenter1 |
	
	presenter := SpPresenter new.
	presenter layout: (SpFrameLayout new 
		child: (SpTabLayout new
			add: (tabPresenter1 := presenter newLabel 
					label: 'Tab1'; 
					yourself)
				label: 'Tab1';
			yourself);
		yourself).

	presenter build.
	
	self assert: presenter adapter widgetLabel isNotNil
]

{ #category : 'tests' }
SpMorphicFrameLayoutTest >> testReplaceChild [
	| presenter widgetChild presenterToChange |

	presenter := SpPresenter new.
	presenter layout: (SpFrameLayout new 
		child: (presenter newLabel 
					label: 'Tab1 Inside'; 
					yourself)
		yourself).
		
	presenter build.
	widgetChild := presenter adapter childrenWidgets anyOne.
	presenter layout child: ((presenterToChange := presenter newLabel) 
					label: 'Tab2 Inside'; 
					yourself).
	
	self deny: widgetChild equals: presenter adapter childrenWidgets anyOne.
	self 
		assert: presenterToChange adapter widget 
		equals: presenter adapter childrenWidgets anyOne
	
]
