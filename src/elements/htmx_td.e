note
	description: "HTML td (table data cell) element."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_TD

inherit
	HTMX_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "td"

feature -- Attributes (fluent)

	colspan (a_span: INTEGER): like Current
			-- Set column span.
		do
			attributes.force (a_span.out, "colspan")
			Result := Current
		end

	rowspan (a_span: INTEGER): like Current
			-- Set row span.
		do
			attributes.force (a_span.out, "rowspan")
			Result := Current
		end

end
