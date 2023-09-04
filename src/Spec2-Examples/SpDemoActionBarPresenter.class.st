"
This demo shows an action bar.
"
Class {
	#name : #SpDemoActionBarPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'actionBar',
		'text'
	],
	#category : #'Spec2-Examples-Demo-Buttons'
}

{ #category : #layout }
SpDemoActionBarPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: text;
		  addLast: actionBar expand: false;
		  yourself
]

{ #category : #initialization }
SpDemoActionBarPresenter >> initializePresenters [

	actionBar := self newActionBar
		             add: (self newButton
				              label: 'Add';
				              icon: (self iconNamed: #smallOk);
				              help: 'Add.';
				              action: [
					              actionBar defer: [ self inform: 'Add' ] ];
				              yourself);
		             add: (self newButton
				              label: 'Remove';
				              icon: (self iconNamed: #smallCancel);
				              help: 'Remove.';
				              action: [
					              actionBar defer: [ self inform: 'Remove' ] ];
				              yourself);
		             addLast: (self newButton
				              label: 'Other';
				              help: 'Other.';
				              action: [
					              actionBar defer: [ self inform: 'Other' ] ];
				              yourself);
		             yourself.

	text := self newText
]
