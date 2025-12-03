note
	description: "HTML anchor (a) element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_A

inherit
	HTMX_ELEMENT

create
	make,
	make_link

feature {NONE} -- Initialization

	make_link (a_href, a_text: READABLE_STRING_GENERAL)
			-- Create link with href and text.
		do
			make
			attributes.force (a_href.to_string_32, "href")
			content_text := a_text.to_string_32
		end

feature -- Access

	tag_name: STRING = "a"

feature -- Anchor Attributes (fluent)

	href (a_url: READABLE_STRING_GENERAL): like Current
			-- Set href URL.
		do
			attributes.force (a_url.to_string_32, "href")
			Result := Current
		end

	target_blank: like Current
			-- Open in new tab/window.
		do
			attributes.force ("_blank", "target")
			Result := Current
		end

	target_self: like Current
			-- Open in same frame.
		do
			attributes.force ("_self", "target")
			Result := Current
		end

	rel_noopener: like Current
			-- Add rel="noopener" for security with target_blank.
		do
			attributes.force ("noopener", "rel")
			Result := Current
		end

	download: like Current
			-- Trigger download instead of navigation.
		do
			attributes.force ("download", "download")
			Result := Current
		end

	download_as (a_filename: READABLE_STRING_GENERAL): like Current
			-- Trigger download with specific filename.
		do
			attributes.force (a_filename.to_string_32, "download")
			Result := Current
		end

end
