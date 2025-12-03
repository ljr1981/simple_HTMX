note
	description: "HTML th (table header cell) element."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_TH

inherit
	HTMX_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "th"

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

	scope_col: like Current
			-- Set scope to column.
		do
			attributes.force ("col", "scope")
			Result := Current
		end

	scope_row: like Current
			-- Set scope to row.
		do
			attributes.force ("row", "scope")
			Result := Current
		end

end
