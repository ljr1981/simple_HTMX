note
	description: "HTML ol (ordered list) element."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_OL

inherit
	HTMX_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "ol"

feature -- List Building (fluent)

	li (a_text: READABLE_STRING_GENERAL): like Current
			-- Add list item with text.
		local
			l_li: HTMX_LI
		do
			create l_li.make
			l_li.text (a_text).do_nothing
			children.extend (l_li)
			Result := Current
		end

	li_element (a_element: HTMX_ELEMENT): like Current
			-- Add list item containing an element.
		local
			l_li: HTMX_LI
		do
			create l_li.make
			l_li.containing (a_element).do_nothing
			children.extend (l_li)
			Result := Current
		end

feature -- Attributes (fluent)

	start (a_start: INTEGER): like Current
			-- Set starting number.
		do
			attributes.force (a_start.out, "start")
			Result := Current
		end

	reversed: like Current
			-- Reverse the numbering.
		do
			attributes.force ("reversed", "reversed")
			Result := Current
		end

end
