note
	description: "HTML textarea element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_TEXTAREA

inherit
	HTMX_ELEMENT

create
	make,
	make_with_name

feature {NONE} -- Initialization

	make_with_name (a_name: READABLE_STRING_GENERAL)
			-- Create textarea with name.
		do
			make
			attributes.force (a_name.to_string_32, "name")
		end

feature -- Access

	tag_name: STRING = "textarea"

feature -- Textarea Attributes (fluent)

	name (a_name: READABLE_STRING_GENERAL): like Current
			-- Set textarea name.
		do
			attributes.force (a_name.to_string_32, "name")
			Result := Current
		end

	rows (a_rows: INTEGER): like Current
			-- Set number of visible rows.
		do
			attributes.force (a_rows.out, "rows")
			Result := Current
		end

	cols (a_cols: INTEGER): like Current
			-- Set number of visible columns.
		do
			attributes.force (a_cols.out, "cols")
			Result := Current
		end

	placeholder (a_placeholder: READABLE_STRING_GENERAL): like Current
			-- Set placeholder text.
		do
			attributes.force (a_placeholder.to_string_32, "placeholder")
			Result := Current
		end

	required: like Current
			-- Mark as required.
		do
			attributes.force ("required", "required")
			Result := Current
		end

	readonly: like Current
			-- Make read-only.
		do
			attributes.force ("readonly", "readonly")
			Result := Current
		end

end
