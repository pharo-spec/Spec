# The Spec Handbook

# Table of contents

- [Spec applications](#SpecApplications)
  - [Spec Applications](#SpApplication)
  - [Application Configurations](#SpApplicationConfiguration)
  - [Morphic configurations](#SpMorphicConfiguration)

- [Styles with Morphic backend](#StylesWithMorphicBackend)
  - [Stylesheets for Morphic backend](#SpStyle)
  - [Style classes](#SpStyleClass)
  - [Style properties (SpStyleProperty)](#SpStyleProperty)
  - [Container properties (SpStyleContainer)](#SpStyleContainer)
  - [Draw property (SpStyleDraw)](#SpStyleDraw)
  - [Font property (SpStyleFont)](#SpStyleFont)
  - [Geometry properties (SpStyleGeometry)](#SpStyleGeometry)
  - [A Style in a Morph (SpMorphStyle)](#SpMorphStyle)

- [Simple example Spec application](#SimpleExampleSpecApplication)
  - [A (simple) sample application](#SpSimpleExampleApplication)
  - [A (simple) sample configuration](#SpSimpleExampleConfiguration)
  - [A (simple) sample presenter](#SpSimpleExamplePresenter)
# Spec Applications

A SpApplication is a class that handles many aspects of a Spec Application (hence it's name) in a convenient fashion. 
SpApplication handles your application initialisation, configuration and resources. It also keeps the windows you have currently opened. 
## Initialisation
Initialisation of an application includes (non mandatory): configure the backend you want to use, add useful resources and define a start method that will call your initial window.
### Configure backend
Spec2 includes several backends (for the moment, Morphic and Gtk). A SpApplication configures a Morphic backend by default, but you can change it using `#useBackend:` or `#useBackend:with:` and sending the backend identifier and optionally a configuration (you may want to do specific backend things to configure your application behavior).

See this example: 
```Smalltalk
"This example shows how to change the backend of an application" 
| app |

"You want to subclass SpApplication to create your app"
app := SpApplication new.
app useBackend: #Gtk.
app run
```

see also: [SpApplicationConfiguration](#SpApplicationConfiguration)
### Add resources
During initialisation, you may want to add special resources (like icons, themes, etc.).
While you can add your own way to access resources, SpApplication provides a property registration mechanism (a simple Dictionary and accessors), you may find useful to search at `accessing properties` protocol.
### Defining a start method.
This is useful to give your application a starting window (in general, this is what you want).
Example: 
```Smalltalk
MyApplication>>start

   (self new: MyMainPresenter) openWithSpec
```

# Application Configurations

Tipically, each Spec application will implement one or several configurations (for example, to run on Morphic or Gtk) by extending this class or one of its children. 
A configuration takes the responsibility to prepare an application to run properly. This preparation can be different depending on the platform where it is running, that's why you have several extension points you can extend/override: 

- `configure:` a generic configuration point that normally will dispatch the configuration to a plarform specific method. 
- `configureOSX:`/`configureUnix:`/`configureWindows:` platform specific entry points.

> **TODO:**: Examples of configurations.
see also: [SpMorphicConfiguration](#SpMorphicConfiguration), [SpGtkConfiguration](#SpGtkConfiguration)
# Morphic configurations

Morphic configurations will prepare your application to run in a Morphic backend. Tipically, you will not change much of what is already provided on a Pharo system, but there are several entry points you may want to extend/override: 

- [SpMorphicConfiguration>>#styleSheet](#SpMorphicConfiguration_styleSheet)

## SpMorphicConfiguration >> styleSheet
Define the default styleSheet to use in your application. You can override this and add your 
 own application dependent styles (and you can compose them, see [](SpStyle)).
	
```Smalltalk
^ SpStyle defaultStyleSheet 
```
# Stylesheets for Morphic backend

A style is a property container to "style" morphic components, and define (in a certain degree) its behaviour within the different layouts implemented.
There are two kinds of style elements: style classes and style properties.
## Stylesheet STON format
To easy the definition and storage outside an image, a stylesheet may be defined as a STON file, string or stream, that you can later read using [SpStyleSTONReader](#SpStyleSTONReader).
A defined stylesheet has to have always a root element, and this root element needs to be called `.application`. 
See this small example: 

```Smalltalk
SpStyleSTONReader fromString: '
.application [  
	.myButton [
		Geometry { #width: 150 }
	]
]'
```

As a more complex example, see [SpStyle class>>#createDefaultStyleSheet](#SpStyle class_createDefaultStyleSheet) who defines the default behaviour of all elements of a Morphic Spec backend.
## Referencing style elements in your presenters
You can add styles to your presenters easily by using [class:SpAbstractWidgetPresenter](>#addStyle:)
**TODO**: more examples
See [SpStyleClass](#SpStyleClass), [SpStyleProperty](#SpStyleProperty), [SpMorphStyle](#SpMorphStyle)
## SpAbstractWidgetPresenter >> addStyle:
Add a style-class to a presenter. Styles are defined in the application stylesheet and will 
 affect presenters by applying the properties the user adds to the class.
 - Styles can just be added to widget presenters (the ones that inherits of [](SpAbstractWidgetPresenter)).
 - Styles can be added and removed dynamically (see also [SpAbstractWidgetPresenter](>removeStyle:)
	
```Smalltalk
button := self newButton 
	label: 'Example of style';
	addStyle: 'myButton';
	yourself.
```
# Style classes

A style class define a set of properties grouped by a common name. You can think a style class of morphic a little bit as a style class of CSS, but it has several differences.
 ## Style classes can be nested
You can nest classes to refine some properties. For example, if you have this definition: 

```
.application [
	.button [
		Geometry { #height: 25, #width: 100 }
		.smallButton {
			Geometry { #width: 150 }
		}
	]	
]
```

the result style for a button with "smallButton" style will have a Geometry with the form: `Geometry { #width: 150, #height: 25 }`, which is the result of the merge of all properties, with the deepest nested property taking precedence.
## Style classes are composable
You can compose class styles (stacking them to form a new style). This is an useful practice to add your own styles to the default definition.  

```
myStyle := SpStyle defaultStyleSheet, myOwnStyleDefinition			
```

# Style properties (SpStyleProperty)

Style properties define different kind of properties a morphic component can have. There are several types of properties, defined as: 

- [SpStyleContainer](#SpStyleContainer)
- [SpStyleDraw](#SpStyleDraw)
- [SpStyleFont](#SpStyleFont)
- [SpStyleGeometry](#SpStyleGeometry)

# Container properties (SpStyleContainer)

A container property can be applied to container elements (buttonbar, toolbar, actionbar), and define several properties: 

- borderColor: The color of the border (in case borderWidth > 0). 
- borderWidth: The width of the border.
- padding: The space between elements.

See [SpStyleContainer>>#borderColor](#SpStyleContainer_borderColor)
## Usage
The identifier of container in the stylesheet is `Container`.

```
Container { 
	#borderColor: #blue, 
	#borderWidth: 2,
	#padding: 5
}
```

## SpStyleContainer >> borderColor
This property can be expressed as 
- a STON map: `Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }`
- a named selector: `#red`
- an hex string: `'FF0000'`
# Draw property (SpStyleDraw)

Draw properties control how the component (morph) will be draw.
I keep this properties: 

- color: foreground color for the morph if it applies (if the morph understands #color:).
- backgroundColor: background color if it applies (if the morph understands #backgroundColor:).

See [SpStyleDraw>>#color](#SpStyleDraw_color) and [SpStyleDraw>>#backgroundColor](#SpStyleDraw_backgroundColor)
## Usage
The identifier of draw in the stylesheet is `Draw`.

```
Draw { 
	#color: #red,
	#backgroundColor: '00FF00'
}
```

# Font property (SpStyleFont)

Font properties control how a component (morph) with font will draw the text.
I keep this properties: 

- name: The font name (it needs to be available in the list of fonts, e.g. "Source Code Pro") 
- size: The font point size.
- bold: Font is bold? (boolean, default **false**)
- italic: Font is italic? (boolean, default **false**)

## Usage
The identifier of font in the stylesheet is `Font`.

```
Font { 
 	#name: "Source Sans Pro",  
	#size: 12,
	#bold: false,
	#italic: false
}
```

# Geometry properties (SpStyleGeometry)

Geometry properties controls how the component (morph) will be arranged within its layout.

- hResizing: the component can be resized horizontally? (boolean, default depends on how the morph behaves outside spec)
- vResizing: the component can be resized vertically? (boolean, default depends on how the morph behaves outside spec)
- width: fixed width of the component.
- height: fixed height of the component.
- minWidth: minimum width of the component (to use when `hResizing=true`) 
- minHeight: minimum height of the component (to use when `vResizing=true`) 
- maxWidth: maximum width of the component (to use when `hResizing=true`) 
- maxHeight: maximum height of the component (to use when `vResizing=true`) 

## Usage
The identifier of geometry in the stylesheet is `Geometry`.

```
Geometry { 
	#hResizing: false,
	#vResizing: false,
	#width: 100,
	#height: 25,
	#minWidth: 50,
	#minHeight: 25,
	#maxWidth: 150,
	#maxHeight: 25
}
```

# A Style in a Morph (SpMorphStyle)

This is for internal use of the framework, but it is interesting to notice how it works since it may give some insigts on how to declare things.
At creation of a component, an instance of `SpMorphStyle` is created and by taking the stylesheet it collects styles from most external to more internal. So, for example, this stylesheet: 

```
.application [
	Geometry { #height: 100 }, 
	.button [
		Geometry { #width: 100 }
	]
]
```

Will collect, for a button ([SpButtonPresenter](#SpButtonPresenter), who has a style name `button`), the styles

```
application
application.button
```

This collection will be used to get all properties defined and perform a merge between them ([SpStyleProperty>>#mergeWith:](#SpStyleProperty_mergeWith:)), to get all one single property for each type of them. Which means at the end it will apply a property `Geometry { #width: 100, #height: 25 }`.

# A (simple) sample application

This is the starting point of every Spec application. A subclass of [SpApplication](#SpApplication) who defines how your application will behave and start.
You will need to override `initialize` and `start` methods as a begining.
## SpSimpleExampleApplication >> initialize
The configuration point for this application can be defined here. 
 Sending #useBackend:with: you will declare your application to use a morphic application and 
 use a [](SpSimpleExampleConfiguration) instance as configuration.

```Smalltalk
	self 
		useBackend: #Morphic 
		with: SpSimpleExampleConfiguration new.
```
## SpSimpleExampleApplication >> start
You will declare your initial window here (spec is, after all, a framework to create desktop 
 applications).
	
```Smalltalk
	(self new: SpSimpleExamplePresenter) openWithSpec.
```
	# A (simple) sample configuration

A configuration is needed to define different elements for each different backend.
You do this by extending [SpApplicationConfiguration](#SpApplicationConfiguration) or one of its more specific children ([SpMorphicConfiguration](#SpMorphicConfiguration) and [SpGtkConfiguration](#SpGtkConfiguration)).
See [SpSimpleExampleConfiguration>>#styleSheet](#SpSimpleExampleConfiguration_styleSheet)
## SpSimpleExampleConfiguration >> styleSheet
This method will answer the default stylesheed (provided by calling `super styleSheed`) and 
 it will add a class called `title` to be used by labels.
	
```Smalltalk
^ super styleSheet, (SpStyleSTONReader fromString: '
	.application [
		.label [
			.title [
				Font { #name: ""Source Code Pro"", #size: 24 },
				Draw { #color: #red }
			]
		]	
	]')
```
# A (simple) sample presenter

A simple presenter to show how I can construct and show a window in the context of a Spec application. 
It will show a simple title, a message and a button.

## SpSimpleExamplePresenter class >> defaultSpec
A defaultSpec (@TODO change name for defaultLayout) will define the layout to arrange the
 different elements of this presenter. See [](SpExecutableLayout).
```Smalltalk
^ SpBoxLayout newVertical
	add: #titleLabel;
	add: #messageLabel expand: false;
	add: (SpBoxLayout newHorizontal
			hAlignCenter;
			add: #actionButton;
			yourself)
		expand: false;
	yourself	
```
## SpSimpleExamplePresenter >> initializePresenters
Initialize presenters: you will add your presenters here.
 BEWARE! all your presenters names need to match the name defined in the [SpSimpleExamplePresenter class](>defaultSpec) method.

```Smalltalk
titleLabel := self newLabel
	label: 'A Simple Title';
	addStyle: 'title';
	yourself.
messageLabel := self newLabel 
	label: 'Some message';
	yourself.
actionButton := self newButton 
	label: 'A button';
	action: [  ];
	yourself	
```
## SpSimpleExamplePresenter >> initializeWindow:
A presenter can be composed as part of another presenter. 
 But it can also be shown as a window. 
 Define here the window properties you need (see [](SpWindowPresenter))
	
```Smalltalk
aWindowPresenter 
	title: 'Simple Application';
	initialExtent: 400@400
```
	