note
	description: "Tests for HTMX HTML element building."
	author: "Claude Code"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HTMX_ELEMENTS

inherit
	TEST_SET_BASE

feature -- Tests: Basic Elements

	test_div_simple
			-- Test simple div creation.
		local
			l_div: HTMX_DIV
		do
			create l_div.make
			assert_strings_equal ("simple div", "<div></div>", l_div.to_html_8)
		end

	test_div_with_id
			-- Test div with id attribute.
		local
			l_div: HTMX_DIV
		do
			create l_div.make
			l_div.id ("main").do_nothing
			assert_strings_equal ("div with id", "<div id=%"main%"></div>", l_div.to_html_8)
		end

	test_div_with_class
			-- Test div with CSS class.
		local
			l_div: HTMX_DIV
		do
			create l_div.make
			l_div.class_ ("container").do_nothing
			assert_strings_equal ("div with class", "<div class=%"container%"></div>", l_div.to_html_8)
		end

	test_div_with_multiple_classes
			-- Test div with multiple CSS classes.
		local
			l_div: HTMX_DIV
		do
			create l_div.make
			l_div.class_ ("container").class_ ("main").class_ ("wide").do_nothing
			assert ("has three classes", l_div.to_html_8.has_substring ("container main wide"))
		end

	test_div_with_text
			-- Test div with text content.
		local
			l_div: HTMX_DIV
		do
			create l_div.make
			l_div.text ("Hello World").do_nothing
			assert_strings_equal ("div with text", "<div>Hello World</div>", l_div.to_html_8)
		end

	test_span_simple
			-- Test span creation.
		local
			l_span: HTMX_SPAN
		do
			create l_span.make
			l_span.text ("inline text").do_nothing
			assert_strings_equal ("span", "<span>inline text</span>", l_span.to_html_8)
		end

feature -- Tests: Feature Chaining

	test_chained_attributes
			-- Test fluent interface chaining.
		local
			l_div: HTMX_DIV
		do
			create l_div.make
			l_div.id ("main").class_ ("container").data ("value", "123").text ("Content").do_nothing
			assert ("has id", l_div.to_html_8.has_substring ("id=%"main%""))
			assert ("has class", l_div.to_html_8.has_substring ("class=%"container%""))
			assert ("has data", l_div.to_html_8.has_substring ("data-value=%"123%""))
			assert ("has content", l_div.to_html_8.has_substring ("Content"))
		end

feature -- Tests: HTMX Attributes

	test_hx_get
			-- Test hx-get attribute.
		local
			l_div: HTMX_DIV
		do
			create l_div.make
			l_div.hx_get ("/api/data").do_nothing
			assert ("has hx-get", l_div.to_html_8.has_substring ("hx-get=%"/api/data%""))
		end

	test_hx_post
			-- Test hx-post attribute.
		local
			l_button: HTMX_BUTTON
		do
			create l_button.make_with_text ("Save")
			l_button.hx_post ("/api/save").do_nothing
			assert ("has hx-post", l_button.to_html_8.has_substring ("hx-post=%"/api/save%""))
		end

	test_hx_target_and_swap
			-- Test hx-target and hx-swap attributes.
		local
			l_button: HTMX_BUTTON
		do
			create l_button.make
			l_button.hx_get ("/api/data").hx_target ("#result").hx_swap_inner_html.do_nothing
			assert ("has hx-target", l_button.to_html_8.has_substring ("hx-target=%"#result%""))
			assert ("has hx-swap", l_button.to_html_8.has_substring ("hx-swap=%"innerHTML%""))
		end

	test_hx_trigger
			-- Test hx-trigger variations.
		local
			l_input: HTMX_INPUT
		do
			create l_input.make_text ("search")
			l_input.hx_get ("/api/search").hx_trigger ("keyup changed delay:500ms").do_nothing
			assert ("has hx-trigger", l_input.to_html_8.has_substring ("hx-trigger=%"keyup changed delay:500ms%""))
		end

	test_hx_confirm
			-- Test hx-confirm attribute.
		local
			l_button: HTMX_BUTTON
		do
			create l_button.make_with_text ("Delete")
			l_button.hx_delete ("/api/item/1").hx_confirm ("Are you sure?").do_nothing
			assert ("has hx-confirm", l_button.to_html_8.has_substring ("hx-confirm=%"Are you sure?%""))
		end

feature -- Tests: Form Elements

	test_form_simple
			-- Test form creation.
		local
			l_form: HTMX_FORM
		do
			create l_form.make
			l_form.method_post.action ("/submit").do_nothing
			assert ("has method", l_form.to_html_8.has_substring ("method=%"post%""))
			assert ("has action", l_form.to_html_8.has_substring ("action=%"/submit%""))
		end

	test_input_text
			-- Test text input creation.
		local
			l_input: HTMX_INPUT
		do
			create l_input.make_text ("username")
			l_input.placeholder ("Enter username").required.do_nothing
			assert ("is void element", l_input.to_html_8.has_substring ("/>"))
			assert ("has name", l_input.to_html_8.has_substring ("name=%"username%""))
			assert ("has placeholder", l_input.to_html_8.has_substring ("placeholder=%"Enter username%""))
			assert ("has required", l_input.to_html_8.has_substring ("required"))
		end

	test_input_hidden
			-- Test hidden input creation.
		local
			l_input: HTMX_INPUT
		do
			create l_input.make_hidden ("csrf", "token123")
			assert ("has type hidden", l_input.to_html_8.has_substring ("type=%"hidden%""))
			assert ("has value", l_input.to_html_8.has_substring ("value=%"token123%""))
		end

	test_textarea
			-- Test textarea creation.
		local
			l_textarea: HTMX_TEXTAREA
		do
			create l_textarea.make_with_name ("description")
			l_textarea.rows (5).cols (40).text ("Initial content").do_nothing
			assert ("has name", l_textarea.to_html_8.has_substring ("name=%"description%""))
			assert ("has rows", l_textarea.to_html_8.has_substring ("rows=%"5%""))
			assert ("has content", l_textarea.to_html_8.has_substring ("Initial content"))
		end

	test_select_with_options
			-- Test select with options.
		local
			l_select: HTMX_SELECT
		do
			create l_select.make_with_name ("country")
			l_select.option ("us", "United States").option_selected ("ca", "Canada").option ("mx", "Mexico").do_nothing
			assert ("has name", l_select.to_html_8.has_substring ("name=%"country%""))
			assert ("has us option", l_select.to_html_8.has_substring ("value=%"us%""))
			assert ("has selected", l_select.to_html_8.has_substring ("selected"))
		end

feature -- Tests: Nested Elements

	test_nested_elements
			-- Test nesting elements with containing.
		local
			l_div: HTMX_DIV
			l_span: HTMX_SPAN
		do
			create l_span.make
			l_span.text ("nested").do_nothing
			create l_div.make
			l_div.containing (l_span).do_nothing
			assert_strings_equal ("nested", "<div><span>nested</span></div>", l_div.to_html_8)
		end

	test_multiple_children
			-- Test multiple child elements.
		local
			l_div: HTMX_DIV
			l_p1, l_p2: HTMX_P
		do
			create l_p1.make
			l_p1.text ("First paragraph").do_nothing
			create l_p2.make
			l_p2.text ("Second paragraph").do_nothing
			create l_div.make
			l_div.containing (l_p1).containing (l_p2).do_nothing
			assert ("has first p", l_div.to_html_8.has_substring ("<p>First paragraph</p>"))
			assert ("has second p", l_div.to_html_8.has_substring ("<p>Second paragraph</p>"))
		end

feature -- Tests: Void Elements

	test_br_void_element
			-- Test br is self-closing.
		local
			l_br: HTMX_BR
		do
			create l_br.make
			assert_strings_equal ("br self-closing", "<br/>", l_br.to_html_8)
		end

	test_hr_void_element
			-- Test hr is self-closing.
		local
			l_hr: HTMX_HR
		do
			create l_hr.make
			assert_strings_equal ("hr self-closing", "<hr/>", l_hr.to_html_8)
		end

	test_img_void_element
			-- Test img is self-closing.
		local
			l_img: HTMX_IMG
		do
			create l_img.make_src ("/images/logo.png", "Logo")
			assert ("img self-closing", l_img.to_html_8.has_substring ("/>"))
			assert ("has src", l_img.to_html_8.has_substring ("src=%"/images/logo.png%""))
			assert ("has alt", l_img.to_html_8.has_substring ("alt=%"Logo%""))
		end

feature -- Tests: Tables

	test_table_structure
			-- Test table with thead and tbody.
		local
			l_table: HTMX_TABLE
			l_thead: HTMX_THEAD
			l_tbody: HTMX_TBODY
			l_tr_head, l_tr_body: HTMX_TR
		do
			create l_tr_head.make
			l_tr_head.th ("Name").th ("Value").do_nothing
			create l_thead.make
			l_thead.containing (l_tr_head).do_nothing

			create l_tr_body.make
			l_tr_body.td ("Item").td ("123").do_nothing
			create l_tbody.make
			l_tbody.containing (l_tr_body).do_nothing

			create l_table.make
			l_table.class_ ("data-table").containing (l_thead).containing (l_tbody).do_nothing

			assert ("has thead", l_table.to_html_8.has_substring ("<thead>"))
			assert ("has tbody", l_table.to_html_8.has_substring ("<tbody>"))
			assert ("has th", l_table.to_html_8.has_substring ("<th>Name</th>"))
			assert ("has td", l_table.to_html_8.has_substring ("<td>Item</td>"))
		end

feature -- Tests: Lists

	test_unordered_list
			-- Test ul with li items.
		local
			l_ul: HTMX_UL
		do
			create l_ul.make
			l_ul.li ("First").li ("Second").li ("Third").do_nothing
			assert ("has ul", l_ul.to_html_8.has_substring ("<ul>"))
			assert ("has first li", l_ul.to_html_8.has_substring ("<li>First</li>"))
			assert ("has second li", l_ul.to_html_8.has_substring ("<li>Second</li>"))
		end

feature -- Tests: Factory

	test_factory_div
			-- Test factory div creation.
		local
			l_html: HTMX_FACTORY
			l_div: HTMX_DIV
		do
			create l_html
			l_div := l_html.div.id ("test").class_ ("container")
			assert ("has id", l_div.to_html_8.has_substring ("id=%"test%""))
		end

	test_factory_button
			-- Test factory button creation.
		local
			l_html: HTMX_FACTORY
			l_btn: HTMX_BUTTON
		do
			create l_html
			l_btn := l_html.button_text ("Click Me").hx_post ("/api/click")
			assert ("has text", l_btn.to_html_8.has_substring ("Click Me"))
			assert ("has hx-post", l_btn.to_html_8.has_substring ("hx-post"))
		end

	test_factory_link
			-- Test factory link creation.
		local
			l_html: HTMX_FACTORY
			l_link: HTMX_A
		do
			create l_html
			l_link := l_html.link ("https://example.com", "Example").target_blank.rel_noopener
			assert ("has href", l_link.to_html_8.has_substring ("href=%"https://example.com%""))
			assert ("has target", l_link.to_html_8.has_substring ("target=%"_blank%""))
		end

feature -- Tests: Render Context

	test_render_context_simple
			-- Test basic render context URL building.
		local
			l_ctx: HTMX_RENDER_CONTEXT
		do
			create l_ctx.make ("/api")
			l_ctx.with_spec ("my-app").with_screen ("main").do_nothing
			assert_strings_equal ("context url", "/api/specs/my-app/screens/main", l_ctx.url_8)
		end

	test_render_context_url_for
			-- Test render context url_for.
		local
			l_ctx: HTMX_RENDER_CONTEXT
		do
			create l_ctx.make ("/api")
			l_ctx.with_spec ("app").with_screen ("home").do_nothing
			assert_strings_equal ("url_for", "/api/specs/app/screens/home/controls", l_ctx.url_for_8 ("controls"))
		end

	test_render_context_url_for_id
			-- Test render context url_for_id.
		local
			l_ctx: HTMX_RENDER_CONTEXT
		do
			create l_ctx.make ("/api")
			l_ctx.with_spec ("app").with_screen ("home").do_nothing
			assert_strings_equal ("url_for_id", "/api/specs/app/screens/home/controls/btn1", l_ctx.url_for_id_8 ("controls", "btn1"))
		end

	test_render_context_child
			-- Test render context child (non-mutating).
		local
			l_ctx, l_child: HTMX_RENDER_CONTEXT
		do
			create l_ctx.make ("/api")
			l_ctx.with_spec ("app").do_nothing
			l_child := l_ctx.child ("screens", "main")
			-- Original should be unchanged
			assert_strings_equal ("parent unchanged", "/api/specs/app", l_ctx.url_8)
			-- Child should have additional segment
			assert_strings_equal ("child extended", "/api/specs/app/screens/main", l_child.url_8)
		end

	test_render_context_target_selectors
			-- Test CSS selector generation.
		local
			l_ctx: HTMX_RENDER_CONTEXT
		do
			create l_ctx.make_empty
			assert_strings_equal ("id selector", "#panel", l_ctx.target_id ("panel").to_string_8)
			assert_strings_equal ("class selector", ".active", l_ctx.target_class ("active").to_string_8)
		end

feature -- Tests: HTML Escaping

	test_attribute_escaping
			-- Test that attribute values are properly escaped.
		local
			l_div: HTMX_DIV
		do
			create l_div.make
			l_div.attr ("data-json", "{%"key%": %"value%"}").do_nothing
			assert ("has escaped quotes", l_div.to_html_8.has_substring ("&quot;"))
		end

feature -- Tests: Complex HTMX Patterns

	test_htmx_search_pattern
			-- Test common HTMX search input pattern.
		local
			l_html: HTMX_FACTORY
			l_input: HTMX_INPUT
		do
			create l_html
			l_input := l_html.input_text ("q")
			l_input.placeholder ("Search...")
			       .hx_get ("/api/search")
			       .hx_trigger ("keyup changed delay:300ms")
			       .hx_target ("#results")
			       .hx_indicator ("#spinner").do_nothing
			assert ("has trigger", l_input.to_html_8.has_substring ("hx-trigger"))
			assert ("has indicator", l_input.to_html_8.has_substring ("hx-indicator"))
		end

	test_htmx_delete_with_confirm
			-- Test delete button with confirmation.
		local
			l_html: HTMX_FACTORY
			l_btn: HTMX_BUTTON
		do
			create l_html
			l_btn := l_html.button_text ("Delete")
			l_btn.class_ ("btn-danger")
			    .hx_delete ("/api/items/123")
			    .hx_confirm ("Delete this item?")
			    .hx_target ("closest tr")
			    .hx_swap_delete.do_nothing
			assert ("has delete", l_btn.to_html_8.has_substring ("hx-delete"))
			assert ("has confirm", l_btn.to_html_8.has_substring ("hx-confirm"))
			assert ("has swap delete", l_btn.to_html_8.has_substring ("hx-swap=%"delete%""))
		end

end
