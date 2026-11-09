Extension { #name : 'SpCheckBoxPresenter' }

{ #category : '*Spec2-Examples' }
SpCheckBoxPresenter class >> example [ 

	self new 
		label: 'Example';
		state: false;
		whenActivatedDo: [ 'Activated' newLineTrace ];
		whenDeactivatedDo: [ 'Deactivated' newLineTrace ];
		open
]
