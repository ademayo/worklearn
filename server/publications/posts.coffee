#######################################################
#
#	Moocita collections
# Created by Markus on 26/10/2015.
#
#######################################################

#######################################################
Meteor.publish "posts", (group_name) ->
	check group_name, String

	user_id = this.userId
	filter =
		group_name: group_name
		published: true

	crs = Posts.find filter, fields

	log_publication crs, user_id, "posts"
	return crs

