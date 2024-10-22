import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.updateClock();
    setInterval(this.updateClock.bind(this), 1000);
  }

  updateClock() {
    const clockElement = document.getElementById('clock');
    const now = new Date();
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    clockElement.textContent = `${hours}:${minutes}:${seconds}`;
  }
}
