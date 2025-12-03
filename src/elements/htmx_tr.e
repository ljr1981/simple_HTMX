note
	description: "HTML tr (table row) element."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_TR

inherit
	HTMX_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "tr"

feature -- Cell Building (fluent)

	th (a_text: READABLE_STRING_GENERAL): like Current
			-- Add header cell with text.
		local
			l_th: HTMX_TH
		do
			create l_th.make
			l_th.text (a_text).do_nothing
			children.extend (l_th)
			Result := Current
		end

	td (a_text: READABLE_STRING_GENERAL): like Current
			-- Add data cell with text.
		local
			l_td: HTMX_TD
		do
			create l_td.make
			l_td.text (a_text).do_nothing
			children.extend (l_td)
			Result := Current
		end

	td_element (a_element: HTMX_ELEMENT): like Current
			-- Add data cell containing an element.
		local
			l_td: HTMX_TD
		do
			create l_td.make
			l_td.containing (a_element).do_nothing
			children.extend (l_td)
			Result := Current
		end

end
