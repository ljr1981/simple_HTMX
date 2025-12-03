note
	description: "HTML table element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_TABLE

inherit
	HTMX_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "table"

feature -- Table Building (fluent)

	thead: like Current
			-- Add thead and return Current for chaining.
			-- Access last added element via `last_section`.
		local
			l_thead: HTMX_THEAD
		do
			create l_thead.make
			children.extend (l_thead)
			last_section := l_thead
			Result := Current
		end

	tbody: like Current
			-- Add tbody and return Current for chaining.
		local
			l_tbody: HTMX_TBODY
		do
			create l_tbody.make
			children.extend (l_tbody)
			last_section := l_tbody
			Result := Current
		end

	tfoot: like Current
			-- Add tfoot and return Current for chaining.
		local
			l_tfoot: HTMX_TFOOT
		do
			create l_tfoot.make
			children.extend (l_tfoot)
			last_section := l_tfoot
			Result := Current
		end

feature -- Access

	last_section: detachable HTMX_ELEMENT
			-- Last added section (thead, tbody, tfoot).

end
