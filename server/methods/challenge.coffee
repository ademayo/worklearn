################################################################
#
# Markus 1/23/2017
#
################################################################

###############################################
Meteor.methods
	add_challenge: () ->
		user = Meteor.user()

		if not user
			throw new Meteor.Error('Not permitted.')

		return gen_challenge user

	finish_challenge: (challenge_id) ->
		user = Meteor.user()
		if can_edit Challenges, challenge_id, user
			throw new Meteor.Error("Not permitted.")

		item = get_document_unprotected Challenges, challenge_id
		return finish_challenge item, user

	send_message_to_challenge_learners: (challenge_id, subject, message) ->
		user = Meteor.user()

		if not user
			throw new Meteor.Error('Not permitted.')

		if not has_permission Challenges, challenge_id, user, SEND_MAIL
			throw new Meteor.Error('Not permitted.')

		# we need to know who is registered for a course.
		filter =
			challenge_id: challenge_id

		solutions = Solutions.find filter

		solutions.forEach (solution) ->
			owner = get_document_owner "solutions", solution
			name = get_profile_name_by_user_id owner._id, true, false
			subject =	subject.replace("<<name>>", name)
			message =	message.replace("<<name>>", name)
			send_mail user, subject, message

		return solutions.count()
