note
	description: "HTML br (line break) element."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_BR

inherit
	HTMX_ELEMENT
		redefine
			is_void_element
		end

create
	make

feature -- Access

	tag_name: STRING = "br"

	is_void_element: BOOLEAN = True

end
