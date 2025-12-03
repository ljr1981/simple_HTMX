note
	description: "HTML option element for select elements."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_OPTION

inherit
	HTMX_ELEMENT

create
	make,
	make_with_value

feature {NONE} -- Initialization

	make_with_value (a_value, a_text: READABLE_STRING_GENERAL)
			-- Create option with value and display text.
		do
			make
			attributes.force (a_value.to_string_32, "value")
			content_text := a_text.to_string_32
		end

feature -- Access

	tag_name: STRING = "option"

feature -- Option Attributes (fluent)

	value (a_value: READABLE_STRING_GENERAL): like Current
			-- Set option value.
		do
			attributes.force (a_value.to_string_32, "value")
			Result := Current
		end

	selected: like Current
			-- Mark as selected.
		do
			attributes.force ("selected", "selected")
			Result := Current
		end

end
