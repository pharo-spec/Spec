Extension { #name : 'SpToggleButtonPresenter' }

{ #category : '*Spec2-Examples' }
SpToggleButtonPresenter class >> example [

	<script>
	| presenter |
	presenter := self new.
	presenter
		icon: (self iconNamed: #smallOk);
		whenActivatedDo: [ presenter defer: [ presenter inform: 'Activated' ] ];
		whenDeactivatedDo: [
			presenter defer: [ presenter inform: 'Deactivated' ] ];
		open
]

{ #category : '*Spec2-Examples' }
SpToggleButtonPresenter class >> exampleWithAssociatedButtons [

	^ SpToggleButtonExample new open
]
