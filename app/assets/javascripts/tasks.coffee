# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


//= require bootstrap-switch.min

$("[name='my-checkbox']").bootstrapSwitch({
  size: 'small',
  onText: '<span aria-hidden="true" class="glyphicon glyphicon-check"></span>',
  onColor: 'info',
  offText: '<span aria-hidden="true" class="glyphicon glyphicon-unchecked"></span>',
  offColor: 'warning'
});
