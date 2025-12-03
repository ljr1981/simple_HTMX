note
	description: "HTML span element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_SPAN

inherit
	HTMX_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "span"

end
