note
	description: "HTML label element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_LABEL

inherit
	HTMX_ELEMENT

create
	make,
	make_for

feature {NONE} -- Initialization

	make_for (a_for_id: READABLE_STRING_GENERAL)
			-- Create label with for attribute.
		do
			make
			attributes.force (a_for_id.to_string_32, "for")
		end

feature -- Access

	tag_name: STRING = "label"

feature -- Label Attributes (fluent)

	for_id (a_id: READABLE_STRING_GENERAL): like Current
			-- Set for attribute (links to input id).
		do
			attributes.force (a_id.to_string_32, "for")
			Result := Current
		end

end
