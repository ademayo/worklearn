###############################################################################
# Top Base Menu
###############################################################################

###############################################################################
Template.mooqita_menu.helpers
	profile: () ->
		user_id = Meteor.userId()
		profile = get_profile(user_id)
		return profile

	menu_items: () ->
		mod =
			fields:
				collection_name: 1

		adms = Admissions.find({}, mod).fetch()
		unique = new Set()

		for a in adms
			unique.add(a.collection_name)

		items = [	{name: "Organizations", href: build_url("organizations")}]

		if unique.has("organizations")
		 items.push({name: "Job Postings", href: build_url("jobs")})

		items.push({name: "Challenges", href: build_url("challenges")})

		#{name: "Portfolio", href: build_url("portfolio")}
		#filter =
		#	collection_name: "organizations"
		#if Admissions.find(filter).count() > 0

		if unique.has("solutions")
		 items.push({name: "Solutions", href: build_url("solutions")})
		 items.push({name: "Reviews", href: build_url("reviews")})


		return items

	num_new_messages: () ->
		crs = get_my_documents("messages", {seen:false})
		return crs.count()

###############################################################################
Template.mooqita_menu.events
	'click #logout': (event) ->
		Meteor.logout()

