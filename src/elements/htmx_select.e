note
	description: "HTML select element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_SELECT

inherit
	HTMX_ELEMENT

create
	make,
	make_with_name

feature {NONE} -- Initialization

	make_with_name (a_name: READABLE_STRING_GENERAL)
			-- Create select with name.
		do
			make
			attributes.force (a_name.to_string_32, "name")
		end

feature -- Access

	tag_name: STRING = "select"

feature -- Select Attributes (fluent)

	name (a_name: READABLE_STRING_GENERAL): like Current
			-- Set select name.
		do
			attributes.force (a_name.to_string_32, "name")
			Result := Current
		end

	multiple: like Current
			-- Allow multiple selections.
		do
			attributes.force ("multiple", "multiple")
			Result := Current
		end

	required: like Current
			-- Mark as required.
		do
			attributes.force ("required", "required")
			Result := Current
		end

	size (a_size: INTEGER): like Current
			-- Set number of visible options.
		do
			attributes.force (a_size.out, "size")
			Result := Current
		end

feature -- Options

	option (a_value, a_text: READABLE_STRING_GENERAL): like Current
			-- Add an option.
		local
			l_option: HTMX_OPTION
		do
			create l_option.make_with_value (a_value, a_text)
			children.extend (l_option)
			Result := Current
		end

	option_selected (a_value, a_text: READABLE_STRING_GENERAL): like Current
			-- Add a selected option.
		local
			l_option: HTMX_OPTION
		do
			create l_option.make_with_value (a_value, a_text)
			l_option.selected.do_nothing
			children.extend (l_option)
			Result := Current
		end

end
