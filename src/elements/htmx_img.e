note
	description: "HTML img element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_IMG

inherit
	HTMX_ELEMENT
		redefine
			is_void_element
		end

create
	make,
	make_src

feature {NONE} -- Initialization

	make_src (a_src, a_alt: READABLE_STRING_GENERAL)
			-- Create image with src and alt text.
		do
			make
			attributes.force (a_src.to_string_32, "src")
			attributes.force (a_alt.to_string_32, "alt")
		end

feature -- Access

	tag_name: STRING = "img"

	is_void_element: BOOLEAN = True

feature -- Image Attributes (fluent)

	src (a_url: READABLE_STRING_GENERAL): like Current
			-- Set image source URL.
		do
			attributes.force (a_url.to_string_32, "src")
			Result := Current
		end

	alt (a_text: READABLE_STRING_GENERAL): like Current
			-- Set alt text.
		do
			attributes.force (a_text.to_string_32, "alt")
			Result := Current
		end

	width (a_width: INTEGER): like Current
			-- Set width in pixels.
		do
			attributes.force (a_width.out, "width")
			Result := Current
		end

	height (a_height: INTEGER): like Current
			-- Set height in pixels.
		do
			attributes.force (a_height.out, "height")
			Result := Current
		end

	loading_lazy: like Current
			-- Enable lazy loading.
		do
			attributes.force ("lazy", "loading")
			Result := Current
		end

end
