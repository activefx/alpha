// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require modernizr
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-transition
//= require bootstrap-alert
//= require bootstrap-modal
//= require bootstrap-dropdown
//= require bootstrap-scrollspy
//= require bootstrap-tab
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require bootstrap-button
//= require bootstrap-collapse
//= require bootstrap-carousel
//= require bootstrap-typeahead
//= require bootstrap-initializer
//= require moment
//= require handlebars-1.0.0.rc.3
//= require ember
//= require ember-data
//= require_self
//= require_tree ./ember_dashboard/initializers
//= require_tree ./ember_dashboard/routes
//= require_tree ./ember_dashboard/models
//= require_tree ./ember_dashboard/controllers
//= require_tree ./ember_dashboard/templates
//= require_tree ./ember_dashboard/views

var Dashboard = Ember.Application.create();

Dashboard.Store = DS.Store.extend({
  revision: 11,
  adapter: DS.RESTAdapter.create()
});
