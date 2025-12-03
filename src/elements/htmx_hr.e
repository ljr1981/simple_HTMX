note
	description: "HTML hr (horizontal rule) element."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_HR

inherit
	HTMX_ELEMENT
		redefine
			is_void_element
		end

create
	make

feature -- Access

	tag_name: STRING = "hr"

	is_void_element: BOOLEAN = True

end
