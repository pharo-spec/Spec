Class {
	#name : #SpMorphicWindowAdapterTest,
	#superclass : #TestCase,
	#category : #'Spec2-Morphic-Backend-Tests'
}

{ #category : #tests }
SpMorphicWindowAdapterTest >> testOpenWidgetPresenterAppliesStyle [
	| presenter window |

	presenter := SpTextPresenter new.
	[ window := presenter openWithSpec ]
	ensure: [ window close ].
	
	self 
		assert: presenter adapter widget font 
		equals: StandardFonts defaultFont.
	
	presenter := SpTextPresenter new.
	presenter addStyle: 'code'.
	[ window := presenter openWithSpec ]
	ensure: [ window close ].

	self 
		assert: presenter adapter widget font 
		equals: StandardFonts codeFont.

]
