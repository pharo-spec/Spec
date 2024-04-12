Extension { #name : 'SpDropListPresenter' }

{ #category : '*Spec2-Examples' }
SpDropListPresenter class >> example [
	"Show a simple dropdown list."

	^ (self new
		   help: 'Select the presenter.';
		   items: SpPresenter withAllSubclasses;
		   display: [ :aClass | aClass name ];
		   whenSelectedItemChangedDo: [ :aClass | aClass crTrace ];
		   open)
		  extent: 400 @ 25;
		  yourself
]

{ #category : '*Spec2-Examples' }
SpDropListPresenter class >> exampleWithActions [
	"This example shows how to add icons to a dropdown list."

	^ (self new
		   help: 'Select the presenter.';
			addItemLabeled: 'Action 1' do: [ 'Action 1' crTrace ];
			addItemLabeled: 'Action 2' do: [ 'Action 2' crTrace ];
			addItemLabeled: 'Action 3' do: [ 'Action 3' crTrace ];
		   open)
		resize: 400 @ 25;
		yourself
]

{ #category : '*Spec2-Examples' }
SpDropListPresenter class >> exampleWithIcons [
	"This example shows how to add icons to a dropdown list."

	^ (self new
		   help: 'Select the presenter.';
		   items: SpPresenter withAllSubclasses;
		   display: [ :aClass | aClass name ];
			displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		   whenSelectedItemChangedDo: [ :aClass | aClass crTrace ];
		   open)
		resize: 400 @ 25;
		yourself
]
