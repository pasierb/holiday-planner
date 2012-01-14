module LeaveRequestsHelper

	DEFAULT_DOTS_LENGTH = 300

	def dots( size = DEFAULT_DOTS_LENGTH )
		(0..size).collect{"."}.join
	end

	def user_input( text = nil, size = 30 )
		html_options = {}
		html_options[:class] = "user-content" if text
		content_tag :span, text || dots( size ), html_options
	end

end