Extension { #name : #SpActionBarPresenter }

{ #category : #'*Spec2-Examples' }
SpActionBarPresenter class >> example [
	| presenter list actionBar |
	
	(presenter := SpPresenter new) 
		layout: (SpBoxLayout newVertical 
			add: (list := presenter newList);
			add: (actionBar := presenter newActionBar) expand: false;
			yourself).	
		
	list 
		items: Smalltalk allClassesAndTraits;
		icons: [ :aClass | aClass systemIcon ];
		display: [ :aClass | aClass name ].
		
	actionBar 
		add: (presenter newButton
			label: 'Ok';
			yourself);
		add: (presenter newButton 
			label: 'Ok2';
			yourself);
		addLast: (presenter newButton
			label: 'Last';
			yourself).
			
	presenter openWithSpec

]
