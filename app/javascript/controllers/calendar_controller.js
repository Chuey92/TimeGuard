import { Controller } from "@hotwired/stimulus";
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

export default class extends Controller {
  connect() {
    this.initializeCalendar();
  }

  initializeCalendar() {
    const calendarEl = document.getElementById('calendar');

    const calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin, interactionPlugin],
      initialView: 'dayGridMonth',
      events: '/schedules/events', // Adjust this URL based on your routes
    });

    calendar.render();
  }
}
