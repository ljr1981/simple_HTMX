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
			create raw_attributes.make (5)
			create classes.make (5)
			create children.make (10)
			create content_text.make_empty
		ensure
			attributes_created: attributes /= Void
			raw_attributes_created: raw_attributes /= Void
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

	raw_attributes: HASH_TABLE [STRING_32, STRING]
			-- Attributes with raw values (no HTML escaping).
			-- Used for JavaScript expressions containing <, >, &, etc.

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
			fluent_result: Result = Current
			id_set: attached attributes.item ("id") as l_id and then l_id.same_string_general (a_id)
		end

	class_ (a_class: READABLE_STRING_GENERAL): like Current
			-- Add a CSS class.
		do
			classes.extend (a_class.to_string_8)
			Result := Current
		ensure
			fluent_result: Result = Current
			class_added: classes.has (a_class.to_string_8)
			count_increased: classes.count = old classes.count + 1
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
		ensure
			fluent_result: Result = Current
		end

	attr (a_name: STRING; a_value: READABLE_STRING_GENERAL): like Current
			-- Set an arbitrary attribute.
		require
			name_not_empty: not a_name.is_empty
		do
			attributes.force (a_value.to_string_32, a_name)
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item (a_name) as v and then v.same_string (a_value.to_string_32)
		end

	data (a_name: STRING; a_value: READABLE_STRING_GENERAL): like Current
			-- Set a data-* attribute.
		require
			name_not_empty: not a_name.is_empty
		do
			attributes.force (a_value.to_string_32, "data-" + a_name)
			Result := Current
		ensure
			fluent_result: Result = Current
			data_attribute_set: attached attributes.item ("data-" + a_name) as v and then v.same_string (a_value.to_string_32)
		end

	attr_raw (a_name: STRING; a_value: READABLE_STRING_GENERAL): like Current
			-- Set an arbitrary attribute with raw value (no HTML escaping).
			-- Use for JavaScript expressions containing <, >, &, =>, &&, etc.
		require
			name_not_empty: not a_name.is_empty
		do
			raw_attributes.force (a_value.to_string_32, a_name)
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached raw_attributes.item (a_name) as v and then v.same_string (a_value.to_string_32)
		end

	style (a_style: READABLE_STRING_GENERAL): like Current
			-- Set inline style.
		do
			attributes.force (a_style.to_string_32, "style")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("style") as v and then v.same_string (a_style.to_string_32)
		end

	title (a_title: READABLE_STRING_GENERAL): like Current
			-- Set title attribute (tooltip).
		do
			attributes.force (a_title.to_string_32, "title")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("title") as v and then v.same_string (a_title.to_string_32)
		end

	disabled: like Current
			-- Add disabled attribute.
		do
			attributes.force ("disabled", "disabled")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attributes.has ("disabled")
		end

	hidden: like Current
			-- Add hidden attribute.
		do
			attributes.force ("hidden", "hidden")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attributes.has ("hidden")
		end

feature -- HTMX Attributes (fluent)

	hx_get (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-get attribute for AJAX GET request.
		do
			attributes.force (a_url.to_string_32, "hx-get")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-get") as v and then v.same_string (a_url.to_string_32)
		end

	hx_post (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-post attribute for AJAX POST request.
		do
			attributes.force (a_url.to_string_32, "hx-post")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-post") as v and then v.same_string (a_url.to_string_32)
		end

	hx_put (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-put attribute for AJAX PUT request.
		do
			attributes.force (a_url.to_string_32, "hx-put")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-put") as v and then v.same_string (a_url.to_string_32)
		end

	hx_patch (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-patch attribute for AJAX PATCH request.
		do
			attributes.force (a_url.to_string_32, "hx-patch")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-patch") as v and then v.same_string (a_url.to_string_32)
		end

	hx_delete (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-delete attribute for AJAX DELETE request.
		do
			attributes.force (a_url.to_string_32, "hx-delete")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-delete") as v and then v.same_string (a_url.to_string_32)
		end

	hx_target (a_selector: READABLE_STRING_GENERAL): like Current
			-- Set hx-target attribute (CSS selector for response target).
		do
			attributes.force (a_selector.to_string_32, "hx-target")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-target") as v and then v.same_string (a_selector.to_string_32)
		end

	hx_swap (a_mode: READABLE_STRING_GENERAL): like Current
			-- Set hx-swap attribute (how to swap content).
			-- Values: innerHTML, outerHTML, beforebegin, afterbegin, beforeend, afterend, delete, none
		do
			attributes.force (a_mode.to_string_32, "hx-swap")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-swap") as v and then v.same_string (a_mode.to_string_32)
		end

	hx_swap_inner_html: like Current
			-- Set hx-swap to innerHTML (replace inner content).
		do
			Result := hx_swap ("innerHTML")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-swap") as v and then v.same_string ("innerHTML")
		end

	hx_swap_outer_html: like Current
			-- Set hx-swap to outerHTML (replace entire element).
		do
			Result := hx_swap ("outerHTML")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-swap") as v and then v.same_string ("outerHTML")
		end

	hx_swap_before_end: like Current
			-- Set hx-swap to beforeend (append inside).
		do
			Result := hx_swap ("beforeend")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-swap") as v and then v.same_string ("beforeend")
		end

	hx_swap_after_end: like Current
			-- Set hx-swap to afterend (insert after).
		do
			Result := hx_swap ("afterend")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-swap") as v and then v.same_string ("afterend")
		end

	hx_swap_delete: like Current
			-- Set hx-swap to delete (remove element).
		do
			Result := hx_swap ("delete")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-swap") as v and then v.same_string ("delete")
		end

	hx_swap_none: like Current
			-- Set hx-swap to none (don't swap, just trigger events).
		do
			Result := hx_swap ("none")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-swap") as v and then v.same_string ("none")
		end

	hx_trigger (a_event: READABLE_STRING_GENERAL): like Current
			-- Set hx-trigger attribute (when to send request).
			-- Examples: click, change, submit, load, revealed, every 2s
		do
			attributes.force (a_event.to_string_32, "hx-trigger")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-trigger") as v and then v.same_string (a_event.to_string_32)
		end

	hx_trigger_click: like Current
			-- Set hx-trigger to click.
		do
			Result := hx_trigger ("click")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-trigger") as v and then v.same_string ("click")
		end

	hx_trigger_change: like Current
			-- Set hx-trigger to change.
		do
			Result := hx_trigger ("change")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-trigger") as v and then v.same_string ("change")
		end

	hx_trigger_submit: like Current
			-- Set hx-trigger to submit.
		do
			Result := hx_trigger ("submit")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-trigger") as v and then v.same_string ("submit")
		end

	hx_trigger_load: like Current
			-- Set hx-trigger to load (fire on page load).
		do
			Result := hx_trigger ("load")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-trigger") as v and then v.same_string ("load")
		end

	hx_indicator (a_selector: READABLE_STRING_GENERAL): like Current
			-- Set hx-indicator attribute (loading indicator selector).
		do
			attributes.force (a_selector.to_string_32, "hx-indicator")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-indicator") as v and then v.same_string (a_selector.to_string_32)
		end

	hx_confirm (a_message: READABLE_STRING_GENERAL): like Current
			-- Set hx-confirm attribute (confirmation dialog).
		do
			attributes.force (a_message.to_string_32, "hx-confirm")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-confirm") as v and then v.same_string (a_message.to_string_32)
		end

	hx_disable: like Current
			-- Set hx-disable attribute (disable element during request).
		do
			attributes.force ("true", "hx-disable")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attributes.has ("hx-disable")
		end

	hx_vals (a_json: READABLE_STRING_GENERAL): like Current
			-- Set hx-vals attribute (additional values to submit as JSON).
		do
			attributes.force (a_json.to_string_32, "hx-vals")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-vals") as v and then v.same_string (a_json.to_string_32)
		end

	hx_include (a_selector: READABLE_STRING_GENERAL): like Current
			-- Set hx-include attribute (include additional elements in request).
		do
			attributes.force (a_selector.to_string_32, "hx-include")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-include") as v and then v.same_string (a_selector.to_string_32)
		end

	hx_select (a_selector: READABLE_STRING_GENERAL): like Current
			-- Set hx-select attribute (select part of response to swap).
		do
			attributes.force (a_selector.to_string_32, "hx-select")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-select") as v and then v.same_string (a_selector.to_string_32)
		end

	hx_push_url (a_url: READABLE_STRING_GENERAL): like Current
			-- Set hx-push-url attribute (push URL to history).
		do
			attributes.force (a_url.to_string_32, "hx-push-url")
			Result := Current
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-push-url") as v and then v.same_string (a_url.to_string_32)
		end

	hx_push_url_true: like Current
			-- Set hx-push-url to true (push request URL to history).
		do
			Result := hx_push_url ("true")
		ensure
			fluent_result: Result = Current
			attribute_set: attached attributes.item ("hx-push-url") as v and then v.same_string ("true")
		end

feature -- Content (fluent)

	text (a_text: READABLE_STRING_GENERAL): like Current
			-- Set text content.
		do
			content_text := a_text.to_string_32
			Result := Current
		ensure
			fluent_result: Result = Current
			text_set: content_text.same_string (a_text.to_string_32)
		end

	containing (a_child: HTMX_ELEMENT): like Current
			-- Add a child element.
		require
			not_void_element: not is_void_element
		do
			children.extend (a_child)
			Result := Current
		ensure
			fluent_result: Result = Current
			child_added: children.has (a_child)
			count_increased: children.count = old children.count + 1
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
		ensure
			fluent_result: Result = Current
		end

	raw_html (a_html: READABLE_STRING_GENERAL): like Current
			-- Append raw HTML content (use with caution - no escaping).
		do
			content_text.append (a_html.to_string_32)
			Result := Current
		ensure
			fluent_result: Result = Current
			content_appended: content_text.count >= old content_text.count
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
			-- Add escaped attributes
			from attributes.start until attributes.after loop
				a_buffer.append_character (' ')
				a_buffer.append_string_general (attributes.key_for_iteration)
				a_buffer.append_string_general ("=%"")
				a_buffer.append (escape_html (attributes.item_for_iteration))
				a_buffer.append_character ('"')
				attributes.forth
			end
			-- Add raw attributes (no escaping - for JavaScript expressions)
			from raw_attributes.start until raw_attributes.after loop
				a_buffer.append_character (' ')
				a_buffer.append_string_general (raw_attributes.key_for_iteration)
				a_buffer.append_string_general ("=%"")
				a_buffer.append (raw_attributes.item_for_iteration)
				a_buffer.append_character ('"')
				raw_attributes.forth
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
	raw_attributes_attached: raw_attributes /= Void
	classes_attached: classes /= Void
	children_attached: children /= Void

end
