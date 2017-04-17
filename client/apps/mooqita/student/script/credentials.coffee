##############################################
#
# Resume view of solution
# Created by Markus on 15/11/2015.
#
##############################################

##############################################
# credential list
##############################################

##############################################
Template.student_credentials.onCreated () ->
	self = this

	self.autorun () ->
		s_id = FlowRouter.getParam('user_id')
		if !s_id
			s_id = Meteor.userId()
		self.subscribe 'user_credentials', s_id

##############################################
Template.student_credentials.helpers
	current_resume: () ->
		res = User_Credentials.findOne()
		return res

##############################################
# credential solution
##############################################

##############################################
Template.credential_solution.onCreated () ->
	this.reviews_visible = new ReactiveVar(false)

##############################################
Template.credential_solution.helpers
	reviews_visible: () ->
		return Template.instance().reviews_visible.get()


##############################################
Template.credential_solution.events
	"click #show_reviews": () ->
		rv = Template.instance().reviews_visible
		rv.set !rv.get()


##############################################
# credential review
##############################################

##############################################
Template.credential_review.helpers
	resume_url: () ->
		return get_response_url(this.owner_id)

