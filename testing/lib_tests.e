note
	description: "Tests for SIMPLE_HTMX"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"
	testing: "covers"

class
	LIB_TESTS

inherit
	TEST_SET_BASE

feature -- Test: Element Creation

	test_div_make
			-- Test HTMX div element creation.
		note
			testing: "covers/{HTMX_DIV}.make"
		local
			element: HTMX_DIV
		do
			create element.make
			assert_attached ("element created", element)
		end

	test_div_to_html
			-- Test HTML rendering.
		note
			testing: "covers/{HTMX_DIV}.to_html"
		local
			element: HTMX_DIV
			html: STRING
		do
			create element.make
			html := element.to_html
			assert_false ("html not empty", html.is_empty)
			assert_string_contains ("has div tag", html, "div")
		end

end
