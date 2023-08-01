Extension { #name : #SpDropListPresenter }

{ #category : #'*Spec2-Examples' }
SpDropListPresenter class >> example [

	^ (self new
			application: (SpApplication new useBackend: #Gtk);
		   help: 'Select the presenter.';
		   items: SpPresenter withAllSubclasses;
		   display: [ :aClass | aClass name ];
		   whenSelectedItemChangedDo: [ :aClass | aClass crTrace ];
		   open)
		  extent: 400 @ 25;
		  yourself
]

{ #category : #'*Spec2-Examples' }
SpDropListPresenter class >> exampleWithIcons [

	^ (self new
			application: (SpApplication new useBackend: #Gtk);
		   help: 'Select the presenter.';
		   items: SpPresenter withAllSubclasses;
		   display: [ :aClass | aClass name ];
			displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		   whenSelectedItemChangedDo: [ :aClass | aClass crTrace ];
		   open)
		  resize: 400 @ 25;
		  yourself
]
