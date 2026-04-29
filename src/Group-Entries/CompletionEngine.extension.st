Extension { #name : 'CompletionEngine' }

{ #category : '*Group-Entries' }
CompletionEngine >> handleKeyDownBefore: aKeyboardEvent editor: anEditor [
	"I return a boolean.
	true when I have handled the event and no futher processing is needed by the caller.

	This method would be cleaner if splitted."

	| key |
	self setEditor: anEditor.
	key := aKeyboardEvent key.

	(self isMenuOpen not and: [
		 self editor atCompletionPosition and: [ NECPreferences popupShowWithShortcut matches: { aKeyboardEvent } ] ]) ifTrue: [
			aKeyboardEvent supressNextKeyPress: true.
			self openMenu.
			^ true ].

	key = KeyboardKey backspace ifTrue: [ self smartBackspace ifTrue: [ ^ true ] ].

	self isMenuOpen ifFalse: [ ^ false ].

	({
		 KeyboardKey left.
		 KeyboardKey keypadLeft } includes: key) ifTrue: [
			menuMorph leaveGroup ifTrue: [ ^ true ].
			^ false ].

	({
		 KeyboardKey right.
		 KeyboardKey keypadRight } includes: key) ifTrue: [
			menuMorph insertSelected ifTrue: [ ^ true ].
			^ false ].

	({
		 KeyboardKey up.
		 KeyboardKey keypadUp } includes: key) ifTrue: [
			menuMorph moveUp.
			^ true ].

	({
		 KeyboardKey down.
		 KeyboardKey keypadDown } includes: key) ifTrue: [
			menuMorph moveDown.
			^ true ].

	key = KeyboardKey pageUp ifTrue: [
			menuMorph pageUp.
			^ true ].

	key = KeyboardKey pageDown ifTrue: [
			menuMorph pageDown.
			^ true ].

	((key = KeyboardKey enter or: [ key = KeyboardKey keypadEnter ]) and: [ NECPreferences useEnterToAccept ]) ifTrue: [
		menuMorph insertSelected ifTrue: [ ^ true ] ].

	key = KeyboardKey tab ifTrue: [
		menuMorph insertSelected ifTrue: [ ^ true ] ].

	key = KeyboardKey backspace ifTrue: [
			editor isCaretBehindChar ifFalse: [ self closeMenu ].
			^ false ].

	key = KeyboardKey escape ifTrue: [
			self closeMenu.
			^ true ].

	^ false
]
