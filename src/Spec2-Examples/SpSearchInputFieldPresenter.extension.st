Extension { #name : 'SpSearchInputFieldPresenter' }

{ #category : '*Spec2-Examples' }
SpSearchInputFieldPresenter class >> example [
	<sampleInstance>
	
	^ self new
		placeholder: 'Search...';
		open
]

{ #category : '*Spec2-Examples' }
SpSearchInputFieldPresenter class >> example2 [
	<sampleInstance>
	^ SpPresenter new
		layout: (SpBoxLayout newTopToBottom 
			add: (self new 
					placeholder: 'example2';
					yourself) 
			expand: false;
				add: (SpBoxLayout newLeftToRight
					add: (SpBoxLayout newTopToBottom
						add: (SpLabelPresenter new label: 'title') expand: false;
						add: SpEasyListViewPresenter new;
					yourself);
				yourself);
			yourself);
		open

]

{ #category : '*Spec2-Examples' }
SpSearchInputFieldPresenter class >> example3 [
	<sampleInstance>
	| searchbar |
	SpPresenter new
		layout: (SpOverlayLayout new
			addOverlay: (SpLabelPresenter new label: 'overlay') 
				withConstraints: [ :c | c vAlignEnd; hAlignStart ];
			child: (SpBoxLayout newTopToBottom 
				add: (searchbar := self new placeholder: 'example2') expand: false;
					add: (SpBoxLayout newLeftToRight
						add: (SpBoxLayout newTopToBottom
							add: (SpLabelPresenter new label: 'title') expand: false;
							add: SpEasyListViewPresenter new;
						yourself);
					yourself);
				yourself);
			yourself);
		open.
	searchbar placeholder: 'changing'

]
