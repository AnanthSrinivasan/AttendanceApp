$('#btngenlink').tooltip({
    'show': true,
    'placement': 'bottom',
    'title': "Generates links for Attendance..."
});

$.validator.messages.required = 'required';
$('form[data-novalidate=yes]').bootstrapValidate();