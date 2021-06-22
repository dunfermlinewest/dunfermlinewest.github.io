document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('church-calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {

        headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'listMonth,dayGridMonth'
        },

        displayEventTime: false, // don't show the time column in list view
        eventColor: '#f77f71',
        eventDisplay: 'block',
        initialView: $(window).width() < 765 ? 'listMonth':'dayGridMonth',

        googleCalendarApiKey: 'AIzaSyAZy7rtcSgNxmSpYd-TI5CvUuP-wifZrNA',

        events: 'dunfermlinewest.co.uk_7gp9qiqqejtv9vd3319uepa4ec@group.calendar.google.com',

        eventClick: function(arg) {
        // opens events in a popup window
        //console.log(arg.event);

        var startsAt = moment(arg.event.start).format("ddd Do") + ' ' + moment(arg.event.start).format("MMM") + ', ' + moment(arg.event.start).format("LT");
        $('#church-event').html(` ${startsAt} <b>${arg.event.title}</b>`);
        $('#event-details').html(`<h2>${arg.event.title}</h2><p>${startsAt}</p>`);
        $('#event-modal').modal('show');
        arg.jsEvent.preventDefault() // don't navigate in main tab
        },

        eventClassNames: function(arg) {
            if(arg.event.title.includes('business')) {
                return [ 'business' ]
            } else return;
        }

    });

    calendar.render();
});