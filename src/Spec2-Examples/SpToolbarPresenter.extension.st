Extension { #name : #SpToolbarPresenter }

{ #category : #'*Spec2-Examples' }
SpToolbarPresenter class >> example [
	| loremIpsumWords menuButton |
	
	loremIpsumWords := String loremIpsum substrings.
	^ SpToolbarPresenter new 
		beBoth;
		addItem: (SpToolbarButtonPresenter new 
			icon: (self iconNamed: #smallOk);
			label: 'Simple';
			action: [ UIManager default defer: [ self inform: 'Pressed' ] ];
			yourself);
		addItem: (SpToolbarToggleButtonPresenter new
			icon: (self iconNamed: #smallOk);
			label: 'Toggle';
			action: [ :value | UIManager default defer: [ self inform: value asString ] ];
			yourself);
		addItem: ((menuButton := SpToolbarMenuButtonPresenter new)
			label: 'Menu';
			icon: (self iconNamed: #smallOk);
			action: [ UIManager default defer: [ self inform: menuButton label ] ];
			menu: [ 
				SpMenuPresenter new
					addGroup: [ :group | group
						addItem: [ :item | item 
							name: '1: ', loremIpsumWords atRandom;
							action: [ menuButton label: item name ] ];
						addItem: [ :item | item 
							name: '2: ', loremIpsumWords atRandom;
							action: [ menuButton label: item name ] ];
						addItem: [ :item | item 
							name: '3: ', loremIpsumWords atRandom;
							action: [ menuButton label: item name ] ] ];
					yourself ];
			yourself);
		openWithSpec
]
