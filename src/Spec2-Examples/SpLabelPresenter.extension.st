Extension { #name : #SpLabelPresenter }

{ #category : #'*Spec2-Examples' }
SpLabelPresenter class >> example [

	"This example opens a spec window with a label."

	^ self new
		  label: 'Label example';
		  open
]

{ #category : #'*Spec2-Examples' }
SpLabelPresenter class >> exampleWithDecoration [
	"This example opens a spec window with a decorated label."

	^ self new
	  	label: 'Label example';
		displayColor: [ Color random ];
		displayItalic: [ :aClass | true ];
		displayBold: [ :aClass | true ];
		displayUnderline: [ :aClass | true ];
	  	open
]
