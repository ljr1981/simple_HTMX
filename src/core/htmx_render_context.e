note
	description: "[
		Render context for HTMX applications.

		Provides URL/path building for HTMX attributes, eliminating
		the need to pass spec_id, screen_id, etc. through every method.

		Example:
			ctx := create {HTMX_RENDER_CONTEXT}.make ("/api")
			ctx.resource ("specs", "my-app").resource ("screens", "main")

			-- Now generate URLs:
			ctx.url                        -- "/api/specs/my-app/screens/main"
			ctx.url_for ("controls")       -- "/api/specs/my-app/screens/main/controls"
			ctx.url_for_id ("controls", "btn1")  -- "/api/specs/my-app/screens/main/controls/btn1"

			-- Use in elements:
			html.button ("Save").hx_post (ctx.url_for ("save"))
	]"
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	HTMX_RENDER_CONTEXT

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (a_base_path: READABLE_STRING_GENERAL)
			-- Create context with base API path.
		do
			base_path := a_base_path.to_string_32
			create path_segments.make (5)
		ensure
			base_path_set: base_path.same_string_general (a_base_path)
		end

	make_empty
			-- Create context with no base path.
		do
			create base_path.make_empty
			create path_segments.make (5)
		end

feature -- Access

	base_path: STRING_32
			-- Base API path (e.g., "/api").

	path_segments: ARRAYED_LIST [TUPLE [resource_type: STRING_32; resource_id: STRING_32]]
			-- Accumulated path segments.

feature -- Path Building (fluent)

	resource (a_type: READABLE_STRING_GENERAL; a_id: READABLE_STRING_GENERAL): like Current
			-- Add a resource segment (e.g., "specs", "my-app").
		do
			path_segments.extend ([a_type.to_string_32, a_id.to_string_32])
			Result := Current
		end

	with_spec (a_spec_id: READABLE_STRING_GENERAL): like Current
			-- Add specs/{id} segment.
		do
			Result := resource ("specs", a_spec_id)
		end

	with_screen (a_screen_id: READABLE_STRING_GENERAL): like Current
			-- Add screens/{id} segment.
		do
			Result := resource ("screens", a_screen_id)
		end

	with_control (a_control_id: READABLE_STRING_GENERAL): like Current
			-- Add controls/{id} segment.
		do
			Result := resource ("controls", a_control_id)
		end

feature -- URL Generation

	url: STRING_32
			-- Generate full URL from accumulated segments.
		do
			create Result.make (100)
			Result.append (base_path)
			across path_segments as seg loop
				Result.append_character ('/')
				Result.append (seg.resource_type)
				Result.append_character ('/')
				Result.append (seg.resource_id)
			end
		ensure
			result_not_void: Result /= Void
		end

	url_8: STRING_8
			-- Generate full URL as STRING_8.
		do
			Result := url.to_string_8
		end

	url_for (a_action: READABLE_STRING_GENERAL): STRING_32
			-- Generate URL with additional action/endpoint.
		do
			Result := url
			Result.append_character ('/')
			Result.append_string_general (a_action)
		end

	url_for_8 (a_action: READABLE_STRING_GENERAL): STRING_8
			-- Generate URL with action as STRING_8.
		do
			Result := url_for (a_action).to_string_8
		end

	url_for_id (a_resource: READABLE_STRING_GENERAL; a_id: READABLE_STRING_GENERAL): STRING_32
			-- Generate URL with resource type and ID.
		do
			Result := url
			Result.append_character ('/')
			Result.append_string_general (a_resource)
			Result.append_character ('/')
			Result.append_string_general (a_id)
		end

	url_for_id_8 (a_resource: READABLE_STRING_GENERAL; a_id: READABLE_STRING_GENERAL): STRING_8
			-- Generate URL with resource and ID as STRING_8.
		do
			Result := url_for_id (a_resource, a_id).to_string_8
		end

feature -- Convenience for Common Patterns

	controls_url: STRING_32
			-- URL for controls collection.
		do
			Result := url_for ("controls")
		end

	control_url (a_id: READABLE_STRING_GENERAL): STRING_32
			-- URL for specific control.
		do
			Result := url_for_id ("controls", a_id)
		end

	properties_url (a_control_id: READABLE_STRING_GENERAL): STRING_32
			-- URL for control properties (common HTMX pattern).
		do
			Result := url
			Result.append_string_general ("/properties/")
			Result.append_string_general (a_control_id)
		end

feature -- Duplication

	twin_context: like Current
			-- Create a copy of this context for branching.
		do
			create Result.make (base_path)
			across path_segments as seg loop
				Result.path_segments.extend (seg)
			end
		end

	child (a_type: READABLE_STRING_GENERAL; a_id: READABLE_STRING_GENERAL): like Current
			-- Create child context with additional segment (doesn't modify Current).
		do
			Result := twin_context
			Result.resource (a_type, a_id).do_nothing
		end

feature -- Target Selectors

	target_id (a_id: READABLE_STRING_GENERAL): STRING_32
			-- Generate CSS ID selector (#id).
		do
			create Result.make (a_id.count + 1)
			Result.append_character ('#')
			Result.append_string_general (a_id)
		end

	target_class (a_class: READABLE_STRING_GENERAL): STRING_32
			-- Generate CSS class selector (.class).
		do
			create Result.make (a_class.count + 1)
			Result.append_character ('.')
			Result.append_string_general (a_class)
		end

invariant
	base_path_attached: base_path /= Void
	segments_attached: path_segments /= Void

end
