note
	description: "HTML form element with HTMX support."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_FORM

inherit
	HTMX_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "form"

feature -- Form Attributes (fluent)

	action (a_url: READABLE_STRING_GENERAL): like Current
			-- Set form action URL.
		do
			attributes.force (a_url.to_string_32, "action")
			Result := Current
		end

	method_get: like Current
			-- Set method to GET.
		do
			attributes.force ("get", "method")
			Result := Current
		end

	method_post: like Current
			-- Set method to POST.
		do
			attributes.force ("post", "method")
			Result := Current
		end

	enctype_multipart: like Current
			-- Set enctype for file uploads.
		do
			attributes.force ("multipart/form-data", "enctype")
			Result := Current
		end

	novalidate: like Current
			-- Disable HTML5 validation.
		do
			attributes.force ("novalidate", "novalidate")
			Result := Current
		end

end
