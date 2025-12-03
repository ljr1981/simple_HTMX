note
	description: "[
		Base class for all HTML/HTMX elements.

		Provides fluent interface for building HTML with HTMX attributes.

		Example:
			l_div := create {HTMX_DIV}.make
			l_div.id ("my-div").class_ ("container").hx_get ("/api/data").hx_target ("#result")
			print (l_div.to_html)
			-- Output: <div id="my-div" class="container" hx-get="/api/data" hx-target="#result"></div>
	]"
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTMX_ELEMENT

feature {NONE} -- Initialization

	make
			-- Create empty element.
		do
			create attributes.make (10)
			create classes.make (5)
			create children.make (10)
			create content_text.make_empty
		ensure
			attributes_created: attributes /= Void
			classes_created: classes /= Void
			children_created: children /= Void
		end

feature -- Access

	tag_name: STRING
			-- HTML tag name (div, span, button, etc.)
		deferred
		ensure
			result_not_empty: not Result.is_empty
		end

	is_void_element: BOOLEAN
			-- Is this a void element (no closing tag)?
			-- Examples: input, br, hr, img, meta, link
		do
			Result := False
		end

feature -- Attributes

	attributes: HASH_TABLE [STRING_32, STRING]
			-- All attributes (name -> value).

	classes: ARRAYED_LIST [STRING]
			-- CSS classes.

	children: ARRAYED_LIST [HTMX_ELEMENT]
			-- Child elements.

	content_text: STRING_32
			-- Text content (if no children).

feature -- Standard HTML Attributes (fluent)

	id (a_id: READABLE_STRING_GENERAL): like Current
			-- Set the id attribute.
		do
			attributes.force (a_id.to_string_32, "id")
			Result := Current
		ensure
			id_set: attached attributes.item ("id") as l_id and then l_id.same_string_general (a_id)
		end

	class_ (a_class: READABLE_STRING_GENERAL): like Current
			-- Add a CSS class.
		do
			classes.extend (a_class.to_string_8)
			Result := Current
		ensure
			class_added: classes.has (a_class.to_string_8)
		end

	classes_from (a_classes: READABLE_STRING_GENERAL): like Current
			-- Add multiple CSS classes from space-separated string.
		local
			l_parts: LIST [STRING_32]
		do
			l_parts := a_classes.to_string_32.split (' ')
			across l_parts as c loop
				if not c.is_empty then
					classes.extend (c.to_string_8)
				end
			end
			Result := Current
		end

	attr (a_name: STRING; a_value: READABLE_STRING_GENERAL): like Current
			-- Set an arbitrary attribute.
		require
			name_not_empty: not a_name.is_empty
		do
			attributes.force (a_value.to_string_32, a_name)
			Result := Current
		ensure
			attribute_set: attached attributes.item (a_name)
		end

	data (a_name: STRING; a_value: READABLE_STRING_GENERAL): like Current
			-- Set a data-* attribute.
		require
			name_not_empty: not a_name.is_empty
		do
			attributes.force (a_value.to_string_32, "data-" + a_name)
			Result := Current
		ensure
			data_attribute_set: attached attributes.item ("data-" + a_name)
		end

	style (a_style: READABLE_STRING_GENERAL): like Current
			-- Set inline style.
		do
			attributes.force (a_style.to_string_32, "style")
			Result := Current
		end

	title (a_title: READABLE_STRING_GENERAL): like Current
			-- Set title attribute (tooltip).
		do
			attributes.force (a_title.to_string_32, "title")
			Result := Current
		end

	disabled: like Current
			-- Add disabled attribute.
		do
			attributes.force ("disabled", "disabled")
			Result := Current
		end

	hidden: like Current
			-- Add hidden attribute.
		do
			attributes.force ("hidden", "hidden")
			Result := Current
		end

feature -- HTMX Attributes (fluent)

	hx_get (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-get attribute for AJAX GET request.
		do
			attributes.force (a_url.to_string_32, "hx-get")
			Result := Current
		end

	hx_post (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-post attribute for AJAX POST request.
		do
			attributes.force (a_url.to_string_32, "hx-post")
			Result := Current
		end

	hx_put (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-put attribute for AJAX PUT request.
		do
			attributes.force (a_url.to_string_32, "hx-put")
			Result := Current
		end

	hx_patch (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-patch attribute for AJAX PATCH request.
		do
			attributes.force (a_url.to_string_32, "hx-patch")
			Result := Current
		end

	hx_delete (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-delete attribute for AJAX DELETE request.
		do
			attributes.force (a_url.to_string_32, "hx-delete")
			Result := Current
		end

	hx_target (a_selector: READABLE_STRING_GENERAL): like Current
			-- Set hx-target attribute (CSS selector for response target).
		do
			attributes.force (a_selector.to_string_32, "hx-target")
			Result := Current
		end

	hx_swap (a_mode: READABLE_STRING_GENERAL): like Current
			-- Set hx-swap attribute (how to swap content).
			-- Values: innerHTML, outerHTML, beforebegin, afterbegin, beforeend, afterend, delete, none
		do
			attributes.force (a_mode.to_string_32, "hx-swap")
			Result := Current
		end

	hx_swap_inner_html: like Current
			-- Set hx-swap to innerHTML (replace inner content).
		do
			Result := hx_swap ("innerHTML")
		end

	hx_swap_outer_html: like Current
			-- Set hx-swap to outerHTML (replace entire element).
		do
			Result := hx_swap ("outerHTML")
		end

	hx_swap_before_end: like Current
			-- Set hx-swap to beforeend (append inside).
		do
			Result := hx_swap ("beforeend")
		end

	hx_swap_after_end: like Current
			-- Set hx-swap to afterend (insert after).
		do
			Result := hx_swap ("afterend")
		end

	hx_swap_delete: like Current
			-- Set hx-swap to delete (remove element).
		do
			Result := hx_swap ("delete")
		end

	hx_swap_none: like Current
			-- Set hx-swap to none (don't swap, just trigger events).
		do
			Result := hx_swap ("none")
		end

	hx_trigger (a_event: READABLE_STRING_GENERAL): like Current
			-- Set hx-trigger attribute (when to send request).
			-- Examples: click, change, submit, load, revealed, every 2s
		do
			attributes.force (a_event.to_string_32, "hx-trigger")
			Result := Current
		end

	hx_trigger_click: like Current
			-- Set hx-trigger to click.
		do
			Result := hx_trigger ("click")
		end

	hx_trigger_change: like Current
			-- Set hx-trigger to change.
		do
			Result := hx_trigger ("change")
		end

	hx_trigger_submit: like Current
			-- Set hx-trigger to submit.
		do
			Result := hx_trigger ("submit")
		end

	hx_trigger_load: like Current
			-- Set hx-trigger to load (fire on page load).
		do
			Result := hx_trigger ("load")
		end

	hx_indicator (a_selector: READABLE_STRING_GENERAL): like Current
			-- Set hx-indicator attribute (loading indicator selector).
		do
			attributes.force (a_selector.to_string_32, "hx-indicator")
			Result := Current
		end

	hx_confirm (a_message: READABLE_STRING_GENERAL): like Current
			-- Set hx-confirm attribute (confirmation dialog).
		do
			attributes.force (a_message.to_string_32, "hx-confirm")
			Result := Current
		end

	hx_disable: like Current
			-- Set hx-disable attribute (disable element during request).
		do
			attributes.force ("true", "hx-disable")
			Result := Current
		end

	hx_vals (a_json: READABLE_STRING_GENERAL): like Current
			-- Set hx-vals attribute (additional values to submit as JSON).
		do
			attributes.force (a_json.to_string_32, "hx-vals")
			Result := Current
		end

	hx_include (a_selector: READABLE_STRING_GENERAL): like Current
			-- Set hx-include attribute (include additional elements in request).
		do
			attributes.force (a_selector.to_string_32, "hx-include")
			Result := Current
		end

	hx_select (a_selector: READABLE_STRING_GENERAL): like Current
			-- Set hx-select attribute (select part of response to swap).
		do
			attributes.force (a_selector.to_string_32, "hx-select")
			Result := Current
		end

	hx_push_url (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-push-url attribute (push URL to history).
		do
			attributes.force (a_url.to_string_32, "hx-push-url")
			Result := Current
		end

	hx_push_url_true: like Current
			-- Set hx-push-url to true (push request URL to history).
		do
			Result := hx_push_url ("true")
		end

feature -- Content (fluent)

	text (a_text: READABLE_STRING_GENERAL): like Current
			-- Set text content.
		do
			content_text := a_text.to_string_32
			Result := Current
		end

	containing (a_child: HTMX_ELEMENT): like Current
			-- Add a child element.
		require
			not_void_element: not is_void_element
		do
			children.extend (a_child)
			Result := Current
		ensure
			child_added: children.has (a_child)
		end

	with_children (a_children: ARRAY [HTMX_ELEMENT]): like Current
			-- Add multiple child elements.
		require
			not_void_element: not is_void_element
		do
			across a_children as c loop
				children.extend (c)
			end
			Result := Current
		end

	raw_html (a_html: READABLE_STRING_GENERAL): like Current
			-- Set raw HTML content (use with caution - no escaping).
		do
			content_text := a_html.to_string_32
			Result := Current
		end

feature -- Output

	to_html: STRING_32
			-- Generate HTML string.
		do
			create Result.make (500)
			Result.append_character ('<')
			Result.append_string_general (tag_name)
			append_attributes (Result)
			if is_void_element then
				Result.append_string_general ("/>")
			else
				Result.append_character ('>')
				append_content (Result)
				Result.append_string_general ("</")
				Result.append_string_general (tag_name)
				Result.append_character ('>')
			end
		ensure
			result_not_void: Result /= Void
		end

	to_html_8: STRING_8
			-- Generate HTML string as STRING_8.
		do
			Result := to_html.to_string_8
		end

feature {NONE} -- Implementation

	append_attributes (a_buffer: STRING_32)
			-- Append all attributes to buffer.
		local
			l_class_str: STRING
		do
			-- Handle classes specially
			if not classes.is_empty then
				a_buffer.append_string_general (" class=%"")
				create l_class_str.make (50)
				across classes as c loop
					if not l_class_str.is_empty then
						l_class_str.append_character (' ')
					end
					l_class_str.append (c)
				end
				a_buffer.append_string_general (l_class_str)
				a_buffer.append_character ('"')
			end
			-- Add other attributes
			across attributes as a loop
				a_buffer.append_character (' ')
				a_buffer.append_string_general (attributes.key_for_iteration)
				a_buffer.append_string_general ("=%"")
				a_buffer.append (escape_html (a))
				a_buffer.append_character ('"')
			end
		end

	append_content (a_buffer: STRING_32)
			-- Append content (text or children) to buffer.
		do
			if not children.is_empty then
				across children as c loop
					a_buffer.append (c.to_html)
				end
			elseif not content_text.is_empty then
				a_buffer.append (content_text)
			end
		end

	escape_html (a_text: STRING_32): STRING_32
			-- Escape HTML special characters in attribute values.
		do
			create Result.make (a_text.count + 10)
			across a_text as c loop
				inspect c
				when '&' then Result.append_string_general ("&amp;")
				when '<' then Result.append_string_general ("&lt;")
				when '>' then Result.append_string_general ("&gt;")
				when '"' then Result.append_string_general ("&quot;")
				else Result.append_character (c)
				end
			end
		end

invariant
	attributes_attached: attributes /= Void
	classes_attached: classes /= Void
	children_attached: children /= Void

end
