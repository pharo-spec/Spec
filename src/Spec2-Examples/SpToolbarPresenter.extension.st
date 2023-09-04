Extension { #name : #SpToolbarPresenter }

{ #category : #'*Spec2-Examples' }
SpToolbarPresenter class >> example [
	
	| loremIpsumWords menuButton presenter |
	loremIpsumWords := String loremIpsum substrings.
	presenter := self new.
	^ presenter
		  beBoth;
		  add: (SpToolbarButtonPresenter new
				   icon: (self iconNamed: #smallOk);
				   label: 'Simple';
				   action: [ presenter defer: [ presenter inform: 'Pressed' ] ];
				   yourself);
		  add: (SpToolbarButtonPresenter new
				   enabled: false;
				   icon: (self iconNamed: #smallOk);
				   label: 'Disabled';
				   action: [ presenter defer: [ presenter inform: 'Pressed' ] ];
				   yourself);
		  add: (SpToolbarToggleButtonPresenter new
				   icon: (self iconNamed: #smallOk);
				   label: 'Toggle';
				   action: [ :value |
					   presenter defer: [ presenter inform: value asString ] ];
				   yourself);
		  add: ((menuButton := SpToolbarMenuButtonPresenter new)
				   label: 'Menu';
				   icon: (self iconNamed: #smallOk);
				   action: [
					   presenter defer: [ presenter inform: menuButton label ] ];
				   menu: [
					   SpMenuPresenter new
						   addGroup: [ :group |
							   1 to: 10 do: [ :index |
									   group addItem: [ :item |
											   item
												   name: ('{1}: {2}' format: {
																    index.
																    loremIpsumWords atRandom });
												   action: [ menuButton label: item name ] ] ] ];
						   yourself ];
				   yourself);
		  open
]
