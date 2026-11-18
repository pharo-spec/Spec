Extension { #name : 'SpLabelPresenter' }

{ #category : '*Spec2-Examples' }
SpLabelPresenter class >> example [
	"This example opens a spec window with a label."

	^ self new
		  label: 'Label example';
		  open
]

{ #category : '*Spec2-Examples' }
SpLabelPresenter class >> exampleWithDecoration [
	"This example opens a spec window with a decorated label."

	^ self new
	  	label: 'Label example';
		displayColor: [ Color random ];
		displayItalic: [ true ];
		displayBold: [ true ];
		displayUnderline: [ true ];
		displayStrikethrough: [ true ];
	  	open
]

{ #category : '*Spec2-Examples' }
SpLabelPresenter class >> exampleWrap [
	"This example opens a narrow spec window with a long label that wraps its text over 
	 several lines, above a button. Resize the window: the label lays out its text again 
	 to fit its width, and the button follows it."

	| presenter |
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newTopToBottom
		 add: (presenter newLabel
			  label:
				  'This long label wraps its text over several lines to fit the width of the window. Resize the window to see it lay out its text again.';
			  beWrap;
			  yourself)
		 expand: false;
		 add: (presenter newButton
			  label: 'A button below the label';
			  yourself)
		 expand: false;
		 yourself).

	^ presenter open
		  resize: 250 @ 200;
		  yourself
]
