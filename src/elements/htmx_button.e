note
	description: "HTML button element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_BUTTON

inherit
	HTMX_ELEMENT

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: READABLE_STRING_GENERAL)
			-- Create button with text.
		do
			make
			content_text := a_text.to_string_32
		end

feature -- Access

	tag_name: STRING = "button"

feature -- Button Attributes (fluent)

	type_submit: like Current
			-- Set type to submit.
		do
			attributes.force ("submit", "type")
			Result := Current
		end

	type_button: like Current
			-- Set type to button.
		do
			attributes.force ("button", "type")
			Result := Current
		end

	type_reset: like Current
			-- Set type to reset.
		do
			attributes.force ("reset", "type")
			Result := Current
		end

end
