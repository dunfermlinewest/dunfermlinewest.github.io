function printCalendar() {
    // The "Calendar ID" from your calendar settings page, "Calendar Integration" secion:
    var calendarId = 'dunfermlinewest.co.uk_7gp9qiqqejtv9vd3319uepa4ec@group.calendar.google.com';
    var mnth = false;
    var currentM;
    var allDay;
    var row;
    // 1. Create a project using google's wizzard: https://console.developers.google.com/start/api?id=calendar
    // 2. Create credentials:
    //    a) Go to https://console.cloud.google.com/apis/credentials
    //    b) Create Credentials / API key
    //    c) Since your key will be called from any of your users' browsers, set "Application restrictions" to "None",
    //       leave "Website restrictions" blank; you may optionally set "API restrictions" to "Google Calendar API"
    var apiKey = 'AIzaSyAZy7rtcSgNxmSpYd-TI5CvUuP-wifZrNA';
    // You can get a list of time zones from here: http://www.timezoneconverter.com/cgi-bin/zonehelp
    var userTimeZone = "Europe/London";

    // Initializes the client with the API key and the Translate API.
    gapi.client.init({
        'apiKey': apiKey,
        // Discovery docs docs: https://developers.google.com/api-client-library/javascript/features/discovery
        'discoveryDocs': ['https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest'],
    }).then(function () {
        // Use Google's "apis-explorer" for research: https://developers.google.com/apis-explorer/#s/calendar/v3/
        // Events: list API docs: https://developers.google.com/calendar/v3/reference/events/list
        return gapi.client.calendar.events.list({
            'calendarId': calendarId,
            'timeZone': userTimeZone,
            'singleEvents': true,
            'timeMin': (new Date()).toISOString(), //gathers only events not happened yet
            'maxResults': 30,
            'orderBy': 'startTime'
        });
    }).then(function (response) {
        if (response.result.items) {
            var calendarRows = ['<table class="events-calendar table"><tbody>'];
            response.result.items.forEach(function(entry) {
                currentM = moment(entry.start.dateTime).format("MMM");
                console.log(entry);
                row = "";
                if (typeof entry.start.dateTime == 'undefined') {
                    /* all day events */
                    if(typeof entry.start.date != 'undefined') {
                        row = "";
                        currentM = moment(entry.start.date).format("MMM");
                        allDay = " <b>- " + entry.summary + "</b>";
                    }

                } else {
                    currentM = moment(entry.start.dateTime).format("MMM");
                    var startsAt = moment(entry.start.dateTime).format("dddd Do") + ' ' + moment(entry.start.dateTime).format("LT");
                    row = `<tr><td>${startsAt}</td><td>${entry.summary}${allDay}</td></tr>`;
                    allDay = "";
                }
                /* set month */
                if(mnth!=currentM) {
                    mnth = currentM;
                    calendarRows.push(`<tr><td colspan="2"><b>${mnth}</b></td></tr>`);
                }
                calendarRows.push(row);

            });
            calendarRows.push('</tbody></table>');
            $('#church-calendar').html(calendarRows.join(""));
        }
    }, function (reason) {
        console.log('Error: ' + reason.result.error.message);
    });
};

// Loads the JavaScript client library and invokes `start` afterwards.
gapi.load('client', printCalendar);