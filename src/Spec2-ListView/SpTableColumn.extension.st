Extension { #name : 'SpTableColumn' }

{ #category : '*Spec2-ListView' }
SpTableColumn >> asColumnViewColumn [

	^ SpColumnViewColumn new
		title: self title;
		expand: (self width isNil and: [ self isExpandable ]);
		sortFunction: self sortFunction;
		width: self width;
		setup: [ :aPresenter | 
			SpEasyColumnSetupBuilder new
				presenter: aPresenter;
				visit: self ];
		bind: [ :aPresenter :item | 
			SpEasyColumnBindBuilder new
				presenter: aPresenter;
				item: item;
				visit: self ];
		yourself
]
