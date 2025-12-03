note
	description: "HTML input element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_INPUT

inherit
	HTMX_ELEMENT
		redefine
			is_void_element
		end

create
	make,
	make_text,
	make_hidden

feature {NONE} -- Initialization

	make_text (a_name: READABLE_STRING_GENERAL)
			-- Create text input with name.
		do
			make
			attributes.force ("text", "type")
			attributes.force (a_name.to_string_32, "name")
		end

	make_hidden (a_name, a_value: READABLE_STRING_GENERAL)
			-- Create hidden input with name and value.
		do
			make
			attributes.force ("hidden", "type")
			attributes.force (a_name.to_string_32, "name")
			attributes.force (a_value.to_string_32, "value")
		end

feature -- Access

	tag_name: STRING = "input"

	is_void_element: BOOLEAN = True

feature -- Input Attributes (fluent)

	name (a_name: READABLE_STRING_GENERAL): like Current
			-- Set input name.
		do
			attributes.force (a_name.to_string_32, "name")
			Result := Current
		end

	value (a_value: READABLE_STRING_GENERAL): like Current
			-- Set input value.
		do
			attributes.force (a_value.to_string_32, "value")
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

	autofocus: like Current
			-- Set autofocus.
		do
			attributes.force ("autofocus", "autofocus")
			Result := Current
		end

feature -- Input Types (fluent)

	type_text: like Current
			-- Set type to text.
		do
			attributes.force ("text", "type")
			Result := Current
		end

	type_password: like Current
			-- Set type to password.
		do
			attributes.force ("password", "type")
			Result := Current
		end

	type_email: like Current
			-- Set type to email.
		do
			attributes.force ("email", "type")
			Result := Current
		end

	type_number: like Current
			-- Set type to number.
		do
			attributes.force ("number", "type")
			Result := Current
		end

	type_hidden: like Current
			-- Set type to hidden.
		do
			attributes.force ("hidden", "type")
			Result := Current
		end

	type_checkbox: like Current
			-- Set type to checkbox.
		do
			attributes.force ("checkbox", "type")
			Result := Current
		end

	type_radio: like Current
			-- Set type to radio.
		do
			attributes.force ("radio", "type")
			Result := Current
		end

	type_file: like Current
			-- Set type to file.
		do
			attributes.force ("file", "type")
			Result := Current
		end

	type_date: like Current
			-- Set type to date.
		do
			attributes.force ("date", "type")
			Result := Current
		end

	type_submit: like Current
			-- Set type to submit.
		do
			attributes.force ("submit", "type")
			Result := Current
		end

feature -- Validation Attributes (fluent)

	min (a_value: READABLE_STRING_GENERAL): like Current
			-- Set minimum value.
		do
			attributes.force (a_value.to_string_32, "min")
			Result := Current
		end

	max (a_value: READABLE_STRING_GENERAL): like Current
			-- Set maximum value.
		do
			attributes.force (a_value.to_string_32, "max")
			Result := Current
		end

	minlength (a_length: INTEGER): like Current
			-- Set minimum length.
		do
			attributes.force (a_length.out, "minlength")
			Result := Current
		end

	maxlength (a_length: INTEGER): like Current
			-- Set maximum length.
		do
			attributes.force (a_length.out, "maxlength")
			Result := Current
		end

	pattern (a_regex: READABLE_STRING_GENERAL): like Current
			-- Set validation pattern (regex).
		do
			attributes.force (a_regex.to_string_32, "pattern")
			Result := Current
		end

	checked: like Current
			-- Mark checkbox/radio as checked.
		do
			attributes.force ("checked", "checked")
			Result := Current
		end

end
